From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 16:50:51 -0500
Message-ID: <CAMP44s3S2A2ymEjGZVQjYx8k08x11WYTuy=y_e-MHa_qM78Zxw@mail.gmail.com>
References: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
	<87haiu7jgn.fsf@linux-k42r.v.cablecom.net>
	<7v1u9y2u4q.fsf@alter.siamese.dyndns.org>
	<CAMP44s2-QZxuV-bXc_0zeqxJDy=Y6AAC0iwgbjNDNuCaaMcErA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVU49-0002j4-9P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759389Ab3DYVux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:50:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34945 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758867Ab3DYVuw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:50:52 -0400
Received: by mail-lb0-f174.google.com with SMTP id s10so3230262lbi.33
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Q7oT0FbYWxFW7rWj7YVV1Gt8EqyJLzZfKZMUQOWpqhI=;
        b=1HgVcGfExs6eMukvXypVNOtJqMk7503PbwJdTLKdhwZRcAC5CPYKKB8KKc0sPc108Z
         wyVNvHhXXsPf47kks+BzOs0RqmzCQWiz+ZuaY5TIox7JlR1HBIF+uORV+4O9+1VV0hvM
         BL03GWajd7DH+rbQiJhD781fDkmi/Lr0NnqHzbEuOyoBiqCpL1VFWChHB60v0F+YjRZk
         sW8+Oyk1prPLt8uDBSWP2lroaEAhm/c8WriG1fcHcDyf3k4YBHCIIOX/2PrzF5oNz9kK
         blZQ1+XlXDCZuNEZdNMswC/sj+U5lOZLx35rank3dShFI4jNYxJ6zJU7kojKM261AQcR
         EgwQ==
X-Received: by 10.112.135.3 with SMTP id po3mr17429840lbb.103.1366926651079;
 Thu, 25 Apr 2013 14:50:51 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 14:50:51 -0700 (PDT)
In-Reply-To: <CAMP44s2-QZxuV-bXc_0zeqxJDy=Y6AAC0iwgbjNDNuCaaMcErA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222456>

On Thu, Apr 25, 2013 at 4:41 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, Apr 25, 2013 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> Not just randomly synchronize the revisions with no checks at all. This
>>>> is the way bazaar's UI does it.
>>>>
>>>> Also, add a non-ff check.
>>>>
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>
>>>> This patch should probably go to maint, as the results of pushing the way we
>>>> currently push are not really understood. Perhaps it's similar to a 'git push
>>>>  --force', or perhaps it can potentially screw the repository.
>>>>
>>>> It's better to be safe and just do what bazaar does.
>>>
>>> Other than "this patch should probably go to maint", this should be in
>>> the commit message.
>>
>> Hmph, should it?
>>
>> I do not quite understand what "... are not really understood.
>> Perhaps..." wants to say.  Understood by whom?  By the author of the
>> patch?  By the author of the original code?
>>
>> The log would end up saying "Doing the same as bazaar should be the
>> right thing to do(TM), but don't ask me why.  I do not know what I
>> am doing, or why checking is better than not checking, but it seems
>> to work".  That _could_ be the truth, but it won't help people who
>> are reading the code later, will it?
>
> In addition to that, it's doubtful there's anybody who would actually
> know. Bazaar is basically a dead and unmaintained project now, and it
> has been for quite some time. It seems the people that had any idea
> are long gone.
>
> My gut feeling is that we should do it the way the Bazaar UI does it,
> I don't have any evidence that there's anything wrong with the current
> code, which Bazaar seems to but have, but for different purposes which
> are hard to explain. I would rather avoid surprises.

Er,which Bazaar seems to use, but for different purposes...

-- 
Felipe Contreras
