From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Sat, 13 Apr 2013 01:00:07 -0500
Message-ID: <CAMP44s3+eaRbeXP0bPXMSE8Z1K_Lqyu8e1XCvudkapkTJFBWnA@mail.gmail.com>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
	<1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
	<20130411043346.GE14551@sigill.intra.peff.net>
	<CAMP44s0FkiwPMJVhVBNa32J3rgghRZy6xDTN-YnHKcQ4Fj0BMQ@mail.gmail.com>
	<20130411050509.GC27795@sigill.intra.peff.net>
	<CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 13 08:00:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQtVo-0003sO-Sb
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 08:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3DMGAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 02:00:10 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:63393 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354Ab3DMGAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 02:00:09 -0400
Received: by mail-lb0-f181.google.com with SMTP id r11so3174512lbv.26
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=erDN9jKxI9XmVB6F+2JIKNujWmd3vCm7Hu+yedwodro=;
        b=AuM0CtP+j6zL1er3EVFjbc42EUnlUP/8HDlIOUjVkp+UOORcV918IiHYIt2BbyITje
         6cXOE1pdT5jz2q+vlfj9pyecI66paQ8sKu1jwEbCvfPUdfWsa8lq4MZzUONsLAIh2ESH
         PoUh0zrW0EUAKng2ugwJTZtWGKdDdabXfmVq1aj8i9WNKFY09AGNFEpbGn3Phim/Wsf2
         w/P/Lwl+sJgzKLk/Ffy5MdenLoNnWDjsViMgM2hF1KwjHxvKC7qOfH3/3xiUJsB51Jx8
         PUZY2c9+PBm/ROfgKio29t2hWtgiQxTI+h0GDHWodJ5JjSmT7jWgkGbR6HcJJZjp/b3+
         AKfg==
X-Received: by 10.112.20.106 with SMTP id m10mr6662681lbe.8.1365832807606;
 Fri, 12 Apr 2013 23:00:07 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Fri, 12 Apr 2013 23:00:07 -0700 (PDT)
In-Reply-To: <CAMP44s1LF46VU0E4W=r-qog3JY+Y-qyYGfkqxLEnTG8X8GoWOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221051>

Hi,

Why wasn't this patch merged to 'pu'? To my knowledge nobody raised
any real concerns.

Should I explain in every commit that touches transport-helper how
remote-helpers without marks are impossible? I know I said I was going
to update the commit message, but I don't think that reason to not put
it in 'pu'. Also, the only reason I said so was to make Jeff happy,
but now that I think again, it doesn't really belong there; remote
helpers cannot be using these refs, they just can't. They cannot work
without marks, it's not possible. To think otherwise is simply a
mistake.

On Thu, Apr 11, 2013 at 12:18 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Apr 11, 2013 at 12:05 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, Apr 10, 2013 at 11:53:38PM -0500, Felipe Contreras wrote:
>>
>>> > But if we push some commits to the helper, moving Y up to Z, then it
>>> > would build the new commit (which contains the foreign-vcs's equivalent of
>>> > Y..Z) on top of Z, not Y.
>>>
>>> Why would it do that? If X points to say revision 100, presumably it
>>> was stored somewhere while doing a fetch. Similarly, if foreign
>>> version of Z is 150, it can update that number while doing a push. The
>>> next fetch it would start from 151.
>>
>> I think the only reason not to bump the marker forward during the push
>> would be if the helper wants for some reason to "re-import" from the
>> foreign source rather than accepting the git versions of the commits.
>> Something like git-svn's markup of the commit messages with revision ids
>> comes to mind.
>
> Yeah, but that's already a second level hypothesis. First,
> remote-helpers would need to be able to work without marks, and they
> can't.
>
>> But if it matters, then by definition that would mean
>> that the import/export is not bidirectionally clean.
>
> I don't see how would that matter.
>
>> So I can buy the argument that bumping it forward ourselves will not
>> matter for any well-implemented helper.
>
> Or any helper.
>
>> That is the sort of thing that might be helpful to include in the commit
>> message; if somebody does run across such a helper and bisects to your
>> commit, then they can understand the rationale for the decision.
>
> If it did matter, it would be mentioned. I will updated it later if
> there's no further comments.

-- 
Felipe Contreras
