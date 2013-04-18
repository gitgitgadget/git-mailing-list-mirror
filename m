From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git add <pathspec>... defaults to "-A"
Date: Wed, 17 Apr 2013 18:47:08 -0700
Message-ID: <7v1ua8d2zn.fsf_-_@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 03:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USdwU-0004JB-0P
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 03:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901Ab3DRBrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 21:47:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935698Ab3DRBrM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 21:47:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B3DF08B;
	Thu, 18 Apr 2013 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P5nvR7WoffbfcdUe4IWdcCh7+D8=; b=qx417R
	j1fJEo4KMnjtF/B5xZVFv0cT3+yLY7YHaSj+fUtu9jHTS38Fe4fRDGF5tm4kysbM
	X2hjz78LibwloRNh3xLuoPnc0CkZD4MdqlyzTP25311td+qy/FFvpKd3mbsr8g1b
	V6Oifp/izkrTNnMMN4mqeQeG8qU6gbI7NOHCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ecn474l5NXpwboXCzEWpKhWwtW7l0OP9
	FqHq/p9rZsLfDz45pHvCCRCcIgf69yFpawGoGSm7Twh9kl9Vxq0todeLPaByKtU2
	6ujy99SIS3AQ1Dutbe1QLtT31BtNn8GiEqSpAQ4ezZ3k3M0EWFU/JD40BBudZLlu
	Bza1thmLQho=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BF74F087;
	Thu, 18 Apr 2013 01:47:11 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D0BDF086;
	Thu, 18 Apr 2013 01:47:09 +0000 (UTC)
In-Reply-To: <7va9owd3d1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Apr 2013 18:39:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E23FE4E4-A7C9-11E2-B0BB-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221599>

Make "git add <pathspec>..." notice paths that have been removed
from the working tree, i.e. a synonym to "git add -A <pathspec>...".

Given that "git add <pathspec>" is to update the index with the
state of the named part of the working tree as a whole, it makes it
more intuitive, and also makes it possible to simplify the advice we
give while marking the paths the user finished resolving conflicts
with.  We used to say "to record removal as a resolution, remove the
path from the working tree and say 'git rm'; for all other cases,
edit the path in the working tree and say 'git add'", but we can now
say "update the path in the working tree and say 'git add'" instead.

