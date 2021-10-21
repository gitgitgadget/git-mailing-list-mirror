Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49632C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2955B610C8
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhJUT4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhJUT4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5555C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so1178562wrd.13
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mnb6KdryDykVIaMkHyjvlyN5vBcTaA+lvHqAgmmU900=;
        b=fP2og55IXBtOyL5F+ygN4l9fF2nMahx5DL3Vn373TMSfRv1tEGl57QihqwiVlgcpOz
         tsJkPBSkcBDk3Zlfwh1JKmbUISvNcv5la/DXAZnFBZHWV9ps8KVsmVWHa6QwSllwtTSe
         DLNn+KP+oJ5kWSpKCtZH3yosoCUzeYYpSdOVsb0l9f0VHEWxXcu6aJdPZxWVulZfXZp2
         sJ2bGHcX1MUWqhte7sj4uFPQJWbzXTLdC6bAGZ2t6017ZTP1y+GpfEgmjcT3QMdmoThx
         fUp5EDmMHc6TNctPnexgfz4irz0Ttj4kTr+TPFAi9RjVEmh7uW9kKcrERoN80uBYqitY
         dO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mnb6KdryDykVIaMkHyjvlyN5vBcTaA+lvHqAgmmU900=;
        b=77dQin5D/Q2vEotu3dEcv90u/e4dY7KZrjgqF30BNzNjFYh+pl5BPQDq+uv1udX206
         RBpw+7HM/7tzFGkmHrkR4K0WukFT/WnqOvdL7UdwqIJGGHYqUhym7pHMDDSo3Nd/NMeN
         znCzDHD3mqXlA3vqTREb+8m/KSDGlSMJRACuw+h8Mfjl4no6qdNZjOOxgG35QNzTz7bP
         mUWpSp+mZWb5IEnkb7/FbQi0Gf6O5FXvKeZkvnyfITNxDG218ago605U7oWvJoMCWV11
         Mj6RXEqZRbGlzWrsrRhwOXBFqPD1b2dgFlaiJkGx+rQ4sadi883HkN4MViEqd6go+PUS
         udMw==
X-Gm-Message-State: AOAM5307rBiqkcj1o0QX9bNhXfAXMcenxZj2h+PTtaS0CXnyZtUSxqL6
        gllnpRsFV34WFaejzBBny6CXqtJpPOrwPQ==
X-Google-Smtp-Source: ABdhPJwhThAexMAku5Sl/ENQvj1h2H/4msCDAOpfKkiHh3XTkUZ83Fknl9NuOFhNaF+ReKC1pDGcmg==
X-Received: by 2002:adf:a30b:: with SMTP id c11mr9851730wrb.289.1634846061144;
        Thu, 21 Oct 2021 12:54:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7822492wmp.1.2021.10.21.12.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:54:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] config.c: don't leak memory in handle_path_include()
Date:   Thu, 21 Oct 2021 21:54:14 +0200
Message-Id: <patch-v2-2.3-d6d04da1d9d-20211021T195133Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
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

