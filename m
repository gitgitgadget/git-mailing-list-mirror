Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B94BC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B58611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJUT4l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 15:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhJUT4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 15:56:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE2FC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so1229175wrg.5
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeLxhqMwRsh2kfoeS5N0BcNBRx3O6izpI9qjgHdZznE=;
        b=MD00SeG7tVR0zVapXnNvY+7xsxm0GeJycZKKDdy6wu3AZiNwROajvfNfgVWKdBgidS
         QR8HENQXzCNnHJ6d6yCQaagtUblsuMSPCHrKlVkDm0P5KQNLmG/X2pRO77x7oxMH/Obi
         0dlIb2EpPsi+fve1Ih3fsVwzJ0aGBGhX3EXF6/9onSV87m/P5WuQ+cM2W3ibj0XeGPzz
         0fuVs4Uz652pv4lKX9XqjQwGE1ff6gU7mKFBDBMgWsgahedUKkfzL/gmxYyoEjL1FL2D
         P99aqmDdpqwHMmA+mOkr3C4kGAZrSnS9S5kDtVXt9Evc/2NfLS9zj5f5O30126iZozSb
         fUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeLxhqMwRsh2kfoeS5N0BcNBRx3O6izpI9qjgHdZznE=;
        b=G4ZuUjrxstZElD59ESBfLQqNelR3+hPBuBHZnJHhOzi5rHgZlSXo7MWZic5KtAUcMy
         VgFUcE3GRsQAUV+oRTZBASyu0LRoOqAfryuA5KhO7tsf/UfsVwPF7/ykSd/xR2NLVdBA
         6vFmDxpQJuqdIC1ZGnY82ArLHEj3m+6x76K3T7MNU9rYMg9N8gWM9rQfEBKp1lA6J0s8
         OAbyZRiqbWtAT6mR/lnpftHwBl3lqPL8Ce544Ivq2Td1MC+PKDgjqEMl1gOAw9S0rvDr
         +EFje9tC7MAgAG+AC91n93Kke3PDZQNKfsBX28dfddHql730uDin4pdbJglfcxsjvC5f
         Gf/g==
X-Gm-Message-State: AOAM5302HaLd2eBl8AEqzwdQ/U78tTfv1c0tJ4lYCaBNDp2hoLpssGf+
        p6uFv2HiOtTZ6tHp4JnB/zxvbVePZiDNPQ==
X-Google-Smtp-Source: ABdhPJxOAg/WXsZrd9Z6YktCiWK2DVMA04G5q0Ree6xZAiGC8N72+iYfTMjXvNBEMGE6Q+Z1Az4d7g==
X-Received: by 2002:adf:9787:: with SMTP id s7mr9715820wrb.191.1634846060097;
        Thu, 21 Oct 2021 12:54:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7822492wmp.1.2021.10.21.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 12:54:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] refs.c: make "repo_default_branch_name" static, remove xstrfmt()
Date:   Thu, 21 Oct 2021 21:54:13 +0200
Message-Id: <patch-v2-1.3-4f8554bb02e-20211021T195133Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
References: <patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211021T195133Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The repo_default_branch_name() function introduced in
8747ebb7cde (init: allow setting the default for the initial branch
name via the config, 2020-06-24) has never been used outside of this
file, so let's make it static, its sibling function
git_default_branch_name() is what external callers use.

In addition the xstrfmt() to get the "full_ref" in the same commit
isn't needed, we can use the "REFNAME_ALLOW_ONELEVEL" flag to
check_refname_format() instead.

This also happens to fix an issue with c150064dbe2 (leak tests: run
various built-in tests in t00*.sh SANITIZE=leak, 2021-10-12) in "next"
when combined with SANITIZE=leak and higher optimization flags on at
least some GCC versions. See [1].

1. https://lore.kernel.org/git/patch-1.1-5a47bf2e9c9-20211021T114223Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 8 +++-----
 refs.h | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 7f019c2377e..ccb09acbf1d 100644
--- a/refs.c
+++ b/refs.c
@@ -571,11 +571,11 @@ static const char default_branch_name_advice[] = N_(
 "\tgit branch -m <name>\n"
 );
 
-char *repo_default_branch_name(struct repository *r, int quiet)
+static char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
-	char *ret = NULL, *full_ref;
+	char *ret = NULL;
 	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
 
 	if (env && *env)
@@ -589,10 +589,8 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 			advise(_(default_branch_name_advice), ret);
 	}
 
-	full_ref = xstrfmt("refs/heads/%s", ret);
-	if (check_refname_format(full_ref, 0))
+	if (check_refname_format(ret, REFNAME_ALLOW_ONELEVEL))
 		die(_("invalid branch name: %s = %s"), config_display_key, ret);
-	free(full_ref);
 
 	return ret;
 }
diff --git a/refs.h b/refs.h
index d5099d4984e..77f899da6ef 100644
--- a/refs.h
+++ b/refs.h
@@ -171,7 +171,6 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
  * return value of `git_default_branch_name()` is a singleton.
  */
 const char *git_default_branch_name(int quiet);
-char *repo_default_branch_name(struct repository *r, int quiet);
 
 /*
  * A ref_transaction represents a collection of reference updates that
-- 
2.33.1.1494.g88b39a443e1

