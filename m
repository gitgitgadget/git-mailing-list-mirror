Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F591F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 11:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfJVLsW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 07:48:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36870 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfJVLsV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 07:48:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcsXp106002;
        Tue, 22 Oct 2019 11:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=KYzS++9lAA+38b2bQnAmAV7JCso+dWX+ChClkasrb6E=;
 b=LKpVDv5Da2NIGsk5HnavwmdjIle+7mbznXaBmsu0DC8OQpgLP5J3dobtHLZvJpKQhOLG
 rddhf6d74Ei1agjGfNnwO/myYQ7uY6UktZoDj3qD/R58lr1zQYJ0A4MeSCtur/gBStyM
 zDKH8sofQJh0DY60wCMta990Hb0wgCWRvNIrGinVKWmhptNBZV4yiTj24Fv55FA6YPq+
 vS9SPWKMPQDoJFzOfn14E2A2vYgzPIMO2BJR4CIRFiMTe5gwoKZJ/XjaYw7rS3pm6a7f
 49fm4kUAtp2G78LdUktitE0AmgCI28j2x3qPmMz0ZS5BYFuZhSJSTFHwfvokAEF7dJns yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswte57s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Oct 2019 11:48:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9MBcBrX092757;
        Tue, 22 Oct 2019 11:48:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2vsx22jnq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:48:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9MBm0hU115832;
        Tue, 22 Oct 2019 11:48:05 GMT
Received: from t460.home (dhcp-10-175-28-77.vpn.oracle.com [10.175.28.77])
        by aserp3030.oracle.com with ESMTP id 2vsx22jmx3-4;
        Tue, 22 Oct 2019 11:48:05 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Paul Tan <pyokagan@gmail.com>
Subject: [RFC PATCH v2 3/3] am: add --exact
Date:   Tue, 22 Oct 2019 13:45:18 +0200
Message-Id: <20191022114518.32055-4-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.24.0.rc0.3.g4ba423c3c2
In-Reply-To: <20191022114518.32055-1-vegard.nossum@oracle.com>
References: <20191022114518.32055-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9417 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910220107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This uses exact metadata when creating the commit object, hopefully
reconstructing the commit with the exact same SHA1.

Note: In order to be forwards compatible with new commit formats we
may want a new helper for creating a commit with the exact metadata
that is present (and then validating the result) as opposed to trying
to parse the metadata and pass it piecewise to commit_tree().

Previous-version: 3120370db888889f32e07a082edb4722db8feef1
Cc: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/git-am.txt |   9 +++-
 builtin/am.c             | 111 +++++++++++++++++++++++++++++++++++----
 t/t4150-am.sh            |  30 +++++++++++
 3 files changed, 138 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fc3b993c33..5b75596aaf 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
