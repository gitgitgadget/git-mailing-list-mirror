Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE1C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiDMTyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbiDMTyb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E95245050
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t1so4141646wra.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K6v0a1KKYnl6d5SIBnL2OAl1nvW3QnnjHEmdvfZVsY=;
        b=M4KjzsYkIAv7oeYuDtT/8n1usxicYRLFEgo0F+Iqb225n75jNpdr2kPxBJJes9Wz4c
         BqV7D/YGLFhuOJ4p8rJg9X1RtTuiqNeEcJ6T/AVb5Non9GAgf2onOX2PgTSQVh7qMjt6
         lP//r0U880RvKPM8JuRJj0UZTYZea1ydub+EJxSfJifyMhB3979gg5w8DwHiurmUd/Et
         zNRl2XharqF8BpLlJxnhq2udspv9KMH9/K3MPKTL+O4vXDPQw5y3LwxJ3FUPXqPqbdYh
         +L7NnJUCUY8pDSWEh4ewYxxipeTdpBvfBz1czpxfxs0h3P6JLTP6IcZ3GyO6mFZmky6A
         h2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K6v0a1KKYnl6d5SIBnL2OAl1nvW3QnnjHEmdvfZVsY=;
        b=3uJpu0ZgeWimI5g0+GY9N3yv/jXZMltzPCD+Mdmy83WcMfTXAbCgEthS6fCWEp1ZRT
         tRLrr52kQlJef8xHpM/XNUbpiuO16Wmo4fPS/dUM0xfqaJtbWJutFvNKqVCmTdKeoDvM
         engoX4l+kJVazjzOdCjrHdSnlWokf0MxqU7DLx2QJZJi2RKnxvVanHoBM7//Jl3Ttf94
         A+dZsuhi0pWJR13BiBGl66DEfZMhcUHUjT+AbbtB9pnRt/3ka9U5OuNfeVZmFMNHBIpA
         i8NHqv4IhCwEt+cYNj4+dzXa7EcIHhJ425wKPHEXe25embTAfxuXhGiaYbws+G3eshnk
         nCSQ==
X-Gm-Message-State: AOAM5335jwjpHaWMIJbj3mVPPmiDWfTRj0vaQ4SCCg6B4HtMuf8cNvbp
        v30Tn20WXhPzP9oyQlvmoXND5O1OxZjmJQ==
X-Google-Smtp-Source: ABdhPJz9Riq3I/tPCv6ok46kK2iVmP0IBnzFX4l75D06YwxyQLl5/gSzK/tci+PKhFiuxz9JZKjS8g==
X-Received: by 2002:adf:d1e8:0:b0:207:a5e5:ef9b with SMTP id g8-20020adfd1e8000000b00207a5e5ef9bmr357175wrd.200.1649879527731;
        Wed, 13 Apr 2022 12:52:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/29] ci/lib.sh: use "test" instead of "["
Date:   Wed, 13 Apr 2022 21:51:27 +0200
Message-Id: <patch-v3-14.29-d3909b8e896-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ci/lib.sh script to use "if test" rather than "if [". Until
the preceding commit this script relied on the non-POSIX "export X=Y"
syntax, but now that it's POSIX portable let's use our usual style in
it, and not the bash-specific style that was used in it historically.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cc9a368be42..ffc0e524aaa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -94,7 +94,7 @@ ubuntu-latest)
 		break
 	fi
 
-	if [ "$jobname" = linux-gcc ]
+	if test "$jobname" = linux-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
@@ -104,7 +104,7 @@ ubuntu-latest)
 	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
-	if [ "$jobname" = osx-gcc ]
+	if test "$jobname" = osx-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
-- 
2.36.0.rc2.843.g193535c2aa7

