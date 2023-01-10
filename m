Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A7C46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjAJFoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjAJFoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:05 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBF3FCB5
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id az20so6730404ejc.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTNEy6c6gVSbz//QMG6vUd8BR9QP0SM5R4gXZslEWrI=;
        b=R6m205YgDQxzsTbOomjFRV/iDQVOLcrk14owKRMhOBTHdf3GCv1pN6wYLNPslS59Rh
         IaGZTcNhD+AsStBxYv/AtZmw7lypzabvHSDWo/XJBJOKVZ3lbcCDFfei4XjIwdYVjxOH
         uMG8TSVATawfwz5E1ceWOtvnr6gdTW4w7OebK0Hfg3Zb2c42tXrRSWqLnqQ1LmSmk81W
         PImA3mI35U4R/v1f9EJ4Yab3atydyB2uni1jIbozR4BQ98DOjLzyElDfQv6sGoWHdo2I
         7gbhqym8+Ya8QRflTrgwIl888TaXtaTGvbVXo/wMbB2KM1uccENerGBf+d2aps4tVOUj
         BC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTNEy6c6gVSbz//QMG6vUd8BR9QP0SM5R4gXZslEWrI=;
        b=h2FhNiROmQx2zLq5MPZfXEgNnB3UHmroYIqpoVe32N8mf7MGXInidIeDAn5XEmT/0V
         GmpgAqXSDbDQAHBok1AxZikXw57CxRHiDN9ulC+Lu65n07gkLOMCzrnX/OTggs2a9p2G
         SKYwhEMQYUMZCYCvuK1zJt2huBX5OD6YbS4BTmx7aiOuv3DlYrqbYHUESdG+enNbJeA2
         PzDGkqyCnsZFjeOvWgdbekUIQZhesEI88IYfJuibqJIsyvKvXxfuYa5lWy15rmIal8jS
         4uUsszqJuUTFCB9HA9EWfGyUrgM/cmUqelSBXFwWsRkkCi6QtwnygnyKVSpJO1dfKBDm
         0oDw==
X-Gm-Message-State: AFqh2kp4s9Nvsv2gbm8wi/XPHxLj8mhpMgLneMft45LEGK6ikPNjGpP6
        UDuFk5JwXbPJa8Sa/YvpiP89ET+aLUe9Ig==
X-Google-Smtp-Source: AMrXdXsKXPHaVguecew1Z/Abv43KyZNirLNpIMoernErXZVP83CtvK7ig0LrPw812NgB6VEw1DvEJA==
X-Received: by 2002:a17:907:c301:b0:7fd:ecee:c8ba with SMTP id tl1-20020a170907c30100b007fdeceec8bamr85603385ejc.42.1673329437843;
        Mon, 09 Jan 2023 21:43:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Tue, 10 Jan 2023 06:43:28 +0100
Message-Id: <patch-v3-08.19-f918a6f2adc-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We were leaking both the "struct strbuf" in prune_worktrees(), as well
as the "path" we got from should_prune_worktree(). Since these were
the only two uses of the "struct string_list" let's change it to a
"DUP" and push these to it with "string_list_append_nodup()".

For the string_list_append_nodup() we could also string_list_append()
the main_path.buf, and then strbuf_release(&main_path) right away. But
doing it this way avoids an allocation, as we already have the "struct
strbuf" prepared for appending to "kept".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/worktree.c         | 6 +++---
 t/t2401-worktree-prune.sh  | 1 +
 t/t2406-worktree-repair.sh | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 591d659faea..865ce9be22b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -173,7 +173,7 @@ static void prune_worktrees(void)
 {
 	struct strbuf reason = STRBUF_INIT;
 	struct strbuf main_path = STRBUF_INIT;
-	struct string_list kept = STRING_LIST_INIT_NODUP;
+	struct string_list kept = STRING_LIST_INIT_DUP;
 	DIR *dir = opendir(git_path("worktrees"));
 	struct dirent *d;
 	if (!dir)
@@ -184,14 +184,14 @@ static void prune_worktrees(void)
 		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
-			string_list_append(&kept, path)->util = xstrdup(d->d_name);
+			string_list_append_nodup(&kept, path)->util = xstrdup(d->d_name);
 	}
 	closedir(dir);
 
 	strbuf_add_absolute_path(&main_path, get_git_common_dir());
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
-	string_list_append(&kept, strbuf_detach(&main_path, NULL));
+	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
 	prune_dups(&kept);
 	string_list_clear(&kept, 1);
 
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 3d28c7f06b2..568a47ec426 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -5,6 +5,7 @@ test_description='prune $GIT_DIR/worktrees'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success initialize '
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 5c44453e1c1..8970780efcc 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -2,6 +2,7 @@
 
 test_description='test git worktree repair'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
-- 
2.39.0.1195.gabc92c078c4

