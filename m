Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7E01F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbeHPF0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:36 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:35686 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:36 -0400
Received: by mail-it0-f73.google.com with SMTP id h17-v6so2970393itj.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zc9rJUDpcsXSmYQOApLYZ4ndJkzGaTh+C43eI0eNtwc=;
        b=nq2TXDcUU8ztktZZS/Q4iHEzB5P819iYkegbte9cnV9EAAOsv8wiV73PN71rcFSMqo
         NrhOKnOs1blZCN8EldPl/SvgsRHFfBfW3encg+ogXoG66MouDcUe/nOxhSn2RbGeBIJ4
         eOP6gbawJsYGmjDqcv2BFTvgefyYuURBmlZxUz4u8ZDaRzQ3+te+IX4V4c7a3a4Dh9Lk
         AOJ4SyxjRu6OVB7cDJJP06daURzBNdvR2Mj6pfr6Ucyc1bu9lApRy3DT2bBTsjkImlrb
         rB6bfIE0Pa1r6kBqhn9JS8DeDdHVGz2574Ow8exKnhKQVTJfb0kSdGenGXzJMv87OnZy
         WUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zc9rJUDpcsXSmYQOApLYZ4ndJkzGaTh+C43eI0eNtwc=;
        b=k0bIfrsWV6/yVQs7qNqaeJos7t/yUQSgHlwF7dhOVhtfB/35vsJDXvIFmcSStxEe4I
         VNMJAq7uHxAPyR3VUxsHMp5YbzdrZnsYv5LFyEEVfYvWqPbWsX9Dmdqk2zaufTCCyXcL
         GhzqvZDLwVqfdbr9o6hFHN+ok9PtV41AOrK+/R10AqwuPp8Kf9YS/cbcbxCytMIbPRGz
         uqMGssZ9AfSFSadpQS0ZnTbxinDUwlKm+uPum98fLGdGR9P5nioUf7S2essWi9Nw7ol7
         lr3knoVJCMj6gwUyecMpfftZtotl5NPeJ2g8F/+Bypb/8IKR0BV9l59bxHxePcUlvk9i
         fUoA==
X-Gm-Message-State: AOUpUlGzSfK/xvGMbexukCHLi/h0hz9JZ5Z2+dG/1UDut6RNT+jw9syB
        nTsLj/AadNDuHnoqjhCrpM3g/w/HKmMwLDM7Hvg5H6ork+Kd7hduiZsfUPhxrR9fXfHyXvXivp0
        c8ONgiCUGQ+GOBY9Wrx1wKNl5avAgyxq3KfNdB87u+lvyJSIToMDnkJqJN+KB
X-Google-Smtp-Source: AA+uWPzGuqxsIgcVS3//yXr81MrEjSEIyt5HDgVOJpOpfSwrJmBQlENqAyKeECSrJBpdvFmW4EYUFq93L5Dm
MIME-Version: 1.0
X-Received: by 2002:a6b:6b02:: with SMTP id g2-v6mr13028387ioc.126.1534386688335;
 Wed, 15 Aug 2018 19:31:28 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:31:00 -0700
In-Reply-To: <20180816023100.161626-1-sbeller@google.com>
Message-Id: <20180816023100.161626-8-sbeller@google.com>
References: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [PATCH 7/7] builtin/submodule--helper: unset submodule url if possible
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c      | 24 ++++++++++++++++++++++--
 t/t5526-fetch-submodules.sh      |  2 +-
 t/t7406-submodule-update.sh      |  8 ++++++++
 t/t7410-submodule-checkout-to.sh |  2 +-
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 36de64902ec..3aa385bce5c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1515,6 +1515,7 @@ struct update_clone_data {
 	struct object_id oid;
 	unsigned just_cloned;
 	unsigned retried;
+	unsigned cleanup_url;
 };
 
 struct submodule_update_clone {
@@ -1590,7 +1591,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	struct strbuf displaypath_sb = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	const char *displaypath = NULL;
-	int needs_cloning = 0;
+	int needs_cloning = 0, active;
 
 	if (ce_stage(ce)) {
 		if (suc->recursive_prefix)
@@ -1632,7 +1633,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	}
 
 	/* Check if the submodule has been initialized. */
-	if (!is_submodule_active(the_repository, ce->name)) {
+	active = is_submodule_active(the_repository, ce->name);
+	if (!active) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
 	}
@@ -1653,6 +1655,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	suc->update_clone[suc->update_clone_nr].sub = sub;
 	suc->update_clone[suc->update_clone_nr].retried = 0;
 	suc->update_clone[suc->update_clone_nr].ce = ce;
+	suc->update_clone[suc->update_clone_nr].cleanup_url =
+		(active != SUBMODULE_ACTIVE_VIA_URL);
 	suc->update_clone_nr++;
 
 	if (!needs_cloning)
@@ -1801,6 +1805,22 @@ static int git_update_clone_config(const char *var, const char *value,
 
 static void update_submodule(struct update_clone_data *ucd)
 {
+	if (ucd->cleanup_url) {
+		struct strbuf cfg = STRBUF_INIT;
+		struct strbuf submodule_url = STRBUF_INIT;
+		int r;
+
+		strbuf_addf(&submodule_url, "submodule.%s.url", ucd->sub->name);
+		strbuf_repo_git_path(&cfg, the_repository, "config");
+
+		r = git_config_set_in_file_gently(cfg.buf, submodule_url.buf, NULL);
+		if (r && r != CONFIG_NOTHING_SET)
+			die(_("failed to remove '%s'"), submodule_url.buf);
+
+		strbuf_release(&cfg);
+		strbuf_release(&submodule_url);
+	}
+
 	fprintf(stdout, "dummy %s %d\t%s\n",
 		oid_to_hex(&ucd->oid),
 		ucd->just_cloned,
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 0f730d77815..cd1bd131b59 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -508,7 +508,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' works also without .git
 		git config -f .gitmodules submodule.fake.path fake &&
 		git config -f .gitmodules submodule.fake.url fakeurl &&
 		git add .gitmodules &&
-		git config --unset submodule.submodule.url &&
+		test_might_fail git config --unset submodule.submodule.url &&
 		git fetch >../actual.out 2>../actual.err &&
 		# cleanup
 		git config --unset fetch.recurseSubmodules &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f604ef7a729..f581fea28e0 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -84,6 +84,14 @@ test_expect_success 'submodule update detaching the HEAD ' '
 	)
 '
 
+test_expect_success 'active submodule leaves no URL config in superproject' '
+	# relies on previous test
+	(
+		cd super &&
+		test_must_fail git config -f .git/config submodule.submodule.url
+	)
+'
+
 test_expect_success 'submodule update from subdirectory' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
diff --git a/t/t7410-submodule-checkout-to.sh b/t/t7410-submodule-checkout-to.sh
index f1b492ebc46..683e957934b 100755
--- a/t/t7410-submodule-checkout-to.sh
+++ b/t/t7410-submodule-checkout-to.sh
@@ -55,7 +55,7 @@ test_expect_failure 'can see submodule diffs just after checkout' '
 test_expect_success 'checkout main and initialize independent clones' '
 	mkdir fully_cloned_submodule &&
 	git -C clone/main worktree add "$base_path/fully_cloned_submodule/main" "$rev1_hash_main" &&
-	git -C fully_cloned_submodule/main submodule update
+	git -C fully_cloned_submodule/main submodule update --init
 '
 
 test_expect_success 'can see submodule diffs after independent cloning' '
-- 
2.18.0.265.g16de1b435c9.dirty

