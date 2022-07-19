Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B082CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiGSUsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiGSUrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC252FFB
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so10493656wrc.8
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vgFI6FHKukujjAh9CSmpB3yAzkY5yJrgIK/vbx+GkfM=;
        b=ELr20xyLIzV+GbH8wPyIaLuYQlPF0uKMmiljyE/FNNh/ys39S02/dosRbPjfQx6uLq
         L6WMiQ/r1wl6ZHtEKRQy/x106FVtzJUZtCN4bPsmbTG6Ao8CGCHKA4c3tazszLJC/ch8
         XQpor04okL3FTbyRU6b7Aa89BE5wkNe8nu1EQ7B9/a6hOsbab3R2y9Zu7+mGz4XeYGje
         aI+N7hkBTjk+MO9iFWCWjFSRv9ASFYeQd2O86cdmTH4qFepIUqnUeoZu5uE6IQfHrlcr
         Biei18gDVRRreAif04m7g5rTQofkAGcy1IjBwwMDovDh4Zm+cXNFWDtWiuVJZs4tO7QF
         TXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vgFI6FHKukujjAh9CSmpB3yAzkY5yJrgIK/vbx+GkfM=;
        b=4RO+hVSdHdWEOKJWcwdzf+10eKtXFjKXO6OIexK1UQ17R8gHSXApaS1dZcU9FKw25x
         I+DkMQVUSChpy3RZYD2+rNj0nzxpELWvNumkTRwLJINRX04uKusCj517iQ1S+c2He/e4
         N9Q8aR4ipLxGcxxctE/KHZVH8VyttELOsahdPNVXxXxqTD9rLwdXQV6A7oRjo8CiCcpS
         H7zd8+0FNkuNItbLwDxlXTsoRoHAr6XPKLmttOvOE/nHtaih5eOdygOIDR0at81hIB0Y
         v7horx/jcGQWDHrWpi2vAbsFlP5zEquqxKq/O7pKXzHLvhpfyDUTouDkqmbE/I3cIrAi
         ajTA==
X-Gm-Message-State: AJIora+9IMRomD7T/8d4SZ1quldQpL1wMP7pvjwqGY3u9sw4GQnvwNCj
        gLyhmgok80siZMbAGPcXwgys4Lj3VgajRQ==
X-Google-Smtp-Source: AGRyM1viw4XBR0uFSS298Mex8jRAUyqhgm2tWf1SrB002eLcYU4EE2w6OgbdbwT5kERV+H4slnfDhw==
X-Received: by 2002:adf:e310:0:b0:21e:3e46:81f8 with SMTP id b16-20020adfe310000000b0021e3e4681f8mr3206223wrj.188.1658263663071;
        Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/24] submodule--helper: free some "displaypath" in "struct update_data"
Date:   Tue, 19 Jul 2022 22:47:09 +0200
Message-Id: <patch-v2-18.24-fac2c4491f3-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the update_data_release() function free "displaypath" member when
appropriate. The "displaypath" member is always ours, the "const" on
the "char *" was wrong to begin with.

This leaves a leak of "displaypath" in update_submodule(), which as
we'll see in subsequent commits is harder to deal with than this
trivial fix.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c        | 3 ++-
 t/t2403-worktree-move.sh           | 1 +
 t/t7412-submodule-absorbgitdirs.sh | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 75e842af5ca..dc27e28e98c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1953,7 +1953,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1991,6 +1991,7 @@ struct update_data {
 
 static void update_data_release(struct update_data *ud)
 {
+	free(ud->displaypath);
 	module_list_release(&ud->list);
 }
 
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index a4e1a178e0a..1168e9f9982 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -2,6 +2,7 @@
 
 test_description='test git worktree move, remove, lock and unlock'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768d..2859695c6d2 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -6,6 +6,7 @@ This test verifies that `git submodue absorbgitdirs` moves a submodules git
 directory into the superproject.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup a real submodule' '
-- 
2.37.1.1062.g385eac7fccf

