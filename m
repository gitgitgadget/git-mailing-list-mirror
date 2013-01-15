From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH v2 17/19] reset $sha1 $pathspec: require $sha1 only to be treeish
Date: Mon, 14 Jan 2013 21:47:49 -0800
Message-ID: <1358228871-7142-18-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 06:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuzOQ-0007EL-3e
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 06:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab3AOFse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 00:48:34 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:51953 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755747Ab3AOFs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 00:48:28 -0500
Received: by mail-qa0-f73.google.com with SMTP id a19so345050qad.4
        for <git@vger.kernel.org>; Mon, 14 Jan 2013 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=uOlhHjVTH+AVcPas0rC139fUsLZxGfQS98W6iMVcWTg=;
        b=j6VGvPQ77zgrJDbAgYH7ztU384IpGkjfo8xoTn5+VnOag0moizPzyU6oZ5aszIRajj
         dWB6TULXZH8mGY6mE23fU8uegbLK5jrA7Ww17kuB0BSrpc6+XjwTdOsf4paBjEzlESFv
         dNIHpcT7Qn2ZAwtlNKqLs10e5550JSCC2rmI4AzHdcQfORfMP9uyjm1a5HPfYSwmevII
         jaXR0IyWw8qEX8AMDxAkXoQxkKqsOtZfCmlIl1vyUazSfOno+cHsayGEcRTr+Mc2mfAq
         a1VILcndoWTuHghqZ+4QYbdpcBDrb4qzm0qweVFA8Z/O6pF0Pc4k+YNoXImDwDbduMKC
         24QQ==
X-Received: by 10.236.145.129 with SMTP id p1mr10787804yhj.41.1358228907177;
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id i27si818307yhe.4.2013.01.14.21.48.27
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Mon, 14 Jan 2013 21:48:27 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id F2D5082004A;
	Mon, 14 Jan 2013 21:48:26 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id CB7401011EA; Mon, 14 Jan 2013 21:48:26 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.454.gce43f05
In-Reply-To: <1358228871-7142-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQm0upH2dBPDCZMRXmF/UdYYdw/6yF/6M9/ry1Dz4y3LoI4DnE59ujaAV6khr8reTnFcB8EtTkP/L+UsZToBw9ilDY1QhtrCnYiYP9493LXwd8PcWhsfbrbWqhnw4xEsu+EK06xdLtzL2o1k+eeoPf6uFTd22vFSe+OCSmCVCu9kKouwZ4w/4z1Agpn67lm5EMLS0Aza
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213578>

Resetting with paths does not update HEAD and there is nothing else
that a commit should be needed for. Relax the argument parsing so only
a tree is required.

The sha1 is only passed to read_from_tree(), which already only
requires a tree.

The "rev" variable we pass to run_add_interactive() will resolve to a
tree. This is fine since interactive_reset only needs the parameter to
be a treeish and doesn't use it for display purposes.

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
---
 builtin/reset.c  | 48 +++++++++++++++++++++++++++---------------------
 t/t7102-reset.sh |  8 ++++++++
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 520c1a5..b776867 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -178,9 +178,10 @@ static const char **parse_args(const char **argv, const char *prefix, const char
 	/*
 	 * Possible arguments are:
 	 *
-	 * git reset [-opts] <rev> <paths>...
-	 * git reset [-opts] <rev> -- <paths>...
-	 * git reset [-opts] -- <paths>...
+	 * git reset [-opts] [<rev>]
+	 * git reset [-opts] <tree> [<paths>...]
+	 * git reset [-opts] <tree> -- [<paths>...]
+	 * git reset [-opts] -- [<paths>...]
 	 * git reset [-opts] <paths>...
 	 *
 	 * At this point, argv points immediately after [-opts].
@@ -195,11 +196,13 @@ static const char **parse_args(const char **argv, const char *prefix, const char
 		}
 		/*
 		 * Otherwise, argv[0] could be either <rev> or <paths> and
-		 * has to be unambiguous.
+		 * has to be unambiguous. If there is a single argument, it
+		 * can not be a tree
 		 */
-		else if (!get_sha1_committish(argv[0], unused)) {
+		else if ((!argv[1] && !get_sha1_committish(argv[0], unused)) ||
+			 (argv[1] && !get_sha1_treeish(argv[0], unused))) {
 			/*
-			 * Ok, argv[0] looks like a rev; it should not
+			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
 			verify_non_filename(prefix, argv[0]);
@@ -241,7 +244,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	const char *rev;
 	unsigned char sha1[20];
 	const char **pathspec = NULL;
-	struct commit *commit;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -263,19 +265,23 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 						PARSE_OPT_KEEP_DASHDASH);
 	pathspec = parse_args(argv, prefix, &rev);
 
-	if (get_sha1_committish(rev, sha1))
-		die(_("Failed to resolve '%s' as a valid ref."), rev);
-
-	/*
-	 * NOTE: As "git reset $treeish -- $path" should be usable on
-	 * any tree-ish, this is not strictly correct. We are not
-	 * moving the HEAD to any commit; we are merely resetting the
-	 * entries in the index to that of a treeish.
-	 */
-	commit = lookup_commit_reference(sha1);
-	if (!commit)
-		die(_("Could not parse object '%s'."), rev);
-	hashcpy(sha1, commit->object.sha1);
+	if (!pathspec) {
+		struct commit *commit;
+		if (get_sha1_committish(rev, sha1))
+			die(_("Failed to resolve '%s' as a valid revision."), rev);
+		commit = lookup_commit_reference(sha1);
+		if (!commit)
+			die(_("Could not parse object '%s'."), rev);
+		hashcpy(sha1, commit->object.sha1);
+	} else {
+		struct tree *tree;
+		if (get_sha1_treeish(rev, sha1))
+			die(_("Failed to resolve '%s' as a valid tree."), rev);
+		tree = parse_tree_indirect(sha1);
+		if (!tree)
+			die(_("Could not parse object '%s'."), rev);
+		hashcpy(sha1, tree->object.sha1);
+	}
 
 	if (patch_mode) {
 		if (reset_type != NONE)
@@ -340,7 +346,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		update_ref_status = update_refs(rev, sha1);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
-			print_new_head_line(commit);
+			print_new_head_line(lookup_commit_reference(sha1));
 
 		remove_branch_state();
 	}
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 81b2570..1fa2a5f 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -497,4 +497,12 @@ test_expect_success 'disambiguation (4)' '
 	test ! -f secondfile
 '
 
+test_expect_success 'reset with paths accepts tree' '
+	# for simpler tests, drop last commit containing added files
+	git reset --hard HEAD^ &&
+	git reset HEAD^^{tree} -- . &&
+	git diff --cached HEAD^ --exit-code &&
+	git diff HEAD --exit-code
+'
+
 test_done
-- 
1.8.1.1.454.gce43f05
