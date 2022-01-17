Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A52C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiAQTt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 14:49:56 -0500
Received: from mout.web.de ([212.227.15.4]:54641 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231292AbiAQTt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 14:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642448987;
        bh=6ysN4hLAyOVqAZlI/n+FRxpZZVZdnsWrNHsAc5O5HT0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=V4sBgSs4xi7vyb6Ix/BGNWstqj8vvEbQEzh4z+8L9B9hYW12zxxij6FypoYC8cmT1
         k4PAeVM1uFLYX4DOm45uU5fJCOfwseWFvtU2+Dq14dHLmPQtEe3LVbwWt42y18d008
         FnH7Mle/himMAEx00n4d+2n+tIXLfHYnMWroSuPY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1mLrlX1mL6-00wjfu; Mon, 17
 Jan 2022 20:49:47 +0100
Message-ID: <5c65baaa-ad51-e7e3-c811-1860edb7fff4@web.de>
Date:   Mon, 17 Jan 2022 20:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] cache.h: auto-detect if zlib has uncompress2()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-1.1-9cea01a1395-20220117T170457Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yjCsGIYa5fzsXW507JBpNQXRyMs35alapo3o6z5XoUc4khy2IHb
 r8hMHuBkybsiYEh4Ziwd342w8yOOidq7httuNwEQAb21+U4BRxzuXQsrTooHdA1HYLBtqGN
 NCgcf1cPOzwU+Qd7hHPRqHqHpzRirV3/GDKSYxRuA9fRhryltbH41HVpGLNnQSjcu9AuBrY
 jH32XnP0xAcpH22/KeLXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BW7lnUYdZK8=:wbI8YvlxMp1AEsiG3DZSLc
 ONJXC1CaKqUCmh3OTSANtAe0tmdhWatSVuqNv8U0q3HaN070uZPRFayc7P4eTM5PoS9k/5BCJ
 UJr4VS3smz3+djc2C2SM6U+XeY6YIZBhLLJM/3mhAkjgBbK6Y/tLq2r9LTseLMp1EDG2iqSXc
 A5o29SqPBSjgocgl2fsKW5UOU+U1Ktl1pBUdZEZvbbxi+GxRgiAef2EZq82tgfGYt/UIDcN/U
 GUS8oD3pPM3SbZQmpg6G8azoXbTifmp6Irxc1pf8m3ugCvscSVBLnjWR/WLESa/F/n0PQfchu
 JYqVuKAehJndrX1kHyP0M9SMLs4MmC9qc1w+5N6vswt0ONNtDQx++ESM9mf7VzeRA4HRfPD6F
 /5jknkrKT7bQKQFQhTc19I3gX4Jn8FG0bi76W2+xnRj1Ewps5eWc/st/NkWyjoLoY9Q9zDNl2
 lDpWGm+3viTk/jedE3pXkmVhHlyPGcPLja7YiHiD12CbPWi3ArFVyQLgcfVX+qKbbFAt6kDTY
 b4ct+XDdz6TbvgHrRm22eQIUTrbX0y9OQaL+57nCofpJ5EIF6MkIk9aM0tCMffZxBFWE8KNtA
 Sp2fuLoz8Sp294xMScN7VpM5scpnhFR2wiPP9I8qD4bq3MpbGn2vSalWHQ1SkKwzCIz/cyKLe
 N9kHl/24FnD+zHhvQWwK4ncVwQMNanIOMSCBV8mo2sF0GsyUnoamMn3coWCIhzKCQz+9BL5YG
 eIApLSXbxYnNDrXyKqgqVm99D1MXOZSGNb4sR4I8/mr/rBJGAuu9Fl2RuiNea0tRcxOdC642m
 bzxEHYhQ7axZU+BvZZi+4QvIgJ3TWubzJ24MY1gLbzEOQuD0BgriVaiB5Q7aP/0VNsQw2tF0X
 MIJe5crRBqQxMmPzqd00eXPZZTg3eadur5CVmei15HmqAsRA++ke9znQCU7VgsYuhoy7bc7/k
 Jyj+4BmKm/+HTXwMUhkgo3aOZ3bD6kG9i/aXK8oBaF0x2dZxZ5BLKA+HOgB7+S+mYUAboTv7E
 JWCngOEuCBsGk3WjxXKo71de4q0ARgSp2zD7PbcxRle4B2i8wb79gepZmMAw5FfZ6SfT94I+Q
 NMcyVY+FNil4Vo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.01.22 um 18:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change the NO_UNCOMPRESS2=3DY setting to auto-detect those older zlib
