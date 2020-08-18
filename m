Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4897FC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E00B20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xdtvpxoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHROZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHROZg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE8AC061343
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k20so17194395wmi.5
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gfQFFY1U3cY02b6Wx8Zqn/7SPEXcEtAPodyBG0nK84E=;
        b=Xdtvpxocr6Hr3Tyz+gwlVnU521fRFFdugRY5iP5NfPUFjHqslxFpiDTm8YDbrUmqZG
         QYC1a7hUf+24q9avbWKongiozcuQep6+02fYRStPkR3KqskWzaEjOUOr6+yWLJA84gef
         QbgSZhRD9wL5WYahyAuQ+a6fx9wuMSIp7yrwLZgFlM1rfcT8chkw2oJdJE/75GSVuwSL
         JYDeUc5bOTcSouNtnpZrV+E0GOmw+FHoqF3pf0CG4fuTVB+g1m1QaeT3/UMoTaO5qBDJ
         HjMuIao3XBUPgoh780uF3BCVDpN/Rr8pBryFDB94tj+NmS7hBJyXNMnDGcMeiNXuqH+p
         01Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gfQFFY1U3cY02b6Wx8Zqn/7SPEXcEtAPodyBG0nK84E=;
        b=htfeFLdf++wRQJfSektlXMh62IC/zf2yq46AEvaJrsx6VreGmL+gXra5xZe6gEwjHq
         VTVZtH4MyVqCx9dpWtoYZBy9YXAMFfy8Mfa0nKbLdx9PtQxDn12l+fTPGrB6+MC5j9Qg
         ItPhQfZd6F3d0msWh+lbhtnhm1jDSVUjJy8cOOITJGAJRg1fVChX93xVzJhdGhf9NuL1
         oCr8LBCvr65K5c3i7K5y/gWGH4FauzLyBLttyW+nBghwcBgyM3gNzLNXPG/sUeuY9a3l
         uswN2RZCFEZhoAeqHFDGNmV4y9I5dpPLMqaoBWddrg8CUjGJCdUTMM4Dc46+HoqmRH67
         ZuuQ==
X-Gm-Message-State: AOAM530gjnvfWo5HxohY+r2jHCyEM3dD14ZmWu+KK1G6PSf3j1IuMVOH
        JHQ0q8gnaYm6dJ6j4FgK8fnk9zqAQsc=
X-Google-Smtp-Source: ABdhPJw7sCkiR8uVXIyU1VCuUu5ziRNSwE9/yc7Ck6/86OFdAT28+bwIcnb1YnvF2AyKJDxTLu2NDQ==
X-Received: by 2002:a1c:bc54:: with SMTP id m81mr209595wmf.60.1597760734523;
        Tue, 18 Aug 2020 07:25:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm183163wmb.12.2020.08.18.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:33 -0700 (PDT)
Message-Id: <8779c6c20d7e25e13189074dbd57a86b49ec56e9.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:23 +0000
Subject: [PATCH v2 2/9] maintenance: add prefetch task
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
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When working with very large repositories, an incremental 'git fetch'
command can download a large amount of data. If there are many other
users pushing to a common repo, then this data can rival the initial
pack-file size of a 'git clone' of a medium-size repo.

Users may want to keep the data on their local repos as close as
possible to the data on the remote repos by fetching periodically in
the background. This can break up a large daily fetch into several
smaller hourly fetches.

The task is called "prefetch" because it is work done in advance
of a foreground fetch to make that 'git fetch' command much faster.

However, if we simply ran 'git fetch <remote>' in the background,
then the user running a foregroudn 'git fetch <remote>' would lose
some important feedback when a new branch appears or an existing
branch updates. This is especially true if a remote branch is
force-updated and this isn't noticed by the user because it occurred
in the background. Further, the functionality of 'git push
--force-with-lease' becomes suspect.

When running 'git fetch <remote> <options>' in the background, use
the following options for careful updating:

1. --no-tags prevents getting a new tag when a user wants to see
   the new tags appear in their foreground fetches.

