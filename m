Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6440FC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhL1Vca (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 16:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhL1Vc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 16:32:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6EFC06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t26so40584635wrb.4
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lgCF+kpvTSY66fmxxp714TIlFEsS63dT8obB4mIHTF4=;
        b=RAmrbi4CfxzbKbx7zCu4MXd0pDmcH2UB194NA0En5B/ZS5+Y+4qCIuZAZaqOMXribW
         vBhJW3lPPe4JVTent8UiIydc4wMWcuCJr+U9PAyENsXD29a+coN1//eaJ7/cJqxTYNx9
         wzvJ7GW3GXrW0WtDABckpVVoid7x9wRTSI6r6knACIy0eLBhi7f9LzaFAUQPqb5wyb8J
         tskkRJiXW6SN6sC7cgF5AAFWosgSjTHrXQP/nq0EEmK/uUdsHfvjcGsYdLHzQ6PVI3oJ
         LOmNj1jTB3jNmDJorWFq/S6/lKi5n5uwq0TBgr1zNQVB84dRdk54jKhHfCVf+7j5kW8b
         Cb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lgCF+kpvTSY66fmxxp714TIlFEsS63dT8obB4mIHTF4=;
        b=jxWRyH2toP7UL6sUdWx++m88NX3faDSfC6i+cP1/jSPOAESQ5q/o/GV6XRKqSGsA81
         00iwm+/4GgLf6Hb9zeJjXieZHxuLA7zQ5ewO5qgzWL+EPNDNbPr731ad6FuEHYfH2lmj
         4p7D1GNmj63bmeaEON6cczHR1xFtwHuDt02zpySAPe0MDYurdsT+onlK37UxnkZBPSXu
         8f58fhOgeCums/0IdyDeJV+Z5zkdeb3inD3zhyfGlc3r7QzXRp/eauH/8gNbQlaSi5n2
         InCpWP2O4SPbGSA1ZcoExzA/tSHmjyKjKY8J7JJjZQNlapt62bPH8RWlhwZwa4W5kh6e
         dOVQ==
X-Gm-Message-State: AOAM531D5uVX2Mx+TlMVFqBv5Su2X5MDUhVZWSb9WlhB3lL+mYxGe9TJ
        0JOMKliuW0fOIRg75BVd+Hw1bhawjgY=
X-Google-Smtp-Source: ABdhPJwbQh0H7qXwNnChO6Tr2UA5o0Lnx/YdhsXUvVKjPejo/k2G5BvEjpu9FX2FCQYFq5MkcyR8kA==
X-Received: by 2002:a05:6000:2c8:: with SMTP id o8mr17937017wry.84.1640727145688;
        Tue, 28 Dec 2021 13:32:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm19099543wrg.105.2021.12.28.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:32:25 -0800 (PST)
Message-Id: <749ba67d21e0dacfaadc0fabdbab5e46e3d5bfcc.1640727143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
        <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 21:32:18 +0000
Subject: [PATCH v3 1/6] setup: use a repository when upgrading format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 679c1070368..08f8df2648c 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -361,7 +361,7 @@ static int set_config(enum sparse_checkout_mode mode)
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

