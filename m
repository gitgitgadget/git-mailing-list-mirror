Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9594DC433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA6F2083B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfanJcO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgG3WYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgG3WYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD9C061756
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so26304515wra.5
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PinCAdMsqIP+MXB5Nud7V9IOva8JaEQYH5qk7nJu2nA=;
        b=VfanJcO2rCMWBUEKfTyCvfKlmmaZeexD0aX9KlDq8lCjecp3q6U6rcSftqD9byfCqx
         Dcf7Z3AIsw5edxfLN1txY8FKPwnqd4urMsLUXMKpanHGlVWIC9yCrN5Mi/jWKE03aGNl
         iILJYwS1q9z51Zl4xMaTh3CD2gt3CDmxR2q7/2Bx77pek/YrfUQj/6QJtN5RhoYaEdXb
         KguNYdYowEpQppyYbI3Oml5R8cx6Ih3xtoh5Fzg8iqcacvWejLWzlssxXwky3erOzTed
         pwaMvz62+YzayeJaVx2ehJAjZjs6SO+yo2IMxuie7m6RDuYORatA404AFeSh1GTD62xK
         /gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PinCAdMsqIP+MXB5Nud7V9IOva8JaEQYH5qk7nJu2nA=;
        b=ugYSELVmnXxabu0zzjS9CLLoVU1b0eTECJ2FmwT2QjWVDLApD+Wcr7UrxwuOwci/Nz
         UlTgFrJzK+yXrvZjVcWBTq96qiwrIkNQiZgcjfKBudFxm5TpyKzcFrUMRnvxdd7Trcr8
         ISDIQP42PtT/f9C2gLVBj3mFNd7PeSeMTu/1ayAR2sR47w6iiUoXloJGQerTFc+T8jjH
         k5SAl9lO6oOI+jprL1OL1TDgVTvQ1J7BD5Rks3ev7DdB71hf9pMcJqWEkzlm5bWBYvej
         fJlmfyON+rofioDCNKpF1ft9M0xgK0orn/aThVUG/kZagLmovXnhxlUUiyUKD2hTY0ot
         hfOA==
X-Gm-Message-State: AOAM5300e2kLuzB0dzbhTDe7Yh4k2cJMpPu8abN/q6SEPO6Jv9UPiauF
        Jx2phH5kLitwK/XBHo0aqsGfXZBA
X-Google-Smtp-Source: ABdhPJyMty2Q/8OrPJXjRcJtDsgUCEfCUyUBKEEZZ7d3/GKYpzh9wunss50khUCPsFkRmdFp5BpzrQ==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr739700wrp.114.1596147886324;
        Thu, 30 Jul 2020 15:24:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d21sm1740137wmd.41.2020.07.30.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:45 -0700 (PDT)
Message-Id: <9e38ade15c3a3eeec58dc262f1835d344c4899c0.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:15 +0000
Subject: [PATCH v3 09/20] maintenance: add prefetch task
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
 builtin/gc.c                      | 52 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 24 ++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 9204762e21..d134192fa8 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -53,6 +53,21 @@ since it will not expire `.graph` files that were in the previous
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
 	Cleanup unnecessary files and optimize the local repository. "GC"
 	stands for "garbage collection," but this task performs many
diff --git a/builtin/gc.c b/builtin/gc.c
index b57bc7b0ff..1f20428286 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,6 +28,7 @@
 #include "blob.h"
 #include "tree.h"
 #include "promisor-remote.h"
+#include "remote.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -769,6 +770,52 @@ static int maintenance_task_commit_graph(void)
 	return 1;
 }
 
+static int fetch_remote(const char *remote)
+{
+	struct child_process child = CHILD_PROCESS_INIT;
+
+	child.git_cmd = 1;
+	strvec_pushl(&child.args, "fetch", remote, "--prune", "--no-tags",
+		     "--no-write-fetch-head", "--refmap=", NULL);
+
+	strvec_pushf(&child.args, "+refs/heads/*:refs/prefetch/%s/*", remote);
+
+	if (opts.quiet)
+		strvec_push(&child.args, "--quiet");
+
+	return !!run_command(&child);
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
+	for (item = remotes.items;
+	     item && item < remotes.items + remotes.nr;
+	     item++)
+		result |= fetch_remote(item->string);
+
+cleanup:
+	string_list_clear(&remotes, 0);
+	return result;
+}
+
 static int maintenance_task_gc(void)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -796,6 +843,7 @@ struct maintenance_task {
 };
 
 enum maintenance_task_label {
+	TASK_PREFETCH,
 	TASK_GC,
 	TASK_COMMIT_GRAPH,
 
@@ -804,6 +852,10 @@ enum maintenance_task_label {
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
index 3cdccb24df..5294396a24 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -43,4 +43,28 @@ test_expect_success 'run --task duplicate' '
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

