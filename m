Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CBFC433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7010C206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVmxzbVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgHFRxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgHFQbD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60AC002168
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 09:30:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f12so8763719wru.13
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KGkoFrtpNu2YTXlCaOU2P1B4inNdkFDcA2g/l2ql2p4=;
        b=AVmxzbVwUDjZA7h5AuDDiYZFPuOHd0JaagXQAks6VMtE4cItfZ4dtGm4Lr0s9p3rqf
         I9IyNUDT+wrGiDrojqQkzmOtGbcXI4toMddofWChrMoxWz6Fqn+DNPhf0nodz7llrjOm
         qzNTbBdksTAggbDCSknl6wKf43WqVWb/Uj8/GyrzNPtarcVrAkoda0TgCFeWwtGtHTdO
         NEyN2wAaBz6Bm9MW8OzzmY+cFinxM5WhZ3+J2ivhr5JYCXdvtwAajc91a3aTKVFF9qmh
         AO57vjdWpVAwghpCgjYin6Y+cHzmO/7S2py+Zji87YnQv8BH3/3ryKp0SKRAFVLYdeNH
         1NzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KGkoFrtpNu2YTXlCaOU2P1B4inNdkFDcA2g/l2ql2p4=;
        b=hs46emqrti1iUsGUyMBAUn7yrTIy+hg7I93+m4yva6Xk1aKwp9PjAkrDV8e5d8dlBg
         yjPUyA21BqDV30x398uZT8joOZexA1B1NS3H0JJBpIDimOlYjbp3v3ZNxrQFpfiahRHz
         YTW62ilkj0FVQH65bjD5DVFLAuu0FJU8I4J42flNQoRqWxP5F1WiEtqjBCKUnfz+UTDz
         kkyXjwXEefiVffNgcot+TbbEKIUn6Xd46HDyh7Pv7DImF0WbCT6KLR0Dd9PbZwjpC8xy
         7LS8BWMrfsDLbt/AaNhVAM1/4CkIPMj/OkelPt8ZTD8DAPByE/1nTvy87m6RgJoQQutV
         XKRg==
X-Gm-Message-State: AOAM530Gtf37N/VH+v2W2xu36+7oIk6LtTk4trunXqjmJEIkElTW/DRU
        bV2/GZlR66s2o3A+o4ViKuw73CX2
X-Google-Smtp-Source: ABdhPJwEFqJ4suEZ45nsL6O1r2cIeJHexX1uw31vieFWieuBiFtwlAnAHP2plvLLKhdpdxY7SbkG6A==
X-Received: by 2002:adf:ba83:: with SMTP id p3mr8385392wrg.246.1596731427095;
        Thu, 06 Aug 2020 09:30:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm6857122wrf.48.2020.08.06.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 09:30:26 -0700 (PDT)
Message-Id: <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.git.1596731424.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 16:30:16 +0000
Subject: [PATCH 1/9] fetch: optionally allow disabling FETCH_HEAD update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If you run fetch but record the result in remote-tracking branches,
and either if you do nothing with the fetched refs (e.g. you are
merely mirroring) or if you always work from the remote-tracking
refs (e.g. you fetch and then merge origin/branchname separately),
you can get away with having no FETCH_HEAD at all.

Teach "git fetch" a command line option "--[no-]write-fetch-head"
and "fetch.writeFetchHEAD" configuration variable.  Without either,
the default is to write FETCH_HEAD, and the usual rule that the
command line option defeats configured default applies.

Note that under "--dry-run" mode, FETCH_HEAD is never written;
otherwise you'd see list of objects in the file that you do not
actually have.  Passing `--write-fetch-head` does not force `git
fetch` to write the file.

Also note that this option is explicitly passed when "git pull"
internally invokes "git fetch", so that those who configured their
"git fetch" not to write FETCH_HEAD would not be able to break the
cooperation between these two commands.  "git pull" must see what
"git fetch" got recorded in FETCH_HEAD to work correctly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/fetch.txt  |  7 ++++++
 Documentation/fetch-options.txt | 10 +++++++++
 builtin/fetch.c                 | 19 +++++++++++++---
 builtin/pull.c                  |  3 ++-
 t/t5510-fetch.sh                | 39 +++++++++++++++++++++++++++++++--
 t/t5521-pull-options.sh         | 16 ++++++++++++++
 6 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index b20394038d..0aaa05e8c0 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -91,3 +91,10 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.writeFetchHEAD::
