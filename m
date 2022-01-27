Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96324C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243670AbiA0QXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiA0QXK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:10 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6866C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id f17so5814255wrx.1
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnEncWY7prPme576qHMowsf0JhOvzLfHRK/Tpeb+3HY=;
        b=plfjjfC1nU1ZmtYp6+9R3TKeaIxZd8tTTYToivZfesc1sTCle3qAsqHH8Wv40EOwD7
         Amzba3MhDYZ7jnJ2uZYYxAsv18pjWxG1XbmW7kWtd35UDfMQPB3ef3IgIHYEE7CEgNP7
         wlqakj2lnoCoaoEad4kGq+us6hWoWMvaJc8+tznZpjGataOKPRZ4/jpwfKXxwJwVhvLj
         8qWM616F8HdGxu/meITreTfuGc+lnQPATWmSelqagXoBwJ/A6pAqESwyOFCxzMBu74dM
         OrW3HsgMwrz63vyREUigZLk65dcXuDMXxc98mIfwKbg+G9EDrD9qSCjOeM+Y6K2suKla
         HUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnEncWY7prPme576qHMowsf0JhOvzLfHRK/Tpeb+3HY=;
        b=AtOxquWDts7Oxm01GLi5n5fy48CxA/cc2Szh+2CfHnvp+VALotZ4umdrQ3RsZYvpjP
         wkg1sLrcka6V4UyHc64STzpvsQ9ceC0NrwYofUAMY9/KciTAbMPcUJxUfXzXVP9SUrjb
         bHkXiVtwKU3SJ41ntFD3ZZ8iivF+hR89JfkingES8qpPftRAoVbmQdQACv0WWnm+ONaT
         UrIcjfCoH80Q3lCr9R3h5FdQ7ZFWOoa5RcBYtwFCehzobcP/rLn2K4Nenmffm6zpX0k0
         V2rNDAsYWl33/Anw931XrHzNy8Jf6gkPGV08AQ4ZHasETPFzgcfV2Wgzd/l3+guoOdDt
         +ClA==
X-Gm-Message-State: AOAM533VTVfPKZU0ESozhH10MNV2xDQdp7fF85COKyIrUYtLGpi67GuF
        gd5+rD/73TtIEdlKbHrcXSq/H1G0Xd1Uyg==
X-Google-Smtp-Source: ABdhPJwP22VAt4X1d6RtD7ce5CA2b4Psr9Zuwl5zGR7H6oISYyz69WZj1Ndw54s5ISIIjPdZxg/jgw==
X-Received: by 2002:a05:6000:1ac8:: with SMTP id i8mr3604200wry.136.1643300588198;
        Thu, 27 Jan 2022 08:23:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 6/7] builtin/submodule--helper.c: rename "suc" variable to "opt"
Date:   Thu, 27 Jan 2022 17:22:55 +0100
Message-Id: <patch-v4-6.7-d3ad6e7a351-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "suc" variable in "builtin/submodule--helper.c" to
"opt". The only reason for this change is to make the subsequent
commit's diff smaller, by doing this rename we can "anchor" the diff
better, as it "borrow" most of the options declared here as-is as far
as the diff rename detection is concerned.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1553b318cc7..a96976b1772 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2519,36 +2519,36 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 {
 	const char *update = NULL;
 	struct pathspec pathspec;
-	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
-		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
+		OPT_STRING(0, "recursive-prefix", &opt.recursive_prefix,
 			   N_("path"),
 			   N_("path into the working tree, across nested "
 			      "submodule boundaries")),
 		OPT_STRING(0, "update", &update,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
-		OPT_STRING_LIST(0, "reference", &suc.references, N_("repo"),
+		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
-		OPT_BOOL(0, "dissociate", &suc.dissociate,
+		OPT_BOOL(0, "dissociate", &opt.dissociate,
 			   N_("use --reference only while cloning")),
-		OPT_STRING(0, "depth", &suc.depth, "<depth>",
+		OPT_STRING(0, "depth", &opt.depth, "<depth>",
 			   N_("create a shallow clone truncated to the "
 			      "specified number of revisions")),
-		OPT_INTEGER('j', "jobs", &suc.max_jobs,
+		OPT_INTEGER('j', "jobs", &opt.max_jobs,
 			    N_("parallel jobs")),
-		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
+		OPT_BOOL(0, "recommend-shallow", &opt.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
-		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
-		OPT_BOOL(0, "progress", &suc.progress,
+		OPT__QUIET(&opt.quiet, N_("don't print cloning progress")),
+		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
-		OPT_BOOL(0, "require-init", &suc.require_init,
+		OPT_BOOL(0, "require-init", &opt.require_init,
 			   N_("disallow cloning into non-empty directory")),
-		OPT_BOOL(0, "single-branch", &suc.single_branch,
+		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_END()
 	};
@@ -2557,25 +2557,25 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
 		NULL
 	};
-	suc.prefix = prefix;
+	opt.prefix = prefix;
 
-	update_clone_config_from_gitmodules(&suc.max_jobs);
-	git_config(git_update_clone_config, &suc.max_jobs);
+	update_clone_config_from_gitmodules(&opt.max_jobs);
+	git_config(git_update_clone_config, &opt.max_jobs);
 
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
 
 	if (update)
-		if (parse_submodule_update_strategy(update, &suc.update) < 0)
+		if (parse_submodule_update_strategy(update, &opt.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0)
 		return 1;
 
 	if (pathspec.nr)
-		suc.warn_if_uninitialized = 1;
+		opt.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	return update_submodules(&opt);
 }
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
-- 
2.35.0.894.g563b84683b9

