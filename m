Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0494C433FE
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbhLTP53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbhLTP52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:28 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEACC06173E
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso7672121wmd.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IsSw908ccp3lxCR+ZdyOEfSsjPWPiG+5vFYTdIKHeTI=;
        b=I13ppJdWQkOFXs2ZAv6vCS5+RD6I3Po62pgWas67mMWGXsAjmgMRJTyhqCzf1+9xOg
         eSaYsChJcV9WDgYPbYY91dodhbz8IVa+bs/KYF4FDJ+8u5R5wqgYOAkWae8Q+B/7HdxR
         QqA+zM5bBKRQKXEKDeb0P8x3YgXaRU2GHOvZ91JxIYCeNIG8Fr5/gc23d7obSZptV9bp
         OocdM1GmLoVdWab0xTzVInTyDo0cVQWoOXJGvA/E0Rf9+Lvx73qGgn02cYkoT6rtbKrG
         NgTUuxUYgDCY5nuf6OjLR34mHjrSCpPutL71bS7kPMR3axccsySJCEomJoheSQyQAuEm
         zC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IsSw908ccp3lxCR+ZdyOEfSsjPWPiG+5vFYTdIKHeTI=;
        b=5KDL0WqdzQ5q7rwiZVTllAF7B1A7UkTTDJlX7hPtEBjQdr5RKucNsRRhhOW9rYMfxV
         SD2ICCwuN/6U2g/fjgvo7AvH1BnUvTMVK8geEiB0k/Mt+Kc/NhiFWF7JV+in73zI0IuZ
         wwQ3/V5HJik+6oH08CLyqfi+IfrwBWiUKyMQzmTNt+yV6hXU0BbMwmeCeRPvrIM4bJ5g
         OqUx336m4PwN84kb0Ybf0TzPI0aEcA9KsUxH6J9bq8l3zjiT5TGY8pIK7Ea9LBNbLONO
         n4WYgCZYmIMlxiT0kiUiJWTmYgU8W6OPmgUTkldWvGmVGwTXhFR6+bncWX7DqUpAOCO+
         wyZQ==
X-Gm-Message-State: AOAM531J+64JQ8KyBVCjMWzSuCd9fZ4xEc951MwGOQjcduf/sHyfKKYj
        Hz7MU2ljm4XIUyOOUrxZf70rvUDSdJs=
X-Google-Smtp-Source: ABdhPJx9jHmY7T6cIOThTOqI3x29cMm1tv/OndWrMoc4OzUSrpnLeY2GBzSbuRVD2A78ExwdeAz+gQ==
X-Received: by 2002:a05:600c:1e12:: with SMTP id ay18mr6736741wmb.14.1640015846435;
        Mon, 20 Dec 2021 07:57:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm14090777wrc.74.2021.12.20.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:57:26 -0800 (PST)
Message-Id: <28813703ff612cd346a49549ce11ba79a47eb223.1640015844.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:57:21 +0000
Subject: [PATCH 1/4] setup: use a repository when upgrading format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The upgrade_repository_format() helper previously was not aware of the
possibility of multiple repositories. Add a 'struct repository *'
parameter so it is possible to call it from a specific repository.

The implementation already referred to the_repository in one place, so
that is an easy replacement. The use of git_config_set() is replaced
with a call to repo_config_set().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c     | 2 +-
 list-objects-filter-options.c | 2 +-
 repository.h                  | 2 +-
 setup.c                       | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d0f5c4702be..34447f87cd8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -358,7 +358,7 @@ static int set_config(enum sparse_checkout_mode mode)
 {
 	const char *config_path;
 
-	if (upgrade_repository_format(1) < 0)
+	if (upgrade_repository_format(the_repository, 1) < 0)
 		die(_("unable to upgrade repository format to enable worktreeConfig"));
 	if (git_config_set_gently("extensions.worktreeConfig", "true")) {
 		error(_("failed to set extensions.worktreeConfig setting"));
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index fd8d59f653a..6e21d12045e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -372,7 +372,7 @@ void partial_clone_register(
 			 */
 			return;
 	} else {
-		if (upgrade_repository_format(1) < 0)
+		if (upgrade_repository_format(the_repository, 1) < 0)
 			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
diff --git a/repository.h b/repository.h
index 98f95834706..d3fc1f7689d 100644
--- a/repository.h
+++ b/repository.h
@@ -215,6 +215,6 @@ void prepare_repo_settings(struct repository *r);
  * Return 1 if upgrade repository format to target_version succeeded,
  * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
  */
-int upgrade_repository_format(int target_version);
+int upgrade_repository_format(struct repository *, int target_version);
 
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 347d7181ae9..90516664ce5 100644
--- a/setup.c
+++ b/setup.c
@@ -595,14 +595,14 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
-int upgrade_repository_format(int target_version)
+int upgrade_repository_format(struct repository *r, int target_version)
 {
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf repo_version = STRBUF_INIT;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
-	strbuf_git_common_path(&sb, the_repository, "config");
+	strbuf_git_common_path(&sb, r, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -621,7 +621,7 @@ int upgrade_repository_format(int target_version)
 			     repo_fmt.unknown_extensions.items[0].string);
 
 	strbuf_addf(&repo_version, "%d", target_version);
-	git_config_set("core.repositoryformatversion", repo_version.buf);
+	repo_config_set(r, "core.repositoryformatversion", repo_version.buf);
 	strbuf_release(&repo_version);
 	return 1;
 }
-- 
gitgitgadget

