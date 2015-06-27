From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Sat, 27 Jun 2015 06:10:07 +0200
Message-ID: <CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 06:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hSu-0003Td-DG
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbbF0EKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:10:10 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35178 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbF0EKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:10:08 -0400
Received: by wiga1 with SMTP id a1so31471700wig.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NiRIyFA+qYcjjaWrZ5UaN8pISRYmteDX9GaKoATFpQo=;
        b=xaOIhl7aVy2kfs40ZnmjfUoibAXaA3QJ6K/mNLMfc5+Qrb3VabS/8IUgtLsms7QNeM
         duYjWXuTpG4aJnv9SC1PKxwHS3q+Uy91jdW4E88q9pd62z8z8ummfE+QYKUOjApMQE0k
         MoEzVZ3YuXZb/zceSObqDtwAIxFNJtm6rVsiKktWndWZ1YBmcH1hnxVLUaBUxrETczmj
         rTwBMKkTNY39Zrw4MFxIUxAIUzbZ+zxAoMoc4dFiYgxUHfJuCfhCQUPlWUZ16SWR+Rgw
         3SfivCK9XYt7hzgfJoCcp0ACHMSwlt2HPLK+C3BvhY15q3Q8WbRWBmetOyMKHMn2Ynjn
         me0A==
X-Received: by 10.194.23.225 with SMTP id p1mr8975779wjf.155.1435378207409;
 Fri, 26 Jun 2015 21:10:07 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 21:10:07 -0700 (PDT)
In-Reply-To: <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272841>

On Sat, Jun 27, 2015 at 12:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>>
>>>> + git bisect terms <term-old> <term-new>
>>>
>>> I think this is the other way around.
>>
>> Indeed.
>
> I hate to be saying this, but this is a strong indication that
> consistency with "start $bad $good..." must be broken.  If the
> person who has been working on this topic for a few iterations in
> the past few days cannot get it right, no ordinary user can.  With
> or without a mnemonic hint "N comes before O, so does B before G".
>
> Of course we cannot just say "git bisect terms old new".  That would
> only invite "eh, I do not remember, which between terms and start
> take the old one first?" without helping people.
>
> The best I can come up with is to forbid positional arguments to
> this subcommand and always require them to be given like so:
>
>         git bisect terms --old=fast --new=slow
>         git bisect terms --new=slow --old=fast

If we don't want to support positional arguments, then I would suggest
supporting first the following instead:

         git bisect terms --name-good=fast --name-bad=slow
         git bisect terms --name-bad=slow --name-good=fast

This would make the interface consistent with the code.

Of course we could also accept --name-old and --name-new as synonyms
for --name-good and --name-bad.

> We may want to start supporting
>
>         git bisect start --new=master --old=maint

Maybe we could also support:

git bisect start --name-good=fast --name-bad=slow --fast=maint --slow=master
