From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v6 2/3] bisect: rewrite `check_term_format` shell function
 in C
Date: Fri, 13 May 2016 12:29:59 +0530
Message-ID: <CAFZEwPP+w4BOU+jKSRqGLBx-1f9JtZCq5bj-kkg4-Yw_omeswg@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-3-git-send-email-pranit.bauva@gmail.com>
	<xmqq37pmdhtk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 09:00:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b174x-0000qf-0c
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 09:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbcEMHAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 03:00:01 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34393 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcEMHAA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 03:00:00 -0400
Received: by mail-yw0-f174.google.com with SMTP id j74so94977710ywg.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 23:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=E45w4XxLUCMoLEDkwDGnx0wSmHCOm8DSANhSJPl2ruU=;
        b=IdyZkFjS3GJsbO2t0BsPW5I7R38DEhebO8snvAdWJkhvLtZ/iNrqVanDaz/sC3vl4h
         4sc4C57RwbVxQrtZZPzwuNyfFte4Ivdec5ZNPb4ow/OoZw/9cg/nS+YiVrP/nJSSjc3T
         yXib56GiYzzlCuoxmRb5UzzoHk8mQsTvX+IK015O7L1pupPTQY09qJo/gIMe1P8b/Guz
         fLY9mSR8j/O8pCjY8xjSs1rWwXKTM9ea9HHK8xIIIh2VLUUEAVN6Ts/QlEXDecqvrxv8
         jG7Nxb1vT3CcAeZk3hbW/DekJC+5ifVewEwia5GhVz/wQGbekq+O9WDlafjutIAcVkGh
         gGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=E45w4XxLUCMoLEDkwDGnx0wSmHCOm8DSANhSJPl2ruU=;
        b=Zam95t4El2/zslr3jlO8U6LhiAKFqVgiSP/tCFEDuPHYbNk3OQtZv9lX1M0u9YI+Gr
         n1B4GTnpLhALexK+G/H2lysFTh1czvx+iakrz7JQTWKiFsZT/XmguKWRhiLyzw5l+9Pf
         /ZERO+gUi/G0c8N1vdpL4MilLj3qKRH4vhTBUh03FzpevpEf48r3RUUD3y2JUjj3MD/I
         fBte4CNxtMoaOKlej4RpTYzfE2F8c4Bb7DOUrnQtxhT9Hb7ZTiyAbK4ovEKvOXbM4Pxn
         mOdUYgoGAsWJbWqfiPpRf7rsMC4ViDRHRZjDP4JNTgbQh+941E8xIvxK60F3Zt3x21Eb
         m5cA==
X-Gm-Message-State: AOPr4FUyR1Mdr1pp2qOCFZkI3MIJVsuH7Cf4lKN38vhLh9m5gRP5rOHklv2x1A+0uINxYzXKDhFF7ZhZaWiCag==
X-Received: by 10.13.244.134 with SMTP id d128mr6804830ywf.72.1463122799262;
 Thu, 12 May 2016 23:59:59 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 23:59:59 -0700 (PDT)
In-Reply-To: <xmqq37pmdhtk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294512>

On Fri, May 13, 2016 at 4:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +     /*
>> +      * In theory, nothing prevents swapping completely good and bad,
>> +      * but this situation could be confusing and hasn't been tested
>> +      * enough. Forbid it for now.
>> +      */
>> +
>> +     if ((strcmp(orig_term, "bad") && one_of(term, "bad", "new", NULL)) ||
>> +              (strcmp(orig_term, "good") && one_of(term, "good", "old", NULL)))
>> +             return error(_("can't change the meaning of the term '%s'"), term);
>
> The above comes from below
>
>> -     bad|new)
>> -             if test "$2" != bad
>> -             then
>> -                     die "$(eval_gettext "can't change the meaning ...
>
> So it is not your fault, but it is quite hard to understand.
>
> The original says "You are trying to use 'bad' (or 'new') for
> something that is not 'bad'--which is confusing; do not do it".
>
> I _think_ the reason I find C version harder to read is the use of
> strcmp(orig_term, "bad") to say "orig_term is not BAD".  The shell
> version visually tells with "!=" that the meaning of the new term is
> *NOT* "bad", and does not ahve such a problem.
>
> Perhaps if we rewrote it to
>
>         if ((!strcmp(orig_term, "good") &&
>              one_of(term, "bad", "new", NULL)) ||
>              (!strcmp(orig_term, "bad") &&
>              one_of(term, "good", "old", NULL)))
>
> i.e. "If you are using "bad" or "new" to mean "good", that is not a
> good idea", as a follow-up change after the dust settles, the result
> might be easier to read.

Not just that, it would also be fundamentally more correct as there is
a difference between " !strcmp("good") " and " strcmp("bad") ". Yours
approach suggests that it should be "good" specifically which is
technically more correct as then only it would be sensible to check
whether it is trying to change the meaning of the term.

> But this is just commenting for future reference, not suggesting to
> update this patch at all.  If we were to do the change, that must
> come as a separate step.
>
> Thanks.

Will do this change in a separate patch after the dust settles.

Regards,
Pranit Bauva
