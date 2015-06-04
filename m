From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH mh/lockfile-retry] lockfile: replace random() by rand()
Date: Thu, 4 Jun 2015 08:57:57 -0700
Message-ID: <CAPc5daXsvYppq0=2EU=Ah=MMWtva4_Q8325h7g1phGiDx0RAgg@mail.gmail.com>
References: <55695770.2040303@kdbg.org> <xmqq7frqat0m.fsf@gitster.dls.corp.google.com>
 <55700F10.8030806@kdbg.org> <557039AE.3020107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 04 17:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0XXE-0006PB-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 17:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbbFDP6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 11:58:19 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36153 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbFDP6S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 11:58:18 -0400
Received: by oihb142 with SMTP id b142so34447657oih.3
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 08:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Up7eGUt1bUYubPAYO2Q+EKq0PkJCG6sDHU7K07+Tiok=;
        b=QKhscfBnIVuozKkWCFAf88Yo1cSbXzK2MztO7gwvpd2sEMY/tawvLGpqmh96+yKkyy
         VEUGTHdz/ZdS+ystUhAjBq+30Y5VOaOiUI833OwJG7Zc+px6BnaVa2w20ymUjC7eII5T
         WRQUHAFE/z++wSLJZ/7iGBsBOO8J+s9q16sthpVgJpc/t8KKOjErtEaWKLCu2jj3HoKG
         6neuaTLV9Fgs0H3xO/QxGFMqGfMLzbCo6uHu95XXAqQavLrV3+tHIjuaxuW/xsJc1Vff
         NCFP96yIJieCQU18zGOLoIDAsRfLsfdeBetf8xjvU0oL/u4VtlnUtcxzbFsKw2bZvu28
         VaLw==
X-Received: by 10.182.230.12 with SMTP id su12mr18409039obc.0.1433433498399;
 Thu, 04 Jun 2015 08:58:18 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Thu, 4 Jun 2015 08:57:57 -0700 (PDT)
In-Reply-To: <557039AE.3020107@alum.mit.edu>
X-Google-Sender-Auth: 6gYv7BtoILXMCgmIyHjPkmkHiq8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270781>

On Thu, Jun 4, 2015 at 4:42 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/04/2015 10:40 AM, Johannes Sixt wrote:
> We *certainly* don't require high-quality random numbers for this
> application. Regarding portability, there is one definite point in favor
> of rand() (it's available on Windows) vs. Junio's recollection that
> random() might have portability advantages, presumably on other platforms.

I agree that anything is OK in this codepath. I just suspected that whichever
one we pick, there would be somebody who says "oh, my system lacks it",
and we will end up adding one of compat/{rand,random}.c to emulate.

And when I anticipated that future, my inclination was to prefer random(),
not rand(), used in the code, not the other way around. Yes, both are in
POSIX, but I was getting the impression that rand() is on its way out
(and rand_r() is already marked as obsolete).

> Maybe the easiest thing would be to switch to using rand() and see if
> the OS/2 and VMS users complain ;-)

We can certainly go that route and I am fine with that as the solution for
today, as long as somebody will remember this discussion when that
complaint comes, and make compat/random.c, and switch the
in-code use to random(), instead of sticking to use of rand() in code.
