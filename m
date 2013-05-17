From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 20:59:38 -0500
Message-ID: <CAMP44s1atVbN6CXAud4XzkKjAJOwoobF5uiXX12pBut0Becydw@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 03:59:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud9xR-0002Ng-4X
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 03:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab3EQB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 21:59:40 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58071 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab3EQB7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 21:59:40 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so149858lbi.39
        for <git@vger.kernel.org>; Thu, 16 May 2013 18:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=21V35BpU8jqwOQaD7t04kpB9Af/6d5XO66wuvIoBS9I=;
        b=FwZEIM7ICSB4rcKz9XnG4aKJWxJBxFKRdNEIiZimQNK46IMsu2TVEc1CLRQ2TQS8KX
         EXFEbIPyTzACKlczvcC5io1H9YJVFa3hu910Y1BCGPGZHJ4jmJrokchkyQ+EAHW6Rkw8
         g1Ct/zgQ7MWNvWFO0LC9Yd1Wp0NLy1p+EFgZBVDcZyMPcnkutKTJlVaOv3kvE4x0WQU/
         AJDm6zMmf91F+WCt9ee6AO3HAalNeA5jjvChFBx60SEImsFBwpPVcw2bsdh0Fof2OwCK
         dkt48DmbeAjzCEsU91C6PEDGpyCPHaLZtviQOd3390nyykgHuau0sAzTnQmRbWHhSeAv
         22mQ==
X-Received: by 10.112.163.71 with SMTP id yg7mr11716001lbb.8.1368755978459;
 Thu, 16 May 2013 18:59:38 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 18:59:38 -0700 (PDT)
In-Reply-To: <7vzjvu1jes.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224647>

On Thu, May 16, 2013 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?
>>
>> You would weigh pros-and-cons of supporting such a "single branch
>> only" special case, and add a branch level override, and if the
>> benefit outweighs the cost of complexity, design and implement it.
>>
>> The push.default setting is to make sure we have a simple mechanism
>> to cover more common cases, and my suspicion is what 'current' gives
>> us is already there without the need for 'single'.
>
> Actually, I suspect that you shouldn't even need to do that
> pros-and-cons analysis, because the 'single' thing should cover as a
> natural extension of the existing infrastructure.  You should only
> need to have something like this:
>
>         [remote "there"]
>                 url = ... were you push ...
>                 push = refs/heads/frotz:refs/heads/topics/frotz-for-juno
>                 push = refs/heads/*:refs/heads/topics/*
>
> Without the 'single', your 'frotz' will be pushed to update
> heads/topics/frotz-for-juno, not heads/topics/frotz, because the
> exact refspec match will prevent it from matched twice by the
> wildcarded one.  The imagined 'single' mode would just limit the
> push to the current branch, so it would end up pushing to the branch
> you want to update, without sending an extra copy to the same name.

And would 'git branch --set-downstream-to github/frotz-for-juno' do
that? If not it's basically useless for 99% of the users who never
fiddle with push refspecs.

-- 
Felipe Contreras