> versions that don't have uncompress2().
>
> This makes the compilation of git less annoying on older systems,
> since the inclusion of a322920d0bb (Provide zlib's uncompress2 from
> compat/zlib-compat.c, 2021-10-07) in v2.35.0-rc0 our default
> dependency on a zlib 1.2.9 or newer unless NO_UNCOMPRESS2=3DY is
> specified has resulted in errors when git is compiled.
>
> To get around those errors we've needed to bundle config.mak.uname
> changes such as such as 68d1da41c4e (build: NonStop ships with an
> older zlib, 2022-01-10) and the in-flight
> https://lore.kernel.org/git/20220116020520.26895-1-davvid@gmail.com/.
>
> Let's instead rely on ZLIB_VERNUM. Now only those systems where zlib
> is so broken that it can't be rely on (such a system probably doesn't
> exist) need to provide a NO_UNCOMPRESS2=3DY.
>
> See 9da3acfb194 ([PATCH] compat: support pre-1.2 zlib, 2005-04-30) and
> 609a2289d76 (Improve accuracy of check for presence of deflateBound.,
> 2007-11-07) for in-tree prior art using ZLIB_VERNUM.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>
> I think this should be strongly considered for inclusion before the
> final v2.35.0 release.
>
> Aside from the ones already (and in-flight) in config.mak.uname, I've
> run into numerous other cases where NO_UNCOMPRESS2=3Dy is needed (so far
> gcc{10,14,45,111,119,135,210} on the GCC farm). Adding
> config.mak.uname detections to those would be tedious, we'd need to
> start detecting various other OS versions.
>
> Or, we can just ask zlib.h abuot its ZLIB_VERSION instead, and include
> compat/zlib-uncompress2.c in our own zlib.c wrapper.
>
> This has an interaction with da/rhel7-lacks-uncompress2-and-c99 (the
> merge should preferably delete the NO_UNCOMPRESS2=3DY it adds), it's in
> "next", but I didn't base this on that topic as "nex" clearly won't be
> merged down before v2.35.0.
>
>  Makefile                  |  6 ++++--
>  cache.h                   |  5 +++++
>  compat/zlib-uncompress2.c |  5 +----
>  config.mak.uname          |  6 ------
>  reftable/block.c          |  2 +-
>  reftable/system.h         | 12 +-----------
>  zlib.c                    |  3 +++
>  7 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 5580859afdb..3e90820bbfd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -256,7 +256,10 @@ all::
>  #
>  # Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
>  #
> -# Define NO_UNCOMPRESS2 if your zlib does not have uncompress2.
> +# Define NO_UNCOMPRESS2 if your zlib is older than v1.2.9 and does not
> +# have uncompress2. You should not need to define this unless your
> +# zlib's ZLIB_VERNUM is broken. We'll auto-detect this on the basis of
> +# that macro.
>  #
>  # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile fe=
edback,
>  # as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?i=
d=3D49299)
> @@ -1728,7 +1731,6 @@ endif
>
>  ifdef NO_UNCOMPRESS2
>  	BASIC_CFLAGS +=3D -DNO_UNCOMPRESS2
> -	REFTABLE_OBJS +=3D compat/zlib-uncompress2.o
>  endif
>
>  ifdef NO_POSIX_GOODIES
> diff --git a/cache.h b/cache.h
> index 281f00ab1b1..02b355fcf08 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -29,6 +29,11 @@ typedef struct git_zstream {
>  	unsigned char *next_out;
>  } git_zstream;
>
> +#if defined(NO_UNCOMPRESS2) || ZLIB_VERNUM < 0x1290
> +#define GIT_NO_UNCOMPRESS2 1
> +int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
> +		uLong *sourceLen);
> +#endif
>  void git_inflate_init(git_zstream *);
>  void git_inflate_init_gzip_only(git_zstream *);
>  void git_inflate_end(git_zstream *);
> diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
> index 722610b9718..915796e85ac 100644
> --- a/compat/zlib-uncompress2.c
> +++ b/compat/zlib-uncompress2.c
> @@ -8,15 +8,12 @@
>
>  */
>
> -#include "../reftable/system.h"
> -#define z_const

