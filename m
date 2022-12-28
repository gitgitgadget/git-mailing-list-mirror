Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D160C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiL1SA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiL1SAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:41 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911F183B3
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so6697256wro.9
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzAZSaACoe/whop57XlBvgLBVC5IEyXOdcawpn/kwJ8=;
        b=K92cuGpOm8ZKGJBWeD+XGbMUyNIhLDWv0JahIib8nX90h+U7gn0yLpKsJltmdlAq2u
         6guRiUcbC639uwG07uP7QbdU9J50nehWjTtSqJF4bSZGFD6QDyvTKV7mgu2A49ZA9Urd
         4epaDjZHvoPEYUHP0HUl7ktS/GsWwk8B2WOi/8t3NZRXRr5HyEkdkL2lO+dXpWqzpleF
         LfsLlsJhZa30XyWYofS3nGdE32/MN1VcJ3adLpwWn1nm++gQ4j+8jO4wXp0arKj9i25Y
         ftQJv+Ob5pzTx97Zh/0OejR9tsANa3e1RG3vKYTq1T1SGcWjK8SgyjOw5VWOsTpQuEwn
         4y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzAZSaACoe/whop57XlBvgLBVC5IEyXOdcawpn/kwJ8=;
        b=Tzs9ILlAIpxaMrYIMzuFnkxyQSxYVJZOrY4b/Oz+kBUDdllY4vvv8ZH/0aNJSm5wWX
         3dsrVEukfsyFve1/2MZ/PID1NyN02MgA/XUL4UZPZKpNgHgo/iVNk/ugG0NC8fQDxs6A
         /hIRdJV1bYLzkxjvu1x5AKPzpvyL1paZu7JIPq8Z3dVW6UDnSN6G448TPhKkIim6lhCn
         gANmWeXUNFYRAZpeoMWrvpG3nY2yxiO2afyaa+CLG2XQ/y8nrXL7d+iapZa+0hn5olAr
         IcaDa3/wAPYg2tLjnhchY709Bssd8DTYMn3adNTep/l3Y/k0F8p2KGlf/YV5lvQGUD/w
         LoAw==
X-Gm-Message-State: AFqh2kqSvYaNDJJuZ1oEm5DNOkdQIyzTM5hcMfl+oNJ0kwgEAPCruN4K
        fBqFsCVF6Ujxp70x0oOKlXXXdP/f12CVAA==
X-Google-Smtp-Source: AMrXdXu1Btvo/IB1ljwiodfGG9YNHxN61Fqv8p0OW2sMM2n9e95QIWZuEiqK8P1O3Bi+i1dwa0QmBQ==
X-Received: by 2002:adf:fc07:0:b0:288:ebd8:dc1f with SMTP id i7-20020adffc07000000b00288ebd8dc1fmr1377057wrr.55.1672250434037;
        Wed, 28 Dec 2022 10:00:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/20] reset: fix cmd_reset() leaks with a clear_pathspec() call
Date:   Wed, 28 Dec 2022 19:00:08 +0100
Message-Id: <patch-08.20-21670099c84-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add clear_pathspec() calls to cmd_reset(), including to the codepaths
where we'd return early.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reset.c                | 11 ++++++++---
 t/t7105-reset-patch.sh         |  2 ++
 t/t7106-reset-unborn-branch.sh |  2 ++
 t/t7107-reset-pathspec-file.sh |  1 +
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index fea20a9ba0b..e9c10618cd3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -390,7 +390,8 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (reset_type != NONE)
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
-		return run_add_interactive(rev, "--patch=reset", &pathspec);
+		update_ref_status = run_add_interactive(rev, "--patch=reset", &pathspec);
+		goto cleanup;
 	}
 
 	/* git reset tree [--] paths... can be used to
@@ -439,8 +440,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				       LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, &oid, intent_to_add))
-				return 1;
+			if (read_from_tree(&pathspec, &oid, intent_to_add)) {
+				update_ref_status = 1;
+				goto cleanup;
+			}
 			the_index.updated_skipworktree = 1;
 			if (!no_refresh && get_git_work_tree()) {
 				uint64_t t_begin, t_delta_in_ms;
@@ -488,5 +491,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 
 	discard_index(&the_index);
 
+cleanup:
+	clear_pathspec(&pathspec);
 	return update_ref_status;
 }
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index fc2a6cf5c7a..9b46da7aaa7 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git reset --patch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-patch-mode.sh
 
 test_expect_success PERL 'setup' '
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch.sh
index ecb85c3b823..a0b67a0b843 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git reset should work on unborn branch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 523efbecde1..af5ea406db3 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='reset --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
-- 
2.39.0.1153.gb0033028ca9

