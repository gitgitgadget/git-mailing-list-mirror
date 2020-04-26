Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C2C55185
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E34A2071E
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 00:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWXh6NrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDZAy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726107AbgDZAy4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 20:54:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A9C061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:54:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d17so6752885pgo.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 17:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2ScNUujH48s3Z8klNqg5efrlow7MsBR+3AlJ9t1ZWsM=;
        b=hWXh6NrJlb3Pmc4t4zpoKZRgNJFcfYuEj07473bC2fIaQ+TZcrvWBuhrg1ImNcN2g9
         FLfSg0bvbNeqJb/QWvJSDweYYXvEoGxUv784+snqojgsPId5WAp3VeqyrdNS2NI03UTK
         uX6az87x9VT3Bpon1W/5ebBCn8sPbabcCCEGUFIu/tQ4hkmQJato0kEftrypueoOg+du
         ByafJNZYe7nUFGyQU3YpR3N+CwoFu4NY8KZU1pRijSaI70dhYtx8ZpTWJwY2by3Ivj5S
         drj2qF2qhy/FQXjAiu6Xj12s0VjZGSeP38kRBT4jTkhgtqAQRtagIQgMyRU+hO/dcCNM
         bLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2ScNUujH48s3Z8klNqg5efrlow7MsBR+3AlJ9t1ZWsM=;
        b=q5blLDowyGXUCpiCZ2h4GKlVbGWEYny1CkUao0o/be06WhVENkW9ijrWlYKsnWuvFl
         plDtncKwjJoztqLZaTWDekOu1I4ao/LQyAEAVUEtqr7gvzQKZpYKN868GO5WhVBKjZJu
         KJIOq/bQyJIzF37X5BbYAZxa+pRSyeMRYGw2Mcl80wU7KMH+/NKbFdJnxSfGiGMpmwEi
         LI2ECyPd6VzCxH89XdeZ15GYCVE0dQcjbuKcXOiQV6/4SmC+8zA+7LCJqOl9iHcUtFcM
         ngbPoB/JiQXsolff76eoUlGLF42uCA2+dz4jiAYy81fKxdts5Un8xpZZCkfMBk0W5YIN
         cAJQ==
X-Gm-Message-State: AGi0PuYR/cjdt3k7ofmFzCIn5s7NWgvG4vNJDxMnMvagV6IfHjzyLQTI
        kF4g/1LcdNbUTc9FBMkeUowgTQ6aN7w=
X-Google-Smtp-Source: APiQypIqCREWGX7qV0rUeVWl4TkQTdLOgxKLQoCAYH2zvKlin5IiWolf4fFdIVdPM6faRrQv04tIeQ==
X-Received: by 2002:a62:be19:: with SMTP id l25mr16423638pff.304.1587862494138;
        Sat, 25 Apr 2020 17:54:54 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id y186sm7854113pgb.69.2020.04.25.17.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 17:54:53 -0700 (PDT)
Date:   Sun, 26 Apr 2020 07:54:51 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-25 21:28:05+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wro=
te:
>=20
>=20
> On 24/04/2020 23:34, Danh Doan wrote:
> [snip]
>=20
> > OK, I've tried with my glibc box, it doesn't have that warning.
> > On musl, it warns:
> >=20
> > 	$ make compat/regex/regex.sp
> > 	GIT_VERSION =3D 2.26.2
> > 	    * new build flags
> > 	    SP compat/regex/regex.c
> > 	/usr/include/alloca.h:14:9: warning: preprocessor token alloca redefin=
ed
> > 	compat/regex/regex.c:66:9: this was the original definition
> > 	compat/regex/regex_internal.c:925:1: error: symbol 're_string_context_=
at' redeclared with different type (originally declared at compat/regex/reg=
ex_internal.h:433) - different modifiers
> >=20
> >=20
>=20
> OK, I had a quick look at the <alloca.h> header file on a glibc
> system (linux) and new-lib system (cygwin) and they both do
> (more or less) the same thing: first #undef alloca, and then
> if being compiled by gcc, define alloca(size) to be __builtin_alloca(size=
).

musl people don't do that.
They just go ahead define it, if any other header file requires
alloca, they will include alloca.h

> So, even if <alloca.h> is #included after regex.c:66, it wouldn't
> be a problem. Since I don't have access to a musl based system,
> I don't know what that system header is doing.

musl's alloca.h is available here:

https://git.musl-libc.org/cgit/musl/tree/include/alloca.h

> However, I said *even if* above, because I don't see why it is trying
> to #include <alloca.h> in the first place! ;-)

I looked into my system again. The inclusion chain is:

compat/regex/regex.c:77
`-> compat/regex/regex_internal.h:26
    `-> /usr/include/stdlib.h:138 [*1*]

[*1*]: https://git.musl-libc.org/cgit/musl/tree/include/stdlib.h#n137

I don't know why _GNU_SOURCE and/or _BSD_SOURCE is defined.

>   $ make V=3D1 NO_REGEX=3D1 compat/regex/regex.sp
>   cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-s=
ecurity -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototyp=
es -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-b=
ody -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter=
  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DHAVE_ALLO=
CA_H  -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSH=
A1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h=
\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA256_=
BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTO=
NIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFREAD_=
READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex -DSHELL_PATH=3D'"/bin/sh"' -D=
PAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DGAWK -DNO_MBSUPPORT \
>   	  compat/regex/regex.c
>   $=20
>  =20
> ... is not being set on the command-line.

Here's the invocation of cc and cgcc:

	$ make V=3D1  compat/regex/regex.o
	cc -o compat/regex/regex.o -c -MF compat/regex/.depend/regex.o.d -MQ compa=
t/regex/regex.o -MMD -MP -Werror -Wall -Wdeclaration-after-statement -Wform=
at-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prot=
otypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-emp=
ty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-param=
eter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE_L=
IBPCRE2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DICONV_OMITS_BOM -DSHA1_D=
C -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1D=
C_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=
=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHA=
VE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABL=
E_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/=
regex -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DGAW=
K -DNO_MBSUPPORT compat/regex/regex.c
	$ make V=3D1  compat/regex/regex.sp
	cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-secu=
rity -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototypes =
-Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-body=
 -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter  -=
g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE_LIBPCRE2=
 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DICONV_OMITS_BOM -DSHA1_DC -DSHA=
1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTO=
M_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"g=
it-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOC=
K_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=
=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex =
-DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DGAWK -DNO=
_MBSUPPORT \
	          compat/regex/regex.c

> Hmm, do you have this set in config.mak, config.mak.autogen, or some other
> source? puzzled! ;-)

I don't have `config.make.autogen`,
Here is config.mak

	$ cat config.mak
	USE_ASCIIDOCTOR=3DYes
	DEVELOPER=3D1
	DEFAULT_TEST_TARGET=3Dprove
	prefix =3D /home/danh/.local
	USE_LIBPCRE2=3DYesPlease
	ICONV_OMITS_BOM=3DYes
	NO_REGEX=3DYesPlease

> BTW, why are you compiling with NO_REGEX set anyway?

Because I use musl-libc, and musl-libc doesn't have StartEnd

--=20
Danh
