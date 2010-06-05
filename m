From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 19:33:45 +0000
Message-ID: <AANLkTilRqVaVV5q-7NrserSDr0t4L1D_j8rNIWxtMYe1@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605030059.GB2019@progeny.tock>
	<AANLkTilSJ_1STKGvat0llqYVZRI8_tQriE-hIBJPEldn@mail.gmail.com>
	<20100605033849.GB2252@progeny.tock>
	<AANLkTim3PcoLrYb46Bh3tK7Ir3v-K0EQ0czPaD5DIIOK@mail.gmail.com>
	<20100605185926.GA5273@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 21:33:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKz7w-0002HX-Ty
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 21:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab0FETdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 15:33:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59888 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588Ab0FETdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 15:33:46 -0400
Received: by iwn37 with SMTP id 37so2139696iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IhkV67ohMXoJjC1er1kvd5BudU2ySWc9kxp50g/zp2o=;
        b=YmJnhfRnmeLDj81shqpFtC23ApsgUJUft4IpaqsWoXRNQ2dDIK68vMhhp6Y60z0dP1
         B0HwYRUmzbJN2VwUZwRzUhcitwyy9xSsfhFVH8uZftQKXEoYhjmk1GkuV9TY0tK97RdE
         cYwazBUwuD/chBJhdyG4BICWad80Z4KB+szqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NUuwBcqJg8O4gmZe9BU+MewGzGvR6xDGIfDcHgM7W0CsnYtnIrtbpcF/50WvWUTLvN
         zzuHskpYCfRBOQBZO7w8uEfzKbHnLBJ0qvlWm2azYqXAhs7keAR/O33mpOYw/GZsqiJn
         5dmQ+ek6b+k/VevudZzQpYuQKD3Qrc68Xmft4=
Received: by 10.231.124.17 with SMTP id s17mr2499452ibr.181.1275766425717; 
	Sat, 05 Jun 2010 12:33:45 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 12:33:45 -0700 (PDT)
In-Reply-To: <20100605185926.GA5273@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148489>

On Sat, Jun 5, 2010 at 18:59, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Hi =C3=86var,
>
> Thanks for trying it out.

And thanks for your comments helping to make the series better.

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> --- a/gettext.c
>> +++ b/gettext.c
>> @@ -1,11 +1,8 @@
>> -#ifdef NO_GETTEXT
>> -void git_setup_gettext(void) {}
>> -#else
>> =C2=A0#include "exec_cmd.h"
>> =C2=A0#include <libintl.h>
>> =C2=A0#include <stdlib.h>
>>
>> -void git_setup_gettext(void) {
>> +inline void git_setup_gettext(void) {
>
> This should not be inline when NO_GETTEXT is unset, since other
> translation units don=E2=80=99t get a chance to see the definition.

I'm not familiar with what you mean, since I'm not that familiar with
the semantics of inline in C/GCC.

As an aside, I'd appreciate a document pointer, what are the
implications here exactly?

>> diff --git a/gettext.h b/gettext.h
>> index a99da6a..8d44808 100644
>> --- a/gettext.h
>> +++ b/gettext.h
>> @@ -1,7 +1,11 @@
>> =C2=A0#ifndef GETTEXT_H
>> =C2=A0#define GETTEXT_H
>>
>> -void git_setup_gettext(void);
>> +#ifdef NO_GETTEXT
>> +static inline void git_setup_gettext(void) {}
>> +#else
>> +inline void git_setup_gettext(void);
>> +#endif
>
> With s/^inline \(.*;\)/extern &/, to make it:
>
> =C2=A0-void git_setup_gettext(void);
> =C2=A0+#ifdef NO_GETTEXT
> =C2=A0+static inline void git_setup_gettext(void) {}
> =C2=A0+#else
> =C2=A0+extern void git_setup_gettext(void);
> =C2=A0+#endif
>
> this part is exactly how I was imagining it (i.e., like might_fault()
> in linux-2.6/include/linux/kernel.h and many other examples).

Done:

    diff --git a/gettext.c b/gettext.c
    index 4825799..407fbc0 100644
    --- a/gettext.c
    +++ b/gettext.c
    @@ -2,7 +2,7 @@
     #include <libintl.h>
     #include <stdlib.h>

    -inline void git_setup_gettext(void) {
    +extern void git_setup_gettext(void) {
     	char *podir;
     	char *envdir =3D getenv("GIT_TEXTDOMAINDIR");

    diff --git a/gettext.h b/gettext.h
    index 8d44808..7c36c1e 100644
    --- a/gettext.h
    +++ b/gettext.h
    @@ -4,7 +4,7 @@
     #ifdef NO_GETTEXT
     static inline void git_setup_gettext(void) {}
     #else
    -inline void git_setup_gettext(void);
    +extern void git_setup_gettext(void);
     #endif

     #ifdef NO_GETTEXT
