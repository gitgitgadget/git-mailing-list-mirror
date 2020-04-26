Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC99C55186
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231EC20706
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 01:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqhFvUQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZBKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZBKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 21:10:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3EFC061A0C
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:10:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q18so6733609pgm.11
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=noy2b+E99wuIEa193fZ2yR3zquo+tuiUbkXG1PexDFY=;
        b=qqhFvUQDStpqVv2k/m5nX/MLlMfVuXBCuMICj8yk9oMl8XBNs5GW23SrGzuPYN0viC
         YlTDG2JMPGn7jFpmbBMTstSilFU97eQpmqhQk8YBCeXHboi9ZYSWkvUm1esQZTBhndIx
         q5NJrPWptbVqsXq8JkhEmhE81qc37zDtdp3fkEtPLoxpzR0IHnOC7EsQdglsUd9iLcyz
         jri4BPzDM3l/Kg97SA2SH85A4mhsHYXQUYeZj6+daC162Bvmx2ZiiJ3zYLKW5GBfXgMk
         zBCsoGICjOMm/gIQjRExLmobRhDA+oKQKK8l7kg/8ZK72mdlKs2MdtHbjkhNCCysl19a
         BZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=noy2b+E99wuIEa193fZ2yR3zquo+tuiUbkXG1PexDFY=;
        b=Tf+uHoL2O6Skqwq7Th/Fyo3wBuqeNcOEswIz4gw0qa/3Zds1dN+iPPBxRBQmKR3EjT
         VksryZ/awdNkU/o8YkYnYHTfM64TqIJ+6nVxXiu0NkP3AhZdd/BReXZy2ZnyNgnMSe4v
         Zx1f5GeNVAZWGNKmHxOO9cVlxOnbNTyn3i05DM5TheMK5OyrnecOEciNETfSPnFGdsJo
         YK9yH3z9mXmvj7lPrhJnT+oMB+Bm5ciX+gIT1IqPOXmW6kyyeQxr4+DcN7K5VHznKAdt
         9uNlHrYAIPNI9yLbip6AlxxXVkXaQjYhB3JEie3QwiyL5b4TZ+FOXqy37fahtpzt9p5P
         nolw==
X-Gm-Message-State: AGi0Pubs2SBMKvrXvj4bOaPju0pRxqza7cGitOA2IMQ4J1UUZW9TdfZy
        gOnVYZkfPqgZKct/hPSqzX5Vqzz79As=
X-Google-Smtp-Source: APiQypLyQstsKkX0gioCQdwZX5NcDBbbaShTB4TUjKNgx7FVQCGZV3Mtpbh4Yk/LlCfEi0ZCc/SZbg==
X-Received: by 2002:a63:ca48:: with SMTP id o8mr16724358pgi.103.1587863415750;
        Sat, 25 Apr 2020 18:10:15 -0700 (PDT)
Received: from localhost ([2402:800:6374:bf12:8518:c5e6:e4cc:3967])
        by smtp.gmail.com with ESMTPSA id f10sm7995967pju.34.2020.04.25.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 18:10:14 -0700 (PDT)
Date:   Sun, 26 Apr 2020 08:10:13 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
Message-ID: <20200426011013.4dheltp2rumn3bad@danh.dev>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
 <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
 <20200424223440.GC721@danh.dev>
 <ffcaaf4f-a43f-2d20-b70d-dfb8b1d7c687@ramsayjones.plus.com>
 <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200426005451.f7pyoiijgbk4hpsj@danh.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-26 07:54:51+0700, Danh Doan <congdanhqx@gmail.com> wrote:
