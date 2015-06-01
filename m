From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 2/2] messages: uniform error messages for index write
Date: Mon,  1 Jun 2015 15:50:05 +0200
Message-ID: <0835711582b9db4ee067f2ea1fb767e0df13c4a0.1433166363.git.git@drmicha.warpmail.net>
References: <cover.1433166363.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 15:50:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzQ6e-0003N3-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 15:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbbFANuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 09:50:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45227 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752983AbbFANuN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 09:50:13 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 15B293808E0
	for <git@vger.kernel.org>; Mon,  1 Jun 2015 09:50:13 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 01 Jun 2015 09:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=doOlWHzr9uoJ4jj2nKQmHt1/P6E
	=; b=If7kgXWk8ResKn4uDGQIEVI/y+ZCA+24yxs+AWDur0FoPXTk3NcvMJ6hcRi
	ynMx4COvgCrKE/n5oqTgaNsCv7i21sHhwaraq4X/441MOKiGSdLEN/JucdxG+tiz
	FkMp0S/l5lwO1x2ZvWgLZxIWP7eFcDuw8mvTfT80PMdpRL3o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=doOl
	WHzr9uoJ4jj2nKQmHt1/P6E=; b=uVd+nkEumZY8gpH7QUjGA0x7ml9sXO7+vGEc
	BoCqlmKOottCPdPZrX7QYEZ47RlgFoxgdiswn1y5QM529SC92f1/hA6219wc0VIX
	ZEhSA8wtiLZm6FyQV3lXAXKAhEHBBI3rA/XAKBVYjfUlQvCtO+Gpc5gyTPhNwLyL
	fcCp6c4=
X-Sasl-enc: fPTL598/JazvBl4XyvyxqupHTVbqS1HeWfANWv0CKqFa 1433166611
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8C8546800FA;
	Mon,  1 Jun 2015 09:50:11 -0400 (EDT)
X-Mailer: git-send-email 2.4.2.548.g1e81565
In-Reply-To: <cover.1433166363.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270410>

Currently, we have different wordings for the same index write error
message, which may be confusing to users and increases the risk of
more severely different translated messages:

builtin/add.c:			die(_("Unable to write new index file"));
builtin/apply.c:			die(_("Unable to write new index file"));
builtin/checkout.c:		die(_("unable to write new index file"));
builtin/checkout-index.c:		die("Unable to write new index file");
builtin/clone.c:		die(_("unable to write new index file"));
builtin/commit.c:			die(_("unable to create temporary index"));
builtin/commit.c:				die(_("unable to update temporary index file"));
builtin/commit.c:				die(_("unable to write index file"));
builtin/commit.c:		die(_("unable to write new_index file"));
builtin/commit.c:			die(_("unable to write new_index file"));
builtin/commit.c:				die(_("unable to write new_index file"));
builtin/commit.c:		die(_("unable to write temporary index file"));
builtin/commit.c:		     "new_index file. Check that disk is not full and quota is\n"
builtin/merge.c:		return error(_("Unable to write index."));
builtin/mv.c:		die(_("Unable to write new index file"));
builtin/read-tree.c:		die("unable to write new index file");
builtin/rm.c:			die(_("Unable to write new index file"));
builtin/update-index.c:			die("Unable to write new index file");
merge.c:		die(_("unable to write new index file"));
merge-recursive.c:		return error(_("Unable to write index."));
pack-write.c:			die_errno("unable to create '%s'", index_name);
rerere.c:			die("Unable to write new index file");
sequencer.c:		die(_("%s: Unable to write new index file"), action_name(opts));
test-scrap-cache-tree.c:		die("unable to write index file");

Except for "checkout", "new index" always refers to the new state of the
index file, which is extra confusing. "checkout" does not talk about
"new work tree" (but "work tree") either. Therefore, word all of these
as "unable to write index file" (by possibly omitting "new" or "new_",
adjusting capitalization and punctuation, turning "create" into
"write"), except for:

* Leave "temporary" in place and add TRANSLATORS note.
  It may happen that the index file is writable but not the temporary
  one.

* Leave pack-write.c alone.
  It is low level without l10n.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I am actually a bit torn on the "temporary index" messages. On the one hand
we should hide technicalities from the user; on the other hand, we should give
helpful information for debugging.

Maybe "new index" and "temporary index" are really in the same camp? I would
omit "temporary" in that case, too.


 builtin/add.c            |  2 +-
 builtin/apply.c          |  2 +-
 builtin/checkout-index.c |  2 +-
 builtin/checkout.c       |  4 ++--
 builtin/clone.c          |  2 +-
 builtin/commit.c         | 15 +++++++++------
 builtin/merge.c          |  2 +-
 builtin/mv.c             |  2 +-
 builtin/read-tree.c      |  2 +-
 builtin/rm.c             |  2 +-
 builtin/update-index.c   |  2 +-
 merge-recursive.c        |  2 +-
 merge.c                  |  2 +-
 rerere.c                 |  2 +-
 sequencer.c              |  5 +++--
 15 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index df5135b..987dfdf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -445,7 +445,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 finish:
 	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+			die(_("unable to write index file"));
 	}
 
 	return exit_status;
