Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD1C46467
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjARMrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjARMqT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC423D83
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x36so14673146ede.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR+FPXh6Y5O5wMgic69DBql8cZiGwfBcWV0fgMBKx9s=;
        b=CpRYBhq2PykT8p/AUtkyHy5tfCyexEVnY5ICAlbvmXCB82J1D52JiVai7rAqFH9lvY
         NUezSzwfRZoUkbaj3T6umAtAnzYPHacIWK9CGD62GW1FdfxV66gjjGO3HOZYrfBFlxAu
         1qAI6fyr39Jn5iePoI18e9Vjptn6o6cpiw/02jtj98RqaR1rbJJCgDtUKPwciB6pBEAD
         husBqoO25/ePUHySvyCtDDA9DMV5Ybw4kh5Lft3Xuxs6sf2Q3j+R6Ea5D/ZdKI6Wsfj6
         30G3pI8Pte/j+PXO+7uCyQuyhB4/EtpbXH/1p0a6qlSpf05sN6lWq2R92zWWVpa263BV
         AxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tR+FPXh6Y5O5wMgic69DBql8cZiGwfBcWV0fgMBKx9s=;
        b=RH0ALi6ZcBBkawDNwoI1sgBwYOXAuOs+eM7enTSSYKh/SUZTqDlpQcEu3ABDiGyB8A
         r/9D/XBxw5CtGQZo+Hg+t/6WvBI/3JwM/vLNSx9pN9yEk0D7SdsRcwTG7lWL7lA/bwVD
         pB/NhzpMC/CkBkucL5APRcXoHb7dDtL23UaZmkBz5W4dfcrbh8amuejPkzqQOp76y+qH
         Z5+CptnbEmEfifhGSN+4kXQXqRvg+SfF64+f10GMa2+IhaeNRyJrIC/zUlBlSiawEK9a
         rGvP6x212Dw+Ap4AvxzL4jtfmmFsBJKMB1tkdSGW10vRL3q898Ga9VIysBoPz50Vv3Nj
         DBVw==
X-Gm-Message-State: AFqh2kqpebBPtNS8A/MSkzhE0f6v7YtCeRxxmwDT8+5mEcT4BeC/usdY
        TB+X/DX+49CrVxLJIYSEvHsO5WnAD55WgA==
X-Google-Smtp-Source: AMrXdXs/tGbJxB1No5ee0GWq/LC2J+psTUKd/9uWIwBxLRLZYOdYKld3Po9xfTiymX+wKbJPMql9cg==
X-Received: by 2002:a05:6402:1f8b:b0:499:b4b1:5266 with SMTP id c11-20020a0564021f8b00b00499b4b15266mr7602920edc.40.1674043721401;
        Wed, 18 Jan 2023 04:08:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Wed, 18 Jan 2023 13:08:21 +0100
Message-Id: <patch-v5-08.19-02248aca3eb-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

