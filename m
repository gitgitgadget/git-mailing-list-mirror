Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AFBC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 11:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiFCLPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiFCLPd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 07:15:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860713C483
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 04:15:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z17so3936736wmf.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 04:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDmT55ebS6fRkVsOXwqqzrIScwW+g3Ko4kpAsXhWcvI=;
        b=QchZpArrTaLHOx1aeUGWFrNxNMMwfhiQNWCuCWG+UQ0Fhjs1SghazKJyOywzr67PrN
         e9ZYIDJXHmKCxE13Rysfn6e6P2VjsiieALtnd1qv3hrJal0mpaPdlAsTvIkiAxZpxFJh
         BYoVg5Gx7fmk/NyVYHBjdfjnlwd9sNseQ8Zgm+h83i6kk69WtHwN59ucK5Gf4w42uyMi
         BVpPFiTTWN3g4DVcleHR4cEkWIn7+ricSw7bi2z5bFArPN7MlJrFw+OkzJNsmCAv2ciZ
         3ZkiqEzVRLcGohcBLXoXJKAYvAS4jjL20kbm3uUwnOyqgo8+Jo7Z6A7zbKkuEANH95jL
         AjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDmT55ebS6fRkVsOXwqqzrIScwW+g3Ko4kpAsXhWcvI=;
        b=lWxIW9BIo7t20KemnFK0eAfLmPqIbqx0661Anlyo9vyjZSQ+kCtIfexzp1OZ6OFrHM
         ACi3FYy07x9IhkAFEd2GxRkFiZ3JIbcamLq17TZZICXZhRUhxnVkEXEWI9KiLj+r3x/A
         wp0wGeH49MInV46s2g/mkV2Tva0zBEYsCtkyem0oGh6SbzjO3uUgEdtAmrVFZRvMaZ9E
         mnPDYZCxV5z56svzXsiodMft5bNcxT5o2qR/wlposeCoQdExwpa8tfPKxY9fXucUyzox
         5knDXNPJCMI4Q6QkatjDWtBbq32mzLnX3icfIGJAxVG2rO8s5vxL26BPUDe6zFEk1bg8
         sslQ==
X-Gm-Message-State: AOAM5338Fslm1r1FP0ZWfyrnOwSaUdwTaW55qc41STlx9uqAF+YNa5bE
        F+KnH2kBGd0JtymGnF6+A5e8my+0dgwoYw==
X-Google-Smtp-Source: ABdhPJyR8Rp9SGFks15RkYioGtSh1Q74SllGIOHujI8LAjE1JLme6VnpJ1o2Sl4Ox3eq4bPoLhRasQ==
X-Received: by 2002:a05:600c:3552:b0:398:3e9c:30f4 with SMTP id i18-20020a05600c355200b003983e9c30f4mr30657110wmq.37.1654254929695;
        Fri, 03 Jun 2022 04:15:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm7184357wrb.79.2022.06.03.04.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 04:15:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/7] t0008: don't rely on default ".git/info/exclude"
Date:   Fri,  3 Jun 2022 13:15:03 +0200
Message-Id: <patch-v2-1.7-21927e21832-20220603T110506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20220603T110506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test added in 368aa52952d (add git-check-ignore sub-command,
2013-01-06) to clobber .git/info/exclude rather than append to
it.

These tests would break if the "templates/info--exclude" file added in
d3af621b147 (Redo the templates generation and installation.,
2005-08-06) wasn't exactly 6 lines (of only comments).

Let's instead clobber the default .git/info/excludes file, and test
only our own expected content. This is not strictly needed for
anything in this series, but is a good cleanup while we're at it.

As discussed in the preceding commit a lot of things depend on the
"info" directory being created, but this was the only test that relied
on the specific content in the "templates/info--exclude" file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0008-ignores.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 5575dade8ee..c3655a0c53e 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -225,7 +225,7 @@ test_expect_success 'setup' '
 		!globaltwo
 		globalthree
 	EOF
-	cat <<-\EOF >>.git/info/exclude
+	cat <<-\EOF >.git/info/exclude
 		per-repo
 	EOF
 '
@@ -543,9 +543,9 @@ test_expect_success_multi 'submodule from subdirectory' '' '
 
 test_expect_success 'global ignore not yet enabled' '
 	expect_from_stdin <<-\EOF &&
-		.git/info/exclude:7:per-repo	per-repo
+		.git/info/exclude:1:per-repo	per-repo
 		a/.gitignore:2:*three	a/globalthree
-		.git/info/exclude:7:per-repo	a/per-repo
+		.git/info/exclude:1:per-repo	a/per-repo
 	EOF
 	test_check_ignore "-v globalone per-repo a/globalthree a/per-repo not-ignored a/globaltwo"
 '
@@ -566,10 +566,10 @@ test_expect_success 'global ignore with -v' '
 	enable_global_excludes &&
 	expect_from_stdin <<-EOF &&
 		$global_excludes:1:globalone	globalone
-		.git/info/exclude:7:per-repo	per-repo
+		.git/info/exclude:1:per-repo	per-repo
 		$global_excludes:3:globalthree	globalthree
 		a/.gitignore:2:*three	a/globalthree
-		.git/info/exclude:7:per-repo	a/per-repo
+		.git/info/exclude:1:per-repo	a/per-repo
 		$global_excludes:2:!globaltwo	globaltwo
 	EOF
 	test_check_ignore "-v globalone per-repo globalthree a/globalthree a/per-repo not-ignored globaltwo"
-- 
2.36.1.1119.g5a713b43bd4

