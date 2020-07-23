Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BFBC433F7
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA59206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpnEjeDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgGWR44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgGWR4w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823FC0619E3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j18so5741070wmi.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J5JAIL788qaocK3RQu2EiuORUvNYhdMI8XoJUFNK7zk=;
        b=YpnEjeDnXjteJlsuMNVoCxWc8aQppcTn+8q4QuQh9L7iV765wLQqgfBLmTrREpE75L
         T3mgZuPtu852+kMy+t9IwiAxnGeH4VSEz2bc+8Gw1fBr1m9MYc7w0z+vjqS5zGjpFeQk
         HUPeOTChIfrzwYjfQsRYl7XwjKV5TxSWxka2LMeIy5sTg7xU+NXyakdBWVxgiCInbFNX
         0C8WUw0YLpXMyVsd91j0ZwyI0K1GzwPUesdc7Kwn0vYC3jBW13V3YAp0Rs2EOb1lNkMa
         Mizkqh8SzlTbbuiGZnPyQf6/b9+xeROKZUg6C6szxRjrbQseJc34brl0OKrDBzD6AxVt
         6VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J5JAIL788qaocK3RQu2EiuORUvNYhdMI8XoJUFNK7zk=;
        b=V1S5Y7bs5vzdfc8rLnz5n55r2y7UKECqLX/Yhh0Oe0rdo+jLNgRPXGUgJindRz/vLb
         KqMHD0A54KNQXCe3C2FAfdwxm/MMxnug6V87ePjZWSltHcLV383iXb65Q46GtFPR3AdE
         k5nOJ7pfq9IEWPJpr8Ftu4zChSr7NVa4kJqlmJyPE67jWV6WQr+KQXL1RgfvoF7A7017
         HT9MvpuULHng/RYpLca+60LgAyDJiFAABjZ2iYCkyqtlbd2z/xt6i2S2anhro0OGWKIu
         mmkX9C06ZKeZjgKB5AaH2pM6S1OrE8RoIa1NyazOR2AlUvnlmjYbmSL2pyDwAs5l4yRF
         vU+Q==
X-Gm-Message-State: AOAM531Tpcip2PcrPFJcb/SUQjAgUMvLdO5p3kfGYXJ7TsZn31PhmTb/
        pM2GJPBq822jZ9AiOOnuzEAlBUXC
X-Google-Smtp-Source: ABdhPJykQfwHA+ziEtB0gm1u1Sk8u4XAsEyQljX7Y2tQc1NEMk3agvi6hlvMiafA73HnJHqwCWw80w==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr5148107wmg.74.1595527009809;
        Thu, 23 Jul 2020 10:56:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i66sm990336wma.35.2020.07.23.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:49 -0700 (PDT)
Message-Id: <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:30 +0000
Subject: [PATCH v2 08/18] maintenance: add prefetch task
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
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

3. By adding a new refspec "+refs/heads/*:refs/prefetch/<remote>/*"
   we can ensure that we actually load the new values somewhere in
   our refspace while not updating refs/heads or refs/remotes. By
   storing these refs here, the commit-graph job will update the
   commit-graph with the commits from these hidden refs.

4. --prune will delete the refs/prefetch/<remote> refs that no
   longer appear on the remote.

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
 Documentation/git-maintenance.txt | 12 ++++++
 builtin/gc.c                      | 64 ++++++++++++++++++++++++++++++-
 t/t7900-maintenance.sh            | 24 ++++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9204762e21..0927643247 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -53,6 +53,18 @@ since it will not expire `.graph` files that were in the previous
 `commit-graph-chain` file. They will be deleted by a later run based on
 the expiration delay.
 
+prefetch::
+	The `fetch` task updates the object directory with the latest objects
+	from all registered remotes. For each remote, a `git fetch` command
+	is run. The refmap is custom to avoid updating local or remote
+	branches (those in `refs/heads` or `refs/remotes`). Instead, the
+	remote refs are stored in `refs/prefetch/<remote>/`. Also, tags are
+	not updated.
++
+This means that foreground fetches are still required to update the
+remote refs, but the users is notified when the branches and tags are
+updated on the remote.
+
 gc::
 	Cleanup unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
diff --git a/builtin/gc.c b/builtin/gc.c
index 5d99b4b805..969c127877 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,6 +28,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
+#include "remote.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -700,7 +701,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define MAX_NUM_TASKS 2
+#define MAX_NUM_TASKS 3
 
 static const char * const builtin_maintenance_usage[] = {
 	N_("git maintenance run [<options>]"),
@@ -781,6 +782,63 @@ static int maintenance_task_commit_graph(void)
 	return 1;
 }
 
+static int fetch_remote(const char *remote)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct strbuf refmap = STRBUF_INIT;
+
+	argv_array_pushl(&cmd, "fetch", remote, "--prune",
+			 "--no-tags", "--refmap=", NULL);
+
+	strbuf_addf(&refmap, "+refs/heads/*:refs/prefetch/%s/*", remote);
+	argv_array_push(&cmd, refmap.buf);
+
+	if (opts.quiet)
+		argv_array_push(&cmd, "--quiet");
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+
+	strbuf_release(&refmap);
+	return result;
+}
+
+static int fill_each_remote(struct remote *remote, void *cbdata)
+{
+	struct string_list *remotes = (struct string_list *)cbdata;
+
+	string_list_append(remotes, remote->name);
+	return 0;
+}
+
+static int maintenance_task_prefetch(void)
+{
+	int result = 0;
+	struct string_list_item *item;
+	struct string_list remotes = STRING_LIST_INIT_DUP;
+
+	if (for_each_remote(fill_each_remote, &remotes)) {
+		error(_("failed to fill remotes"));
+		result = 1;
+		goto cleanup;
+	}
+
+	/*
+	 * Do not modify the result based on the success of the 'fetch'
+	 * operation, as a loss of network could cause 'fetch' to fail
+	 * quickly. We do not want that to stop the rest of our
+	 * background operations.
+	 */
+	for (item = remotes.items;
+	     item && item < remotes.items + remotes.nr;
+	     item++)
+		fetch_remote(item->string);
+
+cleanup:
+	string_list_clear(&remotes, 0);
+	return result;
+}
+
 static int maintenance_task_gc(void)
 {
 	int result;
@@ -871,6 +929,10 @@ static void initialize_tasks(void)
 	for (i = 0; i < MAX_NUM_TASKS; i++)
 		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
 
+	tasks[num_tasks]->name = "prefetch";
+	tasks[num_tasks]->fn = maintenance_task_prefetch;
+	num_tasks++;
+
 	tasks[num_tasks]->name = "gc";
 	tasks[num_tasks]->fn = maintenance_task_gc;
 	tasks[num_tasks]->enabled = 1;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c09a9eb90b..8b04a04c79 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -44,4 +44,28 @@ test_expect_success 'run --task duplicate' '
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
+	GIT_TRACE2_EVENT="$(pwd)/run-prefetch.txt" git maintenance run --task=prefetch &&
+	grep ",\"fetch\",\"remote1\"" run-prefetch.txt &&
+	grep ",\"fetch\",\"remote2\"" run-prefetch.txt &&
+	test_path_is_missing .git/refs/remotes &&
+	test_cmp clone1/.git/refs/heads/one .git/refs/prefetch/remote1/one &&
+	test_cmp clone2/.git/refs/heads/two .git/refs/prefetch/remote2/two &&
+	git log prefetch/remote1/one &&
+	git log prefetch/remote2/two
+'
+
 test_done
-- 
gitgitgadget

