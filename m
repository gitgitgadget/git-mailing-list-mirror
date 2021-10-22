Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B26C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DDB61163
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJVSWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhJVSWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:22:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEAFC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so3151256wmz.2
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mnb6KdryDykVIaMkHyjvlyN5vBcTaA+lvHqAgmmU900=;
        b=R0mZlHApCcThZAfhVYzTZ2h6Rt0lLKGE9EmTBmZmTh4ih6WT7ufJz+nq0r5g+WmXw4
         JvV/42toU3Jrqx2MQdQXbd4U2uNWiT88wJyKVl1QpYzst5RZg4u0/gdR44U6qj7qYA+g
         XBjyxWhVj+TRAFhx0N8Qsv4Qt8ppU/Fj+4zhtI1GE5sAjNZ5c6bd+Xw3PtWmAQatom2+
         HY31gmtQ0D6PLvfKye2mIDcYMLiAnj5JgH0RbRh+c+VUCNCZrpeLcJ9osjJOgb5PPWXs
         GhCxZYagBrUYfGPjDoOkV1VM2g3T4Cvxg8P1bJEXYAdlU0JLnVUf5vpVtfdK2h2QBc2w
         QgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mnb6KdryDykVIaMkHyjvlyN5vBcTaA+lvHqAgmmU900=;
        b=If4lEjheMocjvBvkItvKco8Z4g5S7jli4u/q+kR6QJy9LY0DrikCCm/P6fluxAwVpH
         C5pTmpPUSNRo+ctJRFTTEvbFFwUC8B1xLn33iD6gJ+dOW/bx7pRaWhp8NGHO6DDf5ZtU
         yQEPrfSwrxPIspSuVyslRTi302t+i4jaE0fevtitqtQSx6WF6UsuwrkVMzrJ3b13So4N
         jHvgRNFSk3gCPVzxJ2zhpIMKoIyksvLtTTUK+IiwPpG19aEVh4/oDTzDB9WpcNTQzzVC
         tt9A+hnHrEoZTZkiumWQT+I0Jkjxvz7wAigi8/iNOYxUSFdOxW5g2r/OD3T4Geglt/eW
         4KbA==
X-Gm-Message-State: AOAM533cXuPx9FlLSLC7+E3dBi298P1De29yvL6BsG7LUFX8P1Nl2a0x
        7f+SegYOu5tnEOusY9XsAywcSntHfEHIgQ==
X-Google-Smtp-Source: ABdhPJxdXgPbh9HmrpmA/0wecdB1Ny5xHqKXCCQMm+0+zhCXH8A1Y5v+s7gKTolYwghXqDMd01DASA==
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr30221823wms.81.1634926784913;
        Fri, 22 Oct 2021 11:19:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm8587242wms.5.2021.10.22.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:19:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/6] config.c: don't leak memory in handle_path_include()
Date:   Fri, 22 Oct 2021 20:19:37 +0200
Message-Id: <patch-v3-4.6-3607b905627-20211022T175227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1505.g075a284c562
In-Reply-To: <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20211022T175227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the error() path in handle_path_include(), this
allows us to run t1305-config-include.sh under SANITIZE=leak,
previously 4 tests there would fail. This fixes up a leak in
9b25a0b52e0 (config: add include directive, 2012-02-06).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c                  | 7 +++++--
 t/t1305-config-include.sh | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 2dcbe901b6b..c5873f3a706 100644
--- a/config.c
+++ b/config.c
@@ -148,8 +148,10 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 	if (!is_absolute_path(path)) {
 		char *slash;
 
-		if (!cf || !cf->path)
-			return error(_("relative config includes must come from files"));
+		if (!cf || !cf->path) {
+			ret = error(_("relative config includes must come from files"));
+			goto cleanup;
+		}
 
 		slash = find_last_dir_sep(cf->path);
 		if (slash)
@@ -167,6 +169,7 @@ static int handle_path_include(const char *path, struct config_include_data *inc
 		ret = git_config_from_file(git_config_include, path, inc);
 		inc->depth--;
 	}
+cleanup:
 	strbuf_release(&buf);
 	free(expanded);
 	return ret;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index ccbb116c016..5cde79ef8c4 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='test config file include directives'
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Force setup_explicit_git_dir() to run until the end. This is needed
-- 
2.33.1.1494.g88b39a443e1

