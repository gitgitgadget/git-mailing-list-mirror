Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B852C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340F561181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbhJFKEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbhJFKEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B379FC06176C
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m22so7185641wrb.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtymzXYeIFxBxo1RMizQW4Mh6UWYuHSgERHeqVA1gWc=;
        b=UkP/nohkPyLxMoShYhlzurdye50cDzgPQRkiLtN7iLucLhwzdkQ7fdthi02vtE8UFY
         f3daxmHxoprXD4W74znnoYWO2qgSJpnIFSD6TsKfOkxIx5DGxRmVQu5jEomSEAoApKrd
         JH1KU2gNCAWcBZLXS8RUH92NzOAwtcPZF1OOEsDDqj44lgiGX0EwbEDqYzJK4Gu/CP3Z
         YJ+yY7MPI+qoTORaqjTVrEBjzlAC+gRMlFj7EKOjQ59NKKeOtWygD9RiLpAzSMffuH67
         e3M+X3AbdrmHbGvYb+1hQIhVtpUjuTVZvP5NUbG827RFRSURnhDXPYkhKW5N+9ydGseX
         H8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtymzXYeIFxBxo1RMizQW4Mh6UWYuHSgERHeqVA1gWc=;
        b=eMRPtdTBeCpcZezACAEZGLZvrbtgQN6m2iJAFYu12c1Phw4aVvNgErCObFepxIooVg
         EInQ9U3o3NbM2lO3l4F7jmzBKihx32BBhnPMHz3tt26/QPiSBJSnTBtLvGQlrlazElXI
         sdnUbOp+1SbAkl98CpgRxnOUtAtuz7peBWBrCqKt1mKDlkmn6zaZgcaEN/Svn+zoHLVY
         V1o5QjUFub7eArBek2haTStKCYn6oEzgZanrL0dyTFWrEtq9PTkYcnVkSdSdk0mr3zwf
         yaswl5pmVVsSBupkOJQV4N+yZOwHPFcJGroeeJ6ArE/kON8Xf8YGVcPOP1SGiZi48noA
         5YOA==
X-Gm-Message-State: AOAM530LHrrA1O84zi8Rs4+E4jYp+yhfEFAHhnEBraD/b18OWS7aRnj9
        F1uDfMJXa8PCBDFrmgRVs7UcQM6lRlXCXA==
X-Google-Smtp-Source: ABdhPJzjUSXNuif1uSKzPgeEgLVSajswS9WzcFnM1se4+g+m9YbNDgqB/O4SMeTt/Neien5IEOOYgw==
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr4139140wrb.352.1633514554051;
        Wed, 06 Oct 2021 03:02:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] ls-files: add missing string_list_clear()
Date:   Wed,  6 Oct 2021 12:02:24 +0200
Message-Id: <patch-6.7-34749645f74-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been here ever since 72aeb18772d (clean.c,
ls-files.c: respect encapsulation of exclude_list_groups, 2013-01-16),
we dup'd the argument in option_parse_exclude(), but never freed the
string_list.

This makes almost all of t3001-ls-files-others-exclude.sh pass (it had
a lot of failures before). Let's mark it as passing with
TEST_PASSES_SANITIZE_LEAK=true, and then exclude the tests that still
failed with a !SANITIZE_LEAK prerequisite check until we fix those
leaks. We can still see the failed tests under
GIT_TEST_FAIL_PREREQS=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c                 | 1 +
 t/t3001-ls-files-others-exclude.sh | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 0fecfa3b0c1..6e5ac0780e4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -783,6 +783,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		ret = 1;
 	}
 
+	string_list_clear(&exclude_list, 0);
 	dir_clear(&dir);
 	free(max_prefix);
 	return ret;
diff --git a/t/t3001-ls-files-others-exclude.sh b/t/t3001-ls-files-others-exclude.sh
index 516c95ea0e8..48cec4e5f88 100755
--- a/t/t3001-ls-files-others-exclude.sh
+++ b/t/t3001-ls-files-others-exclude.sh
@@ -8,6 +8,7 @@ test_description='git ls-files --others --exclude
 This test runs git ls-files --others and tests --exclude patterns.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 rm -fr one three
@@ -102,7 +103,7 @@ test_expect_success \
        >output &&
      test_cmp expect output'
 
-test_expect_success 'restore gitignore' '
+test_expect_success !SANITIZE_LEAK 'restore gitignore' '
 	git checkout --ignore-skip-worktree-bits $allignores &&
 	rm .git/index
 '
@@ -125,7 +126,7 @@ cat > expect << EOF
 #	three/
 EOF
 
-test_expect_success 'git status honors core.excludesfile' \
+test_expect_success !SANITIZE_LEAK 'git status honors core.excludesfile' \
 	'test_cmp expect output'
 
 test_expect_success 'trailing slash in exclude allows directory match(1)' '
-- 
2.33.0.1441.gbbcdb4c3c66

