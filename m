Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B6820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 23:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLKXtk (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 18:49:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39783 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLKXtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 18:49:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id n21so18584905qtl.6
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 15:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WnAGjh6B8DdIzUArnjsZYkwCB5rgZsX9uDkvzrM4f34=;
        b=WYqDTJG+KFWfpz4ILk+SO9zRfwEu9mW+gvaaHhjaZFiTcbXNL1HL+EI81Dz0ULFEQT
         A5tjYsdEegyASTn8VvtYLgfbvRJ2PniCP7YSndJ7z50g2m9cbi2fHHrwUVSLFS7OfofD
         InTYpApqAojv+dAc2LDJOAkdsx0gV/YNs+WkNQlDHanR6IPoek+a5KaZxKqMrg1gAePV
         tpIjREomE1KRmY9KTkmZ1EAea2Y0jhh5pcaGlPkKBUdoKuuPIfbHslWW63Ncb0oKtIoB
         HczqIrCt6yFxoJVIcRMJwUU73LgbJLm3E4GpjCHY6QeZ+o9AuIwUtrQ+VyEybZMYjPcY
         QAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=WnAGjh6B8DdIzUArnjsZYkwCB5rgZsX9uDkvzrM4f34=;
        b=g67znnuoHAwK/RuxMZLvX954clvKyG6symfQ0IO0dbiVYIMd63rpkRzUm+R74i5KZp
         4z7eaXt+1LsZDLZXRnKIqqLsm5vdTDV6Vhu7gVuy73S9qlP8qrI1GNcpHYIlCv9PaGqC
         iWJQLQ+qTwfeo2TKt2U3sL/J1E9X69+B2Wv5UesPGqZyPOBh6JgaftK1H/3O2snSvCOh
         m8laSfdRyrhvjqbHP8lJYYbwAxL1xQCLR3FcggAnX0Hmk5HJQJLb15QZEhHgJKziotOO
         qaQSunpk6QTaWoyzoScAkKO1OjXo6Y/w1wkWuBAeBBmpzc8u4f1rNoKO1YjTl43O74Ph
         nRZg==
X-Gm-Message-State: AA+aEWZScl8EvtBUQe+jKKpMj0G1lfter3vtd4BhX7BnT/M++cNeKaC5
        AC1Y0a8OefPHEHrux5Bcxdr9LK6U
X-Google-Smtp-Source: AFSGD/UTAYogyWPmf8kc47cKHHdtbxDKDwibzLQ8WVagI9TQQULKDYcvVKTMPWEzVceHwToxHRORYg==
X-Received: by 2002:ac8:1185:: with SMTP id d5mr18227572qtj.117.1544572178597;
        Tue, 11 Dec 2018 15:49:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:fd8f])
        by smtp.gmail.com with ESMTPSA id l73sm12435953qkl.16.2018.12.11.15.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:49:37 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     kernel-team@fb.com, Tejun Heo <htejun@fb.com>
Subject: [PATCH 4/5] githooks: Add post-cherry-pick and post-fetch hooks
Date:   Tue, 11 Dec 2018 15:49:08 -0800
Message-Id: <20181211234909.2855638-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org>
References: <20181211234909.2855638-1-tj@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tejun Heo <htejun@fb.com>

* post-cherry-pick: Called after a cherry-pick and given parameters so
  that it can tell which are the new cherry-picks.

* post-fetch: Called after a fetch.  Each updated ref and sha1 are fed
  on stdin.

These two hooks will be used to keep refs/notes/xref-cherry-picks
up-to-date.

Signed-off-by: Tejun Heo <htejun@fb.com>
---
 Documentation/git-cherry-pick.txt |  5 +++
 Documentation/git-fetch.txt       |  5 +++
 Documentation/githooks.txt        | 23 ++++++++++
 builtin/fetch.c                   | 72 ++++++++++++++++++++++++++++---
 builtin/revert.c                  | 14 ++++++
 5 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index d35d771fc..527cb9fea 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -224,6 +224,11 @@ the working tree.
 spending extra time to avoid mistakes based on incorrectly matching
 context lines.
 
+HOOKS
+-----
+This command can run `post-cherry-pick` hook. See linkgit:githooks[5]
+for more information.
+
 SEE ALSO
 --------
 linkgit:git-revert[1]
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e31993559..a04c6079a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -290,6 +290,11 @@ fetched, making it impossible to check out that submodule later without
 having to do a fetch again. This is expected to be fixed in a future Git
 version.
 
+HOOKS
+-----
+This command can run `post-fetch` hook. See linkgit:githooks[5]
+for more information.
+
 SEE ALSO
 --------
 linkgit:git-pull[1]
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 959044347..24c122343 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -149,6 +149,14 @@ invoked after a commit is made.
 This hook is meant primarily for notification, and cannot affect
 the outcome of `git commit`.
 
+post-cherry-pick
+~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-cherry-pick[1]. This hook is
+called with two parameters. The first is `<old sha1>` and the second
+`<new sha1>`, where `<old sha1>..<new sha1>` describes all new
+cherry-picked commits.
+
 pre-rebase
 ~~~~~~~~~~
 
@@ -191,6 +199,21 @@ save and restore any form of metadata associated with the working tree
 (e.g.: permissions/ownership, ACLS, etc).  See contrib/hooks/setgitperms.perl
 for an example of how to do this.
 