> On 2020-04-25 21:28:05+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> w=
rote:
> >=20
> >=20
> > On 24/04/2020 23:34, Danh Doan wrote:
> > [snip]
> >=20
> > > OK, I've tried with my glibc box, it doesn't have that warning.
> > > On musl, it warns:
> > >=20
> > > 	$ make compat/regex/regex.sp
> > > 	GIT_VERSION =3D 2.26.2
> > > 	    * new build flags
> > > 	    SP compat/regex/regex.c
> > > 	/usr/include/alloca.h:14:9: warning: preprocessor token alloca redef=
ined
> > > 	compat/regex/regex.c:66:9: this was the original definition
> > > 	compat/regex/regex_internal.c:925:1: error: symbol 're_string_contex=
t_at' redeclared with different type (originally declared at compat/regex/r=
egex_internal.h:433) - different modifiers
> > >=20
> > >=20
> >=20
> > OK, I had a quick look at the <alloca.h> header file on a glibc
> > system (linux) and new-lib system (cygwin) and they both do
> > (more or less) the same thing: first #undef alloca, and then
> > if being compiled by gcc, define alloca(size) to be __builtin_alloca(si=
ze).
>=20
> musl people don't do that.
> They just go ahead define it, if any other header file requires
> alloca, they will include alloca.h
>=20
> > So, even if <alloca.h> is #included after regex.c:66, it wouldn't
> > be a problem. Since I don't have access to a musl based system,
> > I don't know what that system header is doing.
>=20
> musl's alloca.h is available here:
>=20
> https://git.musl-libc.org/cgit/musl/tree/include/alloca.h
>=20
> > However, I said *even if* above, because I don't see why it is trying
> > to #include <alloca.h> in the first place! ;-)
>=20
> I looked into my system again. The inclusion chain is:
>=20
> compat/regex/regex.c:77
> `-> compat/regex/regex_internal.h:26
>     `-> /usr/include/stdlib.h:138 [*1*]
>         `-> /usr/include/alloca.h
>=20
> [*1*]: https://git.musl-libc.org/cgit/musl/tree/include/stdlib.h#n137

Sorry for the noise, but I should link to a specific tree instead of
their master for future refererence.

https://git.musl-libc.org/cgit/musl/tree/include/stdlib.h?id=3D8e452abae67d=
b445fb6c3e37cd566c4788c2e8f3#n137

>=20
> I don't know why _GNU_SOURCE and/or _BSD_SOURCE is defined.
>=20
> >   $ make V=3D1 NO_REGEX=3D1 compat/regex/regex.sp
> >   cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat=
-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-protot=
ypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty=
-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-paramet=
er  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DHAVE_AL=
LOCA_H  -DUSE_CURL_FOR_IMAP_SEND -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -D=
SHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache=
=2Eh\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\"git-compat-util.h\"" -DSHA=
256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MO=
NOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH=3D"/proc/self/exe"'  -DFR=
EAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex -DSHELL_PATH=3D'"/bin/sh"=
' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DGAWK -DNO_MBSUPPORT \
> >   	  compat/regex/regex.c
> >   $=20
> >  =20
> > ... is not being set on the command-line.
>=20
> Here's the invocation of cc and cgcc:
>=20
> 	$ make V=3D1  compat/regex/regex.o
> 	cc -o compat/regex/regex.o -c -MF compat/regex/.depend/regex.o.d -MQ com=
pat/regex/regex.o -MMD -MP -Werror -Wall -Wdeclaration-after-statement -Wfo=
rmat-security -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-pr=
ototypes -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-e=
mpty-body -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-par=
ameter  -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE=
_LIBPCRE2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DICONV_OMITS_BOM -DSHA1=
_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA=
1DC_CUSTOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK=
_C=3D"\"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -D=
HAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTA=
BLE_PATH=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompa=
t/regex -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DG=
AWK -DNO_MBSUPPORT compat/regex/regex.c
> 	$ make V=3D1  compat/regex/regex.sp
> 	cgcc -no-compile -Werror -Wall -Wdeclaration-after-statement -Wformat-se=
curity -Wold-style-definition -Woverflow -Wpointer-arith -Wstrict-prototype=
s -Wunused -Wvla -DENABLE_SHA256 -Wextra -Wmissing-prototypes -Wno-empty-bo=
dy -Wno-missing-field-initializers -Wno-sign-compare -Wno-unused-parameter =
 -g -O2 -Wall -I. -DHAVE_SYSINFO -DGIT_HOST_CPU=3D"\"x86_64\"" -DUSE_LIBPCR=
E2 -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND -DICONV_OMITS_BOM -DSHA1_DC -DS=
HA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=3D0 -DSHA1DC_CUS=
TOM_INCLUDE_SHA1_C=3D"\"cache.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C=3D"\=
"git-compat-util.h\"" -DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CL=
OCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PAT=
H=3D"/proc/self/exe"' -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -Icompat/regex=
 -DSHELL_PATH=3D'"/bin/sh"' -DPAGER_ENV=3D'"LESS=3DFRX LV=3D-c"' -DGAWK -DN=
O_MBSUPPORT \
> 	          compat/regex/regex.c
>=20
> > Hmm, do you have this set in config.mak, config.mak.autogen, or some ot=
her
> > source? puzzled! ;-)
>=20
> I don't have `config.make.autogen`,
> Here is config.mak
>=20
> 	$ cat config.mak
> 	USE_ASCIIDOCTOR=3DYes
> 	DEVELOPER=3D1
> 	DEFAULT_TEST_TARGET=3Dprove
> 	prefix =3D /home/danh/.local
> 	USE_LIBPCRE2=3DYesPlease
> 	ICONV_OMITS_BOM=3DYes
> 	NO_REGEX=3DYesPlease
>=20
> > BTW, why are you compiling with NO_REGEX set anyway?
>=20
> Because I use musl-libc, and musl-libc doesn't have StartEnd
>=20
> --=20
> Danh

--=20
Danh