As promised, this merges the temporary update_files_in_cache() helper
function back to add_files_to_cache() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So this comes on top of the previous update that will sit at
   jc/add-2.0-delete-default~1 and replaces the one previouly at its
   tip.

 Documentation/git-add.txt | 18 +++++++++------
 builtin/add.c             | 57 ++++++++---------------------------------------
 2 files changed, 20 insertions(+), 55 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 5c501a2..5bd0791 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -53,8 +53,14 @@ OPTIONS
 	Files to add content from.  Fileglobs (e.g. `*.c`) can
 	be given to add all matching files.  Also a
 	leading directory name (e.g. `dir` to add `dir/file1`
-	and `dir/file2`) can be given to add all files in the
-	directory, recursively.
+	and `dir/file2`) can be given to update the index to
+	match the current state of the directory as a whole (e.g.
+	specifying `dir` will record not just a file `dir/file1`
+	modified in the working tree, a file `dir/file2` added to
+	the working tree, but also a file `dir/file3` removed from
+	the working tree.  Note that older versions of 	Git used
+	to ignore removed files; use `--no-all` option if you want
+	to add modified or new files but ignore removed	ones.
 
 -n::
 --dry-run::
@@ -127,11 +133,9 @@ of Git, hence the form without <pathspec> should not be used.
 	files that have been removed from the working tree.  This
 	option is a no-op when no <pathspec> is used.
 +
-This option is primarily to help the current users of Git, whose
-"git add <pathspec>..." ignores removed files.  In future versions
-of Git, "git add <pathspec>..." will be a synonym to "git add -A
-<pathspec>..." and "git add --no-all <pathspec>..." will behave like
-today's "git add <pathspec>...", ignoring removed files.
+This option is primarily to help users who are used to older
+versions of Git, whose "git add <pathspec>..." was a synonym
+to "git add --no-all <pathspec>...", i.e. ignored removed files.
 
 -N::
 --intent-to-add::
diff --git a/builtin/add.c b/builtin/add.c
index 4242bce..21c685f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -26,9 +26,6 @@ static int take_worktree_changes;
 struct update_callback_data {
 	int flags;
 	int add_errors;
-
-	/* only needed for 2.0 transition preparation */
-	int warn_add_would_remove;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -52,17 +49,6 @@ static int fix_unmerged_status(struct diff_filepair *p,
 		return DIFF_STATUS_MODIFIED;
 }
 
-static void warn_add_would_remove(const char *path)
-{
-	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
-		  "index for paths removed from the working tree that match\n"
-		  "the given pathspec. If you want to 'add' only changed\n"
-		  "or newly created paths, say 'git add --no-all <pathspec>...'"
-		  " instead.\n\n"
-		  "'%s' would be removed from the index without --no-all."),
-		path);
-}
-
 static void update_callback(struct diff_queue_struct *q,
 			    struct diff_options *opt, void *cbdata)
 {
@@ -84,10 +70,6 @@ static void update_callback(struct diff_queue_struct *q,
 			}
 			break;
 		case DIFF_STATUS_DELETED:
-			if (data->warn_add_would_remove) {
-				warn_add_would_remove(path);
-				data->warn_add_would_remove = 0;
-			}
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
 			if (!(data->flags & ADD_CACHE_PRETEND))
@@ -99,27 +81,20 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-static void update_files_in_cache(const char *prefix, const char **pathspec,
-				  struct update_callback_data *data)
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 {
+	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
 	init_pathspec(&rev.prune_data, pathspec);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
-	rev.diffopt.format_callback_data = data;
+	data.flags = flags;
+	data.add_errors = 0;
+	rev.diffopt.format_callback_data = &data;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-}
-
-int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
-{
-	struct update_callback_data data;
-
-	memset(&data, 0, sizeof(data));
-	data.flags = flags;
-	update_files_in_cache(prefix, pathspec, &data);
 	return !!data.add_errors;
 }
 
@@ -298,7 +273,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
 
-#define ADDREMOVE_DEFAULT 0 /* Change to 1 in Git 2.0 */
+#define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
 static int addremove_explicit = -1; /* unspecified */
 
@@ -391,7 +366,6 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	char *seen = NULL;
 	const char *option_with_implicit_dot = NULL;
 	const char *short_option_with_implicit_dot = NULL;
-	struct update_callback_data update_data;
 
 	git_config(add_config, NULL);
 
@@ -415,20 +389,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (addremove && take_worktree_changes)
 		die(_("-A and -u are mutually incompatible"));
 
-	/*
-	 * Warn when "git add pathspec..." was given without "-u" or "-A"
-	 * and pathspec... covers a removed path.
-	 */
-	memset(&update_data, 0, sizeof(update_data));
-	if (!take_worktree_changes && addremove_explicit < 0)
-		update_data.warn_add_would_remove = 1;
-
 	if (!take_worktree_changes && addremove_explicit < 0 && argc)
-		/*
-		 * Turn "git add pathspec..." to "git add -A pathspec..."
-		 * in Git 2.0 but not yet
-		 */
-		; /* addremove = 1; */
+		/* Turn "git add pathspec..." to "git add -A pathspec..." */
+		addremove = 1;
 
 	if (!show_only && ignore_missing)
 		die(_("Option --ignore-missing can only be used together with --dry-run"));
@@ -518,10 +481,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	plug_bulk_checkin();
 
-	update_data.flags = flags;
-	update_files_in_cache(prefix, pathspec, &update_data);
+	exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
-	exit_status |= !!update_data.add_errors;
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
 
-- 
1.8.2.1-552-g964983e