Why is it safe to remove this definition?  Because it's defined in
zconf.h, included by zlib.h.  But why did we need it in the first place?
Not caused by this patch, of course, but still strange.

> -
>  /*
>   * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adl=
er
>   * For conditions of distribution and use, see copyright notice in zlib=
.h
>   */
>
> -#include <zlib.h>
> +/* No "#include <zlib.h>", done in cache.h */

Well, it's rather something like "No #include, period.  Because this
file is not meant to be compiled on its own, but is included itself.",
isn't it?

>
>  /* clang-format off */
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 9b3e9bff5f5..d0701f9beb0 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -261,10 +261,6 @@ ifeq ($(uname_S),FreeBSD)
>  	FILENO_IS_A_MACRO =3D UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),OpenBSD)
> -	# Versions < 7.0 need compatibility layer
> -	ifeq ($(shell expr "$(uname_R)" : "[1-6]\."),2)
> -		NO_UNCOMPRESS2 =3D UnfortunatelyYes
> -	endif

No longer relying on OS version trivia like this is very nice.

>  	NO_STRCASESTR =3D YesPlease
>  	NO_MEMMEM =3D YesPlease
>  	USE_ST_TIMESPEC =3D YesPlease
> @@ -520,7 +516,6 @@ ifeq ($(uname_S),Interix)
>  	endif
>  endif
>  ifeq ($(uname_S),Minix)
> -	NO_UNCOMPRESS2 =3D YesPlease
>  	NO_IPV6 =3D YesPlease
>  	NO_ST_BLOCKS_IN_STRUCT_STAT =3D YesPlease
>  	NO_NSEC =3D YesPlease
> @@ -576,7 +571,6 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	NO_SETENV =3D YesPlease
>  	NO_UNSETENV =3D YesPlease
>  	NO_MKDTEMP =3D YesPlease
> -	NO_UNCOMPRESS2 =3D YesPlease
>  	# Currently libiconv-1.9.1.
>  	OLD_ICONV =3D UnfortunatelyYes
>  	NO_REGEX =3D NeedsStartEnd
> diff --git a/reftable/block.c b/reftable/block.c
> index 855e3f5c947..946edd0f34e 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -13,7 +13,7 @@ license that can be found in the LICENSE file or at
>  #include "record.h"
>  #include "reftable-error.h"
>  #include "system.h"
> -#include <zlib.h>
> +#include "zlib.h"

Why?  We don't have a local zlib.h and this patch doesn't add one.

And don't you need to rather include cache.h, to get the definition
of uncompress2 on systems that don't have it in their zlib.h?

>
>  int header_size(int version)
>  {
> diff --git a/reftable/system.h b/reftable/system.h
> index 4907306c0c5..2cebbc94d4d 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -15,17 +15,7 @@ license that can be found in the LICENSE file or at
>  #include "strbuf.h"
>  #include "hash.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> -
> -#include <zlib.h>
> -
> -#ifdef NO_UNCOMPRESS2
> -/*
> - * This is uncompress2, which is only available in zlib >=3D 1.2.9
> - * (released as of early 2017)
> - */
> -int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
> -		uLong *sourceLen);
> -#endif
> +#include "zlib.h"

Same here.  Or rather: Just here.  The include in reftable/block.c
can be removed safely, because it includes this reftable/system.h
here anyway.

>
>  int hash_size(uint32_t id);
>
> diff --git a/zlib.c b/zlib.c
> index d594cba3fc9..d9440dfb784 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -3,6 +3,9 @@
>   * at init time.
>   */
>  #include "cache.h"
> +#ifdef GIT_NO_UNCOMPRESS2
> +#include "compat/zlib-uncompress2.c"
> +#endif

Keeping the function definition in its own file in compat/ with its
own license note is a good choice for maintainability, I think.

>
>  static const char *zerr_to_string(int status)
>  {

