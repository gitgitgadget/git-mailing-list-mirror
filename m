From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 15:31:23 -0500
Message-ID: <CAMP44s0O04OZjPPzW2=5nSHWyWNECm3L5qVZWyFdWK=dzaKA7A@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net>
	<5178C583.6000703@viscovery.net>
	<7vehdy7j5f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
	<7vwqrq31tv.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LhYt+eNaKWyoDWAPtepaOKXLhYsPXg5dPjYN8MoGA-w@mail.gmail.com>
	<7vsj2e2x5d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVSpG-00067L-Gg
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759232Ab3DYUb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 16:31:26 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:42266 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222Ab3DYUbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 16:31:25 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so2961860lab.21
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=5HKudIZLlJGac6jkhTPHPfPmdBrfJS5F3eAZji++2gM=;
        b=ojIn0YuQ+FvZZQe3MANEbxi+FO5hS4WR8AAGWwaGm2qLnjCQyNCFYwKiR0FdoRcYNS
         Vtokd1RW31MA0ruN8cSJs1Ud+XF9vPPIKC30Hf44unza99kS7hI/V2QjaU4fCEIFwECe
         RrszEPqfT3nVST/KNrgCsGk8ZIH5SsXhs7Abhrso5AJulegoq/YMx5nwKGU9q2k6kRze
         1t/chsKfGdOoaiN3k3L3BOmBI5GmLpFlAtbnaE8pE2C/y6Pd8dt3/Wgjs6JdWp9/gcoe
         bQ5d4HokfC4vO/TPYVfp/0ydAMVCOf1+1zknQrWIUiUBYAw26kmGpF5S5HPJMfSe3GEB
         rXxg==
X-Received: by 10.152.6.162 with SMTP id c2mr20717979laa.20.1366921883815;
 Thu, 25 Apr 2013 13:31:23 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 13:31:23 -0700 (PDT)
In-Reply-To: <7vsj2e2x5d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222443>

On Thu, Apr 25, 2013 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>>> ...
>>>>>> +             git for-each-ref --format='%(refname) %(objectname)' |
>>>>>> +             while read ref a
>>>>>>               do
>>>>>> -                     test $a == $b && continue
>>>>>> +                     case "$before" in
>>>>>> +                     *"$ref $a"*)
>>>>>> +                             continue
>>>>>
>>>> I wonder if we should bother with this at all. The purpose of the code
>>>> was mainly to show to users that they should report the success only
>>>> if the refs have been updated, but the code is becoming more
>>>> obfuscated, a comment should do the trick. And then, we can just
>>>> report success for all the refs (and explain in the comment why).
>>>
>>> Are you proposing to say "ok $ref" to everything we see in the
>>> resulting repository, even the ones the caller of remote-testgit did
>>> not ask us to do anything with?
>>>
>>> Wouldn't the caller be surprised if we did so?
>>
>> Why would it?  The only effective difference is what you'll see
>> reported in the UI, but there's no user here.
>
> You are correct that it affects only the UI, but isn't that because
> the current implementation of push_update_refs_status() blindly
> accepts whatever 'ok' response says without checking the ref
> mentioned against what it tried to push out?  I was wondering if
> that codepath should stay that way forever, or if we may want add
> sanity checks later.  If the latter, I suspect this would manifest
> as an ancient bug to say 'ok' for everything we have instead of what
> we actually pushed out (of course, the explanation in the comment
> would help).

Actually, I think the code already checks for that.

> So I am OK with that simpler approach.  Care to roll the conclusion
> of your idea into a patch?

Will do.

> By the way, I noticed that Documentation/gitremote-helpers.txt does
> not even mention these 'ok' responses for 'export' command, but they
> should be the same as responses to 'push'. Perhaps we can share some
> text between the two?

Indeed, it's the same code for both.

-- 
Felipe Contreras
