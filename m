Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D6FC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBFXIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjBFXIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:20 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122065FDE
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:18 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id sa10so8334718ejc.9
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVmLRxCQHtu74AnHvtfKqLTTuJHmqgO3lzJFe3ovMHk=;
        b=la0wcpnjz3k8cWnMcbnvNgOap6AlSOfBLjIjb3PswHELPNj8c1IYqoZOtOIBe1yJKp
         MBrtB3/+91W9JX7ERBH7d2GkLpZFuSr/SuCk2p+r+nnAH8EGXe4PZApDABNaLvyJkgnU
         bdFEOdhpxq8VLTxmWhBJDPK1AVfHW5wBXp81NXl9QD5BG/ndnFr2mlYrU9LyB4tthsms
         CWXB+4DSjaO1z/ugO2KaVoXZeKG381OJGlN9NDx/axFwLCFMDfQeDATB7xvKWvmfULEB
         MsieSwp3mMIeUoS2w/UKTXuUHUfd5LYylQqR45u7U6sxiLwtJ0FcRofSVb+cd+xAApfh
         upJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVmLRxCQHtu74AnHvtfKqLTTuJHmqgO3lzJFe3ovMHk=;
        b=6utyRS9RbifwNF6/Yf+igg2ZUd7C3B4Is/BtjX7Y9w5SOk0DwhvrXbfykJ+NY7skvQ
         U+qd4+ugUj/kplEMyo219JiTUxoPjdAvTnX1CDFm9m6FQIts3DtygBBIkwX0sqNVnZgU
         S/hBmGzXafj8IrxEJKyXzpH7GT/3IWxAx/CDoVUsiL/Hhjft5mXK2gcp14+ThU23F7x6
         f0QtonViP1/ZbZfR57LnUc/jKKb0UKYcT/o+l5X+Xm40ByizFer0Q8j2AbEbWyBmU5cv
         Hx/goATGcxhJ/Mc4pDec+TfkkCdg/mNVcJeyN2LPQEypRfzbRTL63z0W6oJWn4yN26DW
         QYVQ==
X-Gm-Message-State: AO0yUKXb203fPiCow6NJJvB5Z13bA0zL3qn+7pPrf9DewGX1dIfu+jTm
        vbNKhlDM1eSeHmMTRy5/PGwRU56TbfSwrEXf
X-Google-Smtp-Source: AK7set+5RJr0nFo/m6ZYFXOOSqsdOO0whoAhyXzjI3T6wMtiP20NDv7zFd5b0CEvGFES5LiYP/X44g==
X-Received: by 2002:a17:906:af6a:b0:88a:7408:384c with SMTP id os10-20020a170906af6a00b0088a7408384cmr1069783ejb.47.1675724897303;
        Mon, 06 Feb 2023 15:08:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 08/19] worktree: fix a trivial leak in prune_worktrees()
Date:   Tue,  7 Feb 2023 00:07:43 +0100
Message-Id: <patch-v7-08.19-81d97d03f42-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
index f51c40f1e1e..254283aa6f5 100644
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
2.39.1.1425.gac85d95d48c

