From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 16:14:03 -0700
Message-ID: <CAPc5daUF_yotXVf_=CFz_q1GBXVdq8pJxeuNuv=BAC54TJVT9w@mail.gmail.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
 <5661061272076a1883cfde1087be4a42@www.dscho.org> <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org> <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
 <1432070690.14498.4.camel@kaarsemaker.net> <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
 <1432072167.14498.12.camel@kaarsemaker.net> <xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
 <1432074626.14498.16.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed May 20 01:14:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuqiU-00054Z-19
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 01:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbbESXOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 19:14:25 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34836 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbESXOY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 19:14:24 -0400
Received: by oign205 with SMTP id n205so23139710oig.2
        for <git@vger.kernel.org>; Tue, 19 May 2015 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lEeSKQLLJHsAr9RkGaFFsiOurwcjPWo464n5D8Teexc=;
        b=a7XAeUHcJ4kijYq02ddHIAX9TW3s8JCTyUxJZHFlK5ejeo0Y4ZjNBMY1B9UTE1ZrHM
         4h/FlOwJCQhr4tKFtdaOxKC+aYAI5x8k2gBelgi2A4XXn//LsqO7DuXvhDeTrkslhekr
         PBFBJZ9g4p3wEmrXZowSWaSwqEPtjhwtaUNCS9WACqGIvDlnoFdPWWHVKgmOCk52R3ja
         YjrgjbIUMJnuQg+G3EJsBWDKi9KRfnnlSzGjYxYg5RA6GkyRWDL+iBqkYn3FnpA9QX5w
         OK6Pk0LcGm6MbnSI1+clOUIQjh2ZJwtyS48vvlfD5cTbTiVbr6VMZMtHG0tCwGpjg5ah
         AIhw==
X-Received: by 10.202.74.71 with SMTP id x68mr24290743oia.93.1432077263876;
 Tue, 19 May 2015 16:14:23 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 19 May 2015 16:14:03 -0700 (PDT)
In-Reply-To: <1432074626.14498.16.camel@kaarsemaker.net>
X-Google-Sender-Auth: LDnWXzd5dsNC1BxCWM257UQKh4Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269431>

On Tue, May 19, 2015 at 3:30 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On di, 2015-05-19 at 15:10 -0700, Junio C Hamano wrote:
>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>
>> > I've actually done it differently while implementing:
>> >
>> > 1) Make test_commit recognize --tags and stop creating tags unless
>> >    specified
>> > 2) while ! prove --state=save,failed {
>> >        Find and fix tests that now need --tags
>> >    }
>>
>> That was what I feared.  The result of that process is the hardest
>> to reason about and review.
>>
>
> I'm not quite sure I understand what you're trying to say. You seem to
> be worried that there will be silent successes for tests that should
> fail after N/N if I take the proposed approach. I have no idea how that
> could happen though.

You are placing too much faith in the tests. We would want to see a
conversion that
is reasonable and indeed reasoned by eyeballing the change for correctness.

Besides, there are different build options and test configurations. Even if you
run with EXPENSIVE defined, the only thing we can say without validating the
changes is the test happened to have passed. There is no assurance that the
result of your change will catch the same breakage, if inttroduced later to the
code (not tests), as the current unmodified tests will. Two mistakes may happen
to hide the breakage in tests. Taking to the extreme, if you replace
all the test
bodies in test_expect_success with "true", the result of such a
rewrite will still
pass all the existting tests, and the only way you can say "That's absurd" is
because you compare what the existing tests do and a single "true" would do
and realize that they do vastly different things. Your "while ! prove
..." method
does not give me much more faith than such a "rewrite everything to true without
looking" method.
