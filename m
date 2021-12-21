Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395CEC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 19:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhLUTOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbhLUTOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 14:14:11 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA1C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so9264wrd.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IsSw908ccp3lxCR+ZdyOEfSsjPWPiG+5vFYTdIKHeTI=;
        b=qRbO5kEI7ulB62J68+Rxy0FRIO5neWShsx9oW293kNenj04kdG88n/4935E9jb61h9
         Nl5Z/QehVhrBXQX3cMgjVmhXPM7MfsQeKUUMx9B3h7PTvcYkbcJrq7pFHjC/yk9qniE1
         pOI4qD4p3bhFIietQecIR9wEtQIpSlkU5n3W0KCZgKqtyMR5IPUWIBgJXu8X4eOXEtnB
         XDmZ4qCvd9jXciXaIfeuuF42FZh3O9aee6vm0TVuynRxHG1nJItSOauEsk4nF3Ut8b+k
         zxaUoz4km22KEiKQaQY154UWC6OnemJWw5TksT9ZlrjWaR47o7lZm3mi+EdtEfqMGenv
         mY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IsSw908ccp3lxCR+ZdyOEfSsjPWPiG+5vFYTdIKHeTI=;
        b=H4i5zkJqHnMa5yODaiCR7mHkLAVxLuRF6s+w2aXeq223/5y5K3HsKEG6IBx6L+FJ1l
         PhOkFiVqdZPGlVd9Q5pXzcAKIOmFoYjQEt/PEdKHqsU7C/RrZ2AJkyiXq4h245fwaF9V
         0Y6B2tk87SEOxx0Jxzl6O6LdnZH3+huAUCe9EJZDAIxP9POybzo2rgvr6aEqxFLpONpw
         paHibdnKzxQNGChldRnKR6wM4f6uruutPs0pxqH4YXugTcTKdl8ydl4FfFW6N5xrxrEz
         QHfZ4n8h73+J6UeZHxfZRPGAbNNpJ8gZY9Wmtaosa7zq3ScVhV/2UCa0aptYvQEsZ7h1
         0fTg==
X-Gm-Message-State: AOAM531iBGeTWMCq7oHz7SJkZEEQMazaeIXaM+niXsaVhVE5mebCs9Xk
        cwsUl1H1aXpibQHrUFaN7z8GxE97EOw=
X-Google-Smtp-Source: ABdhPJwNNzir40Lk7eKHfpvdh3FFtOegFH2Rzcgi6f02xgD5/SrqE+rpIsmhDb3UwQp/1VFEwrD81Q==
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3704490wrp.442.1640114050002;
        Tue, 21 Dec 2021 11:14:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13sm3313969wms.17.2021.12.21.11.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:14:09 -0800 (PST)
Message-Id: <889e69dc45d0b02e8207a39e321c7a752bdb2532.1640114048.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
        <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 19:14:04 +0000
Subject: [PATCH v2 1/5] setup: use a repository when upgrading format
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

