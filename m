Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7884C433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhLLUOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:14:47 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:35654 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhLLUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:14:38 -0500
Received: by mail-wr1-f43.google.com with SMTP id k9so6057405wrd.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbUJvaLdmDQOx3D4u7U1MVJu/WqJPI5RDuHZkjyE+cg=;
        b=ge/vPiUAtV23tJWAkJiLtCwsmiRmImSEMsIAqAjNTY/jNE3oLKWnqh7MMhnvLiqo+Z
         /Q8yXhcJLU/1lpW5K4cKmkEm/NbNEOw19MSLDq2AHGsace8dJj25MzyeeJG9NuySBI3r
         MNw4rX78z+aVBjtDBUi1TEKgzPo9UKa9BzJYH2QGAl2lkYqrMG3sxxZAV7Y1ib5OGoIw
         fpk6IGUDLeblnWopTuHrsdklFO/pnNisWhYdQTeaVfW66ovCmrlHov7yFbhhVe+KKHyR
         VGHxs1pQbUcBf2XeZ28mxSLct4kOt5o6/WJZWCqitUTr2/exy0cQIEgdwEBQPylHSsCA
         0pgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbUJvaLdmDQOx3D4u7U1MVJu/WqJPI5RDuHZkjyE+cg=;
        b=D0GgUMxpuKFcAZqjjX1Jlg/2+5rQQwmFVAvsvaheMxcVOLeZ76BagYVpgtTv+eb2j7
         GYS9ldkzoIwa+fjBTYseZsxZ49OYD08HUgRQrfn+89SxhdM3WZJ4d6m99PZ5KwQKqcu4
         wk8je6LxgaWpsbDoep6AByWUercsuZFJmrrs8QBv3ehGvcaiIFqv/9FEcYQ2jpZm16s1
         /MCD1WPS1vV/2QeCyk0pcSYPTGrQ0oBLGX2uc1niY8GzdW3VEqAnjTKLZdnYZo27dXYw
         tN+jy2oj5/xIEO4Mo2yvHMwdQvAoC9IACDLKeuqD+1PFt1lPV4LoFF25CObjLhaqbsOk
         A9SQ==
X-Gm-Message-State: AOAM530pmzwsbikvzeP+TJYzPj1uATnLjk2WqroOmhBcZlL87LlV4T29
        3/WIGlGa0CA4O/P7CbJjNgJVMvqYYct/Xw==
X-Google-Smtp-Source: ABdhPJyF+vNlDb1etXoHGg6X/lXFWl+hZInS55uXKeXOLRBEyQBHkvgvAzrwYip/oz7xxCSq4Fm2HA==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr27556508wra.540.1639340016696;
        Sun, 12 Dec 2021 12:13:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay21sm4824336wmb.7.2021.12.12.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:13:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Adam Spiers <git@adamspiers.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/13] t0008: don't rely on default ".git/info/exclude"
Date:   Sun, 12 Dec 2021 21:13:14 +0100
Message-Id: <patch-04.13-3d4ea5c5d30-20211212T201308Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1020.gb1392dd1877
In-Reply-To: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211212T201308Z-avarab@gmail.com>
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
index 42d23148049..6bc08ee2537 100755
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
2.34.1.1020.gb1392dd1877

