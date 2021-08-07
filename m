Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEECC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5959F61167
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 02:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhHGCIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhHGCIh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 22:08:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CEC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 19:08:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zb12so13397771ejb.5
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 19:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5GGuN1UPgVgGHRXPCvEiioVgYKLkpM4xO756JB9Y7k0=;
        b=JyhKksfWLU63LtKIYUPOsx57pJm9tHH0C1/gJKIpnNOV3GdrbW3fg3JylSdrNlGgHM
         a/H1w26y3CoRDK4EbTIKGHoTlSD5znkxwgX814Ad9Az6IXOYlBosV9e5efYIoPMwqbuC
         iWlAnbc4qsEQ4Y46x96/whXumKSufxgEZTIxKQTeUlzNPJLKvPvodiT6xKDOKlhnPXz5
         B/4R6KPpTRn/2KEO8O4Otg6damm0BOsd8w2a5zaRVupoha+RORu1VJN4/iK+L+yS9P5E
         2jVQybmATGisASW8rUzyWT+DTBv/zaGDq+EVej9kdMsZXOCMyv5bCO0UjMCu03hT8QtM
         SYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5GGuN1UPgVgGHRXPCvEiioVgYKLkpM4xO756JB9Y7k0=;
        b=HMiDt596VXv3Xz5VCzlsMNVn6i0quH1ObZ2Fm8artmPqqv/9HecYzts8j2vznOvhmo
         HCXF2ODd24BzjFHRLmrxEAWk2SodJO9pDKAytYYf+PqO43JHebhCMyuBXFE8PZc3MHH+
         XVEXlJuZJJA7ccuKUOYKhA4S3zqtb/cEsIxtItmCLtf1gHpZ0lOSD8ZuLdnvkmrW1zDn
         sS5Kw6Gw/R6kt91JYUIYj3VxAbqSpDNU6IXZwVxOLAuksDCLdMdOLpXnsw9tG8a28pZN
         bOrl9O29npWjMLTHk+lRPJ+N5MAwOWx+5j6eF23m01osp/d8WeAk+VGMLKsdkivWjKO9
         593g==
X-Gm-Message-State: AOAM531rN2MoqU1SbnUpDJvpsT75lDMUoA+QET+BVsplYb4xiVQlzRSb
        rMaLedqSKW5wZLVd3tZj2mo=
X-Google-Smtp-Source: ABdhPJyzkbzW1ahpzUyzB9zA5AZ798xx+2coa3j9/5i8jKrxkEAFj2VeSNySzkrK5PqpxAo7nhtWsQ==
X-Received: by 2002:a17:906:a2c4:: with SMTP id by4mr12577880ejb.521.1628302098751;
        Fri, 06 Aug 2021 19:08:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mf1sm3381286ejb.51.2021.08.06.19.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 19:08:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] detect-compiler: clang updates
Date:   Sat, 07 Aug 2021 04:02:45 +0200
References: <YQ2LdvwEnZN9LUQn@coredump.intra.peff.net>
 <20210806205235.988761-1-gitster@pobox.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210806205235.988761-1-gitster@pobox.com>
Message-ID: <87bl6aypke.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 06 2021, Junio C Hamano wrote:

> So here is a mini-series that summarizes what has been suggested so
> far on the topic.
>
> Carlo Marcelo Arenas Bel=C3=B3n (1):
>   build: update detect-compiler for newer Xcode version
>
> Jeff King (1):
>   build: clang version may not be followed by extra words
>
> Junio C Hamano (1):
>   build: catch clang that identifies itself as "$VENDOR clang"
>
>  detect-compiler | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Perhaps I've missed some obvious reason not to do this, but why are we
parsing the --version output of two modern compilers, as opposed to just
asking them what type/version they are via their usual macro facilities?
I.e. something like the below:

diff --git a/detect-compiler b/detect-compiler
index 70b754481c8..37908ac9ea8 100755
--- a/detect-compiler
+++ b/detect-compiler
@@ -5,19 +5,47 @@
=20
 CC=3D"$*"
=20
-# we get something like (this is at least true for gcc and clang)
+#!/bin/sh
 #
-# FreeBSD clang version 3.4.1 (tags/RELEASE...)
-get_version_line() {
-	$CC -v 2>&1 | grep ' version '
-}
+# Probe the compiler for vintage, version, etc. This is used for setting
+# optional make knobs under the DEVELOPER knob.
+
+CC=3D"$*"
+
+v=3D$($CC -E - <<-EOF 2>&1 | grep -e '=3D')
+GNUC=3D__GNUC__
+GNUC_MINOR=3D__GNUC_MINOR__
+GNUC_PATCHLEVEL=3D__GNUC_PATCHLEVEL__
+clang=3D__clang__
+clang_major=3D__clang_major__
+clang_minor=3D__clang_minor__
+clang_patchlevel=3D__clang_patchlevel__
+EOF
+eval "$v"
=20
 get_family() {
-	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
+	# Clang also sets the GNUC macros, but GCC does not set
+	# clang's.
+	if test "$clang" !=3D "__clang__"
+	then
+		echo clang
+	elif test "$GNUC" !=3D "__GNUC__"
+	then
+		echo gcc
+	else
+		echo unknown
+	fi
 }
=20
 get_version() {
-	get_version_line | sed 's/^.* version \([0-9][^ ]*\) .*/\1/'
+	case "$(get_family)" in
+	clang)
+		echo "$clang_major.$clang_minor.$clang_patchlevel"
+		;;
+	gcc)
+		echo "$GNUC.$GNUC_MINOR.$GNUC_PATCHLEVEL"
+		;;
+	esac
 }
=20
 print_flags() {
@@ -41,12 +69,6 @@ gcc)
 clang)
 	print_flags clang
 	;;
-"FreeBSD clang")
-	print_flags clang
-	;;
-"Apple LLVM")
-	print_flags clang
-	;;
 *)
 	: unknown compiler family
 	;;