+'git am' [--[no-]exact] [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -31,6 +31,13 @@ OPTIONS
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
 
+-e::
+--[no-]exact::
+	Reconstruct the exact commit that the patch was generated from,
+	assuming the mail contains complete metadata (i.e. it was generated
+	using `git format-patch --complete`). This is only possible if all
+	the parent commits are available in the repository.
+
 -s::
 --signoff::
 	Add a `Signed-off-by:` line to the commit message, using
diff --git a/builtin/am.c b/builtin/am.c
index 4190383bba..c0fc27a2ae 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -118,6 +118,7 @@ struct am_state {
 	int allow_rerere_autoupdate;
 	const char *sign_commit;
 	int rebasing;
+	int exact;
 };
 
 /**
@@ -399,6 +400,9 @@ static void am_load(struct am_state *state)
 
 	state->rebasing = !!file_exists(am_path(state, "rebasing"));
 
+	read_state_file(&sb, state, "exact", 1);
+	state->exact = !strcmp(sb.buf, "t");
+
 	strbuf_release(&sb);
 }
 
@@ -1005,6 +1009,8 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	else
 		write_state_text(state, "applying", "");
 
+	write_state_bool(state, "exact", state->exact);
+
 	if (!get_oid("HEAD", &curr_head)) {
 		write_state_text(state, "abort-safety", oid_to_hex(&curr_head));
 		if (!state->rebasing)
@@ -1548,40 +1554,121 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
  */
 static void do_commit(const struct am_state *state)
 {
+	struct object_id meta_commit = {};
+	struct object_id meta_tree = {};
+
 	struct object_id tree, parent, commit;
 	const struct object_id *old_oid;
 	struct commit_list *parents = NULL;
-	const char *reflog_msg, *author;
+	const char *reflog_msg, *author = NULL;
 	struct strbuf sb = STRBUF_INIT;
 
+	if (state->exact) {
+		/*
+		 * Scan meta file for parents + other data.
+		 *
+		 * TODO: Pass everything after the "commit ..." line
+		 * verbatim to the commit for forwards compatibility
+		 * (e.g. so we don't need to know about every type of
+		 * commit attribute that may appear in the future).
+		 */
+
+		struct strbuf line = STRBUF_INIT;
+		FILE *fp = xfopen(am_path(state, "meta"), "r");
+
+		while (!strbuf_getline_lf(&line, fp)) {
+			const char *rest;
+
+			if (skip_prefix(line.buf, "commit ", &rest)) {
+				if (get_oid_hex(rest, &meta_commit))
+					die("invalid exact metadata (commit)");
+			} else if (skip_prefix(line.buf, "tree ", &rest)) {
+				if (get_oid_hex(rest, &meta_tree))
+					die("invalid exact metadata (tree)");
+			} else if (skip_prefix(line.buf, "parent ", &rest)) {
+				if (get_oid_hex(rest, &parent))
+					die("invalid exact metadata (parent)");
+
+				commit_list_insert(lookup_commit(the_repository, &parent), &parents);
+			} else if (skip_prefix(line.buf, "author ", &rest)) {
+				author = strdup(rest);
+			} else if (skip_prefix(line.buf, "committer ", &rest)) {
+				char *name_copy;
+				char *email;
+				char *email_copy;
+				char *date;
+
+				email = strstr(rest, " <");
+				if (!email)
+					die("invalid exact metadata (committer name)");
+
+				name_copy = xstrndup(rest, email - rest);
+				email += 2;
+				setenv("GIT_COMMITTER_NAME", name_copy, 1);
+				free(name_copy);
+
+				date = strstr(email, "> ");
+				if (!date)
+					die("invalid exact metadata (committer email)");
+
+				email_copy = xstrndup(email, date - email);
+				date += 2;
+				setenv("GIT_COMMITTER_EMAIL", email_copy, 1);
+				free(email_copy);
+
+				setenv("GIT_COMMITTER_DATE", date, 1);
+			} else if (line.len == 0) {
+				break;
+			} else {
+				die("unknown exact metadata: %.*s", (int) line.len, line.buf);
+			}
+		}
+
+		fclose(fp);
+	}
+
 	if (run_hook_le(NULL, "pre-applypatch", NULL))
 		exit(1);
 
 	if (write_cache_as_tree(&tree, 0, NULL))
 		die(_("git write-tree failed to write a tree"));
 
+	if (state->exact && !oideq(&tree, &meta_tree))
+		die("tree mismatch");
+
 	if (!get_oid_commit("HEAD", &parent)) {
 		old_oid = &parent;
-		commit_list_insert(lookup_commit(the_repository, &parent),
-				   &parents);
+		if (!state->exact) {
+			commit_list_insert(lookup_commit(the_repository, &parent),
+					   &parents);
+		}
 	} else {
 		old_oid = NULL;
 		say(state, stderr, _("applying to an empty history"));
 	}
 
-	author = fmt_ident(state->author_name, state->author_email,
-		WANT_AUTHOR_IDENT,
-			state->ignore_date ? NULL : state->author_date,
-			IDENT_STRICT);
-
-	if (state->committer_date_is_author_date)
-		setenv("GIT_COMMITTER_DATE",
-			state->ignore_date ? "" : state->author_date, 1);
+	if (state->exact) {
+		/*
+		 * Already got author above.
+		 */
+	} else {
+		author = fmt_ident(state->author_name, state->author_email,
+			WANT_AUTHOR_IDENT,
+				state->ignore_date ? NULL : state->author_date,
+				IDENT_STRICT);
+
+		if (state->committer_date_is_author_date)
+			setenv("GIT_COMMITTER_DATE",
+				state->ignore_date ? "" : state->author_date, 1);
+	}
 
 	if (commit_tree(state->msg, state->msg_len, &tree, parents, &commit,
 			author, state->sign_commit))
 		die(_("failed to write commit object"));
 
+	if (state->exact && !oideq(&commit, &meta_commit))
+		die("sha1 mismatch");
+
 	reflog_msg = getenv("GIT_REFLOG_ACTION");
 	if (!reflog_msg)
 		reflog_msg = "am";
@@ -2182,6 +2269,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 			0, PARSE_OPT_NONEG),
 		OPT_BOOL('c', "scissors", &state.scissors,
 			N_("strip everything before a scissors line")),
+		OPT_BOOL('e', "exact", &state.exact,
+			N_("preserve exact metadata, including sha1")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &state.git_apply_opts, N_("action"),
 			N_("pass it through git-apply"),
 			0),
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 4f1e24ecbe..56a0804dcb 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -147,6 +147,7 @@ test_expect_success setup '
 		git diff-tree --no-commit-id -p second
 	} >patch1-hg.eml &&
 
+	git format-patch --stdout --complete first >patch1-complete &&
 
 	echo file >file &&
 	git add file &&
@@ -1061,6 +1062,35 @@ test_expect_success 'am --quit keeps HEAD where it is' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am --no-exact with metadata succeeds' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	git am --no-exact patch1-complete
+'
+
+test_expect_success 'am --exact without metadata fails' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	test_must_fail git am --exact patch1
+'
+
+test_expect_success 'am --exact with metadata preserves sha1' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	git am --exact patch1-complete &&
+	test_cmp_rev second HEAD
+'
+
+test_expect_success 'am --exact with metadata applied to the wrong tree fails' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout second &&
+	test_must_fail git am --exact patch1-complete
+'
+
 test_expect_success 'am and .gitattibutes' '
 	test_create_repo attributes &&
 	(
--
commit 429e6ce36ee1fb8e020c76756894bf7e196e7c4e
tree 69ec15522af90642ea38dc761510fd1fa82bdfb2
parent 53da20012e763a65071bfe0a42fbf4968d0e1e49
author Vegard Nossum <vegard.nossum@oracle.com> 1571186178 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571740256 +0200

-- 
2.24.0.rc0.3.g4ba423c3c2

