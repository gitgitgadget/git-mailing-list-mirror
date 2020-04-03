Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF7C2BA19
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FFF2076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuT9garj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDCUsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:23 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:32830 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDCUsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:20 -0400
Received: by mail-ed1-f52.google.com with SMTP id z65so10969672ede.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9peLSp9eidkNW6Ps5jRyg6pb74w88i+gJSsUo5tl+7M=;
        b=NuT9garjT70yaAfkrJi84nixyDqXoDTRxVUekObApbFB6pVlWgaCOZTt9euenq5ast
         TdZsCkpMIyaCJ+yqPj8ggmWzREWy5/0NaxYaaedhhlhL2N1e80ntefNV5TH7bt4SS6cm
         yzFEeRfZuehIamgXJkobQ67SCklnGFcSgffIaV1yISzT+y6CblMNHiD2Kk/CF1ZcXkkQ
         WvJU+fDXML27ZlMG0F+eOZsL2a4DYkeJOy2TleSH6aUGJrHBL6aijRswlLaAXmjDhoE1
         BMPvizDGmrQYsw/yDyTX+E8vwJvuNNSorVLOHV+7tRfLqjAcbph9qS/CG6SRqgSRL0YA
         64EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9peLSp9eidkNW6Ps5jRyg6pb74w88i+gJSsUo5tl+7M=;
        b=AP7PjfaZQF+IAXUN7pV+CJCHwA3IpkHC4NlBFRpXFIv4MNRWEgoFuwcv1nJ2ehvchl
         ozDjN3jHtcZeivis4qwHDbZiAknvWO1CwvRCXUuUzjjbwDe0ez5zVJ7ln/QBVIHVD51t
         6nvPcT8MKIPfyrLDQ4H4AuKBd05OG0mbgehVVZk8x/z8lIpgWuaPMYWq3r1Fg9sP0mnX
         cQcRaYptgW3OynjMfn1/d3lEmk7jK7FuZ0BeZE8oGA9w3PfG6PNqz7++VcyUz6IqggAY
         7P8p+nTSPUI+vzWcQlZTcTYCFbBxFAhbZ8x3qllsb8YZKV+bepCNqwZpbukl5RDQ/Llk
         3QWw==
X-Gm-Message-State: AGi0PuabxU9RymVCe1tvBu+M2xaYUDKnq1n7MDnLzoLF0/RfoajdoUkf
        J69IwHneM4twv4pRVudXrRLuaMyB
X-Google-Smtp-Source: APiQypIGrYUblnVRSuLq8fzSpul/1IZeAuMTSdVmZpGWVlOiQ5YU5a0fkNcb/Q03WNsKd/dgrLK/XQ==
X-Received: by 2002:a17:906:b204:: with SMTP id p4mr9931383ejz.188.1585946897841;
        Fri, 03 Apr 2020 13:48:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm1563064edi.11.2020.04.03.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:17 -0700 (PDT)
Message-Id: <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:02 +0000
Subject: [PATCH 03/15] run-job: implement fetch job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
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

3. By adding a new refspec "+refs/heads/*:refs/hidden/<remote>/*"
   we can ensure that we actually load the new values somewhere in
   our refspace while not updating refs/heads or refs/remotes. By
   storing these refs here, the commit-graph job will update the
   commit-graph with the commits from these hidden refs.

4. --prune will delete the refs/hidden/<remote> refs that no
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

RFC QUESTIONS:

1. One downside of the refs/hidden pattern is that 'git log' will
   decorate commits with twice as many refs if they appear at a
   remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
   there an easy way to exclude a refspace from decorations? Should
   we make refs/hidden/* a "special" refspace that is excluded from
   decorations?

2. This feature is designed for a desktop machine or equivalent
   that has a permanent wired network connection, and the machine
   stays on while the user is not present. For things like laptops
   with inconsistent WiFi connections (that may be metered) the
   feature can use the less stable connection more than the user
   wants. Of course, this feature is opt-in for Git, but in Scalar
   we have a "scalar pause" command [2] that pauses all maintenance
   for some amount of time. We should consider a similar mechanism
   for Git, but for the point of this series the user needs to set
   up the "background" part of these jobs manually.

[2] https://github.com/microsoft/scalar/blob/master/Scalar/CommandLine/PauseVerb.cs
[3] https://github.com/microsoft/scalar/blob/master/docs/advanced.md#controlling-background-maintenance

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-run-job.txt | 13 ++++-
 builtin/run-job.c             | 89 ++++++++++++++++++++++++++++++++++-
 t/t7900-run-job.sh            | 22 +++++++++
 3 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index 8bf2762d650..eb92e891915 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -9,7 +9,7 @@ git-run-job - Run a maintenance job. Intended for background operation.
 SYNOPSIS
 --------
 [verse]
-'git run-job commit-graph'
+'git run-job (commit-graph|fetch)'
 
 
 DESCRIPTION
@@ -47,6 +47,17 @@ since it will not expire `.graph` files that were in the previous
 `commit-graph-chain` file. They will be deleted by a later run based on
 the expiration delay.
 
+'fetch'::
+
+The `fetch` job updates the object directory with the latest objects
+from all registered remotes. For each remote, a `git fetch` command is
+run. The refmap is custom to avoid updating local or remote branches
+(those in `refs/heads` or `refs/remotes`). Instead, the remote refs are
+stored in `refs/hidden/<remote>/`. Also, no tags are updated.
++
+This means that foreground fetches are still required to update the
+remote refs, but the users is notified when the branches and tags are
+updated on the remote.
 
 GIT
 ---
diff --git a/builtin/run-job.c b/builtin/run-job.c
index dd7709952d3..e59056b2918 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -7,7 +7,7 @@
 #include "run-command.h"
 
 static char const * const builtin_run_job_usage[] = {
-	N_("git run-job commit-graph"),
+	N_("git run-job (commit-graph|fetch)"),
 	NULL
 };
 
@@ -60,6 +60,91 @@ static int run_commit_graph_job(void)
 	return 1;
 }
 
+static int fetch_remote(const char *remote)
+{
+	int result;
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	struct strbuf refmap = STRBUF_INIT;
+
+	argv_array_pushl(&cmd, "fetch", remote, "--quiet", "--prune",
+			 "--no-tags", "--refmap=", NULL);
+
+	strbuf_addf(&refmap, "+refs/heads/*:refs/hidden/%s/*", remote);
+	argv_array_push(&cmd, refmap.buf);
+
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+
+	strbuf_release(&refmap);
+	return result;
+}
+
+static int fill_remotes(struct string_list *remotes)
+{
+	int result = 0;
+	FILE *proc_out;
+	struct strbuf line = STRBUF_INIT;
+	struct child_process *remote_proc = xmalloc(sizeof(*remote_proc));
+
+	child_process_init(remote_proc);
+
+	argv_array_pushl(&remote_proc->args, "git", "remote", NULL);
+
+	remote_proc->out = -1;
+
+	if (start_command(remote_proc)) {
+		error(_("failed to start 'git remote' process"));
+		result = 1;
+		goto cleanup;
+	}
+
+	proc_out = xfdopen(remote_proc->out, "r");
+
+	/* if there is no line, leave the value as given */
+	while (!strbuf_getline(&line, proc_out))
+		string_list_append(remotes, line.buf);
+
+	strbuf_release(&line);
+
+	fclose(proc_out);
+
+	if (finish_command(remote_proc)) {
+		error(_("failed to finish 'git remote' process"));
+		result = 1;
+	}
+
+cleanup:
+	free(remote_proc);
+	return result;
+}
+
+static int run_fetch_job(void)
+{
+	int result = 0;
+	struct string_list_item *item;
+	struct string_list remotes = STRING_LIST_INIT_DUP;
+
+	if (fill_remotes(&remotes)) {
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
 int cmd_run_job(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_run_job_options[] = {
@@ -79,6 +164,8 @@ int cmd_run_job(int argc, const char **argv, const char *prefix)
 	if (argc > 0) {
 		if (!strcmp(argv[0], "commit-graph"))
 			return run_commit_graph_job();
+		if (!strcmp(argv[0], "fetch"))
+			return run_fetch_job();
 	}
 
 	usage_with_options(builtin_run_job_usage,
diff --git a/t/t7900-run-job.sh b/t/t7900-run-job.sh
index 18b9bd26b3a..d3faeba135b 100755
--- a/t/t7900-run-job.sh
+++ b/t/t7900-run-job.sh
@@ -44,4 +44,26 @@ test_expect_success 'commit-graph job' '
 	)
 '
 
+test_expect_success 'fetch job' '
+	git clone "file://$(pwd)/server" client &&
+
+	# Before fetching, build a client commit-graph
+	git -C client run-job commit-graph &&
+	chain=client/.git/objects/info/commit-graphs/commit-graph-chain &&
+	test_line_count = 1 $chain &&
+
+	git -C client branch -v --remotes >before-refs &&
+	test_commit -C server 24 &&
+
+	git -C client run-job fetch &&
+	git -C client branch -v --remotes >after-refs &&
+	test_cmp before-refs after-refs &&
+	test_cmp server/.git/refs/heads/master \
+		 client/.git/refs/hidden/origin/master &&
+
+	# the hidden ref should trigger a new layer in the commit-graph
+	git -C client run-job commit-graph &&
+	test_line_count = 2 $chain
+'
+
 test_done
-- 
gitgitgadget

