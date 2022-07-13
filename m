Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD10C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiGMNQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGMNQj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED66335
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so9313734wrv.4
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmZbS6YzIAmUCogA+OdgBOA0PZ4LHSGCDj1zill1wG4=;
        b=qpdYHlVzGJenPL6fVS07mrUkbCur5xPteq2JX51xSI8kEEb8Fy0ydPddiuyqsldQsC
         XPw6IscIM5gZ30sARZEZG4LP8vHZnkmz/2oJcgvnodJAJKBAg8uSuKepxGkYbZPjqInS
         hDulfk+SyNDG09awsBGuukyH6h4oJ6VvWPwjDlOR6nfWf2a/8FCu8LIUJVeZPU/+qAEl
         7QuqKQXfzYPGfhqRBhQja5g+hSF1OHsWuo7U8QWPfmtlGMw4U+LyC8FPSBKRMIBdG5CX
         5JMCDAMWJGJnUBHsBkPxg3zmzQsPaQ4Ab9IrXDbkLkS3sEvgJM716n1qunL4QMsoabzo
         4pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmZbS6YzIAmUCogA+OdgBOA0PZ4LHSGCDj1zill1wG4=;
        b=Hey5mNlvnRDqgqzohUDY4h3eAcIbEe6if8xvY/PDIdagbyZegINdtCjor2wC30rScI
         O9Gt86uxBDm+qzfvg5CQkiIJhT+MOhZNzKavD5n3ELXtbynBk0Uf+FtbOklxhXKv9n1s
         UDmGHVmuM7O/+h7/wmhB46JMOzG56flc6CI5eEN9kvuEBUFzGp/9naVfo1KZv9AgIW4W
         D4Sh5tpjEA8ywT75Hd02iKebjTeeD35afa3DXI3JEfBUdjdtWgTdyq4alAEHAekNQYDZ
         HfaorSAA9sGfHOnPWkeIbb4hxFeU1xzqCQXRw7QtY2m7UpI0j0Lj0ytXeMNv/OuTihqj
         oWxw==
X-Gm-Message-State: AJIora9Ur7ajQYG+Ql8w17YSpNYK5Nqy3KvWVfHynYSKIjC9WfiwyV2X
        qY8F2sBZ1Voo0H5sdezwExqvk2kLG+5iWA==
X-Google-Smtp-Source: AGRyM1u+Cn8l7J1B/r05ypc68M3gcSClChRxI7Q42cA218pe9Xsb0kIDOc/l0kF9eZEU2Ik9T/cZng==
X-Received: by 2002:a05:6000:2cc:b0:21d:76d7:995d with SMTP id o12-20020a05600002cc00b0021d76d7995dmr3358116wry.339.1657718195559;
        Wed, 13 Jul 2022 06:16:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/11] submodule--helper: fix a leak with repo_clear()
Date:   Wed, 13 Jul 2022 15:16:15 +0200
Message-Id: <patch-10.11-e6c633256f3-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c        | 1 +
 t/t2403-worktree-move.sh           | 1 +
 t/t7412-submodule-absorbgitdirs.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0bac39880d2..d9fab5d77da 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2486,6 +2486,7 @@ static void ensure_core_worktree(const char *path)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+	repo_clear(&subrepo);
 }
 
 static const char *submodule_update_type_to_label(enum submodule_update_type type)
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
2.37.0.932.g7b7031e73bc