diff --git a/builtin/apply.c b/builtin/apply.c
index 146be97..4143f92 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4672,7 +4672,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 
 	if (update_index) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+			die(_("unable to write index file"));
 	}
 
 	return !!errs;
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..7a68ac2 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -279,6 +279,6 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	if (0 <= newfd &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die("Unable to write new index file");
+		die("unable to write index file");
 	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b49f0e..e7c109e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -380,7 +380,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	}
 
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+		die(_("unable to write index file"));
 
 	read_ref_full("HEAD", 0, rev, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
@@ -591,7 +591,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		cache_tree_update(&the_index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
 
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+		die(_("unable to write index file"));
 
 	if (!opts->force && !opts->quiet)
 		show_local_changes(&new->commit->object, &opts->diff_options);
diff --git a/builtin/clone.c b/builtin/clone.c
index b878252..20c9a91 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -660,7 +660,7 @@ static int checkout(void)
 		die(_("unable to checkout working tree"));
 
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+		die(_("unable to write index file"));
 
 	err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
 			   sha1_to_hex(sha1), "1", NULL);
diff --git a/builtin/commit.c b/builtin/commit.c
index 04d49d5..b5b1158 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -341,7 +341,8 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		refresh_cache_or_die(refresh_flags);
 
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
-			die(_("unable to create temporary index"));
+			/* TRANSLATORS: match with "unable to write index file" */
+			die(_("unable to write temporary index file"));
 
 		old_index_env = getenv(INDEX_ENVIRONMENT);
 		setenv(INDEX_ENVIRONMENT, index_lock.filename.buf, 1);
@@ -360,7 +361,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
 			if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
-				die(_("unable to update temporary index"));
+				die(_("unable to write temporary index file"));
 		} else
 			warning(_("Failed to update main cache tree"));
 
@@ -386,7 +387,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
-			die(_("unable to write new_index file"));
+			die(_("unable to write index file"));
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename.buf;
 	}
@@ -411,7 +412,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (active_cache_changed) {
 			if (write_locked_index(&the_index, &index_lock,
 					       COMMIT_LOCK))
-				die(_("unable to write new_index file"));
+				die(_("unable to write index file"));
 		} else {
 			rollback_lock_file(&index_lock);
 		}
@@ -460,7 +461,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, CLOSE_LOCK))
-		die(_("unable to write new_index file"));
+		die(_("unable to write index file"));
 
 	hold_lock_file_for_update(&false_lock,
 				  git_path("next-index-%"PRIuMAX,
@@ -472,6 +473,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	refresh_cache(REFRESH_QUIET);
 
 	if (write_locked_index(&the_index, &false_lock, CLOSE_LOCK))
+		/* TRANSLATORS: match with "unable to write index file" */
 		die(_("unable to write temporary index file"));
 
 	discard_cache();
@@ -1783,8 +1785,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	unlink(git_path("SQUASH_MSG"));
 
 	if (commit_index_files())
+		/* TRANSLATORS: match with "unable to write index file" */
 		die (_("Repository has been updated, but unable to write\n"
-		     "new_index file. Check that disk is not full and quota is\n"
+		     "index file. Check that disk is not full and quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover."));
 
 	rerere(0);
diff --git a/builtin/merge.c b/builtin/merge.c
index 7e2541a..aa3d0c8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -642,7 +642,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
-		return error(_("Unable to write index."));
+		return error(_("unable to write index file"));
 	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
diff --git a/builtin/mv.c b/builtin/mv.c
index d1d4316..41e2018 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -276,7 +276,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die(_("Unable to write new index file"));
+		die(_("unable to write index file"));
 
 	return 0;
 }
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 43b47f7..b21d8f7 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -244,6 +244,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		prime_cache_tree(&the_index, trees[0]);
 
 	if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-		die("unable to write new index file");
+		die("unable to write index file");
 	return 0;
 }
diff --git a/builtin/rm.c b/builtin/rm.c
index 80b972f..c502832 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -427,7 +427,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+			die(_("unable to write index file"));
 	}
 
 	return 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..0c67dcd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1134,7 +1134,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			unable_to_lock_die(get_index_file(), lock_error);
 		}
 		if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-			die("Unable to write new index file");
+			die("unable to write index file");
 	}
 
 	rollback_lock_file(lock_file);
diff --git a/merge-recursive.c b/merge-recursive.c
index 44d85be..4e4dcf5 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2015,7 +2015,7 @@ int merge_recursive_generic(struct merge_options *o,
 			result);
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, lock, COMMIT_LOCK))
-		return error(_("Unable to write index."));
+		return error(_("unable to write index file"));
 
 	return clean ? 0 : 1;
 }
diff --git a/merge.c b/merge.c
index fcff632..0f7bde4 100644
--- a/merge.c
+++ b/merge.c
@@ -91,6 +91,6 @@ int checkout_fast_forward(const unsigned char *head,
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+		die(_("unable to write index file"));
 	return 0;
 }
diff --git a/rerere.c b/rerere.c
index 94aea9a..45ef340 100644
--- a/rerere.c
+++ b/rerere.c
@@ -491,7 +491,7 @@ static void update_paths(struct string_list *update)
 
 	if (active_cache_changed) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-			die("Unable to write new index file");
+			die("unable to write index file");
 	} else
 		rollback_lock_file(&index_lock);
 }
diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..2fb309d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -317,8 +317,9 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), action_name(opts));
+		/* TRANSLATORS: %s will be "revert" or "cherry-pick"
+ 		   match this with "unable to write index file" */
+		die(_("%s: unable to write index file"), action_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-- 
2.4.2.548.g1e81565
