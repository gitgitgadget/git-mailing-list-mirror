From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Thu, 6 Sep 2012 18:42:31 +0100
Message-ID: <CAOkDyE8pLO3MKVhtW5WEAmqMROV-QKrMOJHN7JKvwYNy7VgFiQ@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<1346544731-938-6-git-send-email-git@adamspiers.org>
	<CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
	<7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
	<CACsJy8D23tDa3SJO6yegHFs2hT+bTr6mLTn16ZU3kiT1dtj4vw@mail.gmail.com>
	<7v627r7s5c.fsf@alter.siamese.dyndns.org>
	<CACsJy8Aq7Sodm1_k2kAmfajHG4wP76xHCshDGPfiLYfzuNwWaA@mail.gmail.com>
	<CACnwZYe19r9mefDmAQtuE5NU4jw033fc_i4JvMZUgtMUkNgEOw@mail.gmail.com>
	<CACsJy8CoBvxg9SWFFXbuDJM7Lu74Jw6LVc=7cNwu24h7pijeXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thiago Farina <tfransosi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9g6D-0002rX-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759245Ab2IFRme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:42:34 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59945 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2IFRmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:42:33 -0400
Received: by bkwj10 with SMTP id j10so971763bkw.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=ncIA9mmrNeolo1KTjtpWJIXS3rRqe4QZHhkkqSF0sco=;
        b=N0+xT+kCokOT+KO0Wm9XJHKeOvxWZyHLOOkFD4yyOKgJAN7LQoEgkBbKxa8twxQc8/
         2muHfXoYM18dqvycjPNpl/yimi2qTMGXSUL/+GJtuuk2wHeHF9y6aiIPRCy0CDY3jo4o
         aaZXUM/UJAoIiYV3jm189+Tnb96hEpH+q/iAhyB+5VpM6RKtv2vxkuW+50TRQGQthkHH
         IRdz0h5CNaixQgCWl6VmclU0hAPOjG4Ql25SPDZXjm9teFHFF2TRYwqj524boJ+Y1HEZ
         FsoTL8YTTn3IC775gRtGCiv4eDvhj+hk2viV3dxknuiL1heuSw0/fWllYelCEerrpL6g
         HpZA==
Received: by 10.205.126.15 with SMTP id gu15mr1524218bkc.134.1346953352017;
 Thu, 06 Sep 2012 10:42:32 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 6 Sep 2012 10:42:31 -0700 (PDT)
In-Reply-To: <CACsJy8CoBvxg9SWFFXbuDJM7Lu74Jw6LVc=7cNwu24h7pijeXQ@mail.gmail.com>
X-Google-Sender-Auth: sTQbjztI4ynC3OCFSEhr84V_inY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204908>

On Thu, Sep 6, 2012 at 4:05 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Sep 6, 2012 at 9:59 PM, Thiago Farina <tfransosi@gmail.com> wrote:
>> On Thu, Sep 6, 2012 at 9:13 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> On Thu, Sep 6, 2012 at 10:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>>
>>>>> We could introduce exclude_path() and kill path_excluded() then. There
>>>>> are just about 5-6 call sites to replace.
>>>>
>>>> The name path_excluded(... path ...) sounds like it is asking a
>>>> yes/no question "is this path excluded?", which actually is what is
>>>> going on.
>>>>
>>>> The name exclude_path(... path ...) sounds as if you are requesting
>>>> somebody to exclude the path.  Does that meaning match the semantics
>>>> of the function?
>>>
>>> I'm not great at naming. And path_excluded() cannot be reused to avoid
>>> problems with other ongoing series if any. So path_is_excluded()?
>>
>> is_path_excluded()?

It makes me happy to see this suggestion :-) Because this is the exact
name I changed it to in an earlier version of my patch series.  But
then I got worried that a) it did not fit the `foo_1' convention which
already seemed to be in use, and b) people would complain about API
changes.  So I changed it back.  However if you would prefer to rename
the functions for clarity, then I have more suggestions:

  old                       new
  -----------------------------------------------------------
  path_excluded             is_path_excluded
  excluded                  is_excluded
  excluded_from_list        is_excluded_from_list
  path_excluded_1           last_exclude_matching_path
  excluded_1                last_exclude_matching
  excluded_from_list_1      last_exclude_matching_from_list
