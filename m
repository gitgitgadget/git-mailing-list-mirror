Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B34CE7A81
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 07:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjIYHqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjIYHq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 03:46:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BA12A
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 00:45:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3ab2436b57dso4015024b6e.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 00:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695627951; x=1696232751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+cpRQ6HTQbfwN3hb+HMHIJyqUzsgko0yjQV0tMzqhtU=;
        b=GHQBun/nfxd7sLQFctGWhfzT9Bw2u4gvqeRdhEhfHrG1rfVfcrre3sECvdjNSQPHlf
         ve3ya+FRYl3nTKOo3dX+OOjBZOlQLHw1odWg/maarmQlDIgZ/nbalLV0dhurH1nBuRWJ
         3K4izOJ7yrT7vumwxlPpvCI7Vftl2yMj6C9QN4ZUm3Nf7o1EGRZPuHbmbYJUIj6A0W71
         yeeW/l12SVwUI/2MbjJg+BD73QTt11hVH11zX6CxvOmYl57yMvxYF/LPNmi4Sn9X2Sa7
         jyeTFqS142FRyAYdaCQrDL+JUihmT8S/VlyqRzYwkkOzLt6N6TeMUcfXcob7qg56IiIV
         Q+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627951; x=1696232751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cpRQ6HTQbfwN3hb+HMHIJyqUzsgko0yjQV0tMzqhtU=;
        b=kN4xw/FtiHz7heiXphDs3Rbs625MsNi5JzC1bnMPpCZwegVZVZUaPxgRHMuRUWfx63
         0KADlMxa4WGyo53UscjEnChHRlZSGZ2OBaIxc2MgkYumhDAGUBA1cNhQ8mGrHrJ+v/kE
         v20wLqmKnxohrfwJP+ZJTV5mZLpiX3elo06X9D1MBesasrjlk+s2j66U7Ca59kwdNbSR
         Tvm/b96M175E5InQCZHlylq36jkJPlQuRrz7EAqzbD14XGpVcNjjn0W/Q7OcjNGR6WjT
         rxhMtYcEWcQ+lrKLJ/0WD+RFcgwUFJ2V19buZ+3hDLwi4ss2g60veBBI/H7+/ooxoOsj
         fR/g==
X-Gm-Message-State: AOJu0Yw17fl99FRA+Eqa27H51YkV5FoAwaK1SvY7jUwXbxNh7CeRAaOj
        GL42KvA9ixY0/nQQ/zahGKU=
X-Google-Smtp-Source: AGHT+IHHLnFhA4ykVZl8xw6Nvwy0fZbkXlgCENdpGSkU1wfvXjKQ+kJ6WngK7q7/IL+GUMfhNc2BFA==
X-Received: by 2002:aca:2305:0:b0:3ae:16b6:6349 with SMTP id e5-20020aca2305000000b003ae16b66349mr8395102oie.43.1695627950846;
        Mon, 25 Sep 2023 00:45:50 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7938c000000b00686236718d8sm7366967pfe.41.2023.09.25.00.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:45:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 314FD9960087; Mon, 25 Sep 2023 14:45:47 +0700 (WIB)
Date:   Mon, 25 Sep 2023 14:45:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <ZRE6q8dHPFRIQezX@debian.me>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MVSBK7dWghthYxJ8"
Content-Disposition: inline
In-Reply-To: <20230924033625.GA1492190@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MVSBK7dWghthYxJ8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 23, 2023 at 11:36:25PM -0400, Jeff King wrote:
> Your report also mentions a validation hook, so I tried installing one
> like:
>=20
> 	cat >.git/hooks/sendemail-validate <<-\EOF
> 	#!/bin/sh
> 	echo >&2 running validate hook
> 	exit 0
> 	EOF
> 	chmod +x .git/hooks/sendemail-validate
>=20
> and confirmed that the hook runs (three times, as expected). But still
> no error. I'm using v2.41.0 to test against.
>=20

Hi Jeff,

I think you missed perl version. As stated earlier, I'm on Debian testing
with perl v5.36.0. On there, `perl -V` outputs:

```
Summary of my perl5 (revision 5 version 36 subversion 0) configuration:
  =20
  Platform:
    osname=3Dlinux
    osvers=3D4.19.0
    archname=3Dx86_64-linux-gnu-thread-multi
    uname=3D'linux localhost 4.19.0 #1 smp debian 4.19.0 x86_64 gnulinux '
    config_args=3D'-Dmksymlinks -Dusethreads -Duselargefiles -Dcc=3Dx86_64-=
linux-gnu-gcc -Dcpp=3Dx86_64-linux-gnu-cpp -Dld=3Dx86_64-linux-gnu-gcc -Dcc=
flags=3D-DDEBIAN -Wdate-time -D_FORTIFY_SOURCE=3D2 -g -O2 -ffile-prefix-map=
=3D/dummy/build/dir=3D. -fstack-protector-strong -fstack-clash-protection -=
Wformat -Werror=3Dformat-security -fcf-protection -Dldflags=3D -Wl,-z,relro=
 -Dlddlflags=3D-shared -Wl,-z,relro -Dcccdlflags=3D-fPIC -Darchname=3Dx86_6=
4-linux-gnu -Dprefix=3D/usr -Dprivlib=3D/usr/share/perl/5.36 -Darchlib=3D/u=
sr/lib/x86_64-linux-gnu/perl/5.36 -Dvendorprefix=3D/usr -Dvendorlib=3D/usr/=
share/perl5 -Dvendorarch=3D/usr/lib/x86_64-linux-gnu/perl5/5.36 -Dsiteprefi=
x=3D/usr/local -Dsitelib=3D/usr/local/share/perl/5.36.0 -Dsitearch=3D/usr/l=
ocal/lib/x86_64-linux-gnu/perl/5.36.0 -Dman1dir=3D/usr/share/man/man1 -Dman=
3dir=3D/usr/share/man/man3 -Dsiteman1dir=3D/usr/local/man/man1 -Dsiteman3di=
r=3D/usr/local/man/man3 -Duse64bitint -Dman1ext=3D1 -Dman3ext=3D3perl -Dpag=
er=3D/usr/bin/sensible-pager -Uafs -Ud_csh -Ud_ualarm -Uusesfio -Uusenm -Ui=
_libutil -Ui_xlocale -Uversiononly -Ud_strlcpy -Ud_strlcat -DDEBUGGING=3D-g=
 -Doptimize=3D-O2 -dEs -Duseshrplib -Dlibperl=3Dlibperl.so.5.36.0'
    hint=3Drecommended
    useposix=3Dtrue
    d_sigaction=3Ddefine
    useithreads=3Ddefine
    usemultiplicity=3Ddefine
    use64bitint=3Ddefine
    use64bitall=3Ddefine
    uselongdouble=3Dundef
    usemymalloc=3Dn
    default_inc_excludes_dot=3Ddefine
  Compiler:
    cc=3D'x86_64-linux-gnu-gcc'
    ccflags =3D'-D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fwrapv -fno-strict-ali=
asing -pipe -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D=
64'
    optimize=3D'-O2 -g'
    cppflags=3D'-D_REENTRANT -D_GNU_SOURCE -DDEBIAN -fwrapv -fno-strict-ali=
asing -pipe -I/usr/local/include'
    ccversion=3D''
    gccversion=3D'13.2.0'
    gccosandvers=3D''
    intsize=3D4
    longsize=3D8
    ptrsize=3D8
    doublesize=3D8
    byteorder=3D12345678
    doublekind=3D3
    d_longlong=3Ddefine
    longlongsize=3D8
    d_longdbl=3Ddefine
    longdblsize=3D16
    longdblkind=3D3
    ivtype=3D'long'
    ivsize=3D8
    nvtype=3D'double'
    nvsize=3D8
    Off_t=3D'off_t'
    lseeksize=3D8
    alignbytes=3D8
    prototype=3Ddefine
  Linker and Libraries:
    ld=3D'x86_64-linux-gnu-gcc'
    ldflags =3D' -fstack-protector-strong -L/usr/local/lib'
    libpth=3D/usr/local/lib /usr/lib/x86_64-linux-gnu /usr/lib /lib/x86_64-=
linux-gnu /lib
    libs=3D-lgdbm -lgdbm_compat -ldb -ldl -lm -lpthread -lc -lcrypt
    perllibs=3D-ldl -lm -lpthread -lc -lcrypt
    libc=3D/lib/x86_64-linux-gnu/libc.so.6
    so=3Dso
    useshrplib=3Dtrue
    libperl=3Dlibperl.so.5.36
    gnulibc_version=3D'2.37'
  Dynamic Linking:
    dlsrc=3Ddl_dlopen.xs
    dlext=3Dso
    d_dlsymun=3Dundef
    ccdlflags=3D'-Wl,-E'
    cccdlflags=3D'-fPIC'
    lddlflags=3D'-shared -L/usr/local/lib -fstack-protector-strong'


Characteristics of this binary (from libperl):=20
  Compile-time options:
    HAS_TIMES
    MULTIPLICITY
    PERLIO_LAYERS
    PERL_COPY_ON_WRITE
    PERL_DONT_CREATE_GVSV
    PERL_MALLOC_WRAP
    PERL_OP_PARENT
    PERL_PRESERVE_IVUV
    USE_64_BIT_ALL
    USE_64_BIT_INT
    USE_ITHREADS
    USE_LARGE_FILES
    USE_LOCALE
    USE_LOCALE_COLLATE
    USE_LOCALE_CTYPE
    USE_LOCALE_NUMERIC
    USE_LOCALE_TIME
    USE_PERLIO
    USE_PERL_ATOF
    USE_REENTRANT_API
    USE_THREAD_SAFE_LOCALE
  Locally applied patches:
    DEBPKG:debian/cpan_definstalldirs - Provide a sensible INSTALLDIRS defa=
ult for modules installed from CPAN.
    DEBPKG:debian/db_file_ver - https://bugs.debian.org/340047 Remove overl=
y restrictive DB_File version check.
    DEBPKG:debian/doc_info - Replace generic man(1) instructions with Debia=
n-specific information.
    DEBPKG:debian/enc2xs_inc - https://bugs.debian.org/290336 Tweak enc2xs =
to follow symlinks and ignore missing @INC directories.
    DEBPKG:debian/errno_ver - https://bugs.debian.org/343351 Remove Errno v=
ersion check due to upgrade problems with long-running processes.
    DEBPKG:debian/libperl_embed_doc - https://bugs.debian.org/186778 Note t=
hat libperl-dev package is required for embedded linking
    DEBPKG:fixes/respect_umask - Respect umask during installation
    DEBPKG:debian/writable_site_dirs - Set umask approproately for site ins=
tall directories
    DEBPKG:debian/extutils_set_libperl_path - EU:MM: set location of libper=
l.a under /usr/lib
    DEBPKG:debian/no_packlist_perllocal - Don't install .packlist or perllo=
cal.pod for perl or vendor
    DEBPKG:debian/fakeroot - Postpone LD_LIBRARY_PATH evaluation to the bin=
ary targets.
    DEBPKG:debian/instmodsh_doc - Debian policy doesn't install .packlist f=
iles for core or vendor.
    DEBPKG:debian/ld_run_path - Remove standard libs from LD_RUN_PATH as pe=
r Debian policy.
    DEBPKG:debian/libnet_config_path - Set location of libnet.cfg to /etc/p=
erl/Net as /usr may not be writable.
    DEBPKG:debian/perlivp - https://bugs.debian.org/510895 Make perlivp ski=
p include directories in /usr/local
    DEBPKG:debian/squelch-locale-warnings - https://bugs.debian.org/508764 =
Squelch locale warnings in Debian package maintainer scripts
    DEBPKG:debian/patchlevel - https://bugs.debian.org/567489 List packaged=
 patches for 5.36.0-9 in patchlevel.h
    DEBPKG:fixes/document_makemaker_ccflags - https://bugs.debian.org/62852=
2 [rt.cpan.org #68613] Document that CCFLAGS should include $Config{ccflags}
    DEBPKG:debian/find_html2text - https://bugs.debian.org/640479 Configure=
 CPAN::Distribution with correct name of html2text
    DEBPKG:debian/perl5db-x-terminal-emulator.patch - https://bugs.debian.o=
rg/668490 Invoke x-terminal-emulator rather than xterm in perl5db.pl
    DEBPKG:debian/cpan-missing-site-dirs - https://bugs.debian.org/688842 F=
ix CPAN::FirstTime defaults with nonexisting site dirs if a parent is writa=
ble
    DEBPKG:fixes/memoize_storable_nstore - [rt.cpan.org #77790] https://bug=
s.debian.org/587650 Memoize::Storable: respect 'nstore' option not respected
    DEBPKG:debian/makemaker-pasthru - https://bugs.debian.org/758471 Pass L=
D settings through to subdirectories
    DEBPKG:debian/makemaker-manext - https://bugs.debian.org/247370 Make EU=
::MakeMaker honour MANnEXT settings in generated manpage headers
    DEBPKG:debian/kfreebsd-softupdates - https://bugs.debian.org/796798 Wor=
k around Debian Bug#796798
    DEBPKG:fixes/memoize-pod - [rt.cpan.org #89441] Fix POD errors in Memoi=
ze
    DEBPKG:debian/hurd-softupdates - https://bugs.debian.org/822735 Fix t/o=
p/stat.t failures on hurd
    DEBPKG:fixes/math_complex_doc_great_circle - https://bugs.debian.org/69=
7567 [rt.cpan.org #114104] Math::Trig: clarify definition of great_circle_m=
idpoint
    DEBPKG:fixes/math_complex_doc_see_also - https://bugs.debian.org/697568=
 [rt.cpan.org #114105] Math::Trig: add missing SEE ALSO
    DEBPKG:fixes/math_complex_doc_angle_units - https://bugs.debian.org/731=
505 [rt.cpan.org #114106] Math::Trig: document angle units
    DEBPKG:fixes/cpan_web_link - https://bugs.debian.org/367291 CPAN: Add l=
ink to main CPAN web site
    DEBPKG:debian/hppa_op_optimize_workaround - https://bugs.debian.org/838=
613 Temporarily lower the optimization of op.c on hppa due to gcc-6 problems
    DEBPKG:debian/installman-utf8 - https://bugs.debian.org/840211 Generate=
 man pages with UTF-8 characters
    DEBPKG:debian/hppa_opmini_optimize_workaround - https://bugs.debian.org=
/869122 Lower the optimization level of opmini.c on hppa
    DEBPKG:debian/sh4_op_optimize_workaround - https://bugs.debian.org/8693=
73 Also lower the optimization level of op.c and opmini.c on sh4
    DEBPKG:debian/perldoc-pager - https://bugs.debian.org/870340 [rt.cpan.o=
rg #120229] Fix perldoc terminal escapes when sensible-pager is less
    DEBPKG:debian/prune_libs - https://bugs.debian.org/128355 Prune the lis=
t of libraries wanted to what we actually need.
    DEBPKG:debian/mod_paths - Tweak @INC ordering for Debian
    DEBPKG:debian/deprecate-with-apt - https://bugs.debian.org/747628 Point=
 users to Debian packages of deprecated core modules
    DEBPKG:debian/disable-stack-check - https://bugs.debian.org/902779 [GH =
#16607] Disable debugperl stack extension checks for binary compatibility w=
ith perl
    DEBPKG:debian/perlbug-editor - https://bugs.debian.org/922609 Use "edit=
or" as the default perlbug editor, as per Debian policy
    DEBPKG:debian/eu-mm-perl-base - https://bugs.debian.org/962138 Suppress=
 an ExtUtils::MakeMaker warning about our non-default @INC
    DEBPKG:fixes/io_socket_ip_ipv6 - Disable getaddrinfo(3) AI_ADDRCONFIG f=
or localhost and IPv4 numeric addresses
    DEBPKG:debian/usrmerge-lib64 - https://bugs.debian.org/914128 Configure=
 / libpth.U: Do not adjust glibpth when /usr/lib64 is present.
    DEBPKG:debian/usrmerge-realpath - https://bugs.debian.org/914128 Config=
ure / libpth.U: use realpath --no-symlinks on Debian
    DEBPKG:debian/configure-regen - https://bugs.debian.org/762638 Regenera=
te Configure et al. after probe unit changes
    DEBPKG:fixes/x32-io-msg-skip - https://bugs.debian.org/922609 Skip io/m=
sg.t on x32 due to broken System V message queues
    DEBPKG:debian/hurd-eumm-workaround - https://bugs.debian.org/1018289 Wo=
rk around a MakeMaker regression breaking GNU/Hurd hint files
    DEBPKG:fixes/json-pp-warnings - https://bugs.debian.org/1019757 Call un=
import first to silence warnings
    DEBPKG:fixes/readline-stream-errors - [80c1f1e] [GH #6799] https://bugs=
=2Edebian.org/1016369 only clear the stream error state in readline() for g=
lob()
    DEBPKG:fixes/readline-stream-errors-test - [0b60216] [GH #6799] https:/=
/bugs.debian.org/1016369 test that <> doesn't clear the stream error state
    DEBPKG:fixes/lto-test-fix - [69b4fa3] [GH #20518] https://bugs.debian.o=
rg/1015579 skip checking categorization of libperl symbols for LTO builds
  Built under linux
  Compiled at Sep  9 2023 16:19:46
  @INC:
    /etc/perl
    /usr/local/lib/x86_64-linux-gnu/perl/5.36.0
    /usr/local/share/perl/5.36.0
    /usr/lib/x86_64-linux-gnu/perl5/5.36
    /usr/share/perl5
    /usr/lib/x86_64-linux-gnu/perl-base
    /usr/lib/x86_64-linux-gnu/perl/5.36
    /usr/share/perl/5.36
    /usr/local/lib/site_perl
```

What are yours?

For the sendemail-validate hook itself, I managed to trigger this regression
with simple helloworld script:

```
#!/bin/bash

echo "patching..." && exit 0
```

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--MVSBK7dWghthYxJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZRE6pAAKCRB7tWyQc2rT
CEmpAQDl8s0xN6kfKkTfyLS1ZME/k0NrxPkheebJctg9fovp0gEA6KmRsvYeHPr1
u5Rn1/vbJn/8KyZgTn27J+n2XapDNQ4=
=fwiq
-----END PGP SIGNATURE-----

--MVSBK7dWghthYxJ8--