+	Setting it to false tells `git fetch` not to write the list
+	of remote refs fetched in the `FETCH_HEAD` file directly
+	under `$GIT_DIR`.  Can be countermanded from the command
+	line with the `--[no-]write-fetch-head` option.  Defaults to
+	true.
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 495bc8ab5a..6972ad2522 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,6 +64,16 @@ documented in linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
 
+ifndef::git-pull[]
+--[no-]write-fetch-head::
+	Write the list of remote refs fetched in the `FETCH_HEAD`
+	file directly under `$GIT_DIR`.  This is the default unless
+	the configuration variable `fetch.writeFetchHEAD` is set to
+	false.  Passing `--no-write-fetch-head` from the command
+	line tells Git not to write the file.  Under `--dry-run`
+	option, the file is never written.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git fetch' is used with `<src>:<dst>` refspec it may
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c8b9366d3c..42ca774ad1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
 static int enable_auto_gc = 1;
@@ -118,6 +119,10 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "fetch.writefetchhead")) {
+		write_fetch_head = git_config_bool(k, v);
+		return 0;
+	}
 	return git_default_config(k, v, cb);
 }
 
@@ -162,6 +167,8 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
+	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
 		    N_("allow updating of HEAD ref")),
@@ -895,7 +902,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
+	const char *filename = (!write_fetch_head
+				? "/dev/null"
+				: git_path_fetch_head(the_repository));
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1329,7 +1338,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		retcode = truncate_fetch_head();
 		if (retcode)
 			goto cleanup;
@@ -1596,7 +1605,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	int i, result = 0;
 	struct strvec argv = STRVEC_INIT;
 
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
@@ -1797,6 +1806,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	/* FETCH_HEAD never gets updated in --dry-run mode */
+	if (dry_run)
+		write_fetch_head = 0;
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/builtin/pull.c b/builtin/pull.c
index 015f6ded0b..5ef3434e1f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -527,7 +527,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 	struct strvec args = STRVEC_INIT;
 	int ret;
 
-	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
+	strvec_pushl(&args, "fetch", "--update-head-ok",
+		     "--write-fetch-head", NULL);
 
 	/* Shared options */
 	argv_push_verbosity(&args);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9850ecde5d..31c91d0ed2 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -539,13 +539,48 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
-test_expect_success 'fetch --dry-run' '
-
+test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
 	rm -f .git/FETCH_HEAD &&
 	git fetch --dry-run . &&
 	! test -f .git/FETCH_HEAD
 '
 
+test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --no-write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success '--write-fetch-head gets defeated by --dry-run' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --dry-run --write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and FETCH_HEAD' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=no fetch . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD gets defeated by --dry-run' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=yes fetch --dry-run . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and --no-write-fetch-head' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=yes fetch --no-write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success 'fetch.writeFetchHEAD and --write-fetch-head' '
+	rm -f .git/FETCH_HEAD &&
+	git -c fetch.writeFetchHEAD=no fetch --write-fetch-head . &&
+	test -f .git/FETCH_HEAD
+'
+
 test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	(
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 159afa7ac8..1acae3b9a4 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -77,6 +77,7 @@ test_expect_success 'git pull -q -v --no-rebase' '
 	test_must_be_empty out &&
 	test -s err)
 '
+
 test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	mkdir clonedcleanup &&
 	(cd clonedcleanup && git init &&
@@ -85,6 +86,21 @@ test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	test -s err)
 '
 
+test_expect_success 'git pull --no-write-fetch-head fails' '
+	mkdir clonedwfh &&
+	(cd clonedwfh && git init &&
+	test_must_fail git pull --no-write-fetch-head "../parent" >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep "no-write-fetch-head" err)
+'
+
+test_expect_success 'git pull succeeds with fetch.writeFetchHEAD=false' '
+	mkdir clonedwfhconfig &&
+	(cd clonedwfhconfig && git init &&
+	git config fetch.writeFetchHEAD false &&
+	git pull "../parent" >out 2>err &&
+	grep FETCH_HEAD err)
+'
 
 test_expect_success 'git pull --force' '
 	mkdir clonedoldstyle &&
-- 
gitgitgadget