+post-fetch
+~~~~~~~~~~
+This hook is called by linkgit:git-fetch[1] and can be used to process
+newly fetched commits and tags.
+
+Information about what was fetched is provided on the hook's standard
+input with lines of the form:
+
+  <local ref> SP <old sha1> SP <remote ref> SP <new sha1> LF
+
+where `<local ref>` got updated from `<old sha1>` to `<new sha1>` as a
+result of fetching `<remote ref>`. If a branch or tag was created,
+`<old_sha1>` will be 40 `0`. If a tag was pruned, `<remote_ref>` will
+be `(delete)` and <new sha1> will be 40 `0`.
+
 pre-push
 ~~~~~~~~
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327a..eac792a33 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -66,6 +66,7 @@ static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static struct strbuf post_fetch_sb = STRBUF_INIT;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -510,10 +511,24 @@ static struct ref *get_ref_map(struct remote *remote,
 	return ref_map;
 }
 
+static void record_post_fetch(const char *name,
+			      const struct object_id *old_oid,
+			      const char *remote,
+			      const struct object_id *new_oid)
+{
+	char old_hex[GIT_MAX_HEXSZ + 1], new_hex[GIT_MAX_HEXSZ + 1];
+
+	oid_to_hex_r(old_hex, old_oid);
+	oid_to_hex_r(new_hex, new_oid);
+	strbuf_addf(&post_fetch_sb, "%s %s %s %s\n",
+		    name, old_hex, remote ?: "(delete)", new_hex);
+}
+
 #define STORE_REF_ERROR_OTHER 1
 #define STORE_REF_ERROR_DF_CONFLICT 2
 
 static int s_update_ref(const char *action,
+			const char *remote,
 			struct ref *ref,
 			int check_old)
 {
@@ -546,6 +561,7 @@ static int s_update_ref(const char *action,
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	free(msg);
+	record_post_fetch(ref->name, &ref->old_oid, remote, &ref->new_oid);
 	return 0;
 fail:
 	ref_transaction_free(transaction);
@@ -726,7 +742,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
 			int r;
-			r = s_update_ref("updating tag", ref, 0);
+			r = s_update_ref("updating tag", remote, ref, 0);
 			format_display(display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
@@ -766,7 +782,7 @@ static int update_local_ref(struct ref *ref,
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(&ref->new_oid);
-		r = s_update_ref(msg, ref, 0);
+		r = s_update_ref(msg, remote, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -782,7 +798,7 @@ static int update_local_ref(struct ref *ref,
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(&ref->new_oid);
-		r = s_update_ref("fast-forward", ref, 1);
+		r = s_update_ref("fast-forward", remote, ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -797,7 +813,7 @@ static int update_local_ref(struct ref *ref,
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(&ref->new_oid);
-		r = s_update_ref("forced-update", ref, 1);
+		r = s_update_ref("forced-update", remote, ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
@@ -1071,8 +1087,11 @@ static int prune_refs(struct refspec *rs, struct ref *ref_map,
 	if (!dry_run) {
 		struct string_list refnames = STRING_LIST_INIT_NODUP;
 
-		for (ref = stale_refs; ref; ref = ref->next)
+		for (ref = stale_refs; ref; ref = ref->next) {
 			string_list_append(&refnames, ref->name);
+			record_post_fetch(ref->name, &ref->old_oid,
+					  NULL, &null_oid);
+		}
 
 		result = delete_refs("fetch: prune", &refnames, 0);
 		string_list_clear(&refnames, 0);
@@ -1561,6 +1580,47 @@ static int fetch_one(struct remote *remote, int argc, const char **argv, int pru
 	return exit_code;
 }
 
+static int run_post_fetch_hook(void)
+{
+	int ret = 0, x;
+	struct child_process proc = CHILD_PROCESS_INIT;
+	const char *argv[2];
+
+	if (!(argv[0] = find_hook("post-fetch")))
+		return 0;
+	argv[1] = NULL;
+
+	proc.argv = argv;
+	proc.in = -1;
+
+	if (start_command(&proc)) {
+		finish_command(&proc);
+		return -1;
+	}
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (write_in_full(proc.in, post_fetch_sb.buf, post_fetch_sb.len) < 0) {
+		/* We do not mind if a hook does not read all refs. */
+		if (errno != EPIPE)
+			ret = -1;
+	}
+
+	strbuf_release(&post_fetch_sb);
+
+	x = close(proc.in);
+	if (!ret)
+		ret = x;
+
+	sigchain_pop(SIGPIPE);
+
+	x = finish_command(&proc);
+	if (!ret)
+		ret = x;
+
+	return ret;
+}
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -1669,6 +1729,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	close_all_packs(the_repository->objects);
 
+	run_post_fetch_hook();
+
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
 		argv_array_push(&argv_gc_auto, "--quiet");
diff --git a/builtin/revert.c b/builtin/revert.c
index c93393c89..0b7e578cc 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -8,6 +8,8 @@
 #include "dir.h"
 #include "sequencer.h"
 #include "branch.h"
+#include "refs.h"
+#include "run-command.h"
 
 /*
  * This implements the builtins revert and cherry-pick.
@@ -223,12 +225,24 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
+	struct object_id old_oid, new_oid;
+	char old_hex[GIT_MAX_HEXSZ + 1], new_hex[GIT_MAX_HEXSZ + 1];
 	int res;
 
+	if (read_ref("HEAD", &old_oid))
+		die(_("failed to read HEAD, cherry-pick failed"));
+
 	opts.action = REPLAY_PICK;
 	sequencer_init_config(&opts);
 	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
+
+	if (read_ref("HEAD", &new_oid))
+		die(_("failed to read HEAD after cherry-pick"));
+
+	oid_to_hex_r(old_hex, &old_oid);
+	oid_to_hex_r(new_hex, &new_oid);
+	run_hook_le(0, "post-cherry-pick", old_hex, new_hex, NULL);
 	return res;
 }
-- 
2.17.1

