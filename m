Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9RbJnHj"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83824D50
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 19:10:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DE64B1B5A24;
	Thu, 23 Nov 2023 22:10:43 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rDWu6otsQ9srZk7YXMR011nxSqASA3dIEjNMDQ
	HXbC4=; b=Y9RbJnHjnbVavcbxD2/zYgY3a5HJJJNb2w5F/0WJhdruuXcSy4FLHC
	oowGBOxYKdWbgG+f9bGr8p2PCf9OVAfhSweqmNaVn1ufwru2sc7uemoWA+gvsBxZ
	d/Ez2hiCT2oCy+GpYUlyFST4i2xmrRunAjVbaojh3oc4HK+B4WL/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D62441B5A22;
	Thu, 23 Nov 2023 22:10:43 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BD0F1B5A21;
	Thu, 23 Nov 2023 22:10:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] orphan/unborn: fix use of 'orphan' in end-user facing
 messages
In-Reply-To: <xmqqbkbj97a9.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	24 Nov 2023 12:09:18 +0900")
References: <xmqqbkbj97a9.fsf@gitster.g>
Date: Fri, 24 Nov 2023 12:10:42 +0900
Message-ID: <xmqq4jhb977x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0DDB7B4A-8A77-11EE-8410-25B3960A682E-77302942!pb-smtp2.pobox.com

"orphan branch" is not even grammatical ("orphaned branch" is), and
we have been using "unborn branch" to mean the state where the HEAD
points at a branch that does not yet exist.

Update end-user facing messages to correct them.  There are cases
other random words are used (e.g., "unparented branch") but now we
have a glossary entry, use the term "unborn branch" consistently.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c      | 2 +-
 builtin/worktree.c      | 6 +++---
 t/t2400-worktree-add.sh | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f53612f468..9d250587df 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1620,7 +1620,7 @@ static struct option *add_common_switch_branch_options(
 			parse_opt_tracking_mode),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unborn branch")),
 		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 10db70b7ec..f0853a9927 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -49,14 +49,14 @@
 	_("No possible source branch, inferring '--orphan'")
 
 #define WORKTREE_ADD_ORPHAN_WITH_DASH_B_HINT_TEXT \
-	_("If you meant to create a worktree containing a new orphan branch\n" \
+	_("If you meant to create a worktree containing a new unborn branch\n" \
 	"(branch with no commits) for this repository, you can do so\n" \
 	"using the --orphan flag:\n" \
 	"\n" \
 	"    git worktree add --orphan -b %s %s\n")
 
 #define WORKTREE_ADD_ORPHAN_NO_DASH_B_HINT_TEXT \
-	_("If you meant to create a worktree containing a new orphan branch\n" \
+	_("If you meant to create a worktree containing a new unborn branch\n" \
 	"(branch with no commits) for this repository, you can do so\n" \
 	"using the --orphan flag:\n" \
 	"\n" \
@@ -784,7 +784,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create a new branch")),
 		OPT_STRING('B', NULL, &new_branch_force, N_("branch"),
 			   N_("create or reset a branch")),
-		OPT_BOOL(0, "orphan", &opts.orphan, N_("create unborn/orphaned branch")),
+		OPT_BOOL(0, "orphan", &opts.orphan, N_("create unborn branch")),
 		OPT_BOOL('d', "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 051363acbb..3c12c3932b 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -414,7 +414,7 @@ test_wt_add_orphan_hint () {
 		git -C repo switch --orphan noref &&
 		test_must_fail git -C repo worktree add $opts foobar/ 2>actual &&
 		! grep "error: unknown switch" actual &&
-		grep "hint: If you meant to create a worktree containing a new orphan branch" actual &&
+		grep "hint: If you meant to create a worktree containing a new unborn branch" actual &&
 		if [ $use_branch -eq 1 ]
 		then
 			grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" actual
@@ -435,7 +435,7 @@ test_expect_success "'worktree add' doesn't show orphan hint in bad/orphan HEAD
 	(cd repo && test_commit commit) &&
 	test_must_fail git -C repo worktree add --quiet foobar_branch foobar/ 2>actual &&
 	! grep "error: unknown switch" actual &&
-	! grep "hint: If you meant to create a worktree containing a new orphan branch" actual
+	! grep "hint: If you meant to create a worktree containing a new unborn branch" actual
 '
 
 test_expect_success 'local clone from linked checkout' '
@@ -708,7 +708,7 @@ test_expect_success 'git worktree --no-guess-remote option overrides config' '
 test_dwim_orphan () {
 	local info_text="No possible source branch, inferring '--orphan'" &&
 	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
-	local orphan_hint="hint: If you meant to create a worktree containing a new orphan branch" &&
+	local orphan_hint="hint: If you meant to create a worktree containing a new unborn branch" &&
 	local invalid_ref_regex="^fatal: invalid reference: " &&
 	local bad_combo_regex="^fatal: '[-a-z]*' and '[-a-z]*' cannot be used together" &&
 
-- 
2.43.0

