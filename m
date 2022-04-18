Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA84C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiDRQd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346293AbiDRQc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107043121A
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so145693wmb.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+rJ1IDX6vJJhltJ6qMhVogY4+dQyZKXc8qV++zMpGM=;
        b=b81huWouwfMmjRpeVK11HRrH5KbhAwfqhkpI/j/7e2c5qb/WY8TRIcIsy3MDqDwxgr
         ujtdOprb5ZASZLog5N0bwo2RtPmTQ0v5U8JKUIut6D+4+fzpzyEakWB6qcYYN7xX4uVq
         vaRx4iyejoEFrW1sZMoKIFiO6AIiteGN5MECULn9c3KYTRm8DjeA66xOz70Wizbp84xb
         8dsVYCqst5tREZZStuIK2bV3lpBqARkck3u+JEtHch+WDmys7+cZ57sRFhjgMMeclGBp
         ttMNBVJAVLhKDJi1byBIXdNgA8vZz6BpXXow3Xg88DPqBkEhk66cGz9WzXFz5TwfDvqZ
         KhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+rJ1IDX6vJJhltJ6qMhVogY4+dQyZKXc8qV++zMpGM=;
        b=dnZQIushcdLyV4WXzRcl1pb+ayAwq993iy7VK+DYfTz+0n5coWg9NjOPMRRDy6f3DM
         oDB8d8EAm94+aE9lime4s3uELXlO1iirpTQtX+XXi9KJA2o9LbyLrjcgETgMTMYdak53
         UNriWLf3DeqAPT2gZQD+H1ASBiZDJFxNSSHQ9NUd8fg0NQQKT+P766QkgA4yCxOZ54/q
         Pv4vW/6N6Gx86dpMQgQs4ZtwjSEzHo0Y0ADe9//9QnLphTRC98W3WhoSNmSG9qJwOWvI
         wAKLgyKhL2Mt+20i8LAVaJoY1saMOpgga6ivXMsvMkNpfuT5lb/cFQ1qPAf/wF5NYuhc
         n7jw==
X-Gm-Message-State: AOAM530ODgJrmRJUUg46i5tTQu7A95sdKMlTesL2dtwQ1Hgj1XwCGfEB
        p+WE9C/Hs0fMzWvuHJhayUKTixVRZHg4cQ==
X-Google-Smtp-Source: ABdhPJxh+3Kw8tMb23NOQTbNRvJhdaD0+cYFKdk+NJ1zFFNDda0eziq5/v2SQ07bUfwiaYwFBZ5a5g==
X-Received: by 2002:a7b:c1cc:0:b0:38e:b876:95d8 with SMTP id a12-20020a7bc1cc000000b0038eb87695d8mr16076407wmj.57.1650299379298;
        Mon, 18 Apr 2022 09:29:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:38 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 28/31] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Mon, 18 Apr 2022 18:29:05 +0200
Message-Id: <patch-v4-28.31-6501059c594-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the setting of "PYTHON_PATH=[...]" to the "$jobname" case
statement. This partially backs out of my 707d2f2fe86 (CI: use
"$runs_on_pool", not "$jobname" to select packages & config,
2021-11-23), now that we have a "osx-{clang,gcc}" anyway for setting
"$CC" we might as well do away with this part of the "$runs_on_pool"
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index ac96b7a1c61..1a7200451e4 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -104,14 +104,6 @@ ubuntu-latest)
 
 	setenv --test GIT_TEST_HTTPD true
 	;;
-macos-latest)
-	if test "$jobname" = osx-gcc
-	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-	fi
-	;;
 esac
 
 case "$jobname" in
@@ -167,9 +159,11 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
 osx-gcc)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	CC=gcc
 	;;
 osx-clang)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	CC=clang
 	;;
 linux-clang)
-- 
2.36.0.rc2.898.gdf6bbac50ff