2. --refmap= removes the configured refspec which usually updates
   refs/remotes/<remote>/* with the refs advertised by the remote.
   While this looks confusing, this was documented and tested by
   b40a50264ac (fetch: document and test --refmap="", 2020-01-21),
   including this sentence in the documentation:

	Providing an empty `<refspec>` to the `--refmap` option
	causes Git to ignore the configured refspecs and rely
	entirely on the refspecs supplied as command-line arguments.

3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
   we can ensure that we actually load the new values somewhere in
   our refspace while not updating refs/heads or refs/remotes. By
   storing these refs here, the commit-graph job will update the
   commit-graph with the commits from these hidden refs.

4. --prune will delete the refs/prefetch/<remote> refs that no
   longer appear on the remote.

5. --no-write-fetch-head prevents updating FETCH_HEAD.

We've been using this step as a critical background job in Scalar
[1] (and VFS for Git). This solved a pain point that was showing up
in user reports: fetching was a pain! Users do not like waiting to
download the data that was created while they were away from their
machines. After implementing background fetch, the foreground fetch
commands sped up significantly because they mostly just update refs
and download a small amount of new data. The effect is especially
dramatic when paried with --no-show-forced-udpates (through
fetch.showForcedUpdates=false).

[1] https://github.com/microsoft/scalar/blob/master/Scalar.Common/Maintenance/FetchStep.cs

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 15 +++++++++
 builtin/gc.c                      | 51 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 26 ++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9af08c644f..e82799ccff 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -50,6 +50,21 @@ since it will not expire `.graph` files that were in the previous
 `commit-graph-chain` file. They will be deleted by a later run based on
 the expiration delay.
 
+prefetch::
+	The `prefetch` task updates the object directory with the latest
+	objects from all registered remotes. For each remote, a `git fetch`
+	command is run. The refmap is custom to avoid updating local or remote
+	branches (those in `refs/heads` or `refs/remotes`). Instead, the
+	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
+	not updated.
++
+This is done to avoid disrupting the remote-tracking branches. The end users
+expect these refs to stay unmoved unless they initiate a fetch.  With prefetch
+task, however, the objects necessary to complete a later real fetch would
+already be obtained, so the real fetch would go faster.  In the ideal case,
+it will just become an update to bunch of remote-tracking branches without
+any object transfer.
+
 gc::
 	Clean up unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
diff --git a/builtin/gc.c b/builtin/gc.c
index 3fdb08655c..2ac08cc740 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -29,6 +29,7 @@
 #include "tree.h"
 #include "promisor-remote.h"
 #include "refs.h"
+#include "remote.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -843,6 +844,51 @@ static int maintenance_task_commit_graph(struct maintenance_opts *opts)
 	return 1;
 }
 
+static int fetch_remote(const char *remote, struct maintenance_opts *opts)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
+		     "--no-write-fetch-head", "--recurse-submodules=no",
+		     "--refmap=", NULL);
+
+	if (opts->quiet)
+		strvec_push(&child.args, "--quiet");
+
+	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
+
+	return !!run_command(&child);
+}
+
+static int append_remote(struct remote *remote, void *cbdata)
+{
+	struct string_list *remotes = (struct string_list *)cbdata;
+
+	string_list_append(remotes, remote->name);
+	return 0;
+}
+
+static int maintenance_task_prefetch(struct maintenance_opts *opts)
+{
+	int result = 0;
+	struct string_list_item *item;
+	struct string_list remotes = STRING_LIST_INIT_DUP;
+
+	if (for_each_remote(append_remote, &remotes)) {
+		error(_("failed to fill remotes"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, &remotes)
+		result |= fetch_remote(item->string, opts);
+
+cleanup:
+	string_list_clear(&remotes, 0);
+	return result;
+}
+
 static int maintenance_task_gc(struct maintenance_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -880,6 +926,7 @@ struct maintenance_task {
 };
 
 enum maintenance_task_label {
+	TASK_PREFETCH,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -888,6 +935,10 @@ enum maintenance_task_label {
 };
 
 static struct maintenance_task tasks[] = {
+	[TASK_PREFETCH] = {
+		"prefetch",
+		maintenance_task_prefetch,
+	},
 	[TASK_GC] = {
 		"gc",
 		maintenance_task_gc,
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4f6a04ddb1..0bade09c43 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -60,4 +60,30 @@ test_expect_success 'run --task duplicate' '
 	test_i18ngrep "cannot be selected multiple times" err
 '
 
+test_expect_success 'run --task=prefetch with no remotes' '
+	git maintenance run --task=prefetch 2>err &&
+	test_must_be_empty err
+'
+
+test_expect_success 'prefetch multiple remotes' '
+	git clone . clone1 &&
+	git clone . clone2 &&
+	git remote add remote1 "file://$(pwd)/clone1" &&
+	git remote add remote2 "file://$(pwd)/clone2" &&
+	git -C clone1 switch -c one &&
+	git -C clone2 switch -c two &&
+	test_commit -C clone1 one &&
+	test_commit -C clone2 two &&
+	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch 2>/dev/null &&
+	fetchargs="--prune --no-tags --no-write-fetch-head --recurse-submodules=no --refmap= --quiet" &&
+	test_subcommand git fetch remote1 $fetchargs +refs/heads/\\*:refs/prefetch/remote1/\\* <run-prefetch.txt &&
+	test_subcommand git fetch remote2 $fetchargs +refs/heads/\\*:refs/prefetch/remote2/\\* <run-prefetch.txt &&
+	test_path_is_missing .git/refs/remotes &&
+	git log prefetch/remote1/one &&
+	git log prefetch/remote2/two &&
+	git fetch --all &&
+	test_cmp_rev refs/remotes/remote1/one refs/prefetch/remote1/one &&
+	test_cmp_rev refs/remotes/remote2/two refs/prefetch/remote2/two
+'
+
 test_done
-- 
gitgitgadget

