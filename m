Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628AD269
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DZ2pZXNc"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9CD8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:23:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AAE5137DD8;
	Tue, 31 Oct 2023 01:23:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=f3d7MPAdbY8rB80RoI6+w2OUP
	9yV3I1S/yTkd5FJmYw=; b=DZ2pZXNckhNh2evfZCBRvFy9NGSFrzNakjSeCvbW5
	+bwCVfHFo+W02oNf+vTMMt5zyI/5S7Wc7g/tbTL1ANf8gM8TOXbUqiwA+/wV1QKi
	5Gn3dh1MMlUp5R1kaHJ1x+cM8yd4bgHTjgGVAGQMvv0mCYtrOtylnF0U7pXfoVUG
	Lc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 949AF37DD7;
	Tue, 31 Oct 2023 01:23:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CCDD37DD6;
	Tue, 31 Oct 2023 01:23:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] tests: teach callers of test_i18ngrep to use test_grep
Date: Tue, 31 Oct 2023 14:23:30 +0900
Message-ID: <20231031052330.3762989-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-530-g692be87cbb
In-Reply-To: <20231031052330.3762989-1-gitster@pobox.com>
References: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
 <20231031052330.3762989-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A438AD42-77AD-11EE-9E88-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

They are equivalents and the former still exists, so as long as the
only change this commit makes are to rewrite test_i18ngrep to
test_grep, there won't be any new bug, even if there still are
callers of test_i18ngrep remaining in the tree, or when merged to
other topics that add new uses of test_i18ngrep.

This patch was produced more or less with

    git grep -l -e 'test_i18ngrep ' 't/t[0-9][0-9][0-9][0-9]-*.sh' |
    xargs perl -p -i -e 's/test_i18ngrep /test_grep /'

and a good way to sanity check the result yourself is to run the
above in a checkout of c4603c1c (test framework: further deprecate
test_i18ngrep, 2023-10-31) and compare the resulting working tree
contents with the result of applying this patch to the same commit.
You'll see that test_i18ngrep in a few t/lib-*.sh files corrected,
in addition to the manual reproduction.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-httpd.sh                               |   2 +-
 t/lib-submodule-update.sh                    |   2 +-
 t/t0001-init.sh                              |  16 +--
 t/t0002-gitfile.sh                           |   4 +-
 t/t0003-attributes.sh                        |   4 +-
 t/t0008-ignores.sh                           |   4 +-
 t/t0012-help.sh                              |  16 +--
 t/t0013-sha1dc.sh                            |   2 +-
 t/t0014-alias.sh                             |   8 +-
 t/t0021-conversion.sh                        |   6 +-
 t/t0028-working-tree-encoding.sh             |  32 ++---
 t/t0040-parse-options.sh                     |   4 +-
 t/t0041-usage.sh                             |  32 ++---
 t/t0061-run-command.sh                       |   6 +-
 t/t0070-fundamental.sh                       |   4 +-
 t/t0091-bugreport.sh                         |   2 +-
 t/t0300-credentials.sh                       |   2 +-
 t/t1060-object-corruption.sh                 |   2 +-
 t/t1091-sparse-checkout-builtin.sh           |  68 ++++-----
 t/t1092-sparse-checkout-compatibility.sh     |   6 +-
 t/t1300-config.sh                            |  44 +++---
 t/t1307-config-blob.sh                       |   2 +-
 t/t1308-config-set.sh                        |  10 +-
 t/t1309-early-config.sh                      |   2 +-
 t/t1310-config-default.sh                    |   4 +-
 t/t1400-update-ref.sh                        |  22 +--
 t/t1404-update-ref-errors.sh                 |   4 +-
 t/t1410-reflog.sh                            |   6 +-
 t/t1416-ref-transaction-hooks.sh             |   2 +-
 t/t1430-bad-ref-name.sh                      |  22 +--
 t/t1450-fsck.sh                              |  80 +++++------
 t/t1506-rev-parse-diagnosis.sh               |  34 ++---
 t/t1512-rev-parse-disambiguation.sh          |   6 +-
 t/t2004-checkout-cache-temp.sh               |   2 +-
 t/t2006-checkout-index-basic.sh              |  14 +-
 t/t2010-checkout-ambiguous.sh                |   4 +-
 t/t2018-checkout-branch.sh                   |   4 +-
 t/t2019-checkout-ambiguous-ref.sh            |   8 +-
 t/t2020-checkout-detach.sh                   |   8 +-
 t/t2024-checkout-dwim.sh                     |   8 +-
 t/t2025-checkout-no-overlay.sh               |   2 +-
 t/t2026-checkout-pathspec-file.sh            |   8 +-
 t/t2027-checkout-track.sh                    |   2 +-
 t/t2030-unresolve-info.sh                    |   2 +-
 t/t2072-restore-pathspec-file.sh             |   8 +-
 t/t2106-update-index-assume-unchanged.sh     |   2 +-
 t/t2107-update-index-basic.sh                |   4 +-
 t/t2203-add-intent.sh                        |   6 +-
 t/t2204-add-ignored.sh                       |   8 +-
 t/t2401-worktree-prune.sh                    |  10 +-
 t/t2402-worktree-list.sh                     |   6 +-
 t/t2403-worktree-move.sh                     |   2 +-
 t/t2406-worktree-repair.sh                   |  24 ++--
 t/t3004-ls-files-basic.sh                    |   4 +-
 t/t3007-ls-files-recurse-submodules.sh       |   4 +-
 t/t3200-branch.sh                            |  18 +--
 t/t3202-show-branch.sh                       |   2 +-
 t/t3206-range-diff.sh                        |  22 +--
 t/t3210-pack-refs.sh                         |   2 +-
 t/t3301-notes.sh                             |   4 +-
 t/t3310-notes-merge-manual-resolve.sh        |  16 +--
 t/t3320-notes-merge-worktrees.sh             |   4 +-
 t/t3321-notes-stripspace.sh                  |   2 +-
 t/t3400-rebase.sh                            |   6 +-
 t/t3402-rebase-merge.sh                      |   2 +-
 t/t3403-rebase-skip.sh                       |  30 ++--
 t/t3404-rebase-interactive.sh                |  38 ++---
 t/t3406-rebase-message.sh                    |  18 +--
 t/t3418-rebase-continue.sh                   |   6 +-
 t/t3431-rebase-fork-point.sh                 |   2 +-
 t/t3501-revert-cherry-pick.sh                |   6 +-
 t/t3507-cherry-pick-conflict.sh              |   8 +-
 t/t3510-cherry-pick-sequence.sh              |   6 +-
 t/t3600-rm.sh                                |   8 +-
 t/t3601-rm-pathspec-file.sh                  |   6 +-
 t/t3700-add.sh                               |   6 +-
 t/t3701-add-interactive.sh                   |   8 +-
 t/t3704-add-pathspec-file.sh                 |  12 +-
 t/t3900-i18n-commit.sh                       |   8 +-
 t/t3901-i18n-patch.sh                        |   2 +-
 t/t3903-stash.sh                             |  10 +-
 t/t3905-stash-include-untracked.sh           |   2 +-
 t/t3909-stash-pathspec-file.sh               |   6 +-
 t/t4001-diff-rename.sh                       |  34 ++---
 t/t4013-diff-various.sh                      |   2 +-
 t/t4014-format-patch.sh                      |  12 +-
 t/t4015-diff-whitespace.sh                   |  20 +--
 t/t4018-diff-funcname.sh                     |  14 +-
 t/t4031-diff-rewrite-binary.sh               |   2 +-
 t/t4047-diff-dirstat.sh                      |  22 +--
 t/t4053-diff-no-index.sh                     |   2 +-
 t/t4055-diff-context.sh                      |   4 +-
 t/t4068-diff-symmetric-merge-base.sh         |  28 ++--
 t/t4115-apply-symlink.sh                     |   2 +-
 t/t4120-apply-popt.sh                        |   4 +-
 t/t4122-apply-symlink-inside.sh              |  14 +-
 t/t4129-apply-samemode.sh                    |   4 +-
 t/t4133-apply-filenames.sh                   |   8 +-
 t/t4150-am.sh                                |   4 +-
 t/t4151-am-abort.sh                          |   2 +-
 t/t4153-am-resume-override-opts.sh           |   2 +-
 t/t4200-rerere.sh                            |   4 +-
 t/t4201-shortlog.sh                          |   2 +-
 t/t4202-log.sh                               |  18 +--
 t/t4203-mailmap.sh                           |   2 +-
 t/t4208-log-magic-pathspec.sh                |   6 +-
 t/t4209-log-pickaxe.sh                       |   4 +-
 t/t4211-line-log.sh                          |   4 +-
 t/t4212-log-corrupt.sh                       |   2 +-
 t/t4256-am-format-flowed.sh                  |   2 +-
 t/t5300-pack-object.sh                       |   4 +-
 t/t5302-pack-index.sh                        |   4 +-
 t/t5304-prune.sh                             |   4 +-
 t/t5310-pack-bitmaps.sh                      |   8 +-
 t/t5318-commit-graph.sh                      |  18 +--
 t/t5319-multi-pack-index.sh                  |  10 +-
 t/t5324-split-commit-graph.sh                |  16 +--
 t/t5331-pack-objects-stdin.sh                |   4 +-
 t/t5411/test-0026-push-options.sh            |   2 +-
 t/t5411/test-0027-push-options--porcelain.sh |   2 +-
 t/t5500-fetch-pack.sh                        |  10 +-
 t/t5504-fetch-receive-strict.sh              |  26 ++--
 t/t5505-remote.sh                            |  22 +--
 t/t5510-fetch.sh                             |   8 +-
 t/t5512-ls-remote.sh                         |   2 +-
 t/t5514-fetch-multiple.sh                    |   4 +-
 t/t5516-fetch-push.sh                        |   8 +-
 t/t5520-pull.sh                              |  34 ++---
 t/t5521-pull-options.sh                      |   2 +-
 t/t5523-push-upstream.sh                     |  12 +-
 t/t5528-push-default.sh                      |   2 +-
 t/t5530-upload-pack-error.sh                 |   4 +-
 t/t5531-deep-submodule-push.sh               |   2 +-
 t/t5534-push-signed.sh                       |   6 +-
 t/t5536-fetch-conflicts.sh                   |   8 +-
 t/t5541-http-push-smart.sh                   |  20 +--
 t/t5545-push-options.sh                      |   2 +-
 t/t5550-http-fetch-dumb.sh                   |   8 +-
 t/t5551-http-fetch-smart.sh                  |   4 +-
 t/t5570-git-daemon.sh                        |  10 +-
 t/t5572-pull-submodule.sh                    |   2 +-
 t/t5573-pull-verify-signatures.sh            |  26 ++--
 t/t5574-fetch-output.sh                      |   4 +-
 t/t5580-unc-paths.sh                         |   2 +-
 t/t5601-clone.sh                             |   6 +-
 t/t5604-clone-reference.sh                   |   2 +-
 t/t5606-clone-options.sh                     |  10 +-
 t/t5607-clone-bundle.sh                      |   4 +-
 t/t5611-clone-config.sh                      |   4 +-
 t/t5616-partial-clone.sh                     |  22 +--
 t/t5701-git-serve.sh                         |   8 +-
 t/t5702-protocol-v2.sh                       |  34 ++---
 t/t5703-upload-pack-ref-in-want.sh           |   4 +-
 t/t5704-protocol-violations.sh               |   4 +-
 t/t5801-remote-helpers.sh                    |   8 +-
 t/t5812-proto-disable-http.sh                |   2 +-
 t/t6001-rev-list-graft.sh                    |   4 +-
 t/t6021-rev-list-exclude-hidden.sh           |   4 +-
 t/t6030-bisect-porcelain.sh                  |  24 ++--
 t/t6040-tracking-info.sh                     |  18 +--
 t/t6050-replace.sh                           |  14 +-
 t/t6102-rev-list-unexpected-objects.sh       |  16 +--
 t/t6112-rev-list-filters-objects.sh          |   2 +-
 t/t6120-describe.sh                          |   2 +-
 t/t6134-pathspec-in-submodule.sh             |   2 +-
 t/t6135-pathspec-with-attrs.sh               |   8 +-
 t/t6136-pathspec-in-bare.sh                  |   8 +-
 t/t6402-merge-rename.sh                      |  16 +--
 t/t6422-merge-rename-corner-cases.sh         |  16 +--
 t/t6423-merge-rename-directories.sh          | 140 +++++++++----------
 t/t6424-merge-unrelated-index-changes.sh     |   6 +-
 t/t6425-merge-rename-delete.sh               |   4 +-
 t/t6426-merge-skip-unneeded-updates.sh       |   2 +-
 t/t6430-merge-recursive.sh                   |   8 +-
 t/t6433-merge-toplevel.sh                    |   4 +-
 t/t6436-merge-overwrite.sh                   |   4 +-
 t/t6437-submodule-merge.sh                   |   2 +-
 t/t6500-gc.sh                                |  14 +-
 t/t7001-mv.sh                                |   4 +-
 t/t7105-reset-patch.sh                       |   6 +-
 t/t7106-reset-unborn-branch.sh               |   2 +-
 t/t7107-reset-pathspec-file.sh               |  10 +-
 t/t7110-reset-merge.sh                       |   6 +-
 t/t7201-co.sh                                |   4 +-
 t/t7300-clean.sh                             |   2 +-
 t/t7400-submodule-basic.sh                   |  64 ++++-----
 t/t7403-submodule-sync.sh                    |   4 +-
 t/t7406-submodule-update.sh                  |   6 +-
 t/t7411-submodule-config.sh                  |   4 +-
 t/t7414-submodule-mistakes.sh                |   8 +-
 t/t7416-submodule-dash-url.sh                |   4 +-
 t/t7417-submodule-path-url.sh                |   4 +-
 t/t7450-bad-git-dotfiles.sh                  |  12 +-
 t/t7500-commit-template-squash-signoff.sh    |   2 +-
 t/t7501-commit-basic-functionality.sh        |   6 +-
 t/t7502-commit-porcelain.sh                  |  32 ++---
 t/t7506-status-submodule.sh                  |  28 ++--
 t/t7507-commit-verbose.sh                    |   4 +-
 t/t7508-status.sh                            |  24 ++--
 t/t7509-commit-authorship.sh                 |   4 +-
 t/t7518-ident-corner-cases.sh                |  10 +-
 t/t7519-status-fsmonitor.sh                  |   6 +-
 t/t7520-ignored-hook-warning.sh              |   8 +-
 t/t7525-status-rename.sh                     |  54 +++----
 t/t7526-commit-pathspec-file.sh              |  14 +-
 t/t7600-merge.sh                             |  30 ++--
 t/t7601-merge-pull-config.sh                 |  50 +++----
 t/t7611-merge-abort.sh                       |   4 +-
 t/t7612-merge-verify-signatures.sh           |  24 ++--
 t/t7703-repack-geometric.sh                  |   4 +-
 t/t7800-difftool.sh                          |   4 +-
 t/t7810-grep.sh                              |   4 +-
 t/t7811-grep-open.sh                         |   2 +-
 t/t7814-grep-recurse-submodules.sh           |   2 +-
 t/t7816-grep-binary-pattern.sh               |   4 +-
 t/t7900-maintenance.sh                       |  24 ++--
 t/t8003-blame-corner-cases.sh                |   2 +-
 t/t8013-blame-ignore-revs.sh                 |   6 +-
 t/t9001-send-email.sh                        |   8 +-
 t/t9300-fast-import.sh                       |  26 ++--
 t/t9800-git-p4-basic.sh                      |  18 +--
 t/t9801-git-p4-branch.sh                     |   2 +-
 t/t9807-git-p4-submit.sh                     |  12 +-
 t/t9815-git-p4-submit-fail.sh                |  12 +-
 224 files changed, 1190 insertions(+), 1190 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2fb1b2ae56..5fe3c8ab69 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -255,7 +255,7 @@ test_http_push_nonff () {
 	'
=20
 	test_expect_success 'non-fast-forward push shows help message' '
-		test_i18ngrep "Updates were rejected because" output
+		test_grep "Updates were rejected because" output
 	'
=20
 	test_expect_${EXPECT_CAS_RESULT} 'force with lease aka cas' '
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 9acb0d5d19..36f767cb74 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -830,7 +830,7 @@ test_submodule_recursing_with_args_common () {
 			cd submodule_update &&
 			git branch -t invalid_sub1 origin/invalid_sub1 &&
 			test_must_fail $command invalid_sub1 2>err &&
-			test_i18ngrep sub1 err &&
+			test_grep sub1 err &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
 		)
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 30a6edca1d..2b78e3be47 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -168,8 +168,8 @@ test_expect_success 'reinit' '
 		git -c init.defaultBranch=3Dinitial init >out1 2>err1 &&
 		git init >out2 2>err2
 	) &&
-	test_i18ngrep "Initialized empty" again/out1 &&
-	test_i18ngrep "Reinitialized existing" again/out2 &&
+	test_grep "Initialized empty" again/out1 &&
+	test_grep "Reinitialized existing" again/out2 &&
 	test_must_be_empty again/err1 &&
 	test_must_be_empty again/err2
 '
@@ -332,7 +332,7 @@ test_expect_success 'init with separate gitdir' '
=20
 test_expect_success 'explicit bare & --separate-git-dir incompatible' '
 	test_must_fail git init --bare --separate-git-dir goop.git bare.git 2>e=
rr &&
-	test_i18ngrep "cannot be used together" err
+	test_grep "cannot be used together" err
 '
=20
 test_expect_success 'implicit bare & --separate-git-dir incompatible' '
@@ -340,7 +340,7 @@ test_expect_success 'implicit bare & --separate-git-d=
ir incompatible' '
 	mkdir -p bare.git &&
 	test_must_fail env GIT_DIR=3D. \
 		git -C bare.git init --separate-git-dir goop.git 2>err &&
-	test_i18ngrep "incompatible" err
+	test_grep "incompatible" err
 '
=20
 test_expect_success 'bare & --separate-git-dir incompatible within workt=
ree' '
@@ -349,7 +349,7 @@ test_expect_success 'bare & --separate-git-dir incomp=
atible within worktree' '
 	git clone --bare . bare.git &&
 	git -C bare.git worktree add --detach ../linkwt &&
 	test_must_fail git -C linkwt init --separate-git-dir seprepo 2>err &&
-	test_i18ngrep "incompatible" err
+	test_grep "incompatible" err
 '
=20
 test_lazy_prereq GETCWD_IGNORES_PERMS '
@@ -563,7 +563,7 @@ test_expect_success '--initial-branch' '
=20
 	: re-initializing should not change the branch name &&
 	git init --initial-branch=3Dignore initial-branch-option 2>err &&
-	test_i18ngrep "ignored --initial-branch" err &&
+	test_grep "ignored --initial-branch" err &&
 	git -C initial-branch-option symbolic-ref HEAD >actual &&
 	grep hello actual
 '
@@ -579,7 +579,7 @@ test_expect_success 'advice on unconfigured init.defa=
ultBranch' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D git -c color.advice=3Dalways \
 		init unconfigured-default-branch-name 2>err &&
 	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded
+	test_grep "<YELLOW>hint: " decoded
 '
=20
 test_expect_success 'overridden default main branch name (env)' '
@@ -592,7 +592,7 @@ test_expect_success 'overridden default main branch n=
ame (env)' '
 test_expect_success 'invalid default branch name' '
 	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3D"with space" =
\
 		git init initial-branch-invalid 2>err &&
-	test_i18ngrep "invalid branch name" err
+	test_grep "invalid branch name" err
 '
=20
 test_expect_success 'branch -m with the initial branch' '
diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index e013d38f48..736516cc6a 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -22,13 +22,13 @@ test_expect_success 'initial setup' '
 test_expect_success 'bad setup: invalid .git file format' '
 	echo "gitdir $REAL" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_i18ngrep "invalid gitfile format" .err
+	test_grep "invalid gitfile format" .err
 '
=20
 test_expect_success 'bad setup: invalid .git file path' '
 	echo "gitdir: $REAL.not" >.git &&
 	test_must_fail git rev-parse 2>.err &&
-	test_i18ngrep "not a git repository" .err
+	test_grep "not a git repository" .err
 '
=20
 test_expect_success 'final setup + check rev-parse --git-dir' '
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b..42695e143d 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -259,7 +259,7 @@ test_expect_success 'root subdir attribute test' '
 test_expect_success 'negative patterns' '
 	echo "!f test=3Dbar" >.gitattributes &&
 	git check-attr test -- '"'"'!f'"'"' 2>errors &&
-	test_i18ngrep "Negative patterns are ignored" errors
+	test_grep "Negative patterns are ignored" errors
 '
=20
 test_expect_success 'patterns starting with exclamation' '
@@ -424,7 +424,7 @@ test_expect_success SYMLINKS 'symlinks not respected =
in-tree' '
 	mkdir subdir &&
 	ln -s ../attr subdir/.gitattributes &&
 	attr_check_basic subdir/file unspecified &&
-	test_i18ngrep "unable to access.*gitattributes" err
+	test_grep "unable to access.*gitattributes" err
 '
=20
 test_expect_success 'large attributes line ignored in tree' '
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c70d11bc91..361446b2f4 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -49,7 +49,7 @@ broken_c_unquote_verbose () {
=20
 stderr_contains () {
 	regexp=3D"$1"
-	if test_i18ngrep "$regexp" "$HOME/stderr"
+	if test_grep "$regexp" "$HOME/stderr"
 	then
 		return 0
 	else
@@ -942,7 +942,7 @@ test_expect_success SYMLINKS 'symlinks not respected =
in-tree' '
 	ln -s ignore subdir/.gitignore &&
 	test_must_fail git check-ignore subdir/file >actual 2>err &&
 	test_must_be_empty actual &&
-	test_i18ngrep "unable to access.*gitignore" err
+	test_grep "unable to access.*gitignore" err
 '
=20
 test_done
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index dbfc5c8267..1d273d91c2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -100,17 +100,17 @@ test_expect_success "--help does not work for guide=
s" "
=20
 test_expect_success 'git help' '
 	git help >help.output &&
-	test_i18ngrep "^   clone  " help.output &&
-	test_i18ngrep "^   add    " help.output &&
-	test_i18ngrep "^   log    " help.output &&
-	test_i18ngrep "^   commit " help.output &&
-	test_i18ngrep "^   fetch  " help.output
+	test_grep "^   clone  " help.output &&
+	test_grep "^   add    " help.output &&
+	test_grep "^   log    " help.output &&
+	test_grep "^   commit " help.output &&
+	test_grep "^   fetch  " help.output
 '
=20
 test_expect_success 'git help -g' '
 	git help -g >help.output &&
-	test_i18ngrep "^   everyday   " help.output &&
-	test_i18ngrep "^   tutorial   " help.output
+	test_grep "^   everyday   " help.output &&
+	test_grep "^   tutorial   " help.output
 '
=20
 test_expect_success 'git help fails for non-existing html pages' '
@@ -257,7 +257,7 @@ do
 			export GIT_CEILING_DIRECTORIES &&
 			test_expect_code 129 git -C sub $builtin -h >output 2>&1
 		) &&
-		test_i18ngrep usage output
+		test_grep usage output
 	'
 done <builtins
=20
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 5324047689..08814173cb 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -16,7 +16,7 @@ fi
=20
 test_expect_success 'test-sha1 detects shattered pdf' '
 	test_must_fail test-tool sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
-	test_i18ngrep collision err &&
+	test_grep collision err &&
 	grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
 '
=20
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 8d3d9144c0..95568342be 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -8,7 +8,7 @@ test_expect_success 'nested aliases - internal execution'=
 '
 	git config alias.nested-internal-1 nested-internal-2 &&
 	git config alias.nested-internal-2 status &&
 	git nested-internal-1 >output &&
-	test_i18ngrep "^On branch " output
+	test_grep "^On branch " output
 '
=20
 test_expect_success 'nested aliases - mixed execution' '
@@ -16,7 +16,7 @@ test_expect_success 'nested aliases - mixed execution' =
'
 	git config alias.nested-external-2 "!git nested-external-3" &&
 	git config alias.nested-external-3 status &&
 	git nested-external-1 >output &&
-	test_i18ngrep "^On branch " output
+	test_grep "^On branch " output
 '
=20
 test_expect_success 'looping aliases - internal execution' '
@@ -24,7 +24,7 @@ test_expect_success 'looping aliases - internal executi=
on' '
 	git config alias.loop-internal-2 loop-internal-3 &&
 	git config alias.loop-internal-3 loop-internal-2 &&
 	test_must_fail git loop-internal-1 2>output &&
-	test_i18ngrep "^fatal: alias loop detected: expansion of" output
+	test_grep "^fatal: alias loop detected: expansion of" output
 '
=20
 # This test is disabled until external loops are fixed, because would bl=
ock
@@ -34,7 +34,7 @@ test_expect_success 'looping aliases - internal executi=
on' '
 #	git config alias.loop-mixed-1 loop-mixed-2 &&
 #	git config alias.loop-mixed-2 "!git loop-mixed-1" &&
 #	test_must_fail git loop-mixed-1 2>output &&
-#	test_i18ngrep "^fatal: alias loop detected: expansion of" output
+#	test_grep "^fatal: alias loop detected: expansion of" output
 #'
=20
 test_expect_success 'run-command formats empty args properly' '
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 46abbeed68..0b4997022b 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -263,7 +263,7 @@ test_expect_success 'required filter with absent clea=
n field' '
=20
 	echo test >test.ac &&
 	test_must_fail git add test.ac 2>stderr &&
-	test_i18ngrep "fatal: test.ac: clean filter .absentclean. failed" stder=
r
+	test_grep "fatal: test.ac: clean filter .absentclean. failed" stderr
 '
=20
 test_expect_success 'required filter with absent smudge field' '
@@ -276,7 +276,7 @@ test_expect_success 'required filter with absent smud=
ge field' '
 	git add test.as &&
 	rm -f test.as &&
 	test_must_fail git checkout -- test.as 2>stderr &&
-	test_i18ngrep "fatal: test.as: smudge filter absentsmudge failed" stder=
r
+	test_grep "fatal: test.as: smudge filter absentsmudge failed" stderr
 '
=20
 test_expect_success 'filtering large input to small output should use li=
ttle memory' '
@@ -733,7 +733,7 @@ test_expect_success 'process filter should restart af=
ter unexpected write failur
 		git checkout --quiet --no-progress . 2>git-stderr.log &&
=20
 		grep "smudge write error" git-stderr.log &&
-		test_i18ngrep "error: external filter" git-stderr.log &&
+		test_grep "error: external filter" git-stderr.log &&
=20
 		cat >expected.log <<-EOF &&
 			START
diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enco=
ding.sh
index c196fdb0ee..1b55f59c23 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -92,23 +92,23 @@ do
 		# In these cases the BOM is prohibited.
 		cp bebom.utf${i}be.raw bebom.utf${i}be &&
 		test_must_fail git add bebom.utf${i}be 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
-		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+		test_grep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_grep "use UTF-${i} as working-tree-encoding" err.out &&
=20
 		cp lebom.utf${i}le.raw lebom.utf${i}be &&
 		test_must_fail git add lebom.utf${i}be 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
-		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+		test_grep "fatal: BOM is prohibited .* utf-${i}be" err.out &&
+		test_grep "use UTF-${i} as working-tree-encoding" err.out &&
=20
 		cp bebom.utf${i}be.raw bebom.utf${i}le &&
 		test_must_fail git add bebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
-		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out &&
+		test_grep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_grep "use UTF-${i} as working-tree-encoding" err.out &&
=20
 		cp lebom.utf${i}le.raw lebom.utf${i}le &&
 		test_must_fail git add lebom.utf${i}le 2>err.out &&
-		test_i18ngrep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
-		test_i18ngrep "use UTF-${i} as working-tree-encoding" err.out
+		test_grep "fatal: BOM is prohibited .* utf-${i}LE" err.out &&
+		test_grep "use UTF-${i} as working-tree-encoding" err.out
 	'
=20
 	test_expect_success "check required UTF-${i} BOM" '
@@ -118,13 +118,13 @@ do
=20
 		cp nobom.utf${i}be.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
-		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
-		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out &&
+		test_grep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_grep "use UTF-${i}BE or UTF-${i}LE" err.out &&
=20
 		cp nobom.utf${i}le.raw nobom.utf${i} &&
 		test_must_fail git add nobom.utf${i} 2>err.out &&
-		test_i18ngrep "fatal: BOM is required .* utf-${i}" err.out &&
-		test_i18ngrep "use UTF-${i}BE or UTF-${i}LE" err.out
+		test_grep "fatal: BOM is required .* utf-${i}" err.out &&
+		test_grep "use UTF-${i}BE or UTF-${i}LE" err.out
 	'
=20
 	test_expect_success "eol conversion for UTF-${i} encoded files on check=
out" '
@@ -169,7 +169,7 @@ test_expect_success 'check unsupported encodings' '
 	echo "*.set text working-tree-encoding" >.gitattributes &&
 	printf "set" >t.set &&
 	test_must_fail git add t.set 2>err.out &&
-	test_i18ngrep "true/false are no valid working-tree-encodings" err.out =
&&
+	test_grep "true/false are no valid working-tree-encodings" err.out &&
=20
 	echo "*.unset text -working-tree-encoding" >.gitattributes &&
 	printf "unset" >t.unset &&
@@ -182,7 +182,7 @@ test_expect_success 'check unsupported encodings' '
 	echo "*.garbage text working-tree-encoding=3Dgarbage" >.gitattributes &=
&
 	printf "garbage" >t.garbage &&
 	test_must_fail git add t.garbage 2>err.out &&
-	test_i18ngrep "failed to encode" err.out
+	test_grep "failed to encode" err.out
 '
=20
 test_expect_success 'error if encoding round trip is not the same during=
 refresh' '
@@ -201,7 +201,7 @@ test_expect_success 'error if encoding round trip is =
not the same during refresh
 	git update-ref refs/heads/main $COMMIT &&
=20
 	test_must_fail git checkout HEAD^ 2>err.out &&
-	test_i18ngrep "error: .* overwritten by checkout:" err.out
+	test_grep "error: .* overwritten by checkout:" err.out
 '
=20
 test_expect_success 'error if encoding garbage is already in Git' '
@@ -217,7 +217,7 @@ test_expect_success 'error if encoding garbage is alr=
eady in Git' '
 	git update-ref refs/heads/main $COMMIT &&
=20
 	git diff 2>err.out &&
-	test_i18ngrep "error: BOM is required" err.out
+	test_grep "error: BOM is required" err.out
 '
=20
 test_lazy_prereq ICONV_SHIFT_JIS '
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index e19a199636..c8cc0fd8d0 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -366,13 +366,13 @@ test_expect_success 'OPT_CMDMODE() works' '
 test_expect_success 'OPT_CMDMODE() detects incompatibility' '
 	test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output=
.err &&
 	test_must_be_empty output &&
-	test_i18ngrep "incompatible with --mode" output.err
+	test_grep "incompatible with --mode" output.err
 '
=20
 test_expect_success 'OPT_CMDMODE() detects incompatibility with somethin=
g else' '
 	test_must_fail test-tool parse-options --set23 --mode2 >output 2>output=
.err &&
 	test_must_be_empty output &&
-	test_i18ngrep "incompatible with something else" output.err
+	test_grep "incompatible with something else" output.err
 '
=20
 test_expect_success 'OPT_COUNTUP() with PARSE_OPT_NODASH works' '
diff --git a/t/t0041-usage.sh b/t/t0041-usage.sh
index 9ea974b0c6..1464294bd1 100755
--- a/t/t0041-usage.sh
+++ b/t/t0041-usage.sh
@@ -21,8 +21,8 @@ test_expect_success 'tag --contains <existent_tag>' '
 test_expect_success 'tag --contains <inexistent_tag>' '
 	test_must_fail git tag --contains "notag" >actual 2>actual.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'tag --no-contains <existent_tag>' '
@@ -34,27 +34,27 @@ test_expect_success 'tag --no-contains <existent_tag>=
' '
 test_expect_success 'tag --no-contains <inexistent_tag>' '
 	test_must_fail git tag --no-contains "notag" >actual 2>actual.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'tag usage error' '
 	test_must_fail git tag --noopt >actual 2>actual.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "usage" actual.err
+	test_grep "usage" actual.err
 '
=20
 test_expect_success 'branch --contains <existent_commit>' '
 	git branch --contains "main" >actual 2>actual.err &&
-	test_i18ngrep "main" actual &&
+	test_grep "main" actual &&
 	test_line_count =3D 0 actual.err
 '
=20
 test_expect_success 'branch --contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err=
 &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'branch --no-contains <existent_commit>' '
@@ -66,14 +66,14 @@ test_expect_success 'branch --no-contains <existent_c=
ommit>' '
 test_expect_success 'branch --no-contains <inexistent_commit>' '
 	test_must_fail git branch --no-contains "nocommit" >actual 2>actual.err=
 &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'branch usage error' '
 	test_must_fail git branch --noopt >actual 2>actual.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "usage" actual.err
+	test_grep "usage" actual.err
 '
=20
 test_expect_success 'for-each-ref --contains <existent_object>' '
@@ -85,8 +85,8 @@ test_expect_success 'for-each-ref --contains <existent_=
object>' '
 test_expect_success 'for-each-ref --contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actu=
al.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'for-each-ref --no-contains <existent_object>' '
@@ -98,14 +98,14 @@ test_expect_success 'for-each-ref --no-contains <exis=
tent_object>' '
 test_expect_success 'for-each-ref --no-contains <inexistent_object>' '
 	test_must_fail git for-each-ref --no-contains "noobject" >actual 2>actu=
al.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "error" actual.err &&
-	test_i18ngrep ! "usage" actual.err
+	test_grep "error" actual.err &&
+	test_grep ! "usage" actual.err
 '
=20
 test_expect_success 'for-each-ref usage error' '
 	test_must_fail git for-each-ref --noopt >actual 2>actual.err &&
 	test_line_count =3D 0 actual &&
-	test_i18ngrep "usage" actual.err
+	test_grep "usage" actual.err
 '
=20
 test_done
diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index e2411f6a9b..20986b693c 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -19,12 +19,12 @@ test_expect_success MINGW 'subprocess inherits only s=
td handles' '
=20
 test_expect_success 'start_command reports ENOENT (slash)' '
 	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
-	test_i18ngrep "\./does-not-exist" err
+	test_grep "\./does-not-exist" err
 '
=20
 test_expect_success 'start_command reports ENOENT (no slash)' '
 	test-tool run-command start-command-ENOENT does-not-exist 2>err &&
-	test_i18ngrep "does-not-exist" err
+	test_grep "does-not-exist" err
 '
=20
 test_expect_success 'run_command can run a command' '
@@ -49,7 +49,7 @@ test_expect_success !RUNS_COMMANDS_FROM_PWD 'run_comman=
d is restricted to PATH'
 	echo yikes
 	EOF
 	test_must_fail test-tool run-command run-command should-not-run 2>err &=
&
-	test_i18ngrep "should-not-run" err
+	test_grep "should-not-run" err
 '
=20
 test_expect_success !MINGW 'run_command can run a script without a #! li=
ne' '
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 574de34198..487bc8d905 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -44,13 +44,13 @@ test_expect_success 'incomplete sideband messages are=
 reassembled' '
 test_expect_success 'eof on sideband message is reported' '
 	printf 1234 >input &&
 	test-tool pkt-line receive-sideband <input 2>err &&
-	test_i18ngrep "unexpected disconnect" err
+	test_grep "unexpected disconnect" err
 '
=20
 test_expect_success 'missing sideband designator is reported' '
 	printf 0004 >input &&
 	test-tool pkt-line receive-sideband <input 2>err &&
-	test_i18ngrep "missing sideband" err
+	test_grep "missing sideband" err
 '
=20
 test_done
diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
index f6998269be..150cc1dea2 100755
--- a/t/t0091-bugreport.sh
+++ b/t/t0091-bugreport.sh
@@ -65,7 +65,7 @@ test_expect_success '--output-directory puts the report=
 in the provided dir' '
=20
 test_expect_success 'incorrect arguments abort with usage' '
 	test_must_fail git bugreport --false 2>output &&
-	test_i18ngrep usage output &&
+	test_grep usage output &&
 	test_path_is_missing git-bugreport-*
 '
=20
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index a4f5bba507..400f6bdbca 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -827,7 +827,7 @@ test_expect_success 'credential config with partial U=
RLs' '
 	git -c credential.$partial.helper=3Dyep \
 		-c credential.with%0anewline.username=3Duh-oh \
 		credential fill <stdin 2>stderr &&
-	test_i18ngrep "skipping credential lookup for key" stderr
+	test_grep "skipping credential lookup for key" stderr
 '
=20
 test_done
diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index 35261afc9d..5e0f0a334f 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -125,7 +125,7 @@ test_expect_success 'fetch into corrupted repo with i=
ndex-pack' '
 		cd bit-error-cp &&
 		test_must_fail git -c transfer.unpackLimit=3D1 \
 			fetch ../no-bit-error 2>stderr &&
-		test_i18ngrep ! -i collision stderr
+		test_grep ! -i collision stderr
 	)
 '
=20
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
index 9ceb17f911..f67611da28 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -47,7 +47,7 @@ test_expect_success 'setup' '
 test_expect_success 'git sparse-checkout list (not sparse)' '
 	test_must_fail git -C repo sparse-checkout list >list 2>err &&
 	test_must_be_empty list &&
-	test_i18ngrep "this worktree is not sparse" err
+	test_grep "this worktree is not sparse" err
 '
=20
 test_expect_success 'git sparse-checkout list (not sparse)' '
@@ -55,7 +55,7 @@ test_expect_success 'git sparse-checkout list (not spar=
se)' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout list >list 2>err &&
 	test_must_be_empty list &&
-	test_i18ngrep "this worktree is not sparse (sparse-checkout file may no=
t exist)" err
+	test_grep "this worktree is not sparse (sparse-checkout file may not ex=
ist)" err
 '
=20
 test_expect_success 'git sparse-checkout list (populated)' '
@@ -230,7 +230,7 @@ test_expect_success 'cone mode: match patterns' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	rm -rf repo/a repo/folder1 repo/folder2 &&
 	git -C repo read-tree -mu HEAD 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err &&
+	test_grep ! "disabling cone patterns" err &&
 	git -C repo reset --hard &&
 	check_files repo a folder1 folder2
 '
@@ -240,7 +240,7 @@ test_expect_success 'cone mode: warn on bad pattern' =
'
 	cp repo/.git/info/sparse-checkout . &&
 	echo "!/deep/deeper/*/" >>repo/.git/info/sparse-checkout &&
 	git -C repo read-tree -mu HEAD 2>err &&
-	test_i18ngrep "unrecognized negative pattern" err
+	test_grep "unrecognized negative pattern" err
 '
=20
 test_expect_success 'sparse-checkout disable' '
@@ -283,7 +283,7 @@ test_expect_success 'sparse-index enabled and disable=
d' '
 test_expect_success 'cone mode: init and set' '
 	git -C repo sparse-checkout init --cone &&
 	git -C repo config --list >config &&
-	test_i18ngrep "core.sparsecheckoutcone=3Dtrue" config &&
+	test_grep "core.sparsecheckoutcone=3Dtrue" config &&
 	list_files repo >dir  &&
 	echo a >expect &&
 	test_cmp expect dir &&
@@ -386,7 +386,7 @@ test_expect_success 'not-up-to-date does not block re=
st of sparsification' '
=20
 	git -C repo sparse-checkout set deep/deeper1 2>err &&
=20
-	test_i18ngrep "The following paths are not up to date" err &&
+	test_grep "The following paths are not up to date" err &&
 	test_cmp expect repo/.git/info/sparse-checkout &&
 	check_files repo/deep a deeper1 deeper2 &&
 	check_files repo/deep/deeper1 a deepest &&
@@ -401,8 +401,8 @@ test_expect_success 'revert to old sparse-checkout on=
 empty update' '
 		git add file &&
 		git commit -m "test" &&
 		git sparse-checkout set nothing 2>err &&
-		test_i18ngrep ! "Sparse checkout leaves no entry on working directory"=
 err &&
-		test_i18ngrep ! ".git/index.lock" err &&
+		test_grep ! "Sparse checkout leaves no entry on working directory" err=
 &&
+		test_grep ! ".git/index.lock" err &&
 		git sparse-checkout set --no-cone file
 	)
 '
@@ -411,14 +411,14 @@ test_expect_success 'fail when lock is taken' '
 	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
 	touch repo/.git/info/sparse-checkout.lock &&
 	test_must_fail git -C repo sparse-checkout set deep 2>err &&
-	test_i18ngrep "Unable to create .*\.lock" err
+	test_grep "Unable to create .*\.lock" err
 '
=20
 test_expect_success '.gitignore should not warn about cone mode' '
 	git -C repo config --worktree core.sparseCheckoutCone true &&
 	echo "**/bin/*" >repo/.gitignore &&
 	git -C repo reset --hard 2>err &&
-	test_i18ngrep ! "disabling cone patterns" err
+	test_grep ! "disabling cone patterns" err
 '
=20
 test_expect_success 'sparse-checkout (init|set|disable) warns with dirty=
 status' '
@@ -426,10 +426,10 @@ test_expect_success 'sparse-checkout (init|set|disa=
ble) warns with dirty status'
 	echo dirty >dirty/folder1/a &&
=20
 	git -C dirty sparse-checkout init --no-cone 2>err &&
-	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_grep "warning.*The following paths are not up to date" err &&
=20
 	git -C dirty sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
-	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_grep "warning.*The following paths are not up to date" err &&
 	test_path_is_file dirty/folder1/a &&
=20
 	git -C dirty sparse-checkout disable 2>err &&
@@ -453,14 +453,14 @@ test_expect_success 'sparse-checkout (init|set|disa=
ble) warns with unmerged stat
 	git -C unmerged update-index --index-info <input &&
=20
 	git -C unmerged sparse-checkout init --no-cone 2>err &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
=20
 	git -C unmerged sparse-checkout set /folder2/* /deep/deeper1/* 2>err &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
 	test_path_is_file dirty/folder1/a &&
=20
 	git -C unmerged sparse-checkout disable 2>err &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
=20
 	git -C unmerged reset --hard &&
 	git -C unmerged sparse-checkout init --no-cone &&
@@ -480,24 +480,24 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak update-index --index-info <input &&
=20
 	git -C tweak sparse-checkout init --cone 2>err &&
-	test_i18ngrep "warning.*The following paths are not up to date" err &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are not up to date" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
=20
 	git -C tweak sparse-checkout set folder2 deep/deeper1 2>err &&
-	test_i18ngrep "warning.*The following paths are not up to date" err &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are not up to date" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
=20
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_i18ngrep "warning.*The following paths are not up to date" err &&
+	test_grep "warning.*The following paths are not up to date" err &&
 	test_path_is_file tweak/deep/deeper2/a &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
=20
 	git -C tweak checkout HEAD deep/deeper2/a &&
 	git -C tweak sparse-checkout reapply 2>err &&
-	test_i18ngrep ! "warning.*The following paths are not up to date" err &=
&
+	test_grep ! "warning.*The following paths are not up to date" err &&
 	test_path_is_missing tweak/deep/deeper2/a &&
-	test_i18ngrep "warning.*The following paths are unmerged" err &&
+	test_grep "warning.*The following paths are unmerged" err &&
 	test_path_is_file tweak/folder1/a &&
=20
 	# NEEDSWORK: We are asking to update a file outside of the
@@ -578,8 +578,8 @@ test_expect_success 'check-rules interaction with sub=
modules' '
 	git -C super ls-tree --name-only -r HEAD >all-files &&
 	git -C super sparse-checkout check-rules >check-rules-matches <all-file=
s &&
=20
-	test_i18ngrep ! "modules/" check-rules-matches &&
-	test_i18ngrep "folder1/" check-rules-matches
+	test_grep ! "modules/" check-rules-matches &&
+	test_grep "folder1/" check-rules-matches
 '
=20
 test_expect_success 'different sparse-checkouts with worktrees' '
@@ -616,7 +616,7 @@ check_read_tree_errors () {
 	then
 		test_must_be_empty err
 	else
-		test_i18ngrep "$ERRORS" err
+		test_grep "$ERRORS" err
 	fi &&
 	check_files $REPO $FILES
 }
@@ -898,32 +898,32 @@ test_expect_success 'setup bare repo' '
 '
 test_expect_success 'list fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout list 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'add fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout add deeper 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'set fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout set deeper 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'init fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout init 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'reapply fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout reapply 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'disable fails outside work tree' '
 	test_must_fail git -C bare sparse-checkout disable 2>err &&
-	test_i18ngrep "this operation must be run in a work tree" err
+	test_grep "this operation must be run in a work tree" err
 '
=20
 test_expect_success 'setup clean' '
@@ -946,8 +946,8 @@ test_expect_success 'check-rules cone mode' '
=20
 	git -C repo sparse-checkout check-rules >check-rules-default <all-files=
 &&
=20
-	test_i18ngrep "deep/deeper1/deepest/a" check-rules-file &&
-	test_i18ngrep ! "deep/deeper2" check-rules-file &&
+	test_grep "deep/deeper1/deepest/a" check-rules-file &&
+	test_grep ! "deep/deeper2" check-rules-file &&
=20
 	test_cmp check-rules-file ls-files &&
 	test_cmp check-rules-file check-rules-default
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-ch=
eckout-compatibility.sh
index 8a95adf4b5..12e971b1d1 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -337,8 +337,8 @@ test_expect_success 'status reports sparse-checkout' =
'
 	init_repos &&
 	git -C sparse-checkout status >full &&
 	git -C sparse-index status >sparse &&
-	test_i18ngrep "You are in a sparse checkout with " full &&
-	test_i18ngrep "You are in a sparse checkout." sparse
+	test_grep "You are in a sparse checkout with " full &&
+	test_grep "You are in a sparse checkout." sparse
 '
=20
 test_expect_success 'add, commit, checkout' '
@@ -1182,7 +1182,7 @@ test_expect_success 'checkout-index outside sparse =
definition' '
 	# Without --ignore-skip-worktree-bits, outside-of-cone files will trigg=
er
 	# an error
 	test_sparse_match test_must_fail git checkout-index -- folder1/a &&
-	test_i18ngrep "folder1/a has skip-worktree enabled" sparse-checkout-err=
 &&
+	test_grep "folder1/a has skip-worktree enabled" sparse-checkout-err &&
 	test_path_is_missing folder1/a &&
=20
 	# With --ignore-skip-worktree-bits, outside-of-cone files are checked o=
ut
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 387d336c91..f4e2752134 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -453,7 +453,7 @@ test_expect_success 'get bool variable with empty val=
ue' '
=20
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
-	test_i18ngrep usage output
+	test_grep usage output
 '
=20
 cat > .git/config << EOF
@@ -720,25 +720,25 @@ test_expect_success 'invalid unit' '
 	git config aninvalid.unit "1auto" &&
 	test_cmp_config 1auto aninvalid.unit &&
 	test_must_fail git config --int --get aninvalid.unit 2>actual &&
-	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in=
 file .git/config: invalid unit" actual
+	test_grep "bad numeric config value .1auto. for .aninvalid.unit. in fil=
e .git/config: invalid unit" actual
 '
=20
 test_expect_success 'invalid unit boolean' '
 	git config commit.gpgsign "1true" &&
 	test_cmp_config 1true commit.gpgsign &&
 	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
-	test_i18ngrep "bad boolean config value .1true. for .commit.gpgsign." a=
ctual
+	test_grep "bad boolean config value .1true. for .commit.gpgsign." actua=
l
 '
=20
 test_expect_success 'line number is reported correctly' '
 	printf "[bool]\n\tvar\n" >invalid &&
 	test_must_fail git config -f invalid --path bool.var 2>actual &&
-	test_i18ngrep "line 2" actual
+	test_grep "line 2" actual
 '
=20
 test_expect_success 'invalid stdin config' '
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1=
 &&
-	test_i18ngrep "bad config line 1 in standard input" output
+	test_grep "bad config line 1 in standard input" output
 '
=20
 cat > expect << EOF
@@ -919,7 +919,7 @@ test_expect_success !MINGW 'get --path copes with uns=
et $HOME' '
 		git config --get --path path.normal >>result &&
 		git config --get --path path.trailingtilde >>result
 	) &&
-	test_i18ngrep "[Ff]ailed to expand.*~/" msg &&
+	test_grep "[Ff]ailed to expand.*~/" msg &&
 	test_cmp expect result
 '
=20
@@ -986,7 +986,7 @@ test_expect_success 'get --type=3Dcolor barfs on non-=
color' '
=20
 test_expect_success 'set --type=3Dcolor barfs on non-color' '
 	test_must_fail git config --type=3Dcolor foo.color "not-a-color" 2>erro=
r &&
-	test_i18ngrep "cannot parse color" error
+	test_grep "cannot parse color" error
 '
=20
 cat > expect << EOF
@@ -1447,12 +1447,12 @@ test_expect_success 'git --config-env with missin=
g value' '
=20
 test_expect_success 'git --config-env fails with invalid parameters' '
 	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>err=
or &&
-	test_i18ngrep "invalid config format: foo.flag" error &&
+	test_grep "invalid config format: foo.flag" error &&
 	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag 2>=
error &&
-	test_i18ngrep "missing environment variable name for configuration ${SQ=
}foo.flag${SQ}" error &&
+	test_grep "missing environment variable name for configuration ${SQ}foo=
.flag${SQ}" error &&
 	sane_unset NONEXISTENT &&
 	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bool =
foo.flag 2>error &&
-	test_i18ngrep "missing environment variable ${SQ}NONEXISTENT${SQ} for c=
onfiguration ${SQ}foo.flag${SQ}" error
+	test_grep "missing environment variable ${SQ}NONEXISTENT${SQ} for confi=
guration ${SQ}foo.flag${SQ}" error
 '
=20
 test_expect_success 'git -c and --config-env work together' '
@@ -1533,21 +1533,21 @@ test_expect_success 'git config ignores pairs wit=
h empty count' '
=20
 test_expect_success 'git config fails with invalid count' '
 	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error &&
-	test_i18ngrep "bogus count" error &&
+	test_grep "bogus count" error &&
 	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config --lis=
t 2>error &&
-	test_i18ngrep "too many entries" error
+	test_grep "too many entries" error
 '
=20
 test_expect_success 'git config fails with missing config key' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_VALUE_0=3D"value" \
 		git config --list 2>error &&
-	test_i18ngrep "missing config key" error
+	test_grep "missing config key" error
 '
=20
 test_expect_success 'git config fails with missing config value' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3D"pair.one" \
 		git config --list 2>error &&
-	test_i18ngrep "missing config value" error
+	test_grep "missing config value" error
 '
=20
 test_expect_success 'git config fails with invalid config pair key' '
@@ -1617,7 +1617,7 @@ test_expect_success 'barf on syntax error' '
 	key garbage
 	EOF
 	test_must_fail git config --get section.key 2>error &&
-	test_i18ngrep " line 3 " error
+	test_grep " line 3 " error
 '
=20
 test_expect_success 'barf on incomplete section header' '
@@ -1627,7 +1627,7 @@ test_expect_success 'barf on incomplete section hea=
der' '
 	key =3D value
 	EOF
 	test_must_fail git config --get section.key 2>error &&
-	test_i18ngrep " line 2 " error
+	test_grep " line 2 " error
 '
=20
 test_expect_success 'barf on incomplete string' '
@@ -1637,7 +1637,7 @@ test_expect_success 'barf on incomplete string' '
 	key =3D "value string
 	EOF
 	test_must_fail git config --get section.key 2>error &&
-	test_i18ngrep " line 3 " error
+	test_grep " line 3 " error
 '
=20
 test_expect_success 'urlmatch' '
@@ -2266,17 +2266,17 @@ test_expect_success 'identical mixed --type speci=
fiers are allowed' '
=20
 test_expect_success 'non-identical modern --type specifiers are not allo=
wed' '
 	test_must_fail git config --type=3Dint --type=3Dbool section.big 2>erro=
r &&
-	test_i18ngrep "only one type at a time" error
+	test_grep "only one type at a time" error
 '
=20
 test_expect_success 'non-identical legacy --type specifiers are not allo=
wed' '
 	test_must_fail git config --int --bool section.big 2>error &&
-	test_i18ngrep "only one type at a time" error
+	test_grep "only one type at a time" error
 '
=20
 test_expect_success 'non-identical mixed --type specifiers are not allow=
ed' '
 	test_must_fail git config --type=3Dint --bool section.big 2>error &&
-	test_i18ngrep "only one type at a time" error
+	test_grep "only one type at a time" error
 '
=20
 test_expect_success '--type allows valid type specifiers' '
@@ -2293,7 +2293,7 @@ test_expect_success 'unset type specifiers may be r=
eset to conflicting ones' '
=20
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=3Dnonsense section.foo 2>error &&
-	test_i18ngrep "unrecognized --type argument" error
+	test_grep "unrecognized --type argument" error
 '
=20
 test_expect_success '--type=3Dint requires at least one digit' '
@@ -2339,7 +2339,7 @@ test_expect_success 'set all config with value-patt=
ern' '
=20
 	# multiple matches =3D> failure
 	test_must_fail git config --file=3Dconfig abc.key three o+ 2>err &&
-	test_i18ngrep "has multiple values" err &&
+	test_grep "has multiple values" err &&
=20
 	# multiple values, no match =3D> add
 	git config --file=3Dconfig abc.key three a+ &&
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 0a7099d6f5..b9852fe40e 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -63,7 +63,7 @@ test_expect_success 'parse errors in blobs are properly=
 attributed' '
 	git commit -m broken &&
=20
 	test_must_fail git config --blob=3DHEAD:config some.value 2>err &&
-	test_i18ngrep "HEAD:config" err
+	test_grep "HEAD:config" err
 '
=20
 test_expect_success 'can parse blob ending with CR' '
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 777648722c..3bfec07f1a 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -172,7 +172,7 @@ test_expect_success 'find string value for a key' '
=20
 test_expect_success 'check line error when NULL string is queried' '
 	test_expect_code 128 test-tool config get_string case.foo 2>result &&
-	test_i18ngrep "fatal: .*case\.foo.*\.git/config.*line 7" result
+	test_grep "fatal: .*case\.foo.*\.git/config.*line 7" result
 '
=20
 test_expect_success 'find integer if value is non parse-able' '
@@ -342,14 +342,14 @@ test_expect_success 'check line errors for malforme=
d values' '
 		br
 	EOF
 	test_expect_code 128 git br 2>result &&
-	test_i18ngrep "missing value for .alias\.br" result &&
-	test_i18ngrep "fatal: .*\.git/config" result &&
-	test_i18ngrep "fatal: .*line 2" result
+	test_grep "missing value for .alias\.br" result &&
+	test_grep "fatal: .*\.git/config" result &&
+	test_grep "fatal: .*line 2" result
 '
=20
 test_expect_success 'error on modifying repo config without repo' '
 	nongit test_must_fail git config a.b c 2>err &&
-	test_i18ngrep "not in a git directory" err
+	test_grep "not in a git directory" err
 '
=20
 cmdline_config=3D"'foo.bar=3Dfrom-cmdline'"
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 537435b90a..523aa99a1e 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -78,7 +78,7 @@ test_with_config () {
=20
 test_expect_success 'ignore .git/ with incompatible repository version' =
'
 	test_with_config "[core]repositoryformatversion =3D 999999" 2>err &&
-	test_i18ngrep "warning:.* Expected git repo version <=3D [1-9]" err
+	test_grep "warning:.* Expected git repo version <=3D [1-9]" err
 '
=20
 test_expect_failure 'ignore .git/ with invalid repository version' '
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
index 09b10c144b..1a90d31201 100755
--- a/t/t1310-config-default.sh
+++ b/t/t1310-config-default.sh
@@ -26,12 +26,12 @@ test_expect_success 'canonicalizes --default with app=
ropriate type' '
 test_expect_success 'dies when --default cannot be parsed' '
 	test_must_fail git config -f config --type=3Dexpiry-date --default=3Dx =
--get \
 		not.a.section 2>error &&
-	test_i18ngrep "failed to format default config value" error
+	test_grep "failed to format default config value" error
 '
=20
 test_expect_success 'does not allow --default without --get' '
 	test_must_fail git config --default=3Dquux --unset a.section >output 2>=
&1 &&
-	test_i18ngrep "\-\-default is only applicable to" output
+	test_grep "\-\-default is only applicable to" output
 '
=20
 test_done
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4d66cd7f4a..9ac4b7036b 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -410,7 +410,7 @@ test_expect_success 'Query "main@{2005-05-26 23:33:01=
}" (middle of history with
 	git rev-parse --verify "main@{2005-05-26 23:33:01}" >o 2>e &&
 	echo "$B" >expect &&
 	test_cmp expect o &&
-	test_i18ngrep -F "warning: log for ref $m has gap after $gd" e
+	test_grep -F "warning: log for ref $m has gap after $gd" e
 '
 test_expect_success 'Query "main@{2005-05-26 23:38:00}" (middle of histo=
ry)' '
 	test_when_finished "rm -f o e" &&
@@ -431,7 +431,7 @@ test_expect_success 'Query "main@{2005-05-28}" (past =
end of history)' '
 	git rev-parse --verify "main@{2005-05-28}" >o 2>e &&
 	echo "$D" >expect &&
 	test_cmp expect o &&
-	test_i18ngrep -F "warning: log for ref $m unexpectedly ended on $ld" e
+	test_grep -F "warning: log for ref $m unexpectedly ended on $ld" e
 '
=20
 rm -f .git/$m .git/logs/$m expect
@@ -486,7 +486,7 @@ test_expect_success 'git cat-file blob main@{2005-05-=
26 23:42}:F (expect OTHER)'
 test_expect_success 'given old value for missing pseudoref, do not creat=
e' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
 	test_must_fail git rev-parse PSEUDOREF &&
-	test_i18ngrep "unable to resolve reference" err
+	test_grep "unable to resolve reference" err
 '
=20
 test_expect_success 'create pseudoref' '
@@ -507,7 +507,7 @@ test_expect_success 'overwrite pseudoref with correct=
 old value' '
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
 	test $C =3D $(git rev-parse PSEUDOREF) &&
-	test_i18ngrep "cannot lock ref.*expected" err
+	test_grep "cannot lock ref.*expected" err
 '
=20
 test_expect_success 'delete pseudoref' '
@@ -519,7 +519,7 @@ test_expect_success 'do not delete pseudoref with wro=
ng old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
 	test $A =3D $(git rev-parse PSEUDOREF) &&
-	test_i18ngrep "cannot lock ref.*expected" err
+	test_grep "cannot lock ref.*expected" err
 '
=20
 test_expect_success 'delete pseudoref with correct old value' '
@@ -536,7 +536,7 @@ test_expect_success 'do not overwrite pseudoref with =
old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
 	test $A =3D $(git rev-parse PSEUDOREF) &&
-	test_i18ngrep "already exists" err
+	test_grep "already exists" err
 '
=20
 # Test --stdin
@@ -556,7 +556,7 @@ test_expect_success 'stdin test setup' '
=20
 test_expect_success '-z fails without --stdin' '
 	test_must_fail git update-ref -z $m $m $m 2>err &&
-	test_i18ngrep "usage: git update-ref" err
+	test_grep "usage: git update-ref" err
 '
=20
 test_expect_success 'stdin works with no input' '
@@ -674,7 +674,7 @@ test_expect_success 'stdin fails with duplicate refs'=
 '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed=
" err
+	test_grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" er=
r
 '
=20
 test_expect_success 'stdin create ref works' '
@@ -1107,7 +1107,7 @@ test_expect_success 'stdin -z fails option with unk=
nown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed=
" err
+	test_grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed" er=
r
 '
=20
 test_expect_success 'stdin -z create ref works' '
@@ -1338,7 +1338,7 @@ test_expect_success 'fails with duplicate HEAD upda=
te' '
 	update HEAD $B
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for '\''HEAD'\'' (including one =
via its referent .refs/heads/target1.) are not allowed" err &&
+	test_grep "fatal: multiple updates for '\''HEAD'\'' (including one via =
its referent .refs/heads/target1.) are not allowed" err &&
 	echo "refs/heads/target1" >expect &&
 	git symbolic-ref HEAD >actual &&
 	test_cmp expect actual &&
@@ -1355,7 +1355,7 @@ test_expect_success 'fails with duplicate ref updat=
e via symref' '
 	update refs/heads/symref2 $B
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	test_i18ngrep "fatal: multiple updates for '\''refs/heads/target2'\'' (=
including one via symref .refs/heads/symref2.) are not allowed" err &&
+	test_grep "fatal: multiple updates for '\''refs/heads/target2'\'' (incl=
uding one via symref .refs/heads/symref2.) are not allowed" err &&
 	echo "refs/heads/target2" >expect &&
 	git symbolic-ref refs/heads/symref2 >actual &&
 	test_cmp expect actual &&
diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 937ae0d733..0369beea33 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -29,7 +29,7 @@ test_update_rejected () {
 	fi &&
 	printf "create $prefix/%s $C\n" $create >input &&
 	test_must_fail git update-ref --stdin <input 2>output.err &&
-	test_i18ngrep -F "$error" output.err &&
+	test_grep -F "$error" output.err &&
 	git for-each-ref $prefix >actual &&
 	test_cmp unchanged actual
 }
@@ -613,7 +613,7 @@ test_expect_success REFFILES 'delete fails cleanly if=
 packed-refs file is locked
 	test_when_finished "rm -f .git/packed-refs.lock" &&
 	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
 	git for-each-ref $prefix >actual &&
-	test_i18ngrep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
+	test_grep "Unable to create $SQ.*packed-refs.lock$SQ: " err &&
 	test_cmp unchanged actual
 '
=20
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 6c45965b1e..e1fc949f9a 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -29,7 +29,7 @@ check_fsck () {
 	'')
 		test_must_be_empty fsck.output ;;
 	*)
-		test_i18ngrep "$1" fsck.output ;;
+		test_grep "$1" fsck.output ;;
 	esac
 }
=20
@@ -308,9 +308,9 @@ test_expect_success 'git reflog expire unknown refere=
nce' '
 	test_config gc.reflogexpireunreachable never &&
=20
 	test_must_fail git reflog expire main@{123} 2>stderr &&
-	test_i18ngrep "points nowhere" stderr &&
+	test_grep "points nowhere" stderr &&
 	test_must_fail git reflog expire does-not-exist 2>stderr &&
-	test_i18ngrep "points nowhere" stderr
+	test_grep "points nowhere" stderr
 '
=20
 test_expect_success 'checkout should not delete log for packed ref' '
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
index b32ca798f9..2092488090 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -37,7 +37,7 @@ test_expect_success 'hook aborts updating ref in prepar=
ed state' '
 		fi
 	EOF
 	test_must_fail git update-ref HEAD POST 2>err &&
-	test_i18ngrep "ref updates aborted by hook" err
+	test_grep "ref updates aborted by hook" err
 '
=20
 test_expect_success 'hook gets all queued updates in prepared state' '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index ff1c967d55..4da539cf50 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -47,7 +47,7 @@ test_expect_success 'git branch shows badly named ref a=
s warning' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main=
_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/broken...ref" &&
 	git branch >output 2>error &&
-	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.=
ref" error &&
+	test_grep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref"=
 error &&
 	! grep -e "broken\.\.\.ref" output
 '
=20
@@ -158,7 +158,7 @@ test_expect_success 'rev-parse skips symref pointing =
to broken name' '
 	git rev-parse --verify one >expect &&
 	git rev-parse --verify shadow >actual 2>err &&
 	test_cmp expect actual &&
-	test_i18ngrep "ignoring dangling symref refs/tags/shadow" err
+	test_grep "ignoring dangling symref refs/tags/shadow" err
 '
=20
 test_expect_success 'for-each-ref emits warnings for broken names' '
@@ -172,9 +172,9 @@ test_expect_success 'for-each-ref emits warnings for =
broken names' '
 	! grep -e "broken\.\.\.ref" output &&
 	! grep -e "badname" output &&
 	! grep -e "broken\.\.\.symref" output &&
-	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.ref=
" error &&
-	test_i18ngrep ! "ignoring broken ref refs/heads/badname" error &&
-	test_i18ngrep "ignoring ref with broken name refs/heads/broken\.\.\.sym=
ref" error
+	test_grep "ignoring ref with broken name refs/heads/broken\.\.\.ref" er=
ror &&
+	test_grep ! "ignoring broken ref refs/heads/badname" error &&
+	test_grep "ignoring ref with broken name refs/heads/broken\.\.\.symref"=
 error
 '
=20
 test_expect_success 'update-ref -d can delete broken name' '
@@ -192,7 +192,7 @@ test_expect_success 'branch -d can delete broken name=
' '
 	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main=
_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/broken...ref" &&
 	git branch -d broken...ref >output 2>error &&
-	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
+	test_grep "Deleted branch broken...ref (was broken)" output &&
 	test_must_be_empty error &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -218,7 +218,7 @@ test_expect_success 'branch -d can delete symref to b=
roken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
-	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)"=
 output &&
+	test_grep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" out=
put &&
 	test_must_be_empty error
 '
=20
@@ -236,7 +236,7 @@ test_expect_success 'branch -d can delete dangling sy=
mref to broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
 	test_path_is_missing .git/refs/heads/badname &&
-	test_i18ngrep "Deleted branch badname (was refs/heads/broken\.\.\.ref)"=
 output &&
+	test_grep "Deleted branch badname (was refs/heads/broken\.\.\.ref)" out=
put &&
 	test_must_be_empty error
 '
=20
@@ -265,7 +265,7 @@ test_expect_success 'branch -d can delete symref with=
 broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
-	test_i18ngrep "Deleted branch broken...symref (was refs/heads/main)" ou=
tput &&
+	test_grep "Deleted branch broken...symref (was refs/heads/main)" output=
 &&
 	test_must_be_empty error
 '
=20
@@ -283,7 +283,7 @@ test_expect_success 'branch -d can delete dangling sy=
mref with broken name' '
 	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF m=
sg refs/heads/broken...symref" &&
 	git branch -d broken...symref >output 2>error &&
 	test_path_is_missing .git/refs/heads/broken...symref &&
-	test_i18ngrep "Deleted branch broken...symref (was refs/heads/idonotexi=
st)" output &&
+	test_grep "Deleted branch broken...symref (was refs/heads/idonotexist)"=
 output &&
 	test_must_be_empty error
 '
=20
@@ -292,7 +292,7 @@ test_expect_success 'update-ref -d cannot delete non-=
ref in .git dir' '
 	echo precious >expect &&
 	test_must_fail git update-ref -d my-private-file >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep -e "refusing to update ref with bad name" error &&
+	test_grep -e "refusing to update ref with bad name" error &&
 	test_cmp expect .git/my-private-file
 '
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5805d47eb9..e2b30fb75e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -118,7 +118,7 @@ test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "not a commit" out
+	test_grep "not a commit" out
 '
=20
 test_expect_success 'HEAD link pointing at a funny object' '
@@ -127,7 +127,7 @@ test_expect_success 'HEAD link pointing at a funny ob=
ject' '
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
-	test_i18ngrep "detached HEAD points" out
+	test_grep "detached HEAD points" out
 '
=20
 test_expect_success 'HEAD link pointing at a funny place' '
@@ -136,7 +136,7 @@ test_expect_success 'HEAD link pointing at a funny pl=
ace' '
 	echo "ref: refs/funny/place" >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail env GIT_DIR=3D.git git fsck 2>out &&
-	test_i18ngrep "HEAD points to something strange" out
+	test_grep "HEAD points to something strange" out
 '
=20
 test_expect_success 'HEAD link pointing at a funny object (from differen=
t wt)' '
@@ -147,7 +147,7 @@ test_expect_success 'HEAD link pointing at a funny ob=
ject (from different wt)' '
 	echo $ZERO_OID >.git/HEAD &&
 	# avoid corrupt/broken HEAD from interfering with repo discovery
 	test_must_fail git -C wt fsck 2>out &&
-	test_i18ngrep "main-worktree/HEAD: detached HEAD points" out
+	test_grep "main-worktree/HEAD: detached HEAD points" out
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny object=
' '
@@ -155,7 +155,7 @@ test_expect_success 'other worktree HEAD link pointin=
g at a funny object' '
 	git worktree add other &&
 	echo $ZERO_OID >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "worktrees/other/HEAD: detached HEAD points" out
+	test_grep "worktrees/other/HEAD: detached HEAD points" out
 '
=20
 test_expect_success 'other worktree HEAD link pointing at missing object=
' '
@@ -163,7 +163,7 @@ test_expect_success 'other worktree HEAD link pointin=
g at missing object' '
 	git worktree add other &&
 	echo "Contents missing from repo" | git hash-object --stdin >.git/workt=
rees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "worktrees/other/HEAD: invalid sha1 pointer" out
+	test_grep "worktrees/other/HEAD: invalid sha1 pointer" out
 '
=20
 test_expect_success 'other worktree HEAD link pointing at a funny place'=
 '
@@ -171,7 +171,7 @@ test_expect_success 'other worktree HEAD link pointin=
g at a funny place' '
 	git worktree add other &&
 	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "worktrees/other/HEAD points to something strange" out
+	test_grep "worktrees/other/HEAD points to something strange" out
 '
=20
 test_expect_success 'commit with multiple signatures is okay' '
@@ -217,7 +217,7 @@ test_expect_success 'email with embedded > is not oka=
y' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new" out
+	test_grep "error in commit $new" out
 '
=20
 test_expect_success 'missing < email delimiter is reported nicely' '
@@ -228,7 +228,7 @@ test_expect_success 'missing < email delimiter is rep=
orted nicely' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new.* - bad name" out
+	test_grep "error in commit $new.* - bad name" out
 '
=20
 test_expect_success 'missing email is reported nicely' '
@@ -239,7 +239,7 @@ test_expect_success 'missing email is reported nicely=
' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new.* - missing email" out
+	test_grep "error in commit $new.* - missing email" out
 '
=20
 test_expect_success '> in name is reported' '
@@ -250,7 +250,7 @@ test_expect_success '> in name is reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new" out
+	test_grep "error in commit $new" out
 '
=20
 # date is 2^64 + 1
@@ -263,7 +263,7 @@ test_expect_success 'integer overflow in timestamps i=
s reported' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new.*integer overflow" out
+	test_grep "error in commit $new.*integer overflow" out
 '
=20
 test_expect_success 'commit with NUL in header' '
@@ -274,7 +274,7 @@ test_expect_success 'commit with NUL in header' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $new.*unterminated header: NUL at offset=
" out
+	test_grep "error in commit $new.*unterminated header: NUL at offset" ou=
t
 '
=20
 test_expect_success 'tree object with duplicate entries' '
@@ -295,7 +295,7 @@ test_expect_success 'tree object with duplicate entri=
es' '
 		git hash-object --literally -w -t tree --stdin
 	) &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in tree .*contains duplicate file entries" out
+	test_grep "error in tree .*contains duplicate file entries" out
 '
=20
 check_duplicate_names () {
@@ -318,8 +318,8 @@ check_duplicate_names () {
 		done >badtree &&
 		badtree=3D$(git mktree <badtree) &&
 		test_must_fail git fsck 2>out &&
-		test_i18ngrep "$badtree" out &&
-		test_i18ngrep "error in tree .*contains duplicate file entries" out
+		test_grep "$badtree" out &&
+		test_grep "error in tree .*contains duplicate file entries" out
 	'
 }
=20
@@ -341,9 +341,9 @@ test_expect_success 'unparseable tree object' '
 	commit_sha1=3D$(git commit-tree $tree_sha1) &&
 	git update-ref refs/heads/wrong $commit_sha1 &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error: empty filename in tree entry" out &&
-	test_i18ngrep "$tree_sha1" out &&
-	test_i18ngrep ! "fatal: empty filename in tree entry" out
+	test_grep "error: empty filename in tree entry" out &&
+	test_grep "$tree_sha1" out &&
+	test_grep ! "fatal: empty filename in tree entry" out
 '
=20
 test_expect_success 'tree entry with type mismatch' '
@@ -360,8 +360,8 @@ test_expect_success 'tree entry with type mismatch' '
 	commit=3D$(git commit-tree $tree) &&
 	git update-ref refs/heads/type_mismatch $commit &&
 	test_must_fail git fsck >out 2>&1 &&
-	test_i18ngrep "is a blob, not a tree" out &&
-	test_i18ngrep ! "dangling blob" out
+	test_grep "is a blob, not a tree" out &&
+	test_grep ! "dangling blob" out
 '
=20
 test_expect_success 'tree entry with bogus mode' '
@@ -394,7 +394,7 @@ test_expect_success 'tag pointing to nonexistent' '
 	echo $tag >.git/refs/tags/invalid &&
 	test_when_finished "git update-ref -d refs/tags/invalid" &&
 	test_must_fail git fsck --tags >out &&
-	test_i18ngrep "broken link" out
+	test_grep "broken link" out
 '
=20
 test_expect_success 'tag pointing to something else than its type' '
@@ -455,7 +455,7 @@ test_expect_success 'tag with bad tagger' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	test_i18ngrep "error in tag .*: invalid author/committer" out
+	test_grep "error in tag .*: invalid author/committer" out
 '
=20
 test_expect_success 'tag with NUL in header' '
@@ -474,7 +474,7 @@ test_expect_success 'tag with NUL in header' '
 	echo $tag >.git/refs/tags/wrong &&
 	test_when_finished "git update-ref -d refs/tags/wrong" &&
 	test_must_fail git fsck --tags 2>out &&
-	test_i18ngrep "error in tag $tag.*unterminated header: NUL at offset" o=
ut
+	test_grep "error in tag $tag.*unterminated header: NUL at offset" out
 '
=20
 test_expect_success 'cleaned up' '
@@ -504,7 +504,7 @@ test_expect_success 'rev-list --verify-objects with b=
ad sha1' '
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
=20
 	test_might_fail git rev-list --verify-objects refs/heads/bogus >/dev/nu=
ll 2>out &&
-	test_i18ngrep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)"=
 out
+	test_grep -q "error: hash mismatch $(dirname $new)$(test_oid ff_2)" out
 '
=20
 # An actual bit corruption is more likely than swapped commits, but
@@ -575,7 +575,7 @@ test_expect_success 'fsck notices blob entry pointing=
 to null sha1' '
 	 sha=3D$(printf "100644 file$_bz$_bzoid" |
 	       git hash-object --literally -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  test_i18ngrep "warning.*null sha1" out
+	  test_grep "warning.*null sha1" out
 	)
 '
=20
@@ -585,7 +585,7 @@ test_expect_success 'fsck notices submodule entry poi=
nting to null sha1' '
 	 sha=3D$(printf "160000 submodule$_bz$_bzoid" |
 	       git hash-object --literally -w --stdin -t tree) &&
 	  git fsck 2>out &&
-	  test_i18ngrep "warning.*null sha1" out
+	  test_grep "warning.*null sha1" out
 	)
 '
=20
@@ -606,7 +606,7 @@ while read name path pretty; do
 			printf "$mode $type %s\t%s" "$value" "$path" >bad &&
 			bad_tree=3D$(git mktree <bad) &&
 			git fsck 2>out &&
-			test_i18ngrep "warning.*tree $bad_tree" out
+			test_grep "warning.*tree $bad_tree" out
 		)'
 	done <<-\EOF
 	100644 blob
@@ -652,9 +652,9 @@ test_expect_success 'NUL in commit' '
 		git branch bad $(cat name) &&
=20
 		test_must_fail git -c fsck.nulInCommit=3Derror fsck 2>warn.1 &&
-		test_i18ngrep nulInCommit warn.1 &&
+		test_grep nulInCommit warn.1 &&
 		git fsck 2>warn.2 &&
-		test_i18ngrep nulInCommit warn.2
+		test_grep nulInCommit warn.2
 	)
 '
=20
@@ -774,7 +774,7 @@ test_expect_success 'fsck --name-objects' '
 		tree=3D$(git rev-parse --verify julius:) &&
 		git tag -d julius &&
 		test_must_fail git fsck --name-objects >out &&
-		test_i18ngrep "$tree (refs/tags/augustus44\\^:" out
+		test_grep "$tree (refs/tags/augustus44\\^:" out
 	)
 '
=20
@@ -787,7 +787,7 @@ test_expect_success 'alternate objects are correctly =
blamed' '
 	mkdir alt.git/objects/$(dirname $path) &&
 	>alt.git/objects/$(dirname $path)/$(basename $path) &&
 	test_must_fail git fsck >out 2>&1 &&
-	test_i18ngrep alt.git out
+	test_grep alt.git out
 '
=20
 test_expect_success 'fsck errors in packed objects' '
@@ -806,8 +806,8 @@ test_expect_success 'fsck errors in packed objects' '
 	remove_object $one &&
 	remove_object $two &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "error in commit $one.* - bad name" out &&
-	test_i18ngrep "error in commit $two.* - bad name" out &&
+	test_grep "error in commit $one.* - bad name" out &&
+	test_grep "error in commit $two.* - bad name" out &&
 	! grep corrupt out
 '
=20
@@ -824,7 +824,7 @@ test_expect_success 'fsck fails on corrupt packfile' =
'
 	test_when_finished "rm -f .git/objects/pack/pack-$pack.*" &&
 	remove_object $hsh &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "checksum mismatch" out
+	test_grep "checksum mismatch" out
 '
=20
 test_expect_success 'fsck finds problems in duplicate loose objects' '
@@ -861,7 +861,7 @@ test_expect_success 'fsck detects trailing loose garb=
age (commit)' '
 	chmod +w "$file" &&
 	echo garbage >>"$file" &&
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep "garbage.*$commit" out
+	test_grep "garbage.*$commit" out
 '
=20
 test_expect_success 'fsck detects trailing loose garbage (large blob)' '
@@ -871,7 +871,7 @@ test_expect_success 'fsck detects trailing loose garb=
age (large blob)' '
 	chmod +w "$file" &&
 	echo garbage >>"$file" &&
 	test_must_fail git -c core.bigfilethreshold=3D5 fsck 2>out &&
-	test_i18ngrep "garbage.*$blob" out
+	test_grep "garbage.*$blob" out
 '
=20
 test_expect_success 'fsck detects truncated loose object' '
@@ -887,10 +887,10 @@ test_expect_success 'fsck detects truncated loose o=
bject' '
=20
 	# check both regular and streaming code paths
 	test_must_fail git fsck 2>out &&
-	test_i18ngrep corrupt.*$blob out &&
+	test_grep corrupt.*$blob out &&
=20
 	test_must_fail git -c core.bigfilethreshold=3D128 fsck 2>out &&
-	test_i18ngrep corrupt.*$blob out
+	test_grep corrupt.*$blob out
 '
=20
 # for each of type, we have one version which is referenced by another o=
bject
@@ -979,7 +979,7 @@ test_expect_success 'detect corrupt index file in fsc=
k' '
 	test_when_finished "mv .git/index.backup .git/index" &&
 	corrupt_index_checksum &&
 	test_must_fail git fsck --cache 2>errors &&
-	test_i18ngrep "bad index file" errors
+	test_grep "bad index file" errors
 '
=20
 test_expect_success 'fsck error and recovery on invalid object type' '
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis=
.sh
index 18688cae17..ef40511d89 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -107,16 +107,16 @@ test_expect_success 'correct relative file objects =
(6)' '
=20
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
-	test_i18ngrep "invalid object name .foobar." error &&
+	test_grep "invalid object name .foobar." error &&
 	test_must_fail git rev-parse foobar 2>error &&
-	test_i18ngrep "unknown revision or path not in the working tree." error
+	test_grep "unknown revision or path not in the working tree." error
 '
=20
 test_expect_success 'incorrect file in sha1:path' '
 	test_must_fail git rev-parse HEAD:nothing.txt 2>error &&
-	test_i18ngrep "path .nothing.txt. does not exist in .HEAD." error &&
+	test_grep "path .nothing.txt. does not exist in .HEAD." error &&
 	test_must_fail git rev-parse HEAD:index-only.txt 2>error &&
-	test_i18ngrep "path .index-only.txt. exists on disk, but not in .HEAD."=
 error &&
+	test_grep "path .index-only.txt. exists on disk, but not in .HEAD." err=
or &&
 	(cd subdir &&
 	 test_must_fail git rev-parse HEAD:file2.txt 2>error &&
 	 test_did_you_mean HEAD subdir/ file2.txt exists )
@@ -124,9 +124,9 @@ test_expect_success 'incorrect file in sha1:path' '
=20
 test_expect_success 'incorrect file in :path and :N:path' '
 	test_must_fail git rev-parse :nothing.txt 2>error &&
-	test_i18ngrep "path .nothing.txt. does not exist (neither on disk nor i=
n the index)" error &&
+	test_grep "path .nothing.txt. does not exist (neither on disk nor in th=
e index)" error &&
 	test_must_fail git rev-parse :1:nothing.txt 2>error &&
-	test_i18ngrep "path .nothing.txt. does not exist (neither on disk nor i=
n the index)" error &&
+	test_grep "path .nothing.txt. does not exist (neither on disk nor in th=
e index)" error &&
 	test_must_fail git rev-parse :1:file.txt 2>error &&
 	test_did_you_mean ":0" "" file.txt "is in the index" "at stage 1" &&
 	(cd subdir &&
@@ -137,42 +137,42 @@ test_expect_success 'incorrect file in :path and :N=
:path' '
 	 test_must_fail git rev-parse :2:file2.txt 2>error &&
 	 test_did_you_mean :0 subdir/ file2.txt "is in the index") &&
 	test_must_fail git rev-parse :disk-only.txt 2>error &&
-	test_i18ngrep "path .disk-only.txt. exists on disk, but not in the inde=
x" error
+	test_grep "path .disk-only.txt. exists on disk, but not in the index" e=
rror
 '
=20
 test_expect_success 'invalid @{n} reference' '
 	test_must_fail git rev-parse main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
+	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error  &&
 	test_must_fail git rev-parse --verify main@{99999} >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep "log for [^ ]* only has [0-9][0-9]* entries" error
+	test_grep "log for [^ ]* only has [0-9][0-9]* entries" error
 '
=20
 test_expect_success 'relative path not found' '
 	(
 		cd subdir &&
 		test_must_fail git rev-parse HEAD:./nonexistent.txt 2>error &&
-		test_i18ngrep subdir/nonexistent.txt error
+		test_grep subdir/nonexistent.txt error
 	)
 '
=20
 test_expect_success 'relative path outside worktree' '
 	test_must_fail git rev-parse HEAD:../file.txt >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep "outside repository" error
+	test_grep "outside repository" error
 '
=20
 test_expect_success 'relative path when cwd is outside worktree' '
 	test_must_fail git --git-dir=3D.git --work-tree=3Dsubdir rev-parse HEAD=
:./file.txt >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep "relative path syntax can.t be used outside working tree"=
 error
+	test_grep "relative path syntax can.t be used outside working tree" err=
or
 '
=20
 test_expect_success '<commit>:file correctly diagnosed after a pathname'=
 '
 	test_must_fail git rev-parse file.txt HEAD:file.txt 1>actual 2>error &&
-	test_i18ngrep ! "exists on disk" error &&
-	test_i18ngrep "no such path in the working tree" error &&
+	test_grep ! "exists on disk" error &&
+	test_grep "no such path in the working tree" error &&
 	cat >expect <<-\EOF &&
 	file.txt
 	HEAD:file.txt
@@ -214,13 +214,13 @@ test_expect_success 'dotdot does not peel endpoints=
' '
=20
 test_expect_success 'arg before dashdash must be a revision (missing)' '
 	test_must_fail git rev-parse foobar -- 2>stderr &&
-	test_i18ngrep "bad revision" stderr
+	test_grep "bad revision" stderr
 '
=20
 test_expect_success 'arg before dashdash must be a revision (file)' '
 	>foobar &&
 	test_must_fail git rev-parse foobar -- 2>stderr &&
-	test_i18ngrep "bad revision" stderr
+	test_grep "bad revision" stderr
 '
=20
 test_expect_success 'arg before dashdash must be a revision (ambiguous)'=
 '
@@ -269,7 +269,7 @@ test_expect_success 'arg after dashdash not interpret=
ed as option' '
=20
 test_expect_success 'arg after end-of-options not interpreted as option'=
 '
 	test_must_fail git rev-parse --end-of-options --not-real -- 2>err &&
-	test_i18ngrep bad.revision.*--not-real err
+	test_grep bad.revision.*--not-real err
 '
=20
 test_expect_success 'end-of-options still allows --' '
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disa=
mbiguation.sh
index 98cefe3b70..70f1e0a998 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -129,7 +129,7 @@ test_expect_success 'blob and tree' '
=20
 test_expect_success 'warn ambiguity when no candidate matches type hint'=
 '
 	test_must_fail git rev-parse --verify 000000000^{commit} 2>actual &&
-	test_i18ngrep "short object ID 000000000 is ambiguous" actual
+	test_grep "short object ID 000000000 is ambiguous" actual
 '
=20
 test_expect_success 'disambiguate tree-ish' '
@@ -470,10 +470,10 @@ test_expect_success 'cat-file --batch and --batch-c=
heck show ambiguous' '
 	echo "0000 ambiguous" >expect &&
 	echo 0000 | git cat-file --batch-check >actual 2>err &&
 	test_cmp expect actual &&
-	test_i18ngrep hint: err &&
+	test_grep hint: err &&
 	echo 0000 | git cat-file --batch >actual 2>err &&
 	test_cmp expect actual &&
-	test_i18ngrep hint: err
+	test_grep hint: err
 '
=20
 test_done
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp=
.sh
index b16d69ca4a..4c0fd856b3 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -93,7 +93,7 @@ test_expect_success 'checkout all stages of unknown pat=
h' '
 	rm -f path* .merge_* actual &&
 	test_must_fail git checkout-index --stage=3Dall --temp \
 		-- does-not-exist 2>stderr &&
-	test_i18ngrep not.in.the.cache stderr
+	test_grep not.in.the.cache stderr
 '
=20
 test_expect_success 'checkout all stages/one file to nothing' '
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-bas=
ic.sh
index 5d119871d4..570ba38580 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -8,7 +8,7 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
=20
 test_expect_success 'checkout-index --gobbledegook' '
 	test_expect_code 129 git checkout-index --gobbledegook 2>err &&
-	test_i18ngrep "[Uu]sage" err
+	test_grep "[Uu]sage" err
 '
=20
 test_expect_success 'checkout-index -h in broken repository' '
@@ -19,18 +19,18 @@ test_expect_success 'checkout-index -h in broken repo=
sitory' '
 		>.git/index &&
 		test_expect_code 129 git checkout-index -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage" broken/usage
+	test_grep "[Uu]sage" broken/usage
 '
=20
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
-	test_i18ngrep not.in.the.cache stderr
+	test_grep not.in.the.cache stderr
 '
=20
 test_expect_success 'checkout-index reports errors (stdin)' '
 	echo does-not-exist |
 	test_must_fail git checkout-index --stdin 2>stderr &&
-	test_i18ngrep not.in.the.cache stderr
+	test_grep not.in.the.cache stderr
 '
 for mode in 'case' 'utf-8'
 do
@@ -88,8 +88,8 @@ test_expect_success 'checkout-index --temp correctly re=
ports error on missing bl
 	git update-index --index-info <objs &&
=20
 	test_must_fail git checkout-index --temp symlink file 2>stderr &&
-	test_i18ngrep "unable to read sha1 file of file ($missing_blob)" stderr=
 &&
-	test_i18ngrep "unable to read sha1 file of symlink ($missing_blob)" std=
err
+	test_grep "unable to read sha1 file of file ($missing_blob)" stderr &&
+	test_grep "unable to read sha1 file of symlink ($missing_blob)" stderr
 '
=20
 test_expect_success 'checkout-index --temp correctly reports error for s=
ubmodules' '
@@ -98,7 +98,7 @@ test_expect_success 'checkout-index --temp correctly re=
ports error for submodule
 	git submodule add ./sub &&
 	git commit -m sub &&
 	test_must_fail git checkout-index --temp sub 2>stderr &&
-	test_i18ngrep "cannot create temporary submodule sub" stderr
+	test_grep "cannot create temporary submodule sub" stderr
 '
=20
 test_done
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.s=
h
index 9d4b37526a..82c3bfeac1 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -62,8 +62,8 @@ test_expect_success 'disambiguate checking out from a t=
ree-ish' '
=20
 test_expect_success 'accurate error message with more than one ref' '
 	test_must_fail git checkout HEAD main -- 2>actual &&
-	test_i18ngrep 2 actual &&
-	test_i18ngrep "one reference expected, 2 given" actual
+	test_grep 2 actual &&
+	test_grep "one reference expected, 2 given" actual
 '
=20
 test_done
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 8581ad3437..43551cc148 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -278,12 +278,12 @@ test_expect_success 'checkout -b to a new branch pr=
eserves mergeable changes des
=20
 test_expect_success 'checkout -b rejects an invalid start point' '
 	test_must_fail git checkout -b branch4 file1 2>err &&
-	test_i18ngrep "is not a commit" err
+	test_grep "is not a commit" err
 '
=20
 test_expect_success 'checkout -b rejects an extra path argument' '
 	test_must_fail git checkout -b branch5 branch1 file1 2>err &&
-	test_i18ngrep "Cannot update paths and switch to branch" err
+	test_grep "Cannot update paths and switch to branch" err
 '
=20
 test_done
diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguo=
us-ref.sh
index 9540588664..c67261e2b6 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -32,8 +32,8 @@ test_expect_success 'checkout chooses branch over tag' =
'
 '
=20
 test_expect_success 'checkout reports switch to branch' '
-	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	test_grep "Switched to branch" stderr &&
+	test_grep ! "^HEAD is now at" stderr
 '
=20
 test_expect_success 'checkout vague ref succeeds' '
@@ -54,8 +54,8 @@ test_expect_success VAGUENESS_SUCCESS 'checkout chooses=
 branch over tag' '
 '
=20
 test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to branch=
' '
-	test_i18ngrep "Switched to branch" stderr &&
-	test_i18ngrep ! "^HEAD is now at" stderr
+	test_grep "Switched to branch" stderr &&
+	test_grep ! "^HEAD is now at" stderr
 '
=20
 test_done
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 2eab6474f8..8202ef8c74 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -17,12 +17,12 @@ check_not_detached () {
=20
 PREV_HEAD_DESC=3D'Previous HEAD position was'
 check_orphan_warning() {
-	test_i18ngrep "you are leaving $2 behind" "$1" &&
-	test_i18ngrep ! "$PREV_HEAD_DESC" "$1"
+	test_grep "you are leaving $2 behind" "$1" &&
+	test_grep ! "$PREV_HEAD_DESC" "$1"
 }
 check_no_orphan_warning() {
-	test_i18ngrep ! "you are leaving .* commit.*behind" "$1" &&
-	test_i18ngrep "$PREV_HEAD_DESC" "$1"
+	test_grep ! "you are leaving .* commit.*behind" "$1" &&
+	test_grep "$PREV_HEAD_DESC" "$1"
 }
=20
 reset () {
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 74049a9812..a97416ce65 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -93,7 +93,7 @@ test_expect_success 'when arg matches multiple remotes,=
 do not fallback to inter
=20
 	test_must_fail git checkout ambiguous_branch_and_file 2>err &&
=20
-	test_i18ngrep "matched multiple (2) remote tracking branches" err &&
+	test_grep "matched multiple (2) remote tracking branches" err &&
=20
 	# file must not be altered
 	test_cmp expect ambiguous_branch_and_file
@@ -105,12 +105,12 @@ test_expect_success 'checkout of branch from multip=
le remotes fails with advice'
 	test_must_fail git checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
-	test_i18ngrep "^hint: " stderr &&
+	test_grep "^hint: " stderr &&
 	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=3Dfalse =
\
 		checkout foo 2>stderr &&
 	test_branch main &&
 	status_uno_is_clean &&
-	test_i18ngrep ! "^hint: " stderr
+	test_grep ! "^hint: " stderr
 '
=20
 test_expect_success PERL 'checkout -p with multiple remotes does not pri=
nt advice' '
@@ -118,7 +118,7 @@ test_expect_success PERL 'checkout -p with multiple r=
emotes does not print advic
 	test_might_fail git branch -D foo &&
=20
 	git checkout -p foo 2>stderr &&
-	test_i18ngrep ! "^hint: " stderr &&
+	test_grep ! "^hint: " stderr &&
 	status_uno_is_clean
 '
=20
diff --git a/t/t2025-checkout-no-overlay.sh b/t/t2025-checkout-no-overlay=
.sh
index 3832c3de81..246609d54d 100755
--- a/t/t2025-checkout-no-overlay.sh
+++ b/t/t2025-checkout-no-overlay.sh
@@ -26,7 +26,7 @@ test_expect_success 'checkout --no-overlay removing las=
t file from directory' '
=20
 test_expect_success 'checkout -p --overlay is disallowed' '
 	test_must_fail git checkout -p --overlay HEAD 2>actual &&
-	test_i18ngrep "fatal: options .-p. and .--overlay. cannot be used toget=
her" actual
+	test_grep "fatal: options .-p. and .--overlay. cannot be used together"=
 actual
 '
=20
 test_expect_success '--no-overlay --theirs with D/F conflict deletes fil=
e' '
diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspe=
c-file.sh
index 9c651aefbc..acd55217a6 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -149,16 +149,16 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
=20
 	test_must_fail git checkout --pathspec-from-file=3Dlist --detach 2>err =
&&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--detach. cannot =
be used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--detach. cannot be u=
sed together" err &&
=20
 	test_must_fail git checkout --pathspec-from-file=3Dlist --patch 2>err &=
&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot b=
e used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--patch. cannot be us=
ed together" err &&
=20
 	test_must_fail git checkout --pathspec-from-file=3Dlist -- fileA.t 2>er=
r &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git checkout --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err
 '
=20
 test_done
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index a8bbc60954..98f16c7239 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -22,7 +22,7 @@ test_expect_success 'checkout --track -b creates a new =
tracking branch' '
=20
 test_expect_success 'checkout --track -b rejects an extra path argument'=
 '
 	test_must_fail git checkout --track -b branch2 main one.t 2>err &&
-	test_i18ngrep "cannot be used with updating paths" err
+	test_grep "cannot be used with updating paths" err
 '
=20
 test_expect_success 'checkout --track -b overrides autoSetupMerge=3Dinhe=
rit' '
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 2d8c70b03a..102023ed57 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -191,7 +191,7 @@ test_expect_success 'rerere forget (add-add conflict)=
' '
 	git commit -m "add differently" &&
 	test_must_fail git merge fifth &&
 	git rerere forget add-differently 2>actual &&
-	test_i18ngrep "no remembered" actual
+	test_grep "no remembered" actual
 '
=20
 test_expect_success 'resolve-undo keeps blobs from gc' '
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-=
file.sh
index c22669b39f..8198a1e578 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -152,16 +152,16 @@ test_expect_success 'error conditions' '
 	>empty_list &&
=20
 	test_must_fail git restore --pathspec-from-file=3Dlist --patch --source=
=3DHEAD^1 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot b=
e used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--patch. cannot be us=
ed together" err &&
=20
 	test_must_fail git restore --pathspec-from-file=3Dlist --source=3DHEAD^=
1 -- fileA.t 2>err &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git restore --pathspec-file-nul --source=3DHEAD^1 2>err =
&&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err &&
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err &&
=20
 	test_must_fail git restore --pathspec-from-file=3Dempty_list --source=3D=
HEAD^1 2>err &&
-	test_i18ngrep -e "you must specify path(s) to restore" err
+	test_grep -e "you must specify path(s) to restore" err
 '
=20
 test_expect_success 'wildcard pathspec matches file in subdirectory' '
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-in=
dex-assume-unchanged.sh
index d943ddf47e..95c004dc5c 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -22,7 +22,7 @@ test_expect_success 'do not switch branches with dirty =
file' '
 	echo dirt >file &&
 	git update-index --assume-unchanged file &&
 	test_must_fail git checkout - 2>err &&
-	test_i18ngrep overwritten err
+	test_grep overwritten err
 '
=20
 test_done
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.s=
h
index 89b285fa3a..3d7ca5792e 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -14,7 +14,7 @@ test_expect_success 'update-index --nonsense fails' '
=20
 test_expect_success 'update-index --nonsense dumps usage' '
 	test_expect_code 129 git update-index --nonsense 2>err &&
-	test_i18ngrep "[Uu]sage: git update-index" err
+	test_grep "[Uu]sage: git update-index" err
 '
=20
 test_expect_success 'update-index -h with corrupt index' '
@@ -25,7 +25,7 @@ test_expect_success 'update-index -h with corrupt index=
' '
 		>.git/index &&
 		test_expect_code 129 git update-index -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage: git update-index" broken/usage
+	test_grep "[Uu]sage: git update-index" broken/usage
 '
=20
 test_expect_success '--cacheinfo complains of missing arguments' '
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index ebf58db2d1..8fa44a92a2 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -173,7 +173,7 @@ test_expect_success 'rename detection finds the right=
 names' '
 		git add -N third &&
=20
 		git status | grep -v "^?" >actual.1 &&
-		test_i18ngrep "renamed: *first -> third" actual.1 &&
+		test_grep "renamed: *first -> third" actual.1 &&
=20
 		git status --porcelain | grep -v "^?" >actual.2 &&
 		cat >expected.2 <<-\EOF &&
@@ -213,8 +213,8 @@ test_expect_success 'double rename detection in statu=
s' '
 		git add -N third &&
=20
 		git status | grep -v "^?" >actual.1 &&
-		test_i18ngrep "renamed: *first -> second" actual.1 &&
-		test_i18ngrep "renamed: *second -> third" actual.1 &&
+		test_grep "renamed: *first -> second" actual.1 &&
+		test_grep "renamed: *second -> third" actual.1 &&
=20
 		git status --porcelain | grep -v "^?" >actual.2 &&
 		cat >expected.2 <<-\EOF &&
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 89424abccd..b7cf1e492c 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -36,7 +36,7 @@ do
 	'
=20
 	test_expect_success "complaints for ignored $i output" '
-		test_i18ngrep -e "Use -f if" err
+		test_grep -e "Use -f if" err
 	'
=20
 	test_expect_success "complaints for ignored $i with unignored file" '
@@ -46,7 +46,7 @@ do
 		test_must_be_empty out
 	'
 	test_expect_success "complaints for ignored $i with unignored file outp=
ut" '
-		test_i18ngrep -e "Use -f if" err
+		test_grep -e "Use -f if" err
 	'
 done
=20
@@ -65,7 +65,7 @@ do
 	test_expect_success "complaints for ignored $i in dir output" '
 		(
 			cd dir &&
-			test_i18ngrep -e "Use -f if" err
+			test_grep -e "Use -f if" err
 		)
 	'
 done
@@ -85,7 +85,7 @@ do
 	test_expect_success "complaints for ignored $i in sub output" '
 		(
 			cd sub &&
-			test_i18ngrep -e "Use -f if" err
+			test_grep -e "Use -f if" err
 		)
 	'
 done
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index 568a47ec42..71aa9bcd62 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -47,7 +47,7 @@ test_expect_success SANITY 'prune directories with unre=
adable gitdir' '
 	: >.git/worktrees/def/gitdir &&
 	chmod u-r .git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
-	test_i18ngrep "Removing worktrees/def: unable to read gitdir file" actu=
al &&
+	test_grep "Removing worktrees/def: unable to read gitdir file" actual &=
&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
 '
@@ -57,7 +57,7 @@ test_expect_success 'prune directories with invalid git=
dir' '
 	: >.git/worktrees/def/def &&
 	: >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
-	test_i18ngrep "Removing worktrees/def: invalid gitdir file" actual &&
+	test_grep "Removing worktrees/def: invalid gitdir file" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
 '
@@ -67,7 +67,7 @@ test_expect_success 'prune directories with gitdir poin=
ting to nowhere' '
 	: >.git/worktrees/def/def &&
 	echo "$(pwd)"/nowhere >.git/worktrees/def/gitdir &&
 	git worktree prune --verbose 2>actual &&
-	test_i18ngrep "Removing worktrees/def: gitdir file points to non-existe=
nt location" actual &&
+	test_grep "Removing worktrees/def: gitdir file points to non-existent l=
ocation" actual &&
 	! test -d .git/worktrees/def &&
 	! test -d .git/worktrees
 '
@@ -103,7 +103,7 @@ test_expect_success 'prune duplicate (linked/linked)'=
 '
 	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &=
&
 	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
 	git worktree prune --verbose 2>actual &&
-	test_i18ngrep "duplicate entry" actual &&
+	test_grep "duplicate entry" actual &&
 	test -d .git/worktrees/w1 &&
 	! test -d .git/worktrees/w2
 '
@@ -116,7 +116,7 @@ test_expect_success 'prune duplicate (main/linked)' '
 	rm -fr wt &&
 	mv repo wt &&
 	git -C wt worktree prune --verbose 2>actual &&
-	test_i18ngrep "duplicate entry" actual &&
+	test_grep "duplicate entry" actual &&
 	! test -d .git/worktrees/wt
 '
=20
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 9ad9be0c20..33ea9cb21b 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -143,7 +143,7 @@ test_expect_success '"list" all worktrees --porcelain=
 with prunable' '
 	rm -rf prunable &&
 	git worktree list --porcelain >out &&
 	sed -n "/^worktree .*\/prunable$/,/^$/p" <out >only_prunable &&
-	test_i18ngrep "^prunable gitdir file points to non-existent location$" =
only_prunable
+	test_grep "^prunable gitdir file points to non-existent location$" only=
_prunable
 '
=20
 test_expect_success '"list" all worktrees with prunable consistent with =
"prune"' '
@@ -155,8 +155,8 @@ test_expect_success '"list" all worktrees with prunab=
le consistent with "prune"'
 	grep "/prunable  *[0-9a-f].* prunable$" out &&
 	! grep "/unprunable  *[0-9a-f].* unprunable$" out &&
 	git worktree prune --verbose 2>out &&
-	test_i18ngrep "^Removing worktrees/prunable" out &&
-	test_i18ngrep ! "^Removing worktrees/unprunable" out
+	test_grep "^Removing worktrees/prunable" out &&
+	test_grep ! "^Removing worktrees/unprunable" out
 '
=20
 test_expect_success '"list" --verbose and --porcelain mutually exclusive=
' '
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 230a55e99a..901342ea09 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -202,7 +202,7 @@ test_expect_success 'proper error when worktree not f=
ound' '
 	for i in noodle noodle/bork
 	do
 		test_must_fail git worktree lock $i 2>err &&
-		test_i18ngrep "not a working tree" err || return 1
+		test_grep "not a working tree" err || return 1
 	done
 '
=20
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index 8970780efc..edbf502ec5 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -25,7 +25,7 @@ test_expect_success 'worktree path not directory' '
 	>notdir &&
 	test_must_fail git worktree repair >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep "not a directory" err
+	test_grep "not a directory" err
 '
=20
 test_expect_success "don't clobber .git repo" '
@@ -35,7 +35,7 @@ test_expect_success "don't clobber .git repo" '
 	test_create_repo repo &&
 	test_must_fail git worktree repair >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep ".git is not a file" err
+	test_grep ".git is not a file" err
 '
=20
 test_corrupt_gitfile () {
@@ -47,7 +47,7 @@ test_corrupt_gitfile () {
 	git -C corrupt rev-parse --absolute-git-dir >expect &&
 	eval "$butcher" &&
 	git -C "$repairdir" worktree repair 2>err &&
-	test_i18ngrep "$problem" err &&
+	test_grep "$problem" err &&
 	git -C corrupt rev-parse --absolute-git-dir >actual &&
 	test_cmp expect actual
 }
@@ -93,7 +93,7 @@ test_expect_success 'repair .git file from bare.git' '
 test_expect_success 'invalid worktree path' '
 	test_must_fail git worktree repair /notvalid >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep "not a valid path" err
+	test_grep "not a valid path" err
 '
=20
 test_expect_success 'repo not found; .git not file' '
@@ -101,7 +101,7 @@ test_expect_success 'repo not found; .git not file' '
 	test_create_repo not-a-worktree &&
 	test_must_fail git worktree repair not-a-worktree >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep ".git is not a file" err
+	test_grep ".git is not a file" err
 '
=20
 test_expect_success 'repo not found; .git not referencing repo' '
@@ -111,7 +111,7 @@ test_expect_success 'repo not found; .git not referen=
cing repo' '
 	mv side/.newgit side/.git &&
 	mkdir not-a-repo &&
 	test_must_fail git worktree repair side 2>err &&
-	test_i18ngrep ".git file does not reference a repository" err
+	test_grep ".git file does not reference a repository" err
 '
=20
 test_expect_success 'repo not found; .git file broken' '
@@ -121,7 +121,7 @@ test_expect_success 'repo not found; .git file broken=
' '
 	mv orig moved &&
 	test_must_fail git worktree repair moved >out 2>err &&
 	test_must_be_empty out &&
-	test_i18ngrep ".git file broken" err
+	test_grep ".git file broken" err
 '
=20
 test_expect_success 'repair broken gitdir' '
@@ -132,7 +132,7 @@ test_expect_success 'repair broken gitdir' '
 	mv orig moved &&
 	git worktree repair moved 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir unreadable" err
+	test_grep "gitdir unreadable" err
 '
=20
 test_expect_success 'repair incorrect gitdir' '
@@ -142,7 +142,7 @@ test_expect_success 'repair incorrect gitdir' '
 	mv orig moved &&
 	git worktree repair moved 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir incorrect" err
+	test_grep "gitdir incorrect" err
 '
=20
 test_expect_success 'repair gitdir (implicit) from linked worktree' '
@@ -152,7 +152,7 @@ test_expect_success 'repair gitdir (implicit) from li=
nked worktree' '
 	mv orig moved &&
 	git -C moved worktree repair 2>err &&
 	test_cmp expect .git/worktrees/orig/gitdir &&
-	test_i18ngrep "gitdir incorrect" err
+	test_grep "gitdir incorrect" err
 '
=20
 test_expect_success 'unable to repair gitdir (implicit) from main worktr=
ee' '
@@ -177,8 +177,8 @@ test_expect_success 'repair multiple gitdir files' '
 	git worktree repair moved1 moved2 2>err &&
 	test_cmp expect1 .git/worktrees/orig1/gitdir &&
 	test_cmp expect2 .git/worktrees/orig2/gitdir &&
-	test_i18ngrep "gitdir incorrect:.*orig1/gitdir$" err &&
-	test_i18ngrep "gitdir incorrect:.*orig2/gitdir$" err
+	test_grep "gitdir incorrect:.*orig1/gitdir$" err &&
+	test_grep "gitdir incorrect:.*orig2/gitdir$" err
 '
=20
 test_expect_success 'repair moved main and linked worktrees' '
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index a16e25c79b..12e41a7b40 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -21,7 +21,7 @@ test_expect_success 'ls-files with nonexistent path' '
=20
 test_expect_success 'ls-files with nonsense option' '
 	test_expect_code 129 git ls-files --nonsense 2>actual &&
-	test_i18ngrep "[Uu]sage: git ls-files" actual
+	test_grep "[Uu]sage: git ls-files" actual
 '
=20
 test_expect_success 'ls-files -h in corrupt repository' '
@@ -32,7 +32,7 @@ test_expect_success 'ls-files -h in corrupt repository'=
 '
 		>.git/index &&
 		test_expect_code 129 git ls-files -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage: git ls-files " broken/usage
+	test_grep "[Uu]sage: git ls-files " broken/usage
 '
=20
 test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' =
'
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-re=
curse-submodules.sh
index 7308a3d4e2..61771eec83 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -296,7 +296,7 @@ test_expect_success '--recurse-submodules and relativ=
e paths' '
=20
 test_expect_success '--recurse-submodules does not support --error-unmat=
ch' '
 	test_must_fail git ls-files --recurse-submodules --error-unmatch 2>actu=
al &&
-	test_i18ngrep "does not support --error-unmatch" actual
+	test_grep "does not support --error-unmatch" actual
 '
=20
 test_expect_success '--recurse-submodules parses submodule repo config' =
'
@@ -335,7 +335,7 @@ test_expect_success '--recurse-submodules submodules =
ignore super project worktr
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
-		test_i18ngrep 'unsupported mode' actual
+		test_grep 'unsupported mode' actual
 	"
 }
=20
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index daf1666df7..649d9dcba5 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -36,7 +36,7 @@ test_expect_success 'branch -h in broken repository' '
 		>.git/refs/heads/main &&
 		test_expect_code 129 git branch -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage" broken/usage
+	test_grep "[Uu]sage" broken/usage
 '
=20
 test_expect_success 'git branch abc should create a branch' '
@@ -103,7 +103,7 @@ test_expect_success 'git branch l should work after b=
ranch l/m has been deleted'
=20
 test_expect_success 'git branch -m dumps usage' '
 	test_expect_code 128 git branch -m 2>err &&
-	test_i18ngrep "branch name required" err
+	test_grep "branch name required" err
 '
=20
 test_expect_success 'git branch -m m broken_symref should work' '
@@ -581,12 +581,12 @@ EOF
=20
 test_expect_success 'git branch -c dumps usage' '
 	test_expect_code 128 git branch -c 2>err &&
-	test_i18ngrep "branch name required" err
+	test_grep "branch name required" err
 '
=20
 test_expect_success 'git branch --copy dumps usage' '
 	test_expect_code 128 git branch --copy 2>err &&
-	test_i18ngrep "branch name required" err
+	test_grep "branch name required" err
 '
=20
 test_expect_success 'git branch -c d e should work' '
@@ -1025,7 +1025,7 @@ test_expect_success '--set-upstream-to fails on a m=
issing dst branch' '
=20
 test_expect_success '--set-upstream-to fails on a missing src branch' '
 	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &=
&
-	test_i18ngrep "the requested upstream branch '"'"'does-not-exist'"'"' d=
oes not exist" err
+	test_grep "the requested upstream branch '"'"'does-not-exist'"'"' does =
not exist" err
 '
=20
 test_expect_success '--set-upstream-to fails on a non-ref' '
@@ -1039,7 +1039,7 @@ test_expect_success '--set-upstream-to fails on loc=
ked config' '
 	>.git/config.lock &&
 	git branch locked &&
 	test_must_fail git branch --set-upstream-to locked 2>err &&
-	test_i18ngrep "could not lock config file .git/config" err
+	test_grep "could not lock config file .git/config" err
 '
=20
 test_expect_success 'use --set-upstream-to modify HEAD' '
@@ -1070,7 +1070,7 @@ test_expect_success '--unset-upstream should fail i=
f config is locked' '
 	git branch --set-upstream-to locked &&
 	>.git/config.lock &&
 	test_must_fail git branch --unset-upstream 2>err &&
-	test_i18ngrep "could not lock config file .git/config" err
+	test_grep "could not lock config file .git/config" err
 '
=20
 test_expect_success 'test --unset-upstream on HEAD' '
@@ -1506,7 +1506,7 @@ test_expect_success '--list during rebase' '
 	set_fake_editor &&
 	git rebase -i HEAD~2 &&
 	git branch --list >actual &&
-	test_i18ngrep "rebasing main" actual
+	test_grep "rebasing main" actual
 '
=20
 test_expect_success '--list during rebase from detached HEAD' '
@@ -1518,7 +1518,7 @@ test_expect_success '--list during rebase from deta=
ched HEAD' '
 	set_fake_editor &&
 	git rebase -i HEAD~2 &&
 	git branch --list >actual &&
-	test_i18ngrep "rebasing detached HEAD $oid" actual
+	test_grep "rebasing detached HEAD $oid" actual
 '
=20
 test_expect_success 'tracking with unexpected .fetch refspec' '
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index b17f388f56..235c68fb02 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -253,7 +253,7 @@ test_expect_success 'error descriptions on orphan bra=
nch' '
 	test_branch_op_in_wt() {
 		test_orphan_error() {
 			test_must_fail git $* 2>actual &&
-			test_i18ngrep "No commit on branch .orphan-branch. yet.$" actual
+			test_grep "No commit on branch .orphan-branch. yet.$" actual
 		} &&
 		test_orphan_error -C wt branch $1 $2 &&                # implicit bran=
ch
 		test_orphan_error -C wt branch $1 orphan-branch $2 &&  # explicit bran=
ch
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index b5f4d6a653..cfeb8c84b0 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -195,7 +195,7 @@ test_expect_success 'A^! and A^-<n> (unmodified)' '
=20
 test_expect_success 'A^{/..} is not mistaken for a range' '
 	test_must_fail git range-diff topic^.. topic^{/..} -- 2>error &&
-	test_i18ngrep "not a commit range" error
+	test_grep "not a commit range" error
 '
=20
 test_expect_success 'trivial reordering' '
@@ -537,7 +537,7 @@ do
 			main..unmodified >actual &&
 		test_when_finished "rm 000?-*" &&
 		test_line_count =3D 5 actual &&
-		test_i18ngrep "^Range-diff:$" 0000-* &&
+		test_grep "^Range-diff:$" 0000-* &&
 		grep "=3D 1: .* s/5/A" 0000-* &&
 		grep "=3D 2: .* s/4/A" 0000-* &&
 		grep "=3D 3: .* s/11/B" 0000-* &&
@@ -549,7 +549,7 @@ test_expect_success 'format-patch --range-diff as com=
mentary' '
 	git format-patch --range-diff=3DHEAD~1 HEAD~1 >actual &&
 	test_when_finished "rm 0001-*" &&
 	test_line_count =3D 1 actual &&
-	test_i18ngrep "^Range-diff:$" 0001-* &&
+	test_grep "^Range-diff:$" 0001-* &&
 	grep "> 1: .* new message" 0001-*
 '
=20
@@ -557,7 +557,7 @@ test_expect_success 'format-patch --range-diff reroll=
-count with a non-integer'
 	git format-patch --range-diff=3DHEAD~1 -v2.9 HEAD~1 >actual &&
 	test_when_finished "rm v2.9-0001-*" &&
 	test_line_count =3D 1 actual &&
-	test_i18ngrep "^Range-diff:$" v2.9-0001-* &&
+	test_grep "^Range-diff:$" v2.9-0001-* &&
 	grep "> 1: .* new message" v2.9-0001-*
 '
=20
@@ -565,7 +565,7 @@ test_expect_success 'format-patch --range-diff reroll=
-count with a integer' '
 	git format-patch --range-diff=3DHEAD~1 -v2 HEAD~1 >actual &&
 	test_when_finished "rm v2-0001-*" &&
 	test_line_count =3D 1 actual &&
-	test_i18ngrep "^Range-diff ..* v1:$" v2-0001-* &&
+	test_grep "^Range-diff ..* v1:$" v2-0001-* &&
 	grep "> 1: .* new message" v2-0001-*
 '
=20
@@ -573,7 +573,7 @@ test_expect_success 'format-patch --range-diff with v=
0' '
 	git format-patch --range-diff=3DHEAD~1 -v0 HEAD~1 >actual &&
 	test_when_finished "rm v0-0001-*" &&
 	test_line_count =3D 1 actual &&
-	test_i18ngrep "^Range-diff:$" v0-0001-* &&
+	test_grep "^Range-diff:$" v0-0001-* &&
 	grep "> 1: .* new message" v0-0001-*
 '
=20
@@ -670,7 +670,7 @@ test_expect_success 'format-patch --range-diff does n=
ot compare notes by default
 		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count =3D 5 actual &&
-	test_i18ngrep "^Range-diff:$" 0000-* &&
+	test_grep "^Range-diff:$" 0000-* &&
 	grep "=3D 1: .* s/5/A" 0000-* &&
 	grep "=3D 2: .* s/4/A" 0000-* &&
 	grep "=3D 3: .* s/11/B" 0000-* &&
@@ -687,7 +687,7 @@ test_expect_success 'format-patch --range-diff with -=
-no-notes' '
 		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count =3D 5 actual &&
-	test_i18ngrep "^Range-diff:$" 0000-* &&
+	test_grep "^Range-diff:$" 0000-* &&
 	grep "=3D 1: .* s/5/A" 0000-* &&
 	grep "=3D 2: .* s/4/A" 0000-* &&
 	grep "=3D 3: .* s/11/B" 0000-* &&
@@ -704,7 +704,7 @@ test_expect_success 'format-patch --range-diff with -=
-notes' '
 		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count =3D 5 actual &&
-	test_i18ngrep "^Range-diff:$" 0000-* &&
+	test_grep "^Range-diff:$" 0000-* &&
 	grep "=3D 1: .* s/5/A" 0000-* &&
 	grep "=3D 2: .* s/4/A" 0000-* &&
 	grep "=3D 3: .* s/11/B" 0000-* &&
@@ -733,7 +733,7 @@ test_expect_success 'format-patch --range-diff with f=
ormat.notes config' '
 		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count =3D 5 actual &&
-	test_i18ngrep "^Range-diff:$" 0000-* &&
+	test_grep "^Range-diff:$" 0000-* &&
 	grep "=3D 1: .* s/5/A" 0000-* &&
 	grep "=3D 2: .* s/4/A" 0000-* &&
 	grep "=3D 3: .* s/11/B" 0000-* &&
@@ -764,7 +764,7 @@ test_expect_success 'format-patch --range-diff with m=
ultiple notes' '
 		main..unmodified >actual &&
 	test_when_finished "rm 000?-*" &&
 	test_line_count =3D 5 actual &&
-	test_i18ngrep "^Range-diff:$" 0000-* &&
+	test_grep "^Range-diff:$" 0000-* &&
 	grep "=3D 1: .* s/5/A" 0000-* &&
 	grep "=3D 2: .* s/4/A" 0000-* &&
 	grep "=3D 3: .* s/11/B" 0000-* &&
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7326adb70f..7f4e98db7d 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -227,7 +227,7 @@ test_expect_success 'notice d/f conflict with existin=
g directory' '
=20
 test_expect_success 'existing directory reports concrete ref' '
 	test_must_fail git branch foo 2>stderr &&
-	test_i18ngrep refs/heads/foo/bar/baz stderr
+	test_grep refs/heads/foo/bar/baz stderr
 '
=20
 test_expect_success 'notice d/f conflict with existing ref' '
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d734000d2f..cf23c06c09 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1469,9 +1469,9 @@ test_expect_success 'GIT_NOTES_REWRITE_REF override=
s config' '
=20
 test_expect_success 'git notes copy diagnoses too many or too few argume=
nts' '
 	test_must_fail git notes copy 2>error &&
-	test_i18ngrep "too few arguments" error &&
+	test_grep "too few arguments" error &&
 	test_must_fail git notes copy one two three 2>error &&
-	test_i18ngrep "too many arguments" error
+	test_grep "too many arguments" error
 '
=20
 test_expect_success 'git notes get-ref expands refs/heads/main to refs/n=
otes/refs/heads/main' '
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-=
manual-resolve.sh
index d3d72e25fe..60d6ed2dc8 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -216,7 +216,7 @@ test_expect_success 'merge z into m (=3D=3D y) with d=
efault ("manual") resolver =3D> C
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
-	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_grep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -263,7 +263,7 @@ test_expect_success 'cannot do merge w/conflicts when=
 previous merge is unfinish
 	test -d .git/NOTES_MERGE_WORKTREE &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should indicate what is wrong
-	test_i18ngrep -q "\\.git/NOTES_MERGE_\\* exists" output
+	test_grep -q "\\.git/NOTES_MERGE_\\* exists" output
 '
=20
 # Setup non-conflicting merge between x and new notes ref w
@@ -417,7 +417,7 @@ test_expect_success 'redo merge of z into m (=3D=3D y=
) with default ("manual") resol
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
-	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_grep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -449,7 +449,7 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'redo merge of z into m (=3D=3D y) with default ("ma=
nual") resolver =3D> Conflicting 3-way merge' '
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
-	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_grep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -528,7 +528,7 @@ test_expect_success 'redo merge of z into m (=3D=3D y=
) with default ("manual") resol
 	git update-ref refs/notes/m refs/notes/y &&
 	test_must_fail git notes merge z >output 2>&1 &&
 	# Output should point to where to resolve conflicts
-	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_grep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -573,9 +573,9 @@ EOF
 	test "$(git rev-parse refs/notes/y)" =3D "$(git rev-parse NOTES_MERGE_P=
ARTIAL^1)" &&
 	test "$(git rev-parse refs/notes/m)" !=3D "$(git rev-parse NOTES_MERGE_=
PARTIAL^1)" &&
 	# Mention refs/notes/m, and its current and expected value in output
-	test_i18ngrep -q "refs/notes/m" output &&
-	test_i18ngrep -q "$(git rev-parse refs/notes/m)" output &&
-	test_i18ngrep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	test_grep -q "refs/notes/m" output &&
+	test_grep -q "$(git rev-parse refs/notes/m)" output &&
+	test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-workt=
rees.sh
index bff0aea550..0fd33280cf 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -57,7 +57,7 @@ test_expect_success 'merge z into y while mid-merge in =
another workdir fails' '
 		cd worktree &&
 		git config core.notesRef refs/notes/y &&
 		test_must_fail git notes merge z 2>err &&
-		test_i18ngrep "a notes merge into refs/notes/y is already in-progress =
at" err
+		test_grep "a notes merge into refs/notes/y is already in-progress at" =
err
 	) &&
 	test_must_fail git -C worktree symbolic-ref NOTES_MERGE_REF
 '
@@ -67,7 +67,7 @@ test_expect_success 'merge z into x while mid-merge on =
y succeeds' '
 		cd worktree2 &&
 		git config core.notesRef refs/notes/x &&
 		test_must_fail git notes merge z >out 2>&1 &&
-		test_i18ngrep "Automatic notes merge failed" out &&
+		test_grep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" ou=
t
 	) &&
 	echo "refs/notes/x" >expect &&
diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index 028d825e8f..33c1322989 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -428,7 +428,7 @@ test_expect_success 'add notes with empty messages' '
 	git notes add -m "${LF}" \
 		      -m "${MULTI_LF}" \
 		      -m "${LF}" >actual 2>&1 &&
-	test_i18ngrep "Removing note for object" actual
+	test_grep "Removing note for object" actual
 '
=20
 test_expect_success 'add note by specifying "-C", "--no-stripspace" is t=
he default behavior' '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 3ce918fdb8..621c8ef84c 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -143,8 +143,8 @@ test_expect_success 'Show verbose error when HEAD cou=
ld not be detached' '
 	>B &&
 	test_when_finished "rm -f B" &&
 	test_must_fail git rebase topic 2>output.err >output.out &&
-	test_i18ngrep "The following untracked working tree files would be over=
written by checkout:" output.err &&
-	test_i18ngrep B output.err
+	test_grep "The following untracked working tree files would be overwrit=
ten by checkout:" output.err &&
+	test_grep B output.err
 '
=20
 test_expect_success 'fail when upstream arg is missing and not on branch=
' '
@@ -421,7 +421,7 @@ test_expect_success 'refuse to switch to branch check=
ed out elsewhere' '
 	git checkout main &&
 	git worktree add wt &&
 	test_must_fail git -C wt rebase main main 2>err &&
-	test_i18ngrep "already checked out" err
+	test_grep "already checked out" err
 '
=20
 test_expect_success MINGW,SYMLINKS_WINDOWS 'rebase when .git/logs is a s=
ymlink' '
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index e9e03ca4b5..5c67d07ba3 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -171,7 +171,7 @@ test_expect_success '--reapply-cherry-picks' '
=20
 	# Regular rebase fails, because the 1-11 commit is deduplicated
 	test_must_fail git -C repo rebase --merge main 2> err &&
-	test_i18ngrep "error: could not apply.*add 12 in another branch" err &&
+	test_grep "error: could not apply.*add 12 in another branch" err &&
 	git -C repo rebase --abort &&
=20
 	# With --reapply-cherry-picks, it works
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index f6e4864497..a1911c4a9d 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -108,10 +108,10 @@ test_expect_success 'correct advice upon picking em=
pty commit' '
 	test_when_finished "git rebase --abort" &&
 	test_must_fail git rebase -i --onto goodbye \
 		amended-goodbye^ amended-goodbye 2>err &&
-	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git rebase --skip" err &&
+	test_grep "previous cherry-pick is now empty" err &&
+	test_grep "git rebase --skip" err &&
 	test_must_fail git commit &&
-	test_i18ngrep "git rebase --skip" err
+	test_grep "git rebase --skip" err
 '
=20
 test_expect_success 'correct authorship when committing empty pick' '
@@ -131,10 +131,10 @@ test_expect_success 'correct advice upon rewording =
empty commit' '
 		test_must_fail env FAKE_LINES=3D"reword 1" git rebase -i \
 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
 	) &&
-	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git rebase --skip" err &&
+	test_grep "previous cherry-pick is now empty" err &&
+	test_grep "git rebase --skip" err &&
 	test_must_fail git commit &&
-	test_i18ngrep "git rebase --skip" err
+	test_grep "git rebase --skip" err
 '
=20
 test_expect_success 'correct advice upon editing empty commit' '
@@ -144,10 +144,10 @@ test_expect_success 'correct advice upon editing em=
pty commit' '
 		test_must_fail env FAKE_LINES=3D"edit 1" git rebase -i \
 			--onto goodbye amended-goodbye^ amended-goodbye 2>err
 	) &&
-	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git rebase --skip" err &&
+	test_grep "previous cherry-pick is now empty" err &&
+	test_grep "git rebase --skip" err &&
 	test_must_fail git commit &&
-	test_i18ngrep "git rebase --skip" err
+	test_grep "git rebase --skip" err
 '
=20
 test_expect_success 'correct advice upon cherry-picking an empty commit =
during a rebase' '
@@ -157,10 +157,10 @@ test_expect_success 'correct advice upon cherry-pic=
king an empty commit during a
 		test_must_fail env FAKE_LINES=3D"1 exec_git_cherry-pick_amended-goodby=
e" \
 			git rebase -i goodbye^ goodbye 2>err
 	) &&
-	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_grep "previous cherry-pick is now empty" err &&
+	test_grep "git cherry-pick --skip" err &&
 	test_must_fail git commit 2>err &&
-	test_i18ngrep "git cherry-pick --skip" err
+	test_grep "git cherry-pick --skip" err
 '
=20
 test_expect_success 'correct advice upon multi cherry-pick picking an em=
pty commit during a rebase' '
@@ -170,10 +170,10 @@ test_expect_success 'correct advice upon multi cher=
ry-pick picking an empty comm
 		test_must_fail env FAKE_LINES=3D"1 exec_git_cherry-pick_goodbye_amende=
d-goodbye" \
 			git rebase -i goodbye^^ goodbye 2>err
 	) &&
-	test_i18ngrep "previous cherry-pick is now empty" err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_grep "previous cherry-pick is now empty" err &&
+	test_grep "git cherry-pick --skip" err &&
 	test_must_fail git commit 2>err &&
-	test_i18ngrep "git cherry-pick --skip" err
+	test_grep "git cherry-pick --skip" err
 '
=20
 test_expect_success 'fixup that empties commit fails' '
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
index 96a56aafbe..dbd5df5aa4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -291,9 +291,9 @@ test_expect_success 'abort with error when new base c=
annot be checked out' '
 	git rm --cached file1 &&
 	git commit -m "remove file in base" &&
 	test_must_fail git rebase -i primary > output 2>&1 &&
-	test_i18ngrep "The following untracked working tree files would be over=
written by checkout:" \
+	test_grep "The following untracked working tree files would be overwrit=
ten by checkout:" \
 		output &&
-	test_i18ngrep "file1" output &&
+	test_grep "file1" output &&
 	test_path_is_missing .git/rebase-merge &&
 	rm file1 &&
 	git reset --hard HEAD^
@@ -604,7 +604,7 @@ test_expect_success 'clean error after failed "exec"'=
 '
 	echo "edited again" > file7 &&
 	git add file7 &&
 	test_must_fail git rebase --continue 2>error &&
-	test_i18ngrep "you have staged changes in your working tree" error
+	test_grep "you have staged changes in your working tree" error
 '
=20
 test_expect_success 'rebase a detached HEAD' '
@@ -955,7 +955,7 @@ test_expect_success 'rebase --exec works without -i '=
 '
 	git reset --hard execute &&
 	rm -rf exec_output &&
 	EDITOR=3D"echo >invoked_editor" git rebase --exec "echo a line >>exec_o=
utput"  HEAD~2 2>actual &&
-	test_i18ngrep  "Successfully rebased and updated" actual &&
+	test_grep  "Successfully rebased and updated" actual &&
 	test_line_count =3D 2 exec_output &&
 	test_path_is_missing invoked_editor
 '
@@ -963,7 +963,7 @@ test_expect_success 'rebase --exec works without -i '=
 '
 test_expect_success 'rebase -i --exec without <CMD>' '
 	git reset --hard execute &&
 	test_must_fail git rebase -i --exec 2>actual &&
-	test_i18ngrep "requires a value" actual &&
+	test_grep "requires a value" actual &&
 	git checkout primary
 '
=20
@@ -1272,7 +1272,7 @@ test_expect_success 'todo count' '
 		test_set_editor "$(pwd)/dump-raw.sh" &&
 		git rebase -i HEAD~4 >actual
 	) &&
-	test_i18ngrep "^# Rebase ..* onto ..* ([0-9]" actual
+	test_grep "^# Rebase ..* onto ..* ([0-9]" actual
 '
=20
 test_expect_success 'rebase -i commits that overwrite untracked files (p=
ick)' '
@@ -1379,7 +1379,7 @@ test_expect_success 'rebase -i respects rebase.miss=
ingCommitsCheck =3D ignore' '
 		FAKE_LINES=3D"1 2 3 4" git rebase -i --root 2>actual
 	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ngrep \
+	test_grep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
 		actual
 '
@@ -1442,7 +1442,7 @@ test_expect_success 'rebase --edit-todo respects re=
base.missingCommitsCheck =3D ig
 		git rebase --continue 2>actual
 	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ngrep \
+	test_grep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
 		actual
 '
@@ -1477,7 +1477,7 @@ test_expect_success 'rebase --edit-todo respects re=
base.missingCommitsCheck =3D wa
 		git rebase --continue 2>actual
 	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ngrep \
+	test_grep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
 		actual
 '
@@ -1525,7 +1525,7 @@ test_expect_success 'rebase --edit-todo respects re=
base.missingCommitsCheck =3D er
 		git rebase --continue 2>actual
 	) &&
 	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
-	test_i18ngrep \
+	test_grep \
 		"Successfully rebased and updated refs/heads/missing-commit" \
 		actual
 '
@@ -1585,9 +1585,9 @@ test_expect_success 'static check of bad command' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES=3D"1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-		test_i18ngrep "pickled $(git rev-list --oneline -1 primary~1)" \
+		test_grep "pickled $(git rev-list --oneline -1 primary~1)" \
 				actual &&
-		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
+		test_grep "You can fix this with .git rebase --edit-todo.." \
 				actual &&
 		FAKE_LINES=3D"1 2 3 drop 4 5" git rebase --edit-todo
 	) &&
@@ -1645,8 +1645,8 @@ test_expect_success 'static check of bad SHA-1' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES=3D"1 2 edit fakesha 3 4 5 #" \
 			git rebase -i --root 2>actual &&
-			test_i18ngrep "edit XXXXXXX False commit" actual &&
-			test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
+			test_grep "edit XXXXXXX False commit" actual &&
+			test_grep "You can fix this with .git rebase --edit-todo.." \
 					actual &&
 		FAKE_LINES=3D"1 2 4 5 6" git rebase --edit-todo
 	) &&
@@ -1673,7 +1673,7 @@ test_expect_success 'rebase -i --gpg-sign=3D<key-id=
>' '
 		FAKE_LINES=3D"edit 1" git rebase -i --gpg-sign=3D"\"S I Gner\"" \
 			HEAD^ >out 2>err
 	) &&
-	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
+	test_grep "$SQ-S\"S I Gner\"$SQ" err
 '
=20
 test_expect_success 'rebase -i --gpg-sign=3D<key-id> overrides commit.gp=
gSign' '
@@ -1684,7 +1684,7 @@ test_expect_success 'rebase -i --gpg-sign=3D<key-id=
> overrides commit.gpgSign' '
 		FAKE_LINES=3D"edit 1" git rebase -i --gpg-sign=3D"\"S I Gner\"" \
 			HEAD^ >out 2>err
 	) &&
-	test_i18ngrep "$SQ-S\"S I Gner\"$SQ" err
+	test_grep "$SQ-S\"S I Gner\"$SQ" err
 '
=20
 test_expect_success 'valid author header after --root swap' '
@@ -1738,7 +1738,7 @@ test_expect_success 'correct error message for part=
ial commit after empty pick'
 	) &&
 	echo x >file1 &&
 	test_must_fail git commit file1 2>err &&
-	test_i18ngrep "cannot do a partial commit during a rebase." err
+	test_grep "cannot do a partial commit during a rebase." err
 '
=20
 test_expect_success 'correct error message for commit --amend after empt=
y pick' '
@@ -1751,13 +1751,13 @@ test_expect_success 'correct error message for co=
mmit --amend after empty pick'
 	) &&
 	echo x>file1 &&
 	test_must_fail git commit -a --amend 2>err &&
-	test_i18ngrep "middle of a rebase -- cannot amend." err
+	test_grep "middle of a rebase -- cannot amend." err
 '
=20
 test_expect_success 'todo has correct onto hash' '
 	GIT_SEQUENCE_EDITOR=3Dcat git rebase -i no-conflict-branch~4 no-conflic=
t-branch >actual &&
 	onto=3D$(git rev-parse --short HEAD~4) &&
-	test_i18ngrep "^# Rebase ..* onto $onto" actual
+	test_grep "^# Rebase ..* onto $onto" actual
 '
=20
 test_expect_success 'ORIG_HEAD is updated correctly' '
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index ceca160005..a1d7fa7f7c 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -33,24 +33,24 @@ test_expect_success 'rebase -m' '
=20
 test_expect_success 'rebase against main twice' '
 	git rebase --apply main >out &&
-	test_i18ngrep "Current branch topic is up to date" out
+	test_grep "Current branch topic is up to date" out
 '
=20
 test_expect_success 'rebase against main twice with --force' '
 	git rebase --force-rebase --apply main >out &&
-	test_i18ngrep "Current branch topic is up to date, rebase forced" out
+	test_grep "Current branch topic is up to date, rebase forced" out
 '
=20
 test_expect_success 'rebase against main twice from another branch' '
 	git checkout topic^ &&
 	git rebase --apply main topic >out &&
-	test_i18ngrep "Current branch topic is up to date" out
+	test_grep "Current branch topic is up to date" out
 '
=20
 test_expect_success 'rebase fast-forward to main' '
 	git checkout topic^ &&
 	git rebase --apply topic >out &&
-	test_i18ngrep "Fast-forwarded HEAD to topic" out
+	test_grep "Fast-forwarded HEAD to topic" out
 '
=20
 test_expect_success 'rebase --stat' '
@@ -75,14 +75,14 @@ test_expect_success 'rebase -n overrides config rebas=
e.stat config' '
=20
 test_expect_success 'rebase --onto outputs the invalid ref' '
 	test_must_fail git rebase --onto invalid-ref HEAD HEAD 2>err &&
-	test_i18ngrep "invalid-ref" err
+	test_grep "invalid-ref" err
 '
=20
 test_expect_success 'error out early upon -C<n> or --whitespace=3D<bad>'=
 '
 	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
-	test_i18ngrep "numerical value" err &&
+	test_grep "numerical value" err &&
 	test_must_fail git rebase --whitespace=3Dbad HEAD 2>err &&
-	test_i18ngrep "Invalid whitespace option" err
+	test_grep "Invalid whitespace option" err
 '
=20
 write_reflog_expect () {
@@ -251,8 +251,8 @@ test_expect_success 'rebase -i onto unrelated history=
' '
 	git -C unrelated remote add -f origin "$PWD" &&
 	git -C unrelated branch --set-upstream-to=3Dorigin/main &&
 	git -C unrelated -c core.editor=3Dtrue rebase -i -v --stat >actual &&
-	test_i18ngrep "Changes to " actual &&
-	test_i18ngrep "5 files changed" actual
+	test_grep "Changes to " actual &&
+	test_grep "5 files changed" actual
 '
=20
 test_done
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index fb7b68990c..108d5c28fa 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -182,8 +182,8 @@ test_expect_success '--skip after failed fixup cleans=
 commit message' '
=20
 	: Final squash failed, but there was still a squash &&
 	head -n1 .git/copy.txt >first-line &&
-	test_i18ngrep "# This is a combination of 3 commits" first-line &&
-	test_i18ngrep "# This is the commit message #3:" .git/copy.txt
+	test_grep "# This is a combination of 3 commits" first-line &&
+	test_grep "# This is the commit message #3:" .git/copy.txt
 '
=20
 test_expect_success 'setup rerere database' '
@@ -276,7 +276,7 @@ test_expect_success '--reschedule-failed-exec' '
 	test_must_fail git -c rebase.rescheduleFailedExec=3Dtrue \
 		rebase -x false HEAD^ 2>err &&
 	grep "^exec false" .git/rebase-merge/git-rebase-todo &&
-	test_i18ngrep "has been rescheduled" err
+	test_grep "has been rescheduled" err
 '
=20
 test_expect_success 'rebase.rescheduleFailedExec only affects `rebase -i=
`' '
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4bfc779bb8..0bb284d61d 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -84,7 +84,7 @@ test_expect_success 'git rebase --fork-point with ambig=
ous refname' '
=20
 test_expect_success '--fork-point and --root both given' '
 	test_must_fail git rebase --fork-point --root 2>err &&
-	test_i18ngrep "cannot be used together" err
+	test_grep "cannot be used together" err
 '
=20
 test_expect_success 'rebase.forkPoint set to false' '
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.s=
h
index e2ef619323..3eac20c098 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -43,7 +43,7 @@ test_expect_success 'cherry-pick --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git cherry-pick --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep "[Uu]sage:" msg
+	test_grep "[Uu]sage:" msg
 '
=20
 test_expect_success 'revert --nonsense' '
@@ -52,7 +52,7 @@ test_expect_success 'revert --nonsense' '
 	git diff --exit-code HEAD &&
 	test_must_fail git revert --nonsense 2>msg &&
 	git diff --exit-code HEAD "$pos" &&
-	test_i18ngrep "[Uu]sage:" msg
+	test_grep "[Uu]sage:" msg
 '
=20
 # the following two test cherry-pick and revert with renames
@@ -99,7 +99,7 @@ test_expect_success 'revert forbidden on dirty working =
tree' '
 	echo content >extra_file &&
 	git add extra_file &&
 	test_must_fail git revert HEAD 2>errors &&
-	test_i18ngrep "your local changes would be overwritten by " errors
+	test_grep "your local changes would be overwritten by " errors
=20
 '
=20
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-confli=
ct.sh
index f32799e046..c88d597b12 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -177,7 +177,7 @@ test_expect_success 'partial commit of cherry-pick fa=
ils' '
 	git add foo &&
 	test_must_fail git commit foo 2>err &&
=20
-	test_i18ngrep "cannot do a partial commit during a cherry-pick." err
+	test_grep "cannot do a partial commit during a cherry-pick." err
 '
=20
 test_expect_success 'commit --amend of cherry-pick fails' '
@@ -188,7 +188,7 @@ test_expect_success 'commit --amend of cherry-pick fa=
ils' '
 	git add foo &&
 	test_must_fail git commit --amend 2>err &&
=20
-	test_i18ngrep "in the middle of a cherry-pick -- cannot amend." err
+	test_grep "in the middle of a cherry-pick -- cannot amend." err
 '
=20
 test_expect_success 'successful final commit clears cherry-pick state' '
@@ -498,7 +498,7 @@ test_expect_success \
 test_expect_success 'failed cherry-pick does not forget -s' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick -s picked &&
-	test_i18ngrep -e "Signed-off-by" .git/MERGE_MSG
+	test_grep -e "Signed-off-by" .git/MERGE_MSG
 '
=20
 test_expect_success 'commit after failed cherry-pick does not add duplic=
ated -s' '
@@ -563,7 +563,7 @@ test_expect_success 'cherry-pick preserves sparse-che=
ckout' '
 	echo /unrelated >.git/info/sparse-checkout &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick -Xours picked>actual &&
-	test_i18ngrep ! "Changes not staged for commit:" actual
+	test_grep ! "Changes not staged for commit:" actual
 '
=20
 test_expect_success 'cherry-pick --continue remembers --keep-redundant-c=
ommits' '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequen=
ce.sh
index 3b0fa66c33..72020a51c4 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -154,7 +154,7 @@ test_expect_success 'skip "empty" commit' '
 	pristine_detach picked &&
 	test_commit dummy foo d &&
 	test_must_fail git cherry-pick anotherpick 2>err &&
-	test_i18ngrep "git cherry-pick --skip" err &&
+	test_grep "git cherry-pick --skip" err &&
 	git cherry-pick --skip &&
 	test_cmp_rev dummy HEAD
 '
@@ -314,7 +314,7 @@ test_expect_success '--abort does not unsafely change=
 HEAD' '
 	git reset --hard base &&
 	test_must_fail git cherry-pick picked anotherpick &&
 	git cherry-pick --abort 2>actual &&
-	test_i18ngrep "You seem to have moved HEAD" actual &&
+	test_grep "You seem to have moved HEAD" actual &&
 	test_cmp_rev base HEAD
 '
=20
@@ -520,7 +520,7 @@ test_expect_success '--continue asks for help after r=
esolving patch to nil' '
 	test_cmp_rev unrelatedpick CHERRY_PICK_HEAD &&
 	git checkout HEAD -- unrelated &&
 	test_must_fail git cherry-pick --continue 2>msg &&
-	test_i18ngrep "The previous cherry-pick is now empty" msg
+	test_grep "The previous cherry-pick is now empty" msg
 '
=20
 test_expect_success 'follow advice and skip nil patch' '
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 0e8afe49ed..98259e2ada 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -276,7 +276,7 @@ test_expect_success 'Resolving by removal is not a wa=
rning-worthy event' '
 	blob=3D$(echo blob | git hash-object -w --stdin) &&
 	printf "100644 $blob %d\tblob\n" 1 2 3 | git update-index --index-info =
&&
 	git rm blob >msg 2>&1 &&
-	test_i18ngrep ! "needs merge" msg &&
+	test_grep ! "needs merge" msg &&
 	test_must_fail git ls-files -s --error-unmatch blob
 '
=20
@@ -631,7 +631,7 @@ test_expect_success 'rm of a populated submodule with=
 a .git directory migrates
 	test_path_is_missing submod/.git &&
 	git status -s -uno --ignore-submodules=3Dnone >actual &&
 	test_file_not_empty actual &&
-	test_i18ngrep Migrating output.err
+	test_grep Migrating output.err
 '
=20
 cat >expect.deepmodified <<EOF
@@ -722,7 +722,7 @@ test_expect_success "rm absorbs submodule's nested .g=
it directory" '
 	test_path_is_missing submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=3Dnone >actual &&
 	test_file_not_empty actual &&
-	test_i18ngrep Migrating output.err
+	test_grep Migrating output.err
 '
=20
 test_expect_success 'checking out a commit after submodule removal needs=
 manual updates' '
@@ -731,7 +731,7 @@ test_expect_success 'checking out a commit after subm=
odule removal needs manual
 	git submodule update &&
 	git checkout -q HEAD^ &&
 	git checkout -q main 2>actual &&
-	test_i18ngrep "^warning: unable to rmdir '\''submod'\'':" actual &&
+	test_grep "^warning: unable to rmdir '\''submod'\'':" actual &&
 	git status -s submod >actual &&
 	echo "?? submod/" >expected &&
 	test_cmp expected actual &&
diff --git a/t/t3601-rm-pathspec-file.sh b/t/t3601-rm-pathspec-file.sh
index a2a0c820fe..7cef12981c 100755
--- a/t/t3601-rm-pathspec-file.sh
+++ b/t/t3601-rm-pathspec-file.sh
@@ -67,14 +67,14 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
=20
 	test_must_fail git rm --pathspec-from-file=3Dlist -- fileA.t 2>err &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git rm --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err &&
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err &&
=20
 	>empty_list &&
 	test_must_fail git rm --pathspec-from-file=3Dempty_list 2>err &&
-	test_i18ngrep -e "No pathspec was given. Which files should I remove?" =
err
+	test_grep -e "No pathspec was given. Which files should I remove?" err
 '
=20
 test_done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7623689da2..f23d39f0d5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -438,7 +438,7 @@ test_expect_success 'git add --chmod fails with non r=
egular files (but updates t
 	test_ln_s_add foo foo3 &&
 	touch foo4 &&
 	test_must_fail git add --chmod=3D+x foo3 foo4 2>stderr &&
-	test_i18ngrep "cannot chmod +x .foo3." stderr &&
+	test_grep "cannot chmod +x .foo3." stderr &&
 	test_mode_in_index 120000 foo3 &&
 	test_mode_in_index 100755 foo4
 '
@@ -455,12 +455,12 @@ test_expect_success 'git add --chmod --dry-run repo=
rts error for non regular fil
 	git reset --hard &&
 	test_ln_s_add foo foo4 &&
 	test_must_fail git add --chmod=3D+x --dry-run foo4 2>stderr &&
-	test_i18ngrep "cannot chmod +x .foo4." stderr
+	test_grep "cannot chmod +x .foo4." stderr
 '
=20
 test_expect_success 'git add --chmod --dry-run reports error for unmatch=
ed pathspec' '
 	test_must_fail git add --chmod=3D+x --dry-run nonexistent 2>stderr &&
-	test_i18ngrep "pathspec .nonexistent. did not match any files" stderr
+	test_grep "pathspec .nonexistent. did not match any files" stderr
 '
=20
 test_expect_success 'no file status change if no pathspec is given' '
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 34aabb7f5f..0b5339ac6c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -335,12 +335,12 @@ test_expect_success 'different prompts for mode cha=
nge/deleted' '
 test_expect_success 'correct message when there is nothing to do' '
 	git reset --hard &&
 	git add -p 2>err &&
-	test_i18ngrep "No changes" err &&
+	test_grep "No changes" err &&
 	printf "\\0123" >binary &&
 	git add binary &&
 	printf "\\0abc" >binary &&
 	git add -p 2>err &&
-	test_i18ngrep "Only binary files changed" err
+	test_grep "Only binary files changed" err
 '
=20
 test_expect_success 'setup again' '
@@ -497,7 +497,7 @@ test_expect_success 'adding an empty file' '
=20
 		echo y | git checkout -p added-file -- >actual &&
 		test_path_is_file empty &&
-		test_i18ngrep "Apply addition to index and worktree" actual
+		test_grep "Apply addition to index and worktree" actual
 	)
 '
=20
@@ -838,7 +838,7 @@ test_expect_success 'diff.algorithm is passed to `git=
 diff-files`' '
 	git add file &&
 	echo changed >file &&
 	test_must_fail git -c diff.algorithm=3Dbogus add -p 2>err &&
-	test_i18ngrep "error: option diff-algorithm accepts " err
+	test_grep "error: option diff-algorithm accepts " err
 '
=20
 test_expect_success 'patch-mode via -i prompts for files' '
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 4e6b5177c9..3aa59f6f63 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -138,23 +138,23 @@ test_expect_success 'error conditions' '
 	>empty_list &&
=20
 	test_must_fail git add --pathspec-from-file=3Dlist --interactive 2>err =
&&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--p=
atch. cannot be used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--interactive/--patch=
. cannot be used together" err &&
=20
 	test_must_fail git add --pathspec-from-file=3Dlist --patch 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--p=
atch. cannot be used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--interactive/--patch=
. cannot be used together" err &&
=20
 	test_must_fail git add --pathspec-from-file=3Dlist --edit 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--edit. cannot be=
 used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--edit. cannot be use=
d together" err &&
=20
 	test_must_fail git add --pathspec-from-file=3Dlist -- fileA.t 2>err &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git add --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err &&
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err &&
=20
 	# This case succeeds, but still prints to stderr
 	git add --pathspec-from-file=3Dempty_list 2>err &&
-	test_i18ngrep -e "Nothing specified, nothing added." err
+	test_grep -e "Nothing specified, nothing added." err
 '
=20
 test_done
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index bfab245eb3..f27d09cfd9 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -45,7 +45,7 @@ test_expect_success 'UTF-8 invalid characters refused' =
'
 	printf "Commit message\n\nInvalid surrogate:\355\240\200\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	test_i18ngrep "did not conform" "$HOME"/stderr
+	test_grep "did not conform" "$HOME"/stderr
 '
=20
 test_expect_success 'UTF-8 overlong sequences rejected' '
@@ -55,7 +55,7 @@ test_expect_success 'UTF-8 overlong sequences rejected'=
 '
 	printf "\340\202\251ommit message\n\nThis is not a space:\300\240\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	test_i18ngrep "did not conform" "$HOME"/stderr
+	test_grep "did not conform" "$HOME"/stderr
 '
=20
 test_expect_success 'UTF-8 non-characters refused' '
@@ -64,7 +64,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 	printf "Commit message\n\nNon-character:\364\217\277\276\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	test_i18ngrep "did not conform" "$HOME"/stderr
+	test_grep "did not conform" "$HOME"/stderr
 '
=20
 test_expect_success 'UTF-8 non-characters refused' '
@@ -73,7 +73,7 @@ test_expect_success 'UTF-8 non-characters refused' '
 	printf "Commit message\n\nNon-character:\357\267\220\n" \
 		>"$HOME/invalid" &&
 	git commit -a -F "$HOME/invalid" 2>"$HOME"/stderr &&
-	test_i18ngrep "did not conform" "$HOME"/stderr
+	test_grep "did not conform" "$HOME"/stderr
 '
=20
 for H in ISO8859-1 eucJP ISO-2022-JP
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index 4f16a735d9..4b37f78829 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -298,7 +298,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
=20
 	# commit-tree will warn that the commit message does not contain valid =
UTF-8
 	# as mailinfo did not convert it
-	test_i18ngrep "did not conform" err &&
+	test_grep "did not conform" err &&
=20
 	check_encoding 2
 '
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0b3dfeaea2..3bec71f056 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -395,7 +395,7 @@ test_expect_success 'stash --staged' '
=20
 test_expect_success 'dont assume push with non-option args' '
 	test_must_fail git stash -q drop 2>err &&
-	test_i18ngrep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t=
 be assumed due to unexpected token '\''drop'\''" err
+	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be =
assumed due to unexpected token '\''drop'\''" err
 '
=20
 test_expect_success 'stash --invalid-option' '
@@ -596,7 +596,7 @@ test_expect_success 'giving too many ref arguments do=
es not modify files' '
 	for type in apply pop "branch stash-branch"
 	do
 		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
-		test_i18ngrep "Too many revisions" err &&
+		test_grep "Too many revisions" err &&
 		test 123456789 =3D $(test-tool chmtime -g file2) || return 1
 	done
 '
@@ -604,14 +604,14 @@ test_expect_success 'giving too many ref arguments =
does not modify files' '
 test_expect_success 'drop: too many arguments errors out (does nothing)'=
 '
 	git stash list >expect &&
 	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
-	test_i18ngrep "Too many revisions" err &&
+	test_grep "Too many revisions" err &&
 	git stash list >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'show: too many arguments errors out (does nothing)'=
 '
 	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out &&
-	test_i18ngrep "Too many revisions" err &&
+	test_grep "Too many revisions" err &&
 	test_must_be_empty out
 '
=20
@@ -654,7 +654,7 @@ test_expect_success 'stash branch - stashes on stack,=
 stash-like argument' '
=20
 test_expect_success 'stash branch complains with no arguments' '
 	test_must_fail git stash branch 2>err &&
-	test_i18ngrep "No branch name specified" err
+	test_grep "No branch name specified" err
 '
=20
 test_expect_success 'stash show format defaults to --stat' '
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-u=
ntracked.sh
index 5390eec4e3..1289ae3e07 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -404,7 +404,7 @@ test_expect_success 'stash show --include-untracked e=
rrors on duplicate files' '
 	) &&
 	w_commit=3D$(git commit-tree -p HEAD -p "$i_commit" -p "$u_commit" -m "=
WIP on any-branch" "$tree") &&
 	test_must_fail git stash show --include-untracked "$w_commit" 2>err &&
-	test_i18ngrep "worktree and untracked commit have duplicate entries: tr=
acked" err
+	test_grep "worktree and untracked commit have duplicate entries: tracke=
d" err
 '
=20
 test_expect_success 'stash show --{include,only}-untracked on stashes wi=
thout untracked entries' '
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file=
.sh
index dead9f18d9..73f2dbdeb0 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -88,13 +88,13 @@ test_expect_success 'error conditions' '
 	echo fileA.t >list &&
=20
 	test_must_fail git stash push --pathspec-from-file=3Dlist --patch 2>err=
 &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot b=
e used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--patch. cannot be us=
ed together" err &&
=20
 	test_must_fail git stash push --pathspec-from-file=3Dlist -- fileA.t 2>=
err &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git stash push --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err
 '
=20
 test_done
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 3dc9047044..85be1367de 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -135,25 +135,25 @@ test_expect_success 'favour same basenames over dif=
ferent ones' '
 	mkdir subdir &&
 	git mv another-path subdir/path1 &&
 	git status >out &&
-	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+	test_grep "renamed: .*path1 -> subdir/path1" out
 '
=20
 test_expect_success 'test diff.renames=3Dtrue for git status' '
 	git -c diff.renames=3Dtrue status >out &&
-	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+	test_grep "renamed: .*path1 -> subdir/path1" out
 '
=20
 test_expect_success 'test diff.renames=3Dfalse for git status' '
 	git -c diff.renames=3Dfalse status >out &&
-	test_i18ngrep ! "renamed: .*path1 -> subdir/path1" out &&
-	test_i18ngrep "new file: .*subdir/path1" out &&
-	test_i18ngrep "deleted: .*[^/]path1" out
+	test_grep ! "renamed: .*path1 -> subdir/path1" out &&
+	test_grep "new file: .*subdir/path1" out &&
+	test_grep "deleted: .*[^/]path1" out
 '
=20
 test_expect_success 'favour same basenames even with minor differences' =
'
 	git show HEAD:path1 | sed "s/15/16/" > subdir/path1 &&
 	git status >out &&
-	test_i18ngrep "renamed: .*path1 -> subdir/path1" out
+	test_grep "renamed: .*path1 -> subdir/path1" out
 '
=20
 test_expect_success 'two files with same basename and same content' '
@@ -165,7 +165,7 @@ test_expect_success 'two files with same basename and=
 same content' '
 	git commit -m 2 &&
 	git mv dir other-dir &&
 	git status >out &&
-	test_i18ngrep "renamed: .*dir/A/file -> other-dir/A/file" out
+	test_grep "renamed: .*dir/A/file -> other-dir/A/file" out
 '
=20
 test_expect_success 'setup for many rename source candidates' '
@@ -202,9 +202,9 @@ test_expect_success 'rename pretty print with nothing=
 in common' '
 	git mv a/b/c c/b/a &&
 	git commit -m "a/b/c -> c/b/a" &&
 	git diff -M --summary HEAD^ HEAD >output &&
-	test_i18ngrep " a/b/c =3D> c/b/a " output &&
+	test_grep " a/b/c =3D> c/b/a " output &&
 	git diff -M --stat HEAD^ HEAD >output &&
-	test_i18ngrep " a/b/c =3D> c/b/a " output
+	test_grep " a/b/c =3D> c/b/a " output
 '
=20
 test_expect_success 'rename pretty print with common prefix' '
@@ -212,9 +212,9 @@ test_expect_success 'rename pretty print with common =
prefix' '
 	git mv c/b/a c/d/e &&
 	git commit -m "c/b/a -> c/d/e" &&
 	git diff -M --summary HEAD^ HEAD >output &&
-	test_i18ngrep " c/{b/a =3D> d/e} " output &&
+	test_grep " c/{b/a =3D> d/e} " output &&
 	git diff -M --stat HEAD^ HEAD >output &&
-	test_i18ngrep " c/{b/a =3D> d/e} " output
+	test_grep " c/{b/a =3D> d/e} " output
 '
=20
 test_expect_success 'rename pretty print with common suffix' '
@@ -222,9 +222,9 @@ test_expect_success 'rename pretty print with common =
suffix' '
 	git mv c/d/e d/e &&
 	git commit -m "c/d/e -> d/e" &&
 	git diff -M --summary HEAD^ HEAD >output &&
-	test_i18ngrep " {c/d =3D> d}/e " output &&
+	test_grep " {c/d =3D> d}/e " output &&
 	git diff -M --stat HEAD^ HEAD >output &&
-	test_i18ngrep " {c/d =3D> d}/e " output
+	test_grep " {c/d =3D> d}/e " output
 '
=20
 test_expect_success 'rename pretty print with common prefix and suffix' =
'
@@ -232,9 +232,9 @@ test_expect_success 'rename pretty print with common =
prefix and suffix' '
 	git mv d/e d/f/e &&
 	git commit -m "d/e -> d/f/e" &&
 	git diff -M --summary HEAD^ HEAD >output &&
-	test_i18ngrep " d/{ =3D> f}/e " output &&
+	test_grep " d/{ =3D> f}/e " output &&
 	git diff -M --stat HEAD^ HEAD >output &&
-	test_i18ngrep " d/{ =3D> f}/e " output
+	test_grep " d/{ =3D> f}/e " output
 '
=20
 test_expect_success 'rename pretty print common prefix and suffix overla=
p' '
@@ -242,9 +242,9 @@ test_expect_success 'rename pretty print common prefi=
x and suffix overlap' '
 	git mv d/f/e d/f/f/e &&
 	git commit -m "d/f/e d/f/f/e" &&
 	git diff -M --summary HEAD^ HEAD >output &&
-	test_i18ngrep " d/f/{ =3D> f}/e " output &&
+	test_grep " d/f/{ =3D> f}/e " output &&
 	git diff -M --stat HEAD^ HEAD >output &&
-	test_i18ngrep " d/f/{ =3D> f}/e " output
+	test_grep " d/f/{ =3D> f}/e " output
 '
=20
 test_expect_success 'diff-tree -l0 defaults to a big rename limit, not z=
ero' '
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5de1d19075..86f3693bc0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -613,7 +613,7 @@ test_expect_success 'diff -I<regex> --stat' '
=20
 test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_expect_code 129 git diff --ignore-matching-lines=3D"^[124-9" 2>err=
or &&
-	test_i18ngrep "invalid regex given to -I: " error
+	test_grep "invalid regex given to -I: " error
 '
=20
 # check_prefix <patch> <src> <dst>
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..7abd307c5c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2369,25 +2369,25 @@ test_expect_success 'interdiff: cover-letter' '
 	--q
 	EOF
 	git format-patch --cover-letter --interdiff=3Dboop~2 -1 boop &&
-	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
-	test_i18ngrep ! "^Interdiff:$" 0001-fleep.patch &&
+	test_grep "^Interdiff:$" 0000-cover-letter.patch &&
+	test_grep ! "^Interdiff:$" 0001-fleep.patch &&
 	sed "1,/^@@ /d; /^-- $/q" 0000-cover-letter.patch >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'interdiff: reroll-count' '
 	git format-patch --cover-letter --interdiff=3Dboop~2 -v2 -1 boop &&
-	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+	test_grep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
=20
 test_expect_success 'interdiff: reroll-count with a non-integer' '
 	git format-patch --cover-letter --interdiff=3Dboop~2 -v2.2 -1 boop &&
-	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
+	test_grep "^Interdiff:$" v2.2-0000-cover-letter.patch
 '
=20
 test_expect_success 'interdiff: reroll-count with a integer' '
 	git format-patch --cover-letter --interdiff=3Dboop~2 -v2 -1 boop &&
-	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
+	test_grep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
=20
 test_expect_success 'interdiff: solo-patch' '
@@ -2396,7 +2396,7 @@ test_expect_success 'interdiff: solo-patch' '
=20
 	EOF
 	git format-patch --interdiff=3Dboop~2 -1 boop &&
-	test_i18ngrep "^Interdiff:$" 0001-fleep.patch &&
+	test_grep "^Interdiff:$" 0001-fleep.patch &&
 	sed "1,/^  @@ /d; /^$/q" 0001-fleep.patch >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b298f220e0..730f025360 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -909,7 +909,7 @@ test_expect_success 'combined diff with autocrlf conv=
ersion' '
 	git commit -m "the other side" x &&
 	git config core.autocrlf true &&
 	test_must_fail git merge one-side >actual &&
-	test_i18ngrep "Automatic merge failed" actual &&
+	test_grep "Automatic merge failed" actual &&
=20
 	git diff >actual.raw &&
 	sed -e "1,/^@@@/d" actual.raw >actual &&
@@ -2187,27 +2187,27 @@ test_expect_success 'compare whitespace delta acr=
oss moved blocks' '
=20
 test_expect_success 'bogus settings in move detection erroring out' '
 	test_must_fail git diff --color-moved=3Dbogus 2>err &&
-	test_i18ngrep "must be one of" err &&
-	test_i18ngrep bogus err &&
+	test_grep "must be one of" err &&
+	test_grep bogus err &&
=20
 	test_must_fail git -c diff.colormoved=3Dbogus diff 2>err &&
-	test_i18ngrep "must be one of" err &&
-	test_i18ngrep "from command-line config" err &&
+	test_grep "must be one of" err &&
+	test_grep "from command-line config" err &&
=20
 	test_must_fail git diff --color-moved-ws=3Dbogus 2>err &&
-	test_i18ngrep "possible values" err &&
-	test_i18ngrep bogus err &&
+	test_grep "possible values" err &&
+	test_grep bogus err &&
=20
 	test_must_fail git -c diff.colormovedws=3Dbogus diff 2>err &&
-	test_i18ngrep "possible values" err &&
-	test_i18ngrep "from command-line config" err
+	test_grep "possible values" err &&
+	test_grep "from command-line config" err
 '
=20
 test_expect_success 'compare whitespace delta incompatible with other sp=
ace options' '
 	test_must_fail git diff \
 		--color-moved-ws=3Dallow-indentation-change,ignore-all-space \
 		2>err &&
-	test_i18ngrep allow-indentation-change err
+	test_grep allow-indentation-change err
 '
=20
 EMPTY=3D''
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index c8d555771d..e026fac1f4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -53,15 +53,15 @@ do
 		echo "*.java diff=3D$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_grep ! fatal msg &&
+		test_grep ! error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=3D$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index --word-diff \
 			A.java B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_grep ! fatal msg &&
+		test_grep ! error msg
 	'
=20
 	test_expect_success "builtin $p pattern compiles on bare repo with --at=
tr-source" '
@@ -79,8 +79,8 @@ do
 		git -C bare.git symbolic-ref HEAD refs/heads/master &&
 		test_expect_code 1 git -C bare.git --attr-source=3DbranchA \
 			diff --exit-code HEAD:A.java HEAD:B.java 2>msg &&
-		test_i18ngrep ! fatal msg &&
-		test_i18ngrep ! error msg
+		test_grep ! fatal msg &&
+		test_grep ! error msg
 	'
 done
=20
@@ -88,7 +88,7 @@ test_expect_success 'last regexp must not be negated' '
 	echo "*.java diff=3Djava" >.gitattributes &&
 	test_config diff.java.funcname "!static" &&
 	test_expect_code 128 git diff --no-index A.java B.java 2>msg &&
-	test_i18ngrep ": Last expression must not be negated:" msg
+	test_grep ": Last expression must not be negated:" msg
 '
=20
 test_expect_success 'setup hunk header tests' '
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary=
.sh
index eacc6694f7..c4394a27b5 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -53,7 +53,7 @@ test_expect_success 'rewrite diff --numstat shows binar=
y changes' '
 test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 	git diff -B --stat --summary >diff &&
 	grep "Bin" diff &&
-	test_i18ngrep "0 insertions.*0 deletions" diff &&
+	test_grep "0 insertions.*0 deletions" diff &&
 	grep " rewrite file" diff
 '
=20
diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 70224c3da1..7b73462d53 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -943,37 +943,37 @@ test_expect_success '--dirstat=3Dfuture_param,lines=
,0 should fail loudly' '
 	test_must_fail git diff --dirstat=3Dfuture_param,lines,0 HEAD^..HEAD >a=
ctual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_must_be_empty actual_diff_dirstat &&
-	test_i18ngrep -q "future_param" actual_error &&
-	test_i18ngrep -q "\--dirstat" actual_error
+	test_grep -q "future_param" actual_error &&
+	test_grep -q "\--dirstat" actual_error
 '
=20
 test_expect_success '--dirstat=3Ddummy1,cumulative,2dummy should report =
both unrecognized parameters' '
 	test_must_fail git diff --dirstat=3Ddummy1,cumulative,2dummy HEAD^..HEA=
D >actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_must_be_empty actual_diff_dirstat &&
-	test_i18ngrep -q "dummy1" actual_error &&
-	test_i18ngrep -q "2dummy" actual_error &&
-	test_i18ngrep -q "\--dirstat" actual_error
+	test_grep -q "dummy1" actual_error &&
+	test_grep -q "2dummy" actual_error &&
+	test_grep -q "\--dirstat" actual_error
 '
=20
 test_expect_success 'diff.dirstat=3Dfuture_param,0,lines should warn, bu=
t still work' '
 	git -c diff.dirstat=3Dfuture_param,0,lines diff --dirstat HEAD^..HEAD >=
actual_diff_dirstat 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
-	test_i18ngrep -q "future_param" actual_error &&
-	test_i18ngrep -q "diff\\.dirstat" actual_error &&
+	test_grep -q "future_param" actual_error &&
+	test_grep -q "diff\\.dirstat" actual_error &&
=20
 	git -c diff.dirstat=3Dfuture_param,0,lines diff --dirstat -M HEAD^..HEA=
D >actual_diff_dirstat_M 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
-	test_i18ngrep -q "future_param" actual_error &&
-	test_i18ngrep -q "diff\\.dirstat" actual_error &&
+	test_grep -q "future_param" actual_error &&
+	test_grep -q "diff\\.dirstat" actual_error &&
=20
 	git -c diff.dirstat=3Dfuture_param,0,lines diff --dirstat -C -C HEAD^..=
HEAD >actual_diff_dirstat_CC 2>actual_error &&
 	test_debug "cat actual_error" &&
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC &&
-	test_i18ngrep -q "future_param" actual_error &&
-	test_i18ngrep -q "diff\\.dirstat" actual_error
+	test_grep -q "future_param" actual_error &&
+	test_grep -q "diff\\.dirstat" actual_error
 '
=20
 test_expect_success '--shortstat --dirstat should output only one dirsta=
t' '
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 6781cc9078..5a5d958b96 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -56,7 +56,7 @@ test_expect_success 'git diff --no-index executed outsi=
de repo gives correct err
 		export GIT_CEILING_DIRECTORIES &&
 		cd non/git &&
 		test_must_fail git diff --no-index a 2>actual.err &&
-		test_i18ngrep "usage: git diff --no-index" actual.err
+		test_grep "usage: git diff --no-index" actual.err
 	)
 '
=20
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 73048d0a52..3ea9ae99e0 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -74,13 +74,13 @@ test_expect_success 'plumbing not affected' '
 test_expect_success 'non-integer config parsing' '
 	git config diff.context no &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad numeric config value" output
+	test_grep "bad numeric config value" output
 '
=20
 test_expect_success 'negative integer config parsing' '
 	git config diff.context -1 &&
 	test_must_fail git diff 2>output &&
-	test_i18ngrep "bad config variable" output
+	test_grep "bad config variable" output
 '
=20
 test_expect_success '-U0 is valid, so is diff.context=3D0' '
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetri=
c-merge-base.sh
index 2d650d8f10..3356d91cd4 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -68,27 +68,27 @@ test_expect_success 'diff with two merge bases' '
=20
 test_expect_success 'diff with no merge bases' '
 	test_must_fail git diff br2...br3 2>err &&
-	test_i18ngrep "fatal: br2...br3: no merge base" err
+	test_grep "fatal: br2...br3: no merge base" err
 '
=20
 test_expect_success 'diff with too many symmetric differences' '
 	test_must_fail git diff br1...main br2...br3 2>err &&
-	test_i18ngrep "usage" err
+	test_grep "usage" err
 '
=20
 test_expect_success 'diff with symmetric difference and extraneous arg' =
'
 	test_must_fail git diff main br1...main 2>err &&
-	test_i18ngrep "usage" err
+	test_grep "usage" err
 '
=20
 test_expect_success 'diff with two ranges' '
 	test_must_fail git diff main br1..main br2..br3 2>err &&
-	test_i18ngrep "usage" err
+	test_grep "usage" err
 '
=20
 test_expect_success 'diff with ranges and extra arg' '
 	test_must_fail git diff main br1..main commit-D 2>err &&
-	test_i18ngrep "usage" err
+	test_grep "usage" err
 '
=20
 test_expect_success 'diff --merge-base with no commits' '
@@ -97,7 +97,7 @@ test_expect_success 'diff --merge-base with no commits'=
 '
=20
 test_expect_success 'diff --merge-base with three commits' '
 	test_must_fail git diff --merge-base br1 br2 main 2>err &&
-	test_i18ngrep "usage" err
+	test_grep "usage" err
 '
=20
 for cmd in diff-index diff
@@ -143,19 +143,19 @@ do
 	test_expect_success "$cmd --merge-base with non-commit" '
 		git checkout main &&
 		test_must_fail git $cmd --merge-base main^{tree} 2>err &&
-		test_i18ngrep "fatal: --merge-base only works with commits" err
+		test_grep "fatal: --merge-base only works with commits" err
 	'
=20
 	test_expect_success "$cmd --merge-base with no merge bases and one comm=
it" '
 		git checkout main &&
 		test_must_fail git $cmd --merge-base br3 2>err &&
-		test_i18ngrep "fatal: no merge base found" err
+		test_grep "fatal: no merge base found" err
 	'
=20
 	test_expect_success "$cmd --merge-base with multiple merge bases and on=
e commit" '
 		git checkout main &&
 		test_must_fail git $cmd --merge-base br1 2>err &&
-		test_i18ngrep "fatal: multiple merge bases found" err
+		test_grep "fatal: multiple merge bases found" err
 	'
 done
=20
@@ -169,28 +169,28 @@ do
=20
 	test_expect_success "$cmd --merge-base commit and non-commit" '
 		test_must_fail git $cmd --merge-base br2 main^{tree} 2>err &&
-		test_i18ngrep "fatal: --merge-base only works with commits" err
+		test_grep "fatal: --merge-base only works with commits" err
 	'
=20
 	test_expect_success "$cmd --merge-base with no merge bases and two comm=
its" '
 		test_must_fail git $cmd --merge-base br2 br3 2>err &&
-		test_i18ngrep "fatal: no merge base found" err
+		test_grep "fatal: no merge base found" err
 	'
=20
 	test_expect_success "$cmd --merge-base with multiple merge bases and tw=
o commits" '
 		test_must_fail git $cmd --merge-base main br1 2>err &&
-		test_i18ngrep "fatal: multiple merge bases found" err
+		test_grep "fatal: multiple merge bases found" err
 	'
 done
=20
 test_expect_success 'diff-tree --merge-base with one commit' '
 	test_must_fail git diff-tree --merge-base main 2>err &&
-	test_i18ngrep "fatal: --merge-base only works with two commits" err
+	test_grep "fatal: --merge-base only works with two commits" err
 '
=20
 test_expect_success 'diff --merge-base with range' '
 	test_must_fail git diff --merge-base br2..br3 2>err &&
-	test_i18ngrep "fatal: --merge-base does not work with ranges" err
+	test_grep "fatal: --merge-base does not work with ranges" err
 '
=20
 test_done
diff --git a/t/t4115-apply-symlink.sh b/t/t4115-apply-symlink.sh
index a22a90d552..cbef0a593f 100755
--- a/t/t4115-apply-symlink.sh
+++ b/t/t4115-apply-symlink.sh
@@ -136,7 +136,7 @@ test_expect_success SYMLINKS '--reject removes .rej s=
ymlink if it exists' '
=20
 	ln -s foo file.t.rej &&
 	test_must_fail git apply patch --reject 2>err &&
-	test_i18ngrep "Rejected hunk" err &&
+	test_grep "Rejected hunk" err &&
 	test_path_is_missing foo &&
 	test_path_is_file file.t.rej
 '
diff --git a/t/t4120-apply-popt.sh b/t/t4120-apply-popt.sh
index 497b62868d..697e86c0ff 100755
--- a/t/t4120-apply-popt.sh
+++ b/t/t4120-apply-popt.sh
@@ -31,7 +31,7 @@ test_expect_success 'apply git diff with -p2' '
 test_expect_success 'apply with too large -p' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.file 2>err &&
-	test_i18ngrep "removing 3 leading" err
+	test_grep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) traditional diff with funny filenames' =
'
@@ -53,7 +53,7 @@ test_expect_success 'apply (-p2) traditional diff with =
funny filenames' '
 test_expect_success 'apply with too large -p and fancy filename' '
 	cp file1.saved file1 &&
 	test_must_fail git apply --stat -p3 patch.escaped 2>err &&
-	test_i18ngrep "removing 3 leading" err
+	test_grep "removing 3 leading" err
 '
=20
 test_expect_success 'apply (-p2) diff, mode change only' '
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-insi=
de.sh
index 9696537303..2089d84f64 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -95,19 +95,19 @@ test_expect_success SYMLINKS 'do not follow symbolic =
link (same input)' '
=20
 	# same input creates a confusing symbolic link
 	test_must_fail git apply patch 2>error-wt &&
-	test_i18ngrep "beyond a symbolic link" error-wt &&
+	test_grep "beyond a symbolic link" error-wt &&
 	test_path_is_missing arch/x86_64/dir &&
 	test_path_is_missing arch/i386/dir/file &&
=20
 	test_must_fail git apply --index patch 2>error-ix &&
-	test_i18ngrep "beyond a symbolic link" error-ix &&
+	test_grep "beyond a symbolic link" error-ix &&
 	test_path_is_missing arch/x86_64/dir &&
 	test_path_is_missing arch/i386/dir/file &&
 	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
 	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
=20
 	test_must_fail git apply --cached patch 2>error-ct &&
-	test_i18ngrep "beyond a symbolic link" error-ct &&
+	test_grep "beyond a symbolic link" error-ct &&
 	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
 	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
=20
@@ -135,23 +135,23 @@ test_expect_success SYMLINKS 'do not follow symboli=
c link (existing)' '
 	git add arch/x86_64/dir &&
=20
 	test_must_fail git apply add_file.patch 2>error-wt-add &&
-	test_i18ngrep "beyond a symbolic link" error-wt-add &&
+	test_grep "beyond a symbolic link" error-wt-add &&
 	test_path_is_missing arch/i386/dir/file &&
=20
 	mkdir arch/i386/dir &&
 	>arch/i386/dir/file &&
 	test_must_fail git apply del_file.patch 2>error-wt-del &&
-	test_i18ngrep "beyond a symbolic link" error-wt-del &&
+	test_grep "beyond a symbolic link" error-wt-del &&
 	test_path_is_file arch/i386/dir/file &&
 	rm arch/i386/dir/file &&
=20
 	test_must_fail git apply --index add_file.patch 2>error-ix-add &&
-	test_i18ngrep "beyond a symbolic link" error-ix-add &&
+	test_grep "beyond a symbolic link" error-ix-add &&
 	test_path_is_missing arch/i386/dir/file &&
 	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
=20
 	test_must_fail git apply --cached add_file.patch 2>error-ct-file &&
-	test_i18ngrep "beyond a symbolic link" error-ct-file &&
+	test_grep "beyond a symbolic link" error-ct-file &&
 	test_must_fail git ls-files --error-unmatch arch/i386/dir
 '
=20
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index a1c7686519..e7a7295f1b 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -66,13 +66,13 @@ test_expect_success FILEMODE 'mode update (index only=
)' '
 test_expect_success FILEMODE 'empty mode is rejected' '
 	git reset --hard &&
 	test_must_fail git apply patch-empty-mode.txt 2>err &&
-	test_i18ngrep "invalid mode" err
+	test_grep "invalid mode" err
 '
=20
 test_expect_success FILEMODE 'bogus mode is rejected' '
 	git reset --hard &&
 	test_must_fail git apply patch-bogus-mode.txt 2>err &&
-	test_i18ngrep "invalid mode" err
+	test_grep "invalid mode" err
 '
=20
 test_expect_success POSIXPERM 'do not use core.sharedRepository for work=
ing tree files' '
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 35f1060bc8..c21ddb2946 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -32,9 +32,9 @@ EOF
=20
 test_expect_success 'apply diff with inconsistent filenames in headers' =
'
 	test_must_fail git apply bad1.patch 2>err &&
-	test_i18ngrep "inconsistent new filename" err &&
+	test_grep "inconsistent new filename" err &&
 	test_must_fail git apply bad2.patch 2>err &&
-	test_i18ngrep "inconsistent old filename" err
+	test_grep "inconsistent old filename" err
 '
=20
 test_expect_success 'apply diff with new filename missing from headers' =
'
@@ -46,7 +46,7 @@ test_expect_success 'apply diff with new filename missi=
ng from headers' '
 	+1
 	EOF
 	test_must_fail git apply missing_new_filename.diff 2>err &&
-	test_i18ngrep "lacks filename information" err
+	test_grep "lacks filename information" err
 '
=20
 test_expect_success 'apply diff with old filename missing from headers' =
'
@@ -58,7 +58,7 @@ test_expect_success 'apply diff with old filename missi=
ng from headers' '
 	-1
 	EOF
 	test_must_fail git apply missing_old_filename.diff 2>err &&
-	test_i18ngrep "lacks filename information" err
+	test_grep "lacks filename information" err
 '
=20
 test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2935fe1b2d..3b12576269 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -779,7 +779,7 @@ test_expect_success 'am --resolved fails if index has=
 unmerged entries' '
 	test_must_fail git am --resolved >err &&
 	test_path_is_dir .git/rebase-apply &&
 	test_cmp_rev second HEAD &&
-	test_i18ngrep "still have unmerged paths" err
+	test_grep "still have unmerged paths" err
 '
=20
 test_expect_success 'am takes patches from a Pine mailbox' '
@@ -913,7 +913,7 @@ test_expect_success 'am newline in subject' '
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
 	git am <patchnl >output.out 2>&1 &&
-	test_i18ngrep "^Applying: second \\\n foo$" output.out
+	test_grep "^Applying: second \\\n foo$" output.out
 '
=20
 test_expect_success 'am -q is quiet' '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 5ed7e22827..edb38da701 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -46,7 +46,7 @@ do
=20
 	test_expect_success "am$with3 --skip continue after failed am$with3" '
 		test_must_fail git am$with3 --skip >output &&
-		test_i18ngrep "^Applying: 6$" output &&
+		test_grep "^Applying: 6$" output &&
 		test_cmp file-2-expect file-2 &&
 		test ! -f .git/MERGE_RR
 	'
diff --git a/t/t4153-am-resume-override-opts.sh b/t/t4153-am-resume-overr=
ide-opts.sh
index b7c3861407..4add7c7757 100755
--- a/t/t4153-am-resume-override-opts.sh
+++ b/t/t4153-am-resume-override-opts.sh
@@ -53,7 +53,7 @@ test_expect_success '--no-quiet overrides --quiet' '
 	# Applying side1 will be quiet.
 	test_must_fail git am --quiet side[123].eml >out &&
 	test_path_is_dir .git/rebase-apply &&
-	test_i18ngrep ! "^Applying: " out &&
+	test_grep ! "^Applying: " out &&
 	echo side1 >file &&
 	git add file &&
=20
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7025cfdae5..fb53dddf79 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -433,13 +433,13 @@ test_expect_success 'rerere --no-no-rerere-autoupda=
te' '
 	git update-index --index-info <failedmerge &&
 	cp file3.conflict file3 &&
 	test_must_fail git rerere --no-no-rerere-autoupdate 2>err &&
-	test_i18ngrep [Uu]sage err &&
+	test_grep [Uu]sage err &&
 	test_must_fail git update-index --refresh
 '
=20
 test_expect_success 'rerere -h' '
 	test_must_fail git rerere -h >help &&
-	test_i18ngrep [Uu]sage help
+	test_grep [Uu]sage help
 '
=20
 concat_insert () {
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 8e4effebdb..d7382709fc 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -139,7 +139,7 @@ test_expect_success !MINGW 'shortlog can read --forma=
t=3Draw output' '
=20
 test_expect_success 'shortlog from non-git directory refuses extra argum=
ents' '
 	test_must_fail env GIT_DIR=3Dnon-existing git shortlog foo 2>out &&
-	test_i18ngrep "too many arguments" out
+	test_grep "too many arguments" out
 '
=20
 test_expect_success 'shortlog should add newline when input line matches=
 wraplen' '
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index af4a123cd2..708636671a 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1884,7 +1884,7 @@ test_expect_success '--no-graph does not unset --pa=
rents' '
=20
 test_expect_success '--reverse and --graph conflict' '
 	test_must_fail git log --reverse --graph 2>stderr &&
-	test_i18ngrep "cannot be used together" stderr
+	test_grep "cannot be used together" stderr
 '
=20
 test_expect_success '--reverse --graph --no-graph works' '
@@ -1895,7 +1895,7 @@ test_expect_success '--reverse --graph --no-graph w=
orks' '
=20
 test_expect_success '--show-linear-break and --graph conflict' '
 	test_must_fail git log --show-linear-break --graph 2>stderr &&
-	test_i18ngrep "cannot be used together" stderr
+	test_grep "cannot be used together" stderr
 '
=20
 test_expect_success '--show-linear-break --graph --no-graph works' '
@@ -1906,7 +1906,7 @@ test_expect_success '--show-linear-break --graph --=
no-graph works' '
=20
 test_expect_success '--no-walk and --graph conflict' '
 	test_must_fail git log --no-walk --graph 2>stderr &&
-	test_i18ngrep "cannot be used together" stderr
+	test_grep "cannot be used together" stderr
 '
=20
 test_expect_success '--no-walk --graph --no-graph works' '
@@ -1917,8 +1917,8 @@ test_expect_success '--no-walk --graph --no-graph w=
orks' '
=20
 test_expect_success '--walk-reflogs and --graph conflict' '
 	test_must_fail git log --walk-reflogs --graph 2>stderr &&
-	(test_i18ngrep "cannot combine" stderr ||
-		test_i18ngrep "cannot be used together" stderr)
+	(test_grep "cannot combine" stderr ||
+		test_grep "cannot be used together" stderr)
 '
=20
 test_expect_success '--walk-reflogs --graph --no-graph works' '
@@ -2252,7 +2252,7 @@ test_expect_success 'log on empty repo fails' '
 	git init empty &&
 	test_when_finished "rm -rf empty" &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep does.not.have.any.commits stderr
+	test_grep does.not.have.any.commits stderr
 '
=20
 test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
@@ -2260,16 +2260,16 @@ test_expect_success REFFILES 'log diagnoses bogus=
 HEAD hash' '
 	test_when_finished "rm -rf empty" &&
 	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr
+	test_grep broken stderr
 '
=20
 test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
 	git init empty &&
 	echo "ref: refs/heads/invalid.lock" > empty/.git/HEAD &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr &&
+	test_grep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-	test_i18ngrep broken stderr
+	test_grep broken stderr
 '
=20
 test_expect_success 'log does not default to HEAD when rev input is give=
n' '
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 2016132f51..8a88dd7900 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -360,7 +360,7 @@ test_expect_success 'mailmap.blob might be the wrong =
type' '
 	cp default.map .mailmap &&
=20
 	git -c mailmap.blob=3DHEAD: shortlog HEAD >actual 2>err &&
-	test_i18ngrep "mailmap is not a blob" err &&
+	test_grep "mailmap is not a blob" err &&
 	test_cmp expect actual
 '
=20
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.s=
h
index 2e8f5ad7b8..806b2809d4 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -21,7 +21,7 @@ test_expect_success '"git log :/" should not be ambiguo=
us' '
 test_expect_success '"git log :/a" should be ambiguous (applied both rev=
 and worktree)' '
 	: >a &&
 	test_must_fail git log :/a 2>error &&
-	test_i18ngrep ambiguous error
+	test_grep ambiguous error
 '
=20
 test_expect_success '"git log :/a -- " should not be ambiguous' '
@@ -65,7 +65,7 @@ test_expect_success '"git log :/in" should not be ambig=
uous' '
=20
 test_expect_success '"git log :" should be ambiguous' '
 	test_must_fail git log : 2>error &&
-	test_i18ngrep ambiguous error
+	test_grep ambiguous error
 '
=20
 test_expect_success 'git log -- :' '
@@ -104,7 +104,7 @@ test_expect_success '"git log :(exclude)sub --" must =
resolve as an object' '
=20
 test_expect_success '"git log :(unknown-magic) complains of bogus magic'=
 '
 	test_must_fail git log ":(unknown-magic)" 2>error &&
-	test_i18ngrep pathspec.magic error
+	test_grep pathspec.magic error
 '
=20
 test_expect_success 'command line pathspec parsing for "git log"' '
diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 7f6bb27f14..64e1623733 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -57,10 +57,10 @@ test_expect_success setup '
=20
 test_expect_success 'usage' '
 	test_expect_code 129 git log -S 2>err &&
-	test_i18ngrep "switch.*requires a value" err &&
+	test_grep "switch.*requires a value" err &&
=20
 	test_expect_code 129 git log -G 2>err &&
-	test_i18ngrep "switch.*requires a value" err &&
+	test_grep "switch.*requires a value" err &&
=20
 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
 	grep "cannot be used together" err &&
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index c6540e822f..02d76dca28 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -19,7 +19,7 @@ test_expect_success 'basic command line parsing' '
=20
 	# -L requires there is no pathspec
 	test_must_fail git log -L1,1:b.c -- b.c 2>error &&
-	test_i18ngrep "cannot be used with pathspec" error &&
+	test_grep "cannot be used with pathspec" error &&
=20
 	# This would fail because --follow wants a single path, but
 	# we may fail due to incompatibility between -L/--follow in
@@ -50,7 +50,7 @@ canned_test_failure () {
 test_bad_opts () {
 	test_expect_success "invalid args: $1" "
 		test_must_fail git log $1 2>errors &&
-		test_i18ngrep '$2' errors
+		test_grep '$2' errors
 	"
 }
=20
diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
index 85e90acb09..e6b59123a3 100755
--- a/t/t4212-log-corrupt.sh
+++ b/t/t4212-log-corrupt.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
=20
 test_expect_success 'fsck notices broken commit' '
 	test_must_fail git fsck 2>actual &&
-	test_i18ngrep invalid.author actual
+	test_grep invalid.author actual
 '
=20
 test_expect_success 'git log with broken author email' '
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 1015273bc8..92d8c8b651 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup' '
=20
 test_expect_success 'am with format=3Dflowed' '
 	git am <"$TEST_DIRECTORY/t4256/1/patch" 2>stderr &&
-	test_i18ngrep "warning: Patch sent with format=3Dflowed" stderr &&
+	test_grep "warning: Patch sent with format=3Dflowed" stderr &&
 	test_cmp "$TEST_DIRECTORY/t4256/1/mailinfo.c" mailinfo.c
 '
=20
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 745089479c..d402ec18b7 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -541,7 +541,7 @@ test_expect_success 'make sure index-pack detects the=
 SHA1 collision' '
 	(
 		cd corrupt &&
 		test_must_fail git index-pack -o ../bad.idx ../test-3.pack 2>msg &&
-		test_i18ngrep "SHA1 COLLISION FOUND" msg
+		test_grep "SHA1 COLLISION FOUND" msg
 	)
 '
=20
@@ -549,7 +549,7 @@ test_expect_success 'make sure index-pack detects the=
 SHA1 collision (large blob
 	(
 		cd corrupt &&
 		test_must_fail git -c core.bigfilethreshold=3D1 index-pack -o ../bad.i=
dx ../test-3.pack 2>msg &&
-		test_i18ngrep "SHA1 COLLISION FOUND" msg
+		test_grep "SHA1 COLLISION FOUND" msg
 	)
 '
=20
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index f89809be53..d88e6f1691 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -282,8 +282,8 @@ test_expect_success 'index-pack --fsck-objects also w=
arns upon missing tagger in
 test_expect_success 'index-pack -v --stdin produces progress for both ph=
ases' '
 	pack=3D$(git pack-objects --all pack </dev/null) &&
 	GIT_PROGRESS_DELAY=3D0 git index-pack -v --stdin <pack-$pack.pack 2>err=
 &&
-	test_i18ngrep "Receiving objects" err &&
-	test_i18ngrep "Resolving deltas" err
+	test_grep "Receiving objects" err &&
+	test_grep "Resolving deltas" err
 '
=20
 test_expect_success 'too-large packs report the breach' '
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b4df545e5a..1f1f664871 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -318,10 +318,10 @@ test_expect_success 'prune: handle HEAD reflog in m=
ultiple worktrees' '
=20
 test_expect_success 'prune: handle expire option correctly' '
 	test_must_fail git prune --expire 2>error &&
-	test_i18ngrep "requires a value" error &&
+	test_grep "requires a value" error &&
=20
 	test_must_fail git prune --expire=3Dnyah 2>error &&
-	test_i18ngrep "malformed expiration" error &&
+	test_grep "malformed expiration" error &&
=20
 	git prune --no-expire
 '
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 78c1c6c923..d7fd71360e 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -271,7 +271,7 @@ test_bitmap_cases () {
 		mv -f $bitmap.tmp $bitmap &&
 		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 		test_cmp expect actual &&
-		test_i18ngrep corrupt.ewah.bitmap stderr
+		test_grep corrupt.ewah.bitmap stderr
 	'
=20
 	test_expect_success 'truncated bitmap fails gracefully (cache)' '
@@ -284,7 +284,7 @@ test_bitmap_cases () {
 		mv -f $bitmap.tmp $bitmap &&
 		git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 		test_cmp expect actual &&
-		test_i18ngrep corrupted.bitmap.index stderr
+		test_grep corrupted.bitmap.index stderr
 	'
=20
 	# Create a state of history with these properties:
@@ -471,7 +471,7 @@ sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSA=
L
 test_expect_success 'incremental repack fails when bitmaps are requested=
' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
-	test_i18ngrep "Incremental repacks are incompatible with bitmap" err
+	test_grep "Incremental repacks are incompatible with bitmap" err
 '
=20
 test_expect_success 'incremental repack can disable bitmaps' '
@@ -524,7 +524,7 @@ test_expect_success 'truncated bitmap fails gracefull=
y (lookup table)' '
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-	test_i18ngrep corrupted.bitmap.index stderr
+	test_grep corrupted.bitmap.index stderr
 '
=20
 test_done
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4df76173a8..10718142b0 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -47,7 +47,7 @@ test_expect_success 'exit with correct error on bad inp=
ut to --stdin-packs' '
 	echo doesnotexist >in &&
 	test_expect_code 1 git -C full commit-graph write --stdin-packs \
 		<in 2>stderr &&
-	test_i18ngrep "error adding pack" stderr
+	test_grep "error adding pack" stderr
 '
=20
 test_expect_success 'create commits and repack' '
@@ -67,11 +67,11 @@ test_expect_success 'exit with correct error on bad i=
nput to --stdin-commits' '
 	# invalid, non-hex OID
 	echo HEAD | test_expect_code 1 git -C full commit-graph write \
 		--stdin-commits 2>stderr &&
-	test_i18ngrep "unexpected non-hex object ID: HEAD" stderr &&
+	test_grep "unexpected non-hex object ID: HEAD" stderr &&
 	# non-existent OID
 	echo $ZERO_OID | test_expect_code 1 git -C full commit-graph write \
 		--stdin-commits 2>stderr &&
-	test_i18ngrep "invalid object" stderr &&
+	test_grep "invalid object" stderr &&
 	# valid commit and tree OID
 	git -C full rev-parse HEAD HEAD^{tree} >in &&
 	git -C full commit-graph write --stdin-commits <in &&
@@ -143,7 +143,7 @@ test_expect_success 'commit-graph write --stdin-commi=
ts force progress on for st
 	git -C full rev-parse commits/5 >in &&
 	GIT_PROGRESS_DELAY=3D0 git -C full commit-graph write --stdin-commits \
 		--progress <in 2>err &&
-	test_i18ngrep "Collecting commits from input" err
+	test_grep "Collecting commits from input" err
 '
=20
 test_expect_success 'commit-graph write --stdin-commits with the --no-pr=
ogress option' '
@@ -383,13 +383,13 @@ test_expect_success 'warn on improper hash version'=
 '
 		cd sha1 &&
 		mv ../cg-sha256 .git/objects/info/commit-graph &&
 		git log -1 2>err &&
-		test_i18ngrep "commit-graph hash version 2 does not match version 1" e=
rr
+		test_grep "commit-graph hash version 2 does not match version 1" err
 	) &&
 	(
 		cd sha256 &&
 		mv ../cg-sha1 .git/objects/info/commit-graph &&
 		git log -1 2>err &&
-		test_i18ngrep "commit-graph hash version 1 does not match version 2" e=
rr
+		test_grep "commit-graph hash version 1 does not match version 2" err
 	)
 '
=20
@@ -473,7 +473,7 @@ corrupt_graph_verify() {
 	grepstr=3D$1
 	test_must_fail git -C full commit-graph verify 2>test_err &&
 	grep -v "^+" test_err >err &&
-	test_i18ngrep "$grepstr" err &&
+	test_grep "$grepstr" err &&
 	if test "$2" !=3D "no-copy"
 	then
 		cp full/$objdir/info/commit-graph commit-graph-pre-write-test
@@ -714,7 +714,7 @@ test_expect_success 'corrupt commit-graph write (brok=
en parent)' '
 		git commit-tree -p "$broken" -m "good commit" "$empty" >good &&
 		test_must_fail git commit-graph write --stdin-commits \
 			<good 2>test_err &&
-		test_i18ngrep "unable to parse commit" test_err
+		test_grep "unable to parse commit" test_err
 	)
 '
=20
@@ -735,7 +735,7 @@ test_expect_success 'corrupt commit-graph write (miss=
ing tree)' '
 		git commit-tree -p "$broken" -m "good" "$tree" >good &&
 		test_must_fail git commit-graph write --stdin-commits \
 			<good 2>test_err &&
-		test_i18ngrep "unable to parse commit" test_err
+		test_grep "unable to parse commit" test_err
 	)
 '
=20
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1bcc02004d..4b01d78ccb 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -279,13 +279,13 @@ test_expect_success 'warn on improper hash version'=
 '
 		cd sha1 &&
 		mv ../mpi-sha256 .git/objects/pack/multi-pack-index &&
 		git log -1 2>err &&
-		test_i18ngrep "multi-pack-index hash version 2 does not match version =
1" err
+		test_grep "multi-pack-index hash version 2 does not match version 1" e=
rr
 	) &&
 	(
 		cd sha256 &&
 		mv ../mpi-sha1 .git/objects/pack/multi-pack-index &&
 		git log -1 2>err &&
-		test_i18ngrep "multi-pack-index hash version 1 does not match version =
2" err
+		test_grep "multi-pack-index hash version 1 does not match version 2" e=
rr
 	)
 '
=20
@@ -386,7 +386,7 @@ corrupt_midx_and_verify() {
 	printf "$DATA" | dd of=3D"$FILE" bs=3D1 seek=3D"$POS" conv=3Dnotrunc &&
 	test_must_fail $COMMAND 2>test_err &&
 	grep -v "^+" test_err >err &&
-	test_i18ngrep "$GREPSTR" err
+	test_grep "$GREPSTR" err
 }
=20
 test_expect_success 'verify bad signature' '
@@ -501,7 +501,7 @@ test_expect_success 'corrupt MIDX is not reused' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" &&
 	git multi-pack-index write 2>err &&
-	test_i18ngrep checksum.mismatch err &&
+	test_grep checksum.mismatch err &&
 	git multi-pack-index verify
 '
=20
@@ -1031,7 +1031,7 @@ test_expect_success 'load reverse index when missin=
g .idx, .pack' '
=20
 test_expect_success 'usage shown without sub-command' '
 	test_expect_code 129 git multi-pack-index 2>err &&
-	! test_i18ngrep "unrecognized subcommand" err
+	! test_grep "unrecognized subcommand" err
 '
=20
 test_expect_success 'complains when run outside of a repository' '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.s=
h
index 36c4141e67..a48c00ef50 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -281,7 +281,7 @@ test_expect_success 'verify hashes along chain, even =
in shallow' '
 		corrupt_file "$base_file" $(test_oid shallow) "\01" &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "incorrect checksum" err
+		test_grep "incorrect checksum" err
 	)
 '
=20
@@ -295,7 +295,7 @@ test_expect_success 'verify --shallow does not check =
base contents' '
 		git commit-graph verify --shallow &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "incorrect checksum" err
+		test_grep "incorrect checksum" err
 	)
 '
=20
@@ -308,7 +308,7 @@ test_expect_success 'warn on base graph chunk incorre=
ct' '
 		corrupt_file "$base_file" $(test_oid base) "\01" &&
 		git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "commit-graph chain does not match" err
+		test_grep "commit-graph chain does not match" err
 	)
 '
=20
@@ -319,11 +319,11 @@ test_expect_success 'verify after commit-graph-chai=
n corruption' '
 		corrupt_file "$graphdir/commit-graph-chain" 60 "G" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "invalid commit-graph chain" err &&
+		test_grep "invalid commit-graph chain" err &&
 		corrupt_file "$graphdir/commit-graph-chain" 60 "A" &&
 		git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "unable to find all commit-graph files" err
+		test_grep "unable to find all commit-graph files" err
 	)
 '
=20
@@ -341,7 +341,7 @@ test_expect_success 'verify across alternates' '
 		corrupt_file "$tip_file" 100 "\01" &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "commit-graph has incorrect fanout value" err
+		test_grep "commit-graph has incorrect fanout value" err
 	)
 '
=20
@@ -353,7 +353,7 @@ test_expect_success 'add octopus merge' '
 	git commit-graph verify --progress 2>err &&
 	test_line_count =3D 1 err &&
 	grep "Verifying commits in commit graph: 100% (18/18)" err &&
-	test_i18ngrep ! warning err &&
+	test_grep ! warning err &&
 	test_line_count =3D 3 $graphdir/commit-graph-chain
 '
=20
@@ -455,7 +455,7 @@ test_expect_success 'prevent regression for duplicate=
 commits across layers' '
 	git init dup &&
 	git -C dup commit --allow-empty -m one &&
 	git -C dup -c core.commitGraph=3Dfalse commit-graph write --split=3Dno-=
merge --reachable 2>err &&
-	test_i18ngrep "attempting to write a commit-graph" err &&
+	test_grep "attempting to write a commit-graph" err &&
 	git -C dup commit-graph write --split=3Dno-merge --reachable &&
 	git -C dup commit --allow-empty -m two &&
 	git -C dup commit-graph write --split=3Dno-merge --reachable &&
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.s=
h
index acab31667a..2dcf1eecee 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -65,7 +65,7 @@ test_expect_success '--stdin-packs is incompatible with=
 --filter' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --stdout \
 			--filter=3Dblob:none </dev/null 2>err &&
-		test_i18ngrep "cannot use --filter with --stdin-packs" err
+		test_grep "cannot use --filter with --stdin-packs" err
 	)
 '
=20
@@ -74,7 +74,7 @@ test_expect_success '--stdin-packs is incompatible with=
 --revs' '
 		cd stdin-packs &&
 		test_must_fail git pack-objects --stdin-packs --revs out \
 			</dev/null 2>err &&
-		test_i18ngrep "cannot use internal rev list with --stdin-packs" err
+		test_grep "cannot use internal rev list with --stdin-packs" err
 	)
 '
=20
diff --git a/t/t5411/test-0026-push-options.sh b/t/t5411/test-0026-push-o=
ptions.sh
index 6dfc7b1c0d..510fff38da 100644
--- a/t/t5411/test-0026-push-options.sh
+++ b/t/t5411/test-0026-push-options.sh
@@ -18,7 +18,7 @@ test_expect_success "proc-receive: not support push opt=
ions ($PROTOCOL)" '
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	test_i18ngrep "fatal: the receiving end does not support push options" =
\
+	test_grep "fatal: the receiving end does not support push options" \
 		actual &&
=20
 	test_cmp_refs -C "$upstream" <<-EOF
diff --git a/t/t5411/test-0027-push-options--porcelain.sh b/t/t5411/test-=
0027-push-options--porcelain.sh
index 768880b40f..9435457de0 100644
--- a/t/t5411/test-0027-push-options--porcelain.sh
+++ b/t/t5411/test-0027-push-options--porcelain.sh
@@ -19,7 +19,7 @@ test_expect_success "proc-receive: not support push opt=
ions ($PROTOCOL/porcelain
 		HEAD:refs/for/main/topic \
 		>out-$test_count 2>&1 &&
 	make_user_friendly_and_stable_output <out-$test_count >actual &&
-	test_i18ngrep "fatal: the receiving end does not support push options" =
\
+	test_grep "fatal: the receiving end does not support push options" \
 		actual &&
=20
 	test_cmp_refs -C "$upstream" <<-EOF
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d18f2823d8..573e62341f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,7 +403,7 @@ test_expect_success 'in_vain not triggered before fir=
st ACK' '
 	test_commit -C myserver bar &&
=20
 	git -C myclient fetch --progress origin 2>log &&
-	test_i18ngrep "remote: Total 3 " log
+	test_grep "remote: Total 3 " log
 '
=20
 test_expect_success 'in_vain resetted upon ACK' '
@@ -435,7 +435,7 @@ test_expect_success 'in_vain resetted upon ACK' '
 	# the client reports that first_anotherbranch_commit is common.
 	GIT_TRACE2_EVENT=3D"$(pwd)/trace2" git -C myclient fetch --progress ori=
gin main 2>log &&
 	grep \"key\":\"total_rounds\",\"value\":\"6\" trace2 &&
-	test_i18ngrep "Total 3 " log
+	test_grep "Total 3 " log
 '
=20
 test_expect_success 'fetch in shallow repo unreachable shallow objects' =
'
@@ -459,7 +459,7 @@ test_expect_success 'fetch creating new shallow root'=
 '
 		git fetch --depth=3D1 --progress 2>actual &&
 		# This should fetch only the empty commit, no tree or
 		# blob objects
-		test_i18ngrep "remote: Total 1" actual
+		test_grep "remote: Total 1" actual
 	)
 '
=20
@@ -694,7 +694,7 @@ test_expect_success 'fetch-pack cannot fetch a raw sh=
a1 that is not advertised a
 	# unadvertised objects, so restrict this test to v0.
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 git -C client fetch-pa=
ck ../server \
 		$(git -C server rev-parse refs/heads/main^) 2>err &&
-	test_i18ngrep "Server does not allow request for unadvertised object" e=
rr
+	test_grep "Server does not allow request for unadvertised object" err
 '
=20
 check_prot_path () {
@@ -1010,7 +1010,7 @@ test_expect_success 'filtering by size has no effec=
t if support for it is not ad
 	git -C client rev-list --objects --missing=3Dallow-any "$commit" >oids =
&&
 	grep "$blob" oids &&
=20
-	test_i18ngrep "filtering not recognized by server" err
+	test_grep "filtering not recognized by server" err
 '
=20
 fetch_filter_blob_limit_zero () {
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-stri=
ct.sh
index 0b8ab4afdb..138e6778a4 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -144,7 +144,7 @@ test_expect_success 'setup bogus commit' '
=20
 test_expect_success 'fsck with no skipList input' '
 	test_must_fail git fsck 2>err &&
-	test_i18ngrep "missingEmail" err
+	test_grep "missingEmail" err
 '
=20
 test_expect_success 'setup sorted and unsorted skipLists' '
@@ -169,9 +169,9 @@ test_expect_success 'fsck with unsorted skipList' '
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=3D/dev/null -c fsck.missingEmail=3Dignore fsck &&
 	test_must_fail git -c fsck.skipList=3Ddoes-not-exist -c fsck.missingEma=
il=3Dignore fsck 2>err &&
-	test_i18ngrep "could not open.*: does-not-exist" err &&
+	test_grep "could not open.*: does-not-exist" err &&
 	test_must_fail git -c fsck.skipList=3D.git/config -c fsck.missingEmail=3D=
ignore fsck 2>err &&
-	test_i18ngrep "invalid object name: \[core\]" err
+	test_grep "invalid object name: \[core\]" err
 '
=20
 test_expect_success 'fsck with other accepted skipList input (comments &=
 empty lines)' '
@@ -180,14 +180,14 @@ test_expect_success 'fsck with other accepted skipL=
ist input (comments & empty l
 	$(test_oid 001)
 	EOF
 	test_must_fail git -c fsck.skipList=3DSKIP.with-comment fsck 2>err-with=
-comment &&
-	test_i18ngrep "missingEmail" err-with-comment &&
+	test_grep "missingEmail" err-with-comment &&
 	cat >SKIP.with-empty-line <<-EOF &&
 	$(test_oid 001)
=20
 	$(test_oid 002)
 	EOF
 	test_must_fail git -c fsck.skipList=3DSKIP.with-empty-line fsck 2>err-w=
ith-empty-line &&
-	test_i18ngrep "missingEmail" err-with-empty-line
+	test_grep "missingEmail" err-with-empty-line
 '
=20
 test_expect_success 'fsck no garbage output from comments & empty lines =
errors' '
@@ -198,7 +198,7 @@ test_expect_success 'fsck no garbage output from comm=
ents & empty lines errors'
 test_expect_success 'fsck with invalid abbreviated skipList input' '
 	echo $commit | test_copy_bytes 20 >SKIP.abbreviated &&
 	test_must_fail git -c fsck.skipList=3DSKIP.abbreviated fsck 2>err-abbre=
viated &&
-	test_i18ngrep "^fatal: invalid object name: " err-abbreviated
+	test_grep "^fatal: invalid object name: " err-abbreviated
 '
=20
 test_expect_success 'fsck with exhaustive accepted skipList input (vario=
us types of comments etc.)' '
@@ -231,10 +231,10 @@ test_expect_success 'push with receive.fsck.skipLis=
t' '
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=3Ddst/.git config receive.fsck.skipList does-not-exist &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "could not open.*: does-not-exist" err &&
+	test_grep "could not open.*: does-not-exist" err &&
 	git --git-dir=3Ddst/.git config receive.fsck.skipList config &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "invalid object name: \[core\]" err &&
+	test_grep "invalid object name: \[core\]" err &&
=20
 	git --git-dir=3Ddst/.git config receive.fsck.skipList SKIP &&
 	git push --porcelain dst bogus
@@ -260,10 +260,10 @@ test_expect_success 'fetch with fetch.fsck.skipList=
' '
 	test_must_fail git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec =
&&
 	git --git-dir=3Ddst/.git config fetch.fsck.skipList does-not-exist &&
 	test_must_fail git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec =
2>err &&
-	test_i18ngrep "could not open.*: does-not-exist" err &&
+	test_grep "could not open.*: does-not-exist" err &&
 	git --git-dir=3Ddst/.git config fetch.fsck.skipList dst/.git/config &&
 	test_must_fail git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec =
2>err &&
-	test_i18ngrep "invalid object name: \[core\]" err &&
+	test_grep "invalid object name: \[core\]" err &&
=20
 	git --git-dir=3Ddst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 	git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec
@@ -271,7 +271,7 @@ test_expect_success 'fetch with fetch.fsck.skipList' =
'
=20
 test_expect_success 'fsck.<unknownmsg-id> dies' '
 	test_must_fail git -c fsck.whatEver=3Dignore fsck 2>err &&
-	test_i18ngrep "Unhandled message id: whatever" err
+	test_grep "Unhandled message id: whatever" err
 '
=20
 test_expect_success 'push with receive.fsck.missingEmail=3Dwarn' '
@@ -293,7 +293,7 @@ test_expect_success 'push with receive.fsck.missingEm=
ail=3Dwarn' '
 		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	grep "missingEmail" act &&
-	test_i18ngrep "skipping unknown msg id.*whatever" act &&
+	test_grep "skipping unknown msg id.*whatever" act &&
 	git --git-dir=3Ddst/.git branch -D bogus &&
 	git --git-dir=3Ddst/.git config --add \
 		receive.fsck.missingEmail ignore &&
@@ -321,7 +321,7 @@ test_expect_success 'fetch with fetch.fsck.missingEma=
il=3Dwarn' '
 		fetch.fsck.missingEmail warn &&
 	git --git-dir=3Ddst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
 	grep "missingEmail" act &&
-	test_i18ngrep "Skipping unknown msg id.*whatever" act &&
+	test_grep "Skipping unknown msg id.*whatever" act &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=3Ddst/.git config fetch.fsckobjects true &&
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 43b7bcd715..7789ff12c4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1075,7 +1075,7 @@ test_expect_success 'remote prune to cause a dangli=
ng symref' '
 		cd eight &&
 		git remote prune origin
 	) >err 2>&1 &&
-	test_i18ngrep "has become dangling" err &&
+	test_grep "has become dangling" err &&
=20
 	: And the dangling symref will not cause other annoying errors &&
 	(
@@ -1087,7 +1087,7 @@ test_expect_success 'remote prune to cause a dangli=
ng symref' '
 		cd eight &&
 		test_must_fail git branch nomore origin
 	) 2>err &&
-	test_i18ngrep "dangling symref" err
+	test_grep "dangling symref" err
 '
=20
 test_expect_success 'show empty remote' '
@@ -1419,7 +1419,7 @@ test_expect_success 'extra args: setup' '
 test_extra_arg () {
 	test_expect_success "extra args: $*" "
 		test_must_fail git remote $* bogus_extra_arg 2>actual &&
-		test_i18ngrep '^usage:' actual
+		test_grep '^usage:' actual
 	"
 }
=20
@@ -1453,12 +1453,12 @@ test_expect_success 'unqualified <dst> refspec DW=
IM and advice' '
 				oid=3D$(git rev-parse some-tag^{$type})
 			fi &&
 			test_must_fail git push origin $oid:dst 2>err &&
-			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep "hint: Did you mean" err &&
+			test_grep "error: The destination you" err &&
+			test_grep "hint: Did you mean" err &&
 			test_must_fail git -c advice.pushUnqualifiedRefName=3Dfalse \
 				push origin $oid:dst 2>err &&
-			test_i18ngrep "error: The destination you" err &&
-			test_i18ngrep ! "hint: Did you mean" err ||
+			test_grep "error: The destination you" err &&
+			test_grep ! "hint: Did you mean" err ||
 			exit 1
 		done
 	)
@@ -1479,16 +1479,16 @@ test_expect_success 'refs/remotes/* <src> refspec=
 and unqualified <dst> DWIM and
 		git fetch --no-tags two &&
=20
 		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+		test_grep "error: The destination you" err &&
=20
 		test_must_fail git push origin refs/remotes/tags-from-two/my-tag:dst-t=
ag 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+		test_grep "error: The destination you" err &&
=20
 		test_must_fail git push origin refs/remotes/trees-from-two/my-head-tre=
e:dst-tree 2>err &&
-		test_i18ngrep "error: The destination you" err &&
+		test_grep "error: The destination you" err &&
=20
 		test_must_fail git push origin refs/remotes/blobs-from-two/my-file-blo=
b:dst-blob 2>err &&
-		test_i18ngrep "error: The destination you" err
+		test_grep "error: The destination you" err
 	)
 '
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4f289063ce..c940521bcc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -415,9 +415,9 @@ test_expect_success 'fetch uses remote ref names to d=
escribe new refs' '
 	(
 		cd descriptive &&
 		git fetch o 2>actual &&
-		test_i18ngrep "new branch.* -> refs/crazyheads/descriptive-branch$" ac=
tual &&
-		test_i18ngrep "new tag.* -> descriptive-tag$" actual &&
-		test_i18ngrep "new ref.* -> crazy$" actual
+		test_grep "new branch.* -> refs/crazyheads/descriptive-branch$" actual=
 &&
+		test_grep "new tag.* -> descriptive-tag$" actual &&
+		test_grep "new ref.* -> crazy$" actual
 	) &&
 	git checkout main
 '
@@ -1113,7 +1113,7 @@ test_expect_success 'fetching with auto-gc does not=
 lock up' '
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
 		GIT_ASK_YESNO=3D"$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
-		test_i18ngrep "Auto packing the repository" fetch.out &&
+		test_grep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out
 	)
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 151c76eb09..5dbe107ce8 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -320,7 +320,7 @@ test_expect_success 'ls-remote works outside reposito=
ry' '
 test_expect_success 'ls-remote --sort fails gracefully outside repositor=
y' '
 	# Use a sort key that requires access to the referenced objects.
 	nongit test_must_fail git ls-remote --sort=3Dauthordate "$TRASH_DIRECTO=
RY" 2>err &&
-	test_i18ngrep "^fatal: not a git repository, but the field '\''authorda=
te'\'' requires access to object data" err
+	test_grep "^fatal: not a git repository, but the field '\''authordate'\=
'' requires access to object data" err
 '
=20
 test_expect_success 'ls-remote patterns work with all protocol versions'=
 '
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 98f034aa77..a95841dc36 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -200,8 +200,8 @@ test_expect_success 'parallel' '
 	test_must_fail env GIT_TRACE=3D"$PWD/trace" \
 		git fetch --jobs=3D2 --multiple one two 2>err &&
 	grep "preparing to run up to 2 tasks" trace &&
-	test_i18ngrep "could not fetch .one.*128" err &&
-	test_i18ngrep "could not fetch .two.*128" err
+	test_grep "could not fetch .one.*128" err &&
+	test_grep "could not fetch .two.*128" err
 '
=20
 test_expect_success 'git fetch --multiple --jobs=3D0 picks a default' '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 87163d7745..2e7c0e1648 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -227,7 +227,7 @@ test_expect_success 'push with negotiation proceeds a=
nyway even if negotiation f
 	GIT_TEST_PROTOCOL_VERSION=3D0 GIT_TRACE2_EVENT=3D"$(pwd)/event" \
 		git -c push.negotiate=3D1 push testrepo refs/heads/main:refs/remotes/o=
rigin/main 2>err &&
 	grep_wrote 5 event && # 2 commits, 2 trees, 1 blob
-	test_i18ngrep "push negotiation failed" err
+	test_grep "push negotiation failed" err
 '
=20
 test_expect_success 'push with negotiation does not attempt to fetch sub=
modules' '
@@ -1267,7 +1267,7 @@ test_expect_success 'fetch exact SHA1' '
 		# fetching the hidden object should fail by default
 		test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 \
 			git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
-		test_i18ngrep "Server does not allow request for unadvertised object" =
err &&
+		test_grep "Server does not allow request for unadvertised object" err =
&&
 		test_must_fail git rev-parse --verify refs/heads/copy &&
=20
 		# the server side can allow it to succeed
@@ -1369,7 +1369,7 @@ do
 				git fetch ../testrepo/.git $SHA1_3 2>err &&
 			# ideally we would insist this be on a "remote error:"
 			# line, but it is racy; see the commit message
-			test_i18ngrep "not our ref.*$SHA1_3\$" err
+			test_grep "not our ref.*$SHA1_3\$" err
 		)
 	'
 done
@@ -1407,7 +1407,7 @@ test_expect_success 'peeled advertisements are not =
considered ref tips' '
 	oid=3D$(git -C testrepo rev-parse mytag^{commit}) &&
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 \
 		git fetch testrepo $oid 2>err &&
-	test_i18ngrep "Server does not allow request for unadvertised object" e=
rr
+	test_grep "Server does not allow request for unadvertised object" err
 '
=20
 test_expect_success 'pushing a specific ref applies remote.$name.push as=
 refmap' '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 0b72112fb1..47534f1062 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -31,7 +31,7 @@ test_pull_autostash_fail () {
 	echo dirty >new_file &&
 	git add new_file &&
 	test_must_fail git pull "$@" . copy 2>err &&
-	test_i18ngrep -E "uncommitted changes.|overwritten by merge:" err
+	test_grep -E "uncommitted changes.|overwritten by merge:" err
 }
=20
 test_expect_success setup '
@@ -151,7 +151,7 @@ test_expect_success 'fail if wildcard spec does not m=
atch any refs' '
 	echo file >expect &&
 	test_cmp expect file &&
 	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>e=
rr &&
-	test_i18ngrep "no candidates for merging" err &&
+	test_grep "no candidates for merging" err &&
 	test_cmp expect file
 '
=20
@@ -164,7 +164,7 @@ test_expect_success 'fail if no branches specified wi=
th non-default remote' '
 	test_cmp expect file &&
 	test_config branch.test.remote origin &&
 	test_must_fail git pull test_remote 2>err &&
-	test_i18ngrep "specify a branch on the command line" err &&
+	test_grep "specify a branch on the command line" err &&
 	test_cmp expect file
 '
=20
@@ -176,7 +176,7 @@ test_expect_success 'fail if not on a branch' '
 	echo file >expect &&
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
-	test_i18ngrep "not currently on a branch" err &&
+	test_grep "not currently on a branch" err &&
 	test_cmp expect file
 '
=20
@@ -189,7 +189,7 @@ test_expect_success 'fail if no configuration for cur=
rent branch' '
 	echo file >expect &&
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
-	test_i18ngrep "no tracking information" err &&
+	test_grep "no tracking information" err &&
 	test_cmp expect file
 '
=20
@@ -202,7 +202,7 @@ test_expect_success 'pull --all: fail if no configura=
tion for current branch' '
 	echo file >expect &&
 	test_cmp expect file &&
 	test_must_fail git pull --all 2>err &&
-	test_i18ngrep "There is no tracking information" err &&
+	test_grep "There is no tracking information" err &&
 	test_cmp expect file
 '
=20
@@ -214,7 +214,7 @@ test_expect_success 'fail if upstream branch does not=
 exist' '
 	echo file >expect &&
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
-	test_i18ngrep "no such ref was fetched" err &&
+	test_grep "no such ref was fetched" err &&
 	test_cmp expect file
 '
=20
@@ -248,13 +248,13 @@ test_expect_success 'fail if the index has unresolv=
ed entries' '
 	test_file_not_empty unmerged &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "Pulling is not possible because you have unmerged files.=
" err &&
+	test_grep "Pulling is not possible because you have unmerged files." er=
r &&
 	test_cmp expected file &&
 	git add file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "You have not concluded your merge" err &&
+	test_grep "You have not concluded your merge" err &&
 	test_cmp expected file
 '
=20
@@ -264,7 +264,7 @@ test_expect_success 'fast-forwards working tree if br=
anch head is updated' '
 	echo file >expect &&
 	test_cmp expect file &&
 	git pull . second:third 2>err &&
-	test_i18ngrep "fetch updated the current branch head" err &&
+	test_grep "fetch updated the current branch head" err &&
 	echo modified >expect &&
 	test_cmp expect file &&
 	test_cmp_rev third second
@@ -277,7 +277,7 @@ test_expect_success 'fast-forward fails with conflict=
ing work tree' '
 	test_cmp expect file &&
 	echo conflict >file &&
 	test_must_fail git pull . second:third 2>err &&
-	test_i18ngrep "Cannot fast-forward your working tree" err &&
+	test_grep "Cannot fast-forward your working tree" err &&
 	echo conflict >expect &&
 	test_cmp expect file &&
 	test_cmp_rev third second
@@ -375,7 +375,7 @@ test_expect_success '--rebase with conflicts shows ad=
vice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" err
+	test_grep "Resolve all conflicts manually" err
 '
=20
 test_expect_success 'failed --rebase shows advice' '
@@ -389,14 +389,14 @@ test_expect_success 'failed --rebase shows advice' =
'
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" err
+	test_grep "Resolve all conflicts manually" err
 '
=20
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy main 2>err &&
 	test_cmp_rev HEAD before-rebase &&
-	test_i18ngrep "Cannot rebase onto multiple branches" err &&
+	test_grep "Cannot rebase onto multiple branches" err &&
 	echo modified >expect &&
 	git show HEAD:file >actual &&
 	test_cmp expect actual
@@ -520,7 +520,7 @@ test_expect_success 'pull --rebase warns on --verify-=
signatures' '
 	echo new >expect &&
 	git show HEAD:file2 >actual &&
 	test_cmp expect actual &&
-	test_i18ngrep "ignoring --verify-signatures for rebase" err
+	test_grep "ignoring --verify-signatures for rebase" err
 '
=20
 test_expect_success 'pull --rebase does not warn on --no-verify-signatur=
es' '
@@ -530,7 +530,7 @@ test_expect_success 'pull --rebase does not warn on -=
-no-verify-signatures' '
 	echo new >expect &&
 	git show HEAD:file2 >actual &&
 	test_cmp expect actual &&
-	test_i18ngrep ! "verify-signatures" err
+	test_grep ! "verify-signatures" err
 '
=20
 # add a feature branch, keep-merge, that is merged into main, so the
@@ -740,7 +740,7 @@ test_expect_success 'pull --rebase fails on unborn br=
anch with staged changes' '
 		test_cmp expect actual &&
 		git show :staged-file >actual &&
 		test_cmp expect actual &&
-		test_i18ngrep "unborn branch with changes added to the index" err
+		test_grep "unborn branch with changes added to the index" err
 	)
 '
=20
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 264de29c35..d1f0810e42 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -93,7 +93,7 @@ test_expect_success 'git pull --no-write-fetch-head fai=
ls' '
 	(cd clonedwfh && git init &&
 	test_expect_code 129 git pull --no-write-fetch-head "../parent" >out 2>=
err &&
 	test_must_be_empty out &&
-	test_i18ngrep "no-write-fetch-head" err)
+	test_grep "no-write-fetch-head" err)
 '
=20
 test_expect_success 'git pull --force' '
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 1b8d609879..1f859ade16 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -87,7 +87,7 @@ test_expect_success TTY 'progress messages go to tty' '
 	ensure_fresh_upstream &&
=20
 	test_terminal git push -u upstream main >out 2>err &&
-	test_i18ngrep "Writing objects" err
+	test_grep "Writing objects" err
 '
=20
 test_expect_success 'progress messages do not go to non-tty' '
@@ -95,7 +95,7 @@ test_expect_success 'progress messages do not go to non=
-tty' '
=20
 	# skip progress messages, since stderr is non-tty
 	git push -u upstream main >out 2>err &&
-	test_i18ngrep ! "Writing objects" err
+	test_grep ! "Writing objects" err
 '
=20
 test_expect_success 'progress messages go to non-tty (forced)' '
@@ -103,22 +103,22 @@ test_expect_success 'progress messages go to non-tt=
y (forced)' '
=20
 	# force progress messages to stderr, even though it is non-tty
 	git push -u --progress upstream main >out 2>err &&
-	test_i18ngrep "Writing objects" err
+	test_grep "Writing objects" err
 '
=20
 test_expect_success TTY 'push -q suppresses progress' '
 	ensure_fresh_upstream &&
=20
 	test_terminal git push -u -q upstream main >out 2>err &&
-	test_i18ngrep ! "Writing objects" err
+	test_grep ! "Writing objects" err
 '
=20
 test_expect_success TTY 'push --no-progress suppresses progress' '
 	ensure_fresh_upstream &&
=20
 	test_terminal git push -u --no-progress upstream main >out 2>err &&
-	test_i18ngrep ! "Unpacking objects" err &&
-	test_i18ngrep ! "Writing objects" err
+	test_grep ! "Unpacking objects" err &&
+	test_grep ! "Writing objects" err
 '
=20
 test_expect_success TTY 'quiet push' '
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index 284e20fefd..14f7eced9a 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -179,7 +179,7 @@ test_expect_success 'push from/to new branch succeeds=
 with simple if push.autoSe
 test_expect_success '"matching" fails if none match' '
 	git init --bare empty &&
 	test_must_fail git push empty : 2>actual &&
-	test_i18ngrep "Perhaps you should specify a branch" actual
+	test_grep "Perhaps you should specify a branch" actual
 '
=20
 test_expect_success 'push ambiguously named branch with upstream, matchi=
ng and simple' '
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7c1460eaa9..558eedf25a 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -35,8 +35,8 @@ test_expect_success 'upload-pack fails due to error in =
pack-objects packing' '
 	printf "%04xwant %s\n00000009done\n0000" \
 		$(($hexsz + 10)) $head >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	test_i18ngrep "unable to read" output.err &&
-	test_i18ngrep "pack-objects died" output.err
+	test_grep "unable to read" output.err &&
+	test_grep "pack-objects died" output.err
 '
=20
 test_expect_success 'corrupt repo differently' '
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push=
.sh
index 302e4cbdba..f3fff55744 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -311,7 +311,7 @@ test_expect_success 'submodule entry pointing at a ta=
g is error' '
 	git -C work commit -m "bad commit" &&
 	test_when_finished "git -C work reset --hard HEAD^" &&
 	test_must_fail git -C work push --recurse-submodules=3Don-demand ../pub=
.git main 2>err &&
-	test_i18ngrep "is a tag, not a commit" err
+	test_grep "is a tag, not a commit" err
 '
=20
 test_expect_success 'push fails if recurse submodules option passed as y=
es' '
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 7c0a148e73..b4bc24691c 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -68,13 +68,13 @@ test_expect_success 'talking with a receiver without =
push certificate support' '
 test_expect_success 'push --signed fails with a receiver without push ce=
rtificate support' '
 	prepare_dst &&
 	test_must_fail git push --signed dst noop ff +noff 2>err &&
-	test_i18ngrep "the receiving end does not support" err
+	test_grep "the receiving end does not support" err
 '
=20
 test_expect_success 'push --signed=3D1 is accepted' '
 	prepare_dst &&
 	test_must_fail git push --signed=3D1 dst noop ff +noff 2>err &&
-	test_i18ngrep "the receiving end does not support" err
+	test_grep "the receiving end does not support" err
 '
=20
 test_expect_success GPG 'no certificate for a signed push with no update=
' '
@@ -378,7 +378,7 @@ test_expect_success GPG 'failed atomic push does not =
execute GPG' '
 			--signed --atomic --porcelain \
 			dst noop ff noff >out 2>err &&
=20
-	test_i18ngrep ! "gpg failed to sign" err &&
+	test_grep ! "gpg failed to sign" err &&
 	cat >expect <<-EOF &&
 	To dst
 	=3D	refs/heads/noop:refs/heads/noop	[up to date]
diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 91f28c2f78..23bf696170 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -40,7 +40,7 @@ test_expect_success 'fetch conflict: config vs. config'=
 '
 		"+refs/heads/branch2:refs/remotes/origin/branch1" && (
 		cd ccc &&
 		test_must_fail git fetch origin 2>error &&
-		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/he=
ads/branch2 to refs/remotes/origin/branch1" error
+		test_grep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/=
branch2 to refs/remotes/origin/branch1" error
 	)
 '
=20
@@ -67,7 +67,7 @@ test_expect_success 'fetch conflict: arg vs. arg' '
 		test_must_fail git fetch origin \
 			refs/heads/*:refs/remotes/origin/* \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		test_i18ngrep "fatal: Cannot fetch both refs/heads/branch1 and refs/he=
ads/branch2 to refs/remotes/origin/branch1" error
+		test_grep "fatal: Cannot fetch both refs/heads/branch1 and refs/heads/=
branch2 to refs/remotes/origin/branch1" error
 	)
 '
=20
@@ -78,8 +78,8 @@ test_expect_success 'fetch conflict: criss-cross args' =
'
 		git fetch origin \
 			refs/heads/branch1:refs/remotes/origin/branch2 \
 			refs/heads/branch2:refs/remotes/origin/branch1 2>error &&
-		test_i18ngrep "warning: refs/remotes/origin/branch1 usually tracks ref=
s/heads/branch1, not refs/heads/branch2" error &&
-		test_i18ngrep "warning: refs/remotes/origin/branch2 usually tracks ref=
s/heads/branch2, not refs/heads/branch1" error
+		test_grep "warning: refs/remotes/origin/branch1 usually tracks refs/he=
ads/branch1, not refs/heads/branch2" error &&
+		test_grep "warning: refs/remotes/origin/branch2 usually tracks refs/he=
ads/branch2, not refs/heads/branch1" error
 	)
 '
=20
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index d0211cd8be..df758e187d 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -153,7 +153,7 @@ test_expect_success 'push fails for non-fast-forward =
refs unmatched by remote he
 '
=20
 test_expect_success 'push fails for non-fast-forward refs unmatched by r=
emote helper: our output' '
-	test_i18ngrep "Updates were rejected because" \
+	test_grep "Updates were rejected because" \
 		output
 '
=20
@@ -297,7 +297,7 @@ test_expect_success TTY 'push shows progress when std=
err is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
 	test_terminal git push >output 2>&1 &&
-	test_i18ngrep "^Writing objects" output
+	test_grep "^Writing objects" output
 '
=20
 test_expect_success TTY 'push --quiet silences status and progress' '
@@ -311,16 +311,16 @@ test_expect_success TTY 'push --no-progress silence=
s progress but not status' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit no-progress &&
 	test_terminal git push --no-progress >output 2>&1 &&
-	test_i18ngrep "^To http" output &&
-	test_i18ngrep ! "^Writing objects" output
+	test_grep "^To http" output &&
+	test_grep ! "^Writing objects" output
 '
=20
 test_expect_success 'push --progress shows progress to non-tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit progress &&
 	git push --progress >output 2>&1 &&
-	test_i18ngrep "^To http" output &&
-	test_i18ngrep "^Writing objects" output
+	test_grep "^To http" output &&
+	test_grep "^Writing objects" output
 '
=20
 test_expect_success 'http push gives sane defaults to reflog' '
@@ -489,10 +489,10 @@ test_expect_success 'colorize errors/hints' '
 		-c color.push=3Dalways \
 		push origin origin/main^:main 2>act &&
 	test_decode_color <act >decoded &&
-	test_i18ngrep "<RED>.*rejected.*<RESET>" decoded &&
-	test_i18ngrep "<RED>error: failed to push some refs" decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep ! "^hint: " decoded
+	test_grep "<RED>.*rejected.*<RESET>" decoded &&
+	test_grep "<RED>error: failed to push some refs" decoded &&
+	test_grep "<YELLOW>hint: " decoded &&
+	test_grep ! "^hint: " decoded
 '
=20
 test_expect_success 'report error server does not provide ref status' '
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index a158e7d2c0..fb13549da7 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -252,7 +252,7 @@ test_expect_success 'push option denied properly by h=
ttp server' '
 	mk_http_pair false &&
 	test_commit -C test_http_clone one &&
 	test_must_fail git -C test_http_clone push --push-option=3Dasdf origin =
main 2>actual &&
-	test_i18ngrep "the receiving end does not support push options" actual =
&&
+	test_grep "the receiving end does not support push options" actual &&
 	git -C test_http_clone push origin main
 '
=20
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 8f182a3cbf..e444b30bf6 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -376,7 +376,7 @@ test_expect_success 'git client send an empty Accept-=
Language' '
=20
 test_expect_success 'remote-http complains cleanly about malformed urls'=
 '
 	test_must_fail git remote-http http::/example.com/repo.git 2>stderr &&
-	test_i18ngrep "url has no scheme" stderr
+	test_grep "url has no scheme" stderr
 '
=20
 # NEEDSWORK: Writing commands to git-remote-curl can race against the la=
tter
@@ -385,7 +385,7 @@ test_expect_success 'remote-http complains cleanly ab=
out malformed urls' '
 test_expect_success 'remote-http complains cleanly about empty scheme' '
 	test_must_fail ok=3Dsigpipe git ls-remote \
 		http::${HTTPD_URL#http}/dumb/repo.git 2>stderr &&
-	test_i18ngrep "url has no scheme" stderr
+	test_grep "url has no scheme" stderr
 '
=20
 test_expect_success 'redirects can be forbidden/allowed' '
@@ -397,7 +397,7 @@ test_expect_success 'redirects can be forbidden/allow=
ed' '
=20
 test_expect_success 'redirects are reported to stderr' '
 	# just look for a snippet of the redirected-to URL
-	test_i18ngrep /dumb/ stderr
+	test_grep /dumb/ stderr
 '
=20
 test_expect_success 'non-initial redirects can be forbidden' '
@@ -466,7 +466,7 @@ test_expect_success 'can redirect through non-"info/r=
efs?service=3Dgit-upload-pack
=20
 test_expect_success 'print HTTP error when any intermediate redirect thr=
ows error' '
 	test_must_fail git clone "$HTTPD_URL/redir-to/502" 2> stderr &&
-	test_i18ngrep "unable to access.*/redir-to/502" stderr
+	test_grep "unable to access.*/redir-to/502" stderr
 '
=20
 test_expect_success 'fetching via http alternates works' '
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 21b7767cbd..8a41adf1e1 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -275,7 +275,7 @@ test_expect_success 'GIT_SMART_HTTP can disable smart=
 http' '
=20
 test_expect_success 'invalid Content-Type rejected' '
 	test_must_fail git clone $HTTPD_URL/broken_smart/repo.git 2>actual &&
-	test_i18ngrep "not valid:" actual
+	test_grep "not valid:" actual
 '
=20
 test_expect_success 'create namespaced refs' '
@@ -558,7 +558,7 @@ test_expect_success 'GIT_TRACE_CURL_NO_DATA prevents =
data from being traced' '
=20
 test_expect_success 'server-side error detected' '
 	test_must_fail git clone $HTTPD_URL/error_smart/repo.git 2>actual &&
-	test_i18ngrep "server-side error" actual
+	test_grep "server-side error" actual
 '
=20
 test_expect_success 'http auth remembers successful credentials' '
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 1131503b76..f9a9bf9503 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -10,9 +10,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 start_git_daemon
=20
 check_verbose_connect () {
-	test_i18ngrep -F "Looking up 127.0.0.1 ..." stderr &&
-	test_i18ngrep -F "Connecting to 127.0.0.1 (port " stderr &&
-	test_i18ngrep -F "done." stderr
+	test_grep -F "Looking up 127.0.0.1 ..." stderr &&
+	test_grep -F "Connecting to 127.0.0.1 (port " stderr &&
+	test_grep -F "done." stderr
 }
=20
 test_expect_success 'setup repository' '
@@ -108,7 +108,7 @@ test_expect_success 'fetch notices corrupt idx' '
=20
 test_expect_success 'client refuses to ask for repo with newline' '
 	test_must_fail git clone "$GIT_DAEMON_URL/repo$LF.git" dst 2>stderr &&
-	test_i18ngrep newline.is.forbidden stderr
+	test_grep newline.is.forbidden stderr
 '
=20
 test_remote_error()
@@ -148,7 +148,7 @@ test_remote_error()
 	fi
=20
 	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" "$@" 2>output &&
-	test_i18ngrep "fatal: remote error: $msg: /$repo" output &&
+	test_grep "fatal: remote error: $msg: /$repo" output &&
 	ret=3D$?
 	chmod +x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git"
 	(exit $ret)
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 4e917bf87d..51744521f7 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -177,7 +177,7 @@ test_expect_success 'pull --rebase --recurse-submodul=
es fails if both sides reco
 	# submodule itself, but the merge strategy in submodules
 	# does not support rebase:
 	test_must_fail git -C super pull --rebase --recurse-submodules 2>err &&
-	test_i18ngrep "locally recorded submodule modifications" err
+	test_grep "locally recorded submodule modifications" err
 '
=20
 test_expect_success 'pull --rebase --recurse-submodules (no submodule ch=
anges, no fork-point)' '
diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-sign=
atures.sh
index 1221ac0597..ab05f38a99 100755
--- a/t/t5573-pull-verify-signatures.sh
+++ b/t/t5573-pull-verify-signatures.sh
@@ -47,46 +47,46 @@ test_expect_success GPG 'create repositories with sig=
ned commits' '
 test_expect_success GPG 'pull unsigned commit with --verify-signatures' =
'
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures unsigned 2>puller=
ror &&
-	test_i18ngrep "does not have a GPG signature" pullerror
+	test_grep "does not have a GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with bad signature with --verify-si=
gnatures' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &=
&
-	test_i18ngrep "has a bad GPG signature" pullerror
+	test_grep "has a bad GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with untrusted signature with --ver=
ify-signatures' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pulle=
rror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with untrusted signature with --ver=
ify-signatures and minTrustLevel=3Dultimate' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config gpg.minTrustLevel ultimate &&
 	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pulle=
rror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with untrusted signature with --ver=
ify-signatures and minTrustLevel=3Dmarginal' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config gpg.minTrustLevel marginal &&
 	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pulle=
rror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit with untrusted signature with --ver=
ify-signatures and minTrustLevel=3Dundefined' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config gpg.minTrustLevel undefined &&
 	git pull --ff-only --verify-signatures untrusted >pulloutput &&
-	test_i18ngrep "has a good GPG signature" pulloutput
+	test_grep "has a good GPG signature" pulloutput
 '
=20
 test_expect_success GPG 'pull signed commit with --verify-signatures' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	git pull --verify-signatures signed >pulloutput &&
-	test_i18ngrep "has a good GPG signature" pulloutput
+	test_grep "has a good GPG signature" pulloutput
 '
=20
 test_expect_success GPG 'pull commit with bad signature without verifica=
tion' '
@@ -106,7 +106,7 @@ test_expect_success GPG 'pull unsigned commit into un=
born branch' '
 	git init empty-repo &&
 	test_must_fail \
 		git -C empty-repo pull --verify-signatures ..  2>pullerror &&
-	test_i18ngrep "does not have a GPG signature" pullerror
+	test_grep "does not have a GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit into unborn branch with bad signatu=
re and --verify-signatures' '
@@ -114,7 +114,7 @@ test_expect_success GPG 'pull commit into unborn bran=
ch with bad signature and -
 	git init empty-repo &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../bad 2>pullerro=
r &&
-	test_i18ngrep "has a bad GPG signature" pullerror
+	test_grep "has a bad GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit into unborn branch with untrusted s=
ignature and --verify-signatures' '
@@ -122,7 +122,7 @@ test_expect_success GPG 'pull commit into unborn bran=
ch with untrusted signature
 	git init empty-repo &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pu=
llerror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit into unborn branch with untrusted s=
ignature and --verify-signatures and minTrustLevel=3Dultimate' '
@@ -131,7 +131,7 @@ test_expect_success GPG 'pull commit into unborn bran=
ch with untrusted signature
 	test_config_global gpg.minTrustLevel ultimate &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pu=
llerror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit into unborn branch with untrusted s=
ignature and --verify-signatures and minTrustLevel=3Dmarginal' '
@@ -140,7 +140,7 @@ test_expect_success GPG 'pull commit into unborn bran=
ch with untrusted signature
 	test_config_global gpg.minTrustLevel marginal &&
 	test_must_fail \
 		git -C empty-repo pull --ff-only --verify-signatures ../untrusted 2>pu=
llerror &&
-	test_i18ngrep "has an untrusted GPG signature" pullerror
+	test_grep "has an untrusted GPG signature" pullerror
 '
=20
 test_expect_success GPG 'pull commit into unborn branch with untrusted s=
ignature and --verify-signatures and minTrustLevel=3Dundefined' '
@@ -148,7 +148,7 @@ test_expect_success GPG 'pull commit into unborn bran=
ch with untrusted signature
 	git init empty-repo &&
 	test_config_global gpg.minTrustLevel undefined &&
 	git -C empty-repo pull --ff-only --verify-signatures ../untrusted >pull=
output &&
-	test_i18ngrep "has a good GPG signature" pulloutput
+	test_grep "has a good GPG signature" pulloutput
 '
=20
 test_done
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 90e6dcb9a7..a9b06b2251 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -281,12 +281,12 @@ test_expect_success '--no-show-forced-updates' '
 	(
 		cd forced-update-clone &&
 		git fetch --show-forced-updates origin 2>output &&
-		test_i18ngrep "(forced update)" output
+		test_grep "(forced update)" output
 	) &&
 	(
 		cd no-forced-update-clone &&
 		git fetch --no-show-forced-updates origin 2>output &&
-		test_i18ngrep ! "(forced update)" output
+		test_grep ! "(forced update)" output
 	)
 '
=20
diff --git a/t/t5580-unc-paths.sh b/t/t5580-unc-paths.sh
index cd7604fff9..d7537a162b 100755
--- a/t/t5580-unc-paths.sh
+++ b/t/t5580-unc-paths.sh
@@ -75,7 +75,7 @@ test_expect_success push '
 test_expect_success MINGW 'remote nick cannot contain backslashes' '
 	BACKSLASHED=3D"$(winpwd | tr / \\\\)" &&
 	git ls-remote "$BACKSLASHED" 2>err &&
-	test_i18ngrep ! "unable to access" err
+	test_grep ! "unable to access" err
 '
=20
 test_expect_success 'unc alternates' '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b7d5551262..47eae641f0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -630,7 +630,7 @@ test_expect_success 'clone on case-insensitive fs' '
 test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
 	grep X icasefs/warning &&
 	grep x icasefs/warning &&
-	test_i18ngrep "the following paths have collided" icasefs/warning
+	test_grep "the following paths have collided" icasefs/warning
 '
=20
 test_expect_success 'clone with GIT_DEFAULT_HASH' '
@@ -696,7 +696,7 @@ test_expect_success 'partial clone: warn if server do=
es not support object filte
=20
 	git clone --filter=3Dblob:limit=3D0 "file://$(pwd)/server" client 2> er=
r &&
=20
-	test_i18ngrep "filtering not recognized by server" err
+	test_grep "filtering not recognized by server" err
 '
=20
 test_expect_success 'batch missing blob request during checkout' '
@@ -767,7 +767,7 @@ test_expect_success 'reject cloning shallow repositor=
y using HTTP' '
 	test_when_finished "rm -rf repo" &&
 	git clone --bare --no-local --depth=3D1 src "$HTTPD_DOCUMENT_ROOT_PATH/=
repo.git" &&
 	test_must_fail git -c protocol.version=3D2 clone --reject-shallow $HTTP=
D_URL/smart/repo.git repo 2>err &&
-	test_i18ngrep -e "source repository is shallow, reject to clone." err &=
&
+	test_grep -e "source repository is shallow, reject to clone." err &&
=20
 	git clone --no-reject-shallow $HTTPD_URL/smart/repo.git repo
 '
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 9845fc04d5..9b32db8478 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -317,7 +317,7 @@ test_expect_success SYMLINKS 'clone repo with symlink=
ed or unknown files at obje
 	for option in --local --no-hardlinks --dissociate
 	do
 		test_must_fail git clone $option T T$option 2>err || return 1 &&
-		test_i18ngrep "symlink.*exists" err || return 1
+		test_grep "symlink.*exists" err || return 1
 	done &&
=20
 	# But `--shared` clones should still work, even when specifying
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 5890319b97..fc4bbd9daf 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -39,7 +39,7 @@ test_expect_success 'clone -o' '
 test_expect_success 'rejects invalid -o/--origin' '
=20
 	test_must_fail git clone -o "bad...name" parent clone-bad-name 2>err &&
-	test_i18ngrep "'\''bad...name'\'' is not a valid remote name" err
+	test_grep "'\''bad...name'\'' is not a valid remote name" err
=20
 '
=20
@@ -56,7 +56,7 @@ test_expect_success 'disallows --bare with --separate-g=
it-dir' '
=20
 	test_must_fail git clone --bare --separate-git-dir dot-git-destiation p=
arent clone-bare-sgd 2>err &&
 	test_debug "cat err" &&
-	test_i18ngrep -e "options .--bare. and .--separate-git-dir. cannot be u=
sed together" err
+	test_grep -e "options .--bare. and .--separate-git-dir. cannot be used =
together" err
=20
 '
=20
@@ -71,7 +71,7 @@ test_expect_success 'disallows --bundle-uri with shallo=
w options' '
 test_expect_success 'reject cloning shallow repository' '
 	test_when_finished "rm -rf repo" &&
 	test_must_fail git clone --reject-shallow shallow-repo out 2>err &&
-	test_i18ngrep -e "source repository is shallow, reject to clone." err &=
&
+	test_grep -e "source repository is shallow, reject to clone." err &&
=20
 	git clone --no-reject-shallow shallow-repo repo
 '
@@ -79,7 +79,7 @@ test_expect_success 'reject cloning shallow repository'=
 '
 test_expect_success 'reject cloning non-local shallow repository' '
 	test_when_finished "rm -rf repo" &&
 	test_must_fail git clone --reject-shallow --no-local shallow-repo out 2=
>err &&
-	test_i18ngrep -e "source repository is shallow, reject to clone." err &=
&
+	test_grep -e "source repository is shallow, reject to clone." err &&
=20
 	git clone --no-reject-shallow --no-local shallow-repo repo
 '
@@ -149,7 +149,7 @@ test_expect_success 'redirected clone does not show p=
rogress' '
=20
 	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	test_grep ! "Checking connectivity" err
=20
 '
=20
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 51705aa86a..0d1e92d996 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup' '
 test_expect_success '"verify" needs a worktree' '
 	git bundle create tip.bundle -1 main &&
 	nongit test_must_fail git bundle verify ../tip.bundle 2>err &&
-	test_i18ngrep "need a repository" err
+	test_grep "need a repository" err
 '
=20
 test_expect_success 'annotated tags can be excluded by rev-list options'=
 '
@@ -166,7 +166,7 @@ test_expect_success 'git bundle v3 rejects unknown ca=
pabilities' '
 	@unknown=3Dsilly
 	EOF
 	test_must_fail git bundle verify new 2>output &&
-	test_i18ngrep "unknown capability .unknown=3Dsilly." output
+	test_grep "unknown capability .unknown=3Dsilly." output
 '
=20
 test_done
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 727caff443..298d4befab 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -103,7 +103,7 @@ test_expect_success 'set up shallow repository' '
 test_expect_success 'clone.rejectshallow=3Dtrue should reject cloning sh=
allow repo' '
 	test_when_finished "rm -rf out" &&
 	test_must_fail git -c clone.rejectshallow=3Dtrue clone --no-local shall=
ow-repo out 2>err &&
-	test_i18ngrep -e "source repository is shallow, reject to clone." err &=
&
+	test_grep -e "source repository is shallow, reject to clone." err &&
=20
 	git -c clone.rejectshallow=3Dfalse clone --no-local shallow-repo out
 '
@@ -111,7 +111,7 @@ test_expect_success 'clone.rejectshallow=3Dtrue shoul=
d reject cloning shallow repo
 test_expect_success 'option --[no-]reject-shallow override clone.rejects=
hallow config' '
 	test_when_finished "rm -rf out" &&
 	test_must_fail git -c clone.rejectshallow=3Dfalse clone --reject-shallo=
w --no-local shallow-repo out 2>err &&
-	test_i18ngrep -e "source repository is shallow, reject to clone." err &=
&
+	test_grep -e "source repository is shallow, reject to clone." err &&
=20
 	git -c clone.rejectshallow=3Dtrue clone --no-reject-shallow --no-local =
shallow-repo out
 '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8759fc2853..2da7291e37 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -353,14 +353,14 @@ test_expect_success 'upload-pack complains of bogus=
 filter config' '
 	test_must_fail git \
 		-c uploadpackfilter.tree.maxdepth \
 		upload-pack . >/dev/null 2>err &&
-	test_i18ngrep "unable to parse.*tree.maxdepth" err
+	test_grep "unable to parse.*tree.maxdepth" err
 '
=20
 test_expect_success 'upload-pack fails banned object filters' '
 	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
 	test_must_fail ok=3Dsigpipe git clone --no-checkout --filter=3Dblob:non=
e \
 		"file://$(pwd)/srv.bare" pc3 2>err &&
-	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+	test_grep "filter '\''blob:none'\'' not supported" err
 '
=20
 test_expect_success 'upload-pack fails banned combine object filters' '
@@ -370,14 +370,14 @@ test_expect_success 'upload-pack fails banned combi=
ne object filters' '
 	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
 	test_must_fail ok=3Dsigpipe git clone --no-checkout --filter=3Dtree:1 \
 		--filter=3Dblob:none "file://$(pwd)/srv.bare" pc3 2>err &&
-	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+	test_grep "filter '\''blob:none'\'' not supported" err
 '
=20
 test_expect_success 'upload-pack fails banned object filters with fallba=
ck' '
 	test_config -C srv.bare uploadpackfilter.allow false &&
 	test_must_fail ok=3Dsigpipe git clone --no-checkout --filter=3Dblob:non=
e \
 		"file://$(pwd)/srv.bare" pc3 2>err &&
-	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+	test_grep "filter '\''blob:none'\'' not supported" err
 '
=20
 test_expect_success 'upload-pack limits tree depth filters' '
@@ -386,7 +386,7 @@ test_expect_success 'upload-pack limits tree depth fi=
lters' '
 	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
 	test_must_fail ok=3Dsigpipe git clone --no-checkout --filter=3Dtree:1 \
 		"file://$(pwd)/srv.bare" pc3 2>err &&
-	test_i18ngrep "tree filter allows max depth 0, but got 1" err &&
+	test_grep "tree filter allows max depth 0, but got 1" err &&
=20
 	git clone --no-checkout --filter=3Dtree:0 "file://$(pwd)/srv.bare" pc4 =
&&
=20
@@ -394,7 +394,7 @@ test_expect_success 'upload-pack limits tree depth fi=
lters' '
 	git clone --no-checkout --filter=3Dtree:5 "file://$(pwd)/srv.bare" pc5 =
&&
 	test_must_fail ok=3Dsigpipe git clone --no-checkout --filter=3Dtree:6 \
 		"file://$(pwd)/srv.bare" pc6 2>err &&
-	test_i18ngrep "tree filter allows max depth 5, but got 6" err
+	test_grep "tree filter allows max depth 5, but got 6" err
 '
=20
 test_expect_success 'partial clone fetches blobs pointed to by refs even=
 if normally filtered out' '
@@ -459,11 +459,11 @@ test_expect_success 'partial clone with unresolvabl=
e sparse filter fails cleanly
 	test_must_fail git clone --no-local --bare \
 				 --filter=3Dsparse:oid=3Dmain:no-such-name \
 				 sparse-src dst.git 2>err &&
-	test_i18ngrep "unable to access sparse blob in .main:no-such-name" err =
&&
+	test_grep "unable to access sparse blob in .main:no-such-name" err &&
 	test_must_fail git clone --no-local --bare \
 				 --filter=3Dsparse:oid=3Dmain \
 				 sparse-src dst.git 2>err &&
-	test_i18ngrep "unable to parse sparse filter data in" err
+	test_grep "unable to parse sparse filter data in" err
 '
=20
 setup_triangle () {
@@ -493,8 +493,8 @@ setup_triangle () {
 	TREE_HASH=3D$(git -C server rev-parse HEAD~1^{tree}) &&
 	git -C promisor-remote fetch --keep "file://$(pwd)/server" "$TREE_HASH"=
 &&
 	git -C promisor-remote count-objects -v >object-count &&
-	test_i18ngrep "count: 0" object-count &&
-	test_i18ngrep "in-pack: 2" object-count &&
+	test_grep "count: 0" object-count &&
+	test_grep "in-pack: 2" object-count &&
=20
 	# Set it as the promisor remote of client. Thus, whenever
 	# the client lazy fetches, the lazy fetch will succeed only if it is
@@ -748,7 +748,7 @@ test_expect_success 'upon cloning, check that all ref=
s point to objects' '
 	test_must_fail git -c protocol.version=3D2 clone \
 		--filter=3Dblob:none $HTTPD_URL/one_time_perl/server repo 2>err &&
=20
-	test_i18ngrep "did not send all necessary objects" err &&
+	test_grep "did not send all necessary objects" err &&
=20
 	# Ensure that the one-time-perl script was used.
 	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index f21e5e9d33..3591bc2417 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -52,7 +52,7 @@ test_expect_success 'request invalid capability' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	test_i18ngrep "unknown capability" err
+	test_grep "unknown capability" err
 '
=20
 test_expect_success 'request with no command' '
@@ -62,7 +62,7 @@ test_expect_success 'request with no command' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	test_i18ngrep "no command requested" err
+	test_grep "no command requested" err
 '
=20
 test_expect_success 'request invalid command' '
@@ -73,7 +73,7 @@ test_expect_success 'request invalid command' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	test_i18ngrep "invalid command" err
+	test_grep "invalid command" err
 '
=20
 test_expect_success 'request capability as command' '
@@ -115,7 +115,7 @@ test_expect_success 'wrong object-format' '
 	0000
 	EOF
 	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
-	test_i18ngrep "mismatched object format" err
+	test_grep "mismatched object format" err
 '
=20
 # Test the basics of ls-refs
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 6af5c2062f..3c0c6047d5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -189,8 +189,8 @@ test_expect_success 'warn if using server-option with=
 ls-remote with legacy prot
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 git -c protocol.versio=
n=3D0 \
 		ls-remote -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
=20
-	test_i18ngrep "see protocol.version in" err &&
-	test_i18ngrep "server options require protocol version 2 or later" err
+	test_grep "see protocol.version in" err &&
+	test_grep "server options require protocol version 2 or later" err
 '
=20
 test_expect_success 'clone with file:// using protocol v2' '
@@ -377,8 +377,8 @@ test_expect_success 'warn if using server-option with=
 fetch with legacy protocol
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 git -C temp_child -c p=
rotocol.version=3D0 \
 		fetch -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
=20
-	test_i18ngrep "see protocol.version in" err &&
-	test_i18ngrep "server options require protocol version 2 or later" err
+	test_grep "see protocol.version in" err &&
+	test_grep "server options require protocol version 2 or later" err
 '
=20
 test_expect_success 'server-options are sent when cloning' '
@@ -399,8 +399,8 @@ test_expect_success 'warn if using server-option with=
 clone with legacy protocol
 		clone --server-option=3Dhello --server-option=3Dworld \
 		"file://$(pwd)/file_parent" myclone 2>err &&
=20
-	test_i18ngrep "see protocol.version in" err &&
-	test_i18ngrep "server options require protocol version 2 or later" err
+	test_grep "see protocol.version in" err &&
+	test_grep "server options require protocol version 2 or later" err
 '
=20
 test_expect_success 'upload-pack respects config using protocol v2' '
@@ -495,7 +495,7 @@ test_expect_success 'partial clone warns if filter is=
 not advertised' '
 	git -C server config uploadpack.allowfilter 0 &&
 	git -c protocol.version=3D2 \
 		clone --filter=3Dblob:none "file://$(pwd)/server" client 2>err &&
-	test_i18ngrep "filtering not recognized by server, ignoring" err
+	test_grep "filtering not recognized by server, ignoring" err
 '
=20
 test_expect_success 'even with handcrafted request, filter does not work=
 if not advertised' '
@@ -736,7 +736,7 @@ test_expect_success 'file:// --negotiate-only with pr=
otocol v0' '
 		--negotiate-only \
 		--negotiation-tip=3D$(git -C client rev-parse HEAD) \
 		origin 2>err &&
-	test_i18ngrep "negotiate-only requires protocol v2" err
+	test_grep "negotiate-only requires protocol v2" err
 '
=20
 test_expect_success 'push with custom path does not request v2' '
@@ -809,7 +809,7 @@ test_expect_success 'clone repository with http:// us=
ing protocol v2 with incomp
 	# Server responded using protocol v2
 	grep "git< version 2" log &&
 	# Client reported appropriate failure
-	test_i18ngrep "bytes of length header were received" err
+	test_grep "bytes of length header were received" err
 '
=20
 test_expect_success 'clone repository with http:// using protocol v2 wit=
h incomplete pktline body' '
@@ -826,7 +826,7 @@ test_expect_success 'clone repository with http:// us=
ing protocol v2 with incomp
 	# Server responded using protocol v2
 	grep "git< version 2" log &&
 	# Client reported appropriate failure
-	test_i18ngrep "bytes of body are still expected" err
+	test_grep "bytes of body are still expected" err
 '
=20
 test_expect_success 'clone with http:// using protocol v2 and invalid pa=
rameters' '
@@ -973,7 +973,7 @@ test_expect_success 'when server sends "ready", expec=
t DELIM' '
=20
 	test_must_fail git -C http_child -c protocol.version=3D2 \
 		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
-	test_i18ngrep "expected packfile to be sent after .ready." err
+	test_grep "expected packfile to be sent after .ready." err
 '
=20
 test_expect_success 'when server does not send "ready", expect FLUSH' '
@@ -1001,7 +1001,7 @@ test_expect_success 'when server does not send "rea=
dy", expect FLUSH' '
 		fetch "$HTTPD_URL/one_time_perl/http_parent" 2> err &&
 	grep "fetch< .*acknowledgments" log &&
 	! grep "fetch< .*ready" log &&
-	test_i18ngrep "expected no other sections to be sent after no .ready." =
err
+	test_grep "expected no other sections to be sent after no .ready." err
 '
=20
 configure_exclusion () {
@@ -1111,7 +1111,7 @@ test_expect_success 'fetching with valid packfile U=
RI but invalid hash fails' '
 		git -c protocol.version=3D2 \
 		-c fetch.uriprotocols=3Dhttp,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
-	test_i18ngrep "pack downloaded from.*does not match expected hash" err
+	test_grep "pack downloaded from.*does not match expected hash" err
 '
=20
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
@@ -1165,7 +1165,7 @@ test_expect_success 'packfile-uri with transfer.fsc=
kobjects fails on bad object'
 	test_must_fail git -c protocol.version=3D2 -c transfer.fsckobjects=3D1 =
\
 		-c fetch.uriprotocols=3Dhttp,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child 2>error &&
-	test_i18ngrep "invalid author/committer line - missing email" error
+	test_grep "invalid author/committer line - missing email" error
 '
=20
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds whe=
n .gitmodules is separate from tree' '
@@ -1213,7 +1213,7 @@ test_expect_success 'packfile-uri with transfer.fsc=
kobjects fails when .gitmodul
 	test_must_fail git -c protocol.version=3D2 -c transfer.fsckobjects=3D1 =
\
 		-c fetch.uriprotocols=3Dhttp,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
-	test_i18ngrep "disallowed submodule name" err
+	test_grep "disallowed submodule name" err
 '
=20
 test_expect_success 'packfile-uri path redacted in trace' '
@@ -1296,7 +1296,7 @@ test_expect_success 'http:// --negotiate-only witho=
ut wait-for-done support' '
 		--negotiate-only \
 		--negotiation-tip=3D$(git -C client rev-parse HEAD) \
 		origin 2>err &&
-	test_i18ngrep "server does not support wait-for-done" err
+	test_grep "server does not support wait-for-done" err
 '
=20
 test_expect_success 'http:// --negotiate-only with protocol v0' '
@@ -1310,7 +1310,7 @@ test_expect_success 'http:// --negotiate-only with =
protocol v0' '
 		--negotiate-only \
 		--negotiation-tip=3D$(git -C client rev-parse HEAD) \
 		origin 2>err &&
-	test_i18ngrep "negotiate-only requires protocol v2" err
+	test_grep "negotiate-only requires protocol v2" err
 '
=20
 # DO NOT add non-httpd-specific tests here, because the last part of thi=
s
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref=
-in-want.sh
index df74f80061..191097171b 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -484,7 +484,7 @@ test_expect_success 'server is initially ahead - no r=
ef in want' '
 	cp -r "$LOCAL_PRISTINE" local &&
 	inconsistency main $(test_oid numeric) &&
 	test_must_fail git -C local fetch 2>err &&
-	test_i18ngrep "fatal: remote error: upload-pack: not our ref" err
+	test_grep "fatal: remote error: upload-pack: not our ref" err
 '
=20
 test_expect_success 'server is initially ahead - ref in want' '
@@ -530,7 +530,7 @@ test_expect_success 'server loses a ref - ref in want=
' '
 	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
 	test_must_fail git -C local fetch 2>err &&
=20
-	test_i18ngrep "fatal: remote error: unknown ref refs/heads/rain" err
+	test_grep "fatal: remote error: unknown ref refs/heads/rain" err
 '
=20
 # DO NOT add non-httpd-specific tests here, because the last part of thi=
s
diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations=
.sh
index ae1a00afb0..11be64fc03 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -18,7 +18,7 @@ test_expect_success 'extra delim packet in v2 ls-refs a=
rgs' '
 	} >input &&
 	test_must_fail env GIT_PROTOCOL=3Dversion=3D2 \
 		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after ls-refs arguments" err
+	test_grep "expected flush after ls-refs arguments" err
 '
=20
 test_expect_success 'extra delim packet in v2 fetch args' '
@@ -31,7 +31,7 @@ test_expect_success 'extra delim packet in v2 fetch arg=
s' '
 	} >input &&
 	test_must_fail env GIT_PROTOCOL=3Dversion=3D2 \
 		git upload-pack . <input 2>err &&
-	test_i18ngrep "expected flush after fetch arguments" err
+	test_grep "expected flush after fetch arguments" err
 '
=20
 test_expect_success 'bogus symref in v0 capabilities' '
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d386076dbd..4e0a77f985 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -137,7 +137,7 @@ test_expect_success 'forced push' '
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_NOREFSPEC=3D1 \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-	test_i18ngrep "this remote helper should implement refspec capability" =
error &&
+	test_grep "this remote helper should implement refspec capability" erro=
r &&
 	compare_refs local2 HEAD server HEAD
 '
=20
@@ -145,7 +145,7 @@ test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
 	GIT_REMOTE_TESTGIT_NOREFSPEC=3D1 git pull 2>../error) &&
-	test_i18ngrep "this remote helper should implement refspec capability" =
error &&
+	test_grep "this remote helper should implement refspec capability" erro=
r &&
 	compare_refs local2 HEAD server HEAD
 '
=20
@@ -157,7 +157,7 @@ test_expect_success 'pushing without refspecs' '
 	GIT_REMOTE_TESTGIT_NOREFSPEC=3D1 &&
 	export GIT_REMOTE_TESTGIT_NOREFSPEC &&
 	test_must_fail git push 2>../error) &&
-	test_i18ngrep "remote-helper doesn.t support push; refspec needed" erro=
r
+	test_grep "remote-helper doesn.t support push; refspec needed" error
 '
=20
 test_expect_success 'pulling without marks' '
@@ -256,7 +256,7 @@ clean_mark () {
 test_expect_success 'proper failure checks for fetching' '
 	(cd local &&
 	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=3D1 git fetch 2>error &&
-	test_i18ngrep -q "error while running fast-import" error
+	test_grep -q "error while running fast-import" error
 	)
 '
=20
diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.s=
h
index d8da5f58d1..769c717e88 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -20,7 +20,7 @@ test_expect_success 'http(s) transport respects GIT_ALL=
OW_PROTOCOL' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=3Dhttp:https \
 			   GIT_SMART_HTTP=3D0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
-	test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
+	test_grep -E "(ftp.*disabled|your curl version is too old)" stderr
 '
=20
 test_expect_success 'curl limits redirects' '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 16635ecc33..73a2465aa0 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -118,10 +118,10 @@ done
=20
 test_expect_success 'show advice that grafts are deprecated' '
 	git show HEAD 2>err &&
-	test_i18ngrep "git replace" err &&
+	test_grep "git replace" err &&
 	test_config advice.graftFileDeprecated false &&
 	git show HEAD 2>err &&
-	test_i18ngrep ! "git replace" err
+	test_grep ! "git replace" err
 '
=20
 test_done
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclud=
e-hidden.sh
index 1a9d37e638..cdf7aa9427 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -151,12 +151,12 @@ do
 	do
 		test_expect_success "$section: fails with --$pseudoopt" '
 			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt =
2>err &&
-			test_i18ngrep "error: --exclude-hidden cannot be used together with -=
-$pseudoopt" err
+			test_grep "error: --exclude-hidden cannot be used together with --$ps=
eudoopt" err
 		'
=20
 		test_expect_success "$section: fails with --$pseudoopt=3Dpattern" '
 			test_must_fail git rev-list --exclude-hidden=3D$section --$pseudoopt=3D=
pattern 2>err &&
-			test_i18ngrep "error: --exclude-hidden cannot be used together with -=
-$pseudoopt" err
+			test_grep "error: --exclude-hidden cannot be used together with --$ps=
eudoopt" err
 		'
 	done
 done
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index fb01bd6abc..2a5b7d8379 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -220,7 +220,7 @@ test_expect_success 'bisect start: existing ".git/BIS=
ECT_START" not modified if
 	cp .git/BISECT_START saved &&
 	test_must_fail git bisect start $HASH4 foo -- &&
 	git branch > branch.output &&
-	test_i18ngrep "* (no branch, bisect started on other)" branch.output > =
/dev/null &&
+	test_grep "* (no branch, bisect started on other)" branch.output > /dev=
/null &&
 	test_cmp saved .git/BISECT_START
 '
 test_expect_success 'bisect start: no ".git/BISECT_START" if mistaken re=
v' '
@@ -588,7 +588,7 @@ test_expect_success 'bisect starting with a detached =
HEAD' '
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
-	test_i18ngrep "mistook good and bad" rev_list_error &&
+	test_grep "mistook good and bad" rev_list_error &&
 	git bisect reset
 '
=20
@@ -630,7 +630,7 @@ test_expect_success 'side branch creation' '
=20
 test_expect_success 'good merge base when good and bad are siblings' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
+	test_grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	! grep "merge base must be tested" my_bisect_log.txt &&
@@ -639,7 +639,7 @@ test_expect_success 'good merge base when good and ba=
d are siblings' '
 '
 test_expect_success 'skipped merge base when good and bad are siblings' =
'
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
+	test_grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
 	grep "warning" my_bisect_log.txt &&
@@ -649,11 +649,11 @@ test_expect_success 'skipped merge base when good a=
nd bad are siblings' '
=20
 test_expect_success 'bad merge base when good and bad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
+	test_grep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
-	test_i18ngrep "merge base $HASH4 is bad" my_bisect_log.txt &&
-	test_i18ngrep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.=
txt &&
+	test_grep "merge base $HASH4 is bad" my_bisect_log.txt &&
+	test_grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt =
&&
 	git bisect reset
 '
=20
@@ -704,9 +704,9 @@ test_expect_success '"git bisect run --first-parent" =
simple case' '
=20
 test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
+	test_grep "merge base must be tested" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log2.txt &&
+	test_grep "merge base must be tested" my_bisect_log2.txt &&
 	{
 		{
 			grep "$SIDE_HASH5" my_bisect_log.txt &&
@@ -721,14 +721,14 @@ test_expect_success 'good merge bases when good and=
 bad are siblings' '
=20
 test_expect_success 'optimized merge base checks' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
+	test_grep "merge base must be tested" my_bisect_log.txt &&
 	grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" =3D $(git rev-parse --verify HEAD) &&
 	git bisect bad &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
-	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
+	test_grep "merge base must be tested" my_bisect_log4.txt &&
 	test_path_is_missing ".git/BISECT_ANCESTORS_OK"
 '
=20
@@ -806,7 +806,7 @@ test_expect_success 'skipping away from skipped commi=
t' '
=20
 test_expect_success 'erroring out when using bad path arguments' '
 	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error.t=
xt &&
-	test_i18ngrep "bad path arguments" error.txt
+	test_grep "bad path arguments" error.txt
 '
=20
 test_expect_success 'test bisection on bare repo - --no-checkout specifi=
ed' '
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 7ddbd96e58..acc281c116 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -83,13 +83,13 @@ test_expect_success 'checkout (diverged from upstream=
)' '
 	(
 		cd test && git checkout b1
 	) >actual &&
-	test_i18ngrep "have 1 and 1 different" actual
+	test_grep "have 1 and 1 different" actual
 '
=20
 test_expect_success 'checkout with local tracked branch' '
 	git checkout main &&
 	git checkout follower >actual &&
-	test_i18ngrep "is ahead of" actual
+	test_grep "is ahead of" actual
 '
=20
 test_expect_success 'checkout (upstream is gone)' '
@@ -97,14 +97,14 @@ test_expect_success 'checkout (upstream is gone)' '
 		cd test &&
 		git checkout b5
 	) >actual &&
-	test_i18ngrep "is based on .*, but the upstream is gone." actual
+	test_grep "is based on .*, but the upstream is gone." actual
 '
=20
 test_expect_success 'checkout (up-to-date with upstream)' '
 	(
 		cd test && git checkout b6
 	) >actual &&
-	test_i18ngrep "Your branch is up to date with .origin/main" actual
+	test_grep "Your branch is up to date with .origin/main" actual
 '
=20
 test_expect_success 'status (diverged from upstream)' '
@@ -114,7 +114,7 @@ test_expect_success 'status (diverged from upstream)'=
 '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_i18ngrep "have 1 and 1 different" actual
+	test_grep "have 1 and 1 different" actual
 '
=20
 test_expect_success 'status (upstream is gone)' '
@@ -124,7 +124,7 @@ test_expect_success 'status (upstream is gone)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_i18ngrep "is based on .*, but the upstream is gone." actual
+	test_grep "is based on .*, but the upstream is gone." actual
 '
=20
 test_expect_success 'status (up-to-date with upstream)' '
@@ -134,7 +134,7 @@ test_expect_success 'status (up-to-date with upstream=
)' '
 		# reports nothing to commit
 		test_must_fail git commit --dry-run
 	) >actual &&
-	test_i18ngrep "Your branch is up to date with .origin/main" actual
+	test_grep "Your branch is up to date with .origin/main" actual
 '
=20
 cat >expect <<\EOF
@@ -253,7 +253,7 @@ test_expect_success 'fail to track lightweight tags' =
'
 	git checkout main &&
 	git tag light &&
 	test_must_fail git branch --track lighttrack light >actual &&
-	test_i18ngrep ! "set up to track" actual &&
+	test_grep ! "set up to track" actual &&
 	test_must_fail git checkout lighttrack
 '
=20
@@ -261,7 +261,7 @@ test_expect_success 'fail to track annotated tags' '
 	git checkout main &&
 	git tag -m heavy heavy &&
 	test_must_fail git branch --track heavytrack heavy >actual &&
-	test_i18ngrep ! "set up to track" actual &&
+	test_grep ! "set up to track" actual &&
 	test_must_fail git checkout heavytrack
 '
=20
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index c9925edf20..c6e9b33e44 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -44,7 +44,7 @@ commit_peeling_shows_parents ()
 	_parent_number=3D$(( $_parent_number + 1 ))
     done &&
     test_must_fail git rev-parse --verify $_commit^$_parent_number 2>err=
 &&
-    test_i18ngrep "Needed a single revision" err
+    test_grep "Needed a single revision" err
 }
=20
 commit_has_parents ()
@@ -137,8 +137,8 @@ test_expect_success 'tag replaced commit' '
=20
 test_expect_success '"git fsck" works' '
 	git fsck main >fsck_main.out &&
-	test_i18ngrep "dangling commit $R" fsck_main.out &&
-	test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_ma=
in.out &&
+	test_grep "dangling commit $R" fsck_main.out &&
+	test_grep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_main.o=
ut &&
 	test -z "$(git fsck)"
 '
=20
@@ -490,9 +490,9 @@ test_expect_success '--convert-graft-file' '
 		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
 		>.git/info/grafts &&
 	git status 2>stderr &&
-	test_i18ngrep "hint:.*grafts is deprecated" stderr &&
+	test_grep "hint:.*grafts is deprecated" stderr &&
 	git replace --convert-graft-file 2>stderr &&
-	test_i18ngrep ! "hint:.*grafts is deprecated" stderr &&
+	test_grep ! "hint:.*grafts is deprecated" stderr &&
 	test_path_is_missing .git/info/grafts &&
=20
 	: verify that the history is now "grafted" &&
@@ -503,8 +503,8 @@ test_expect_success '--convert-graft-file' '
 	test_when_finished "rm -f .git/info/grafts" &&
 	echo $EMPTY_BLOB $EMPTY_TREE >.git/info/grafts &&
 	test_must_fail git replace --convert-graft-file 2>err &&
-	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" err &&
-	test_i18ngrep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
+	test_grep "$EMPTY_BLOB $EMPTY_TREE" err &&
+	test_grep "$EMPTY_BLOB $EMPTY_TREE" .git/info/grafts
 '
=20
 test_done
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-un=
expected-objects.sh
index 9350b5fd2c..5d28507efc 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -28,7 +28,7 @@ test_expect_success 'TODO (should fail!): traverse unex=
pected non-blob entry (lo
=20
 test_expect_success 'traverse unexpected non-blob entry (seen)' '
 	test_must_fail git rev-list --objects $tree $broken_tree >output 2>&1 &=
&
-	test_i18ngrep "is not a blob" output
+	test_grep "is not a blob" output
 '
=20
 test_expect_success 'setup unexpected non-tree entry' '
@@ -42,7 +42,7 @@ test_expect_success 'traverse unexpected non-tree entry=
 (lone)' '
=20
 test_expect_success 'traverse unexpected non-tree entry (seen)' '
 	test_must_fail git rev-list --objects $blob $broken_tree >output 2>&1 &=
&
-	test_i18ngrep "is not a tree" output
+	test_grep "is not a tree" output
 '
=20
 test_expect_success 'setup unexpected non-commit parent' '
@@ -54,13 +54,13 @@ test_expect_success 'setup unexpected non-commit pare=
nt' '
=20
 test_expect_success 'traverse unexpected non-commit parent (lone)' '
 	test_must_fail git rev-list --objects $broken_commit >output 2>&1 &&
-	test_i18ngrep "not a commit" output
+	test_grep "not a commit" output
 '
=20
 test_expect_success 'traverse unexpected non-commit parent (seen)' '
 	test_must_fail git rev-list --objects $blob $broken_commit \
 		>output 2>&1 &&
-	test_i18ngrep "not a commit" output
+	test_grep "not a commit" output
 '
=20
 test_expect_success 'setup unexpected non-tree root' '
@@ -76,7 +76,7 @@ test_expect_success 'traverse unexpected non-tree root =
(lone)' '
 test_expect_success 'traverse unexpected non-tree root (seen)' '
 	test_must_fail git rev-list --objects $blob $broken_commit \
 		>output 2>&1 &&
-	test_i18ngrep "not a tree" output
+	test_grep "not a tree" output
 '
=20
 test_expect_success 'setup unexpected non-commit tag' '
@@ -93,7 +93,7 @@ test_expect_success 'traverse unexpected non-commit tag=
 (lone)' '
=20
 test_expect_success 'traverse unexpected non-commit tag (seen)' '
 	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
-	test_i18ngrep "not a commit" output
+	test_grep "not a commit" output
 '
=20
 test_expect_success 'setup unexpected non-tree tag' '
@@ -110,7 +110,7 @@ test_expect_success 'traverse unexpected non-tree tag=
 (lone)' '
=20
 test_expect_success 'traverse unexpected non-tree tag (seen)' '
 	test_must_fail git rev-list --objects $blob $tag >output 2>&1 &&
-	test_i18ngrep "not a tree" output
+	test_grep "not a tree" output
 '
=20
 test_expect_success 'setup unexpected non-blob tag' '
@@ -127,7 +127,7 @@ test_expect_success 'traverse unexpected non-blob tag=
 (lone)' '
=20
 test_expect_success 'traverse unexpected non-blob tag (seen)' '
 	test_must_fail git rev-list --objects $commit $tag >output 2>&1 &&
-	test_i18ngrep "not a blob" output
+	test_grep "not a blob" output
 '
=20
 test_done
diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filte=
rs-objects.sh
index 8d9d6604f0..52822b9461 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -457,7 +457,7 @@ expect_invalid_filter_spec () {
 	test_must_fail git -C r3 rev-list --objects --filter=3D"$spec" HEAD \
 		>actual 2>actual_stderr &&
 	test_must_be_empty actual &&
-	test_i18ngrep "$err" actual_stderr
+	test_grep "$err" actual_stderr
 }
=20
 test_expect_success 'combine:... while URL-encoding things that should n=
ot be' '
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 0a5c487540..e78315d23d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -392,7 +392,7 @@ test_expect_success 'describe directly tagged blob' '
 test_expect_success 'describe tag object' '
 	git tag test-blob-1 -a -m msg unique-file:file &&
 	test_must_fail git describe test-blob-1 2>actual &&
-	test_i18ngrep "fatal: test-blob-1 is neither a commit nor blob" actual
+	test_grep "fatal: test-blob-1 is neither a commit nor blob" actual
 '
=20
 test_expect_success ULIMIT_STACK_SIZE 'name-rev works in a deep repo' '
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submo=
dule.sh
index 3214d9db97..16ce4cfcc6 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -27,7 +27,7 @@ test_expect_success 'error message for path inside subm=
odule' '
=20
 test_expect_success 'error message for path inside submodule from within=
 submodule' '
 	test_must_fail git -C sub add . 2>actual &&
-	test_i18ngrep "in unpopulated submodule" actual
+	test_grep "in unpopulated submodule" actual
 '
=20
 test_done
diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs=
.sh
index f70c395e75..a9c1e4e0ec 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -236,7 +236,7 @@ test_expect_success 'check label excluding other labe=
ls' '
=20
 test_expect_success 'fail on multiple attr specifiers in one pathspec it=
em' '
 	test_must_fail git ls-files . ":(attr:labelB,attr:labelC)" 2>actual &&
-	test_i18ngrep "Only one" actual
+	test_grep "Only one" actual
 '
=20
 test_expect_success 'fail if attr magic is used places not implemented' =
'
@@ -246,7 +246,7 @@ test_expect_success 'fail if attr magic is used place=
s not implemented' '
 	# though, but git-add is convenient as it has its own internal pathspec
 	# parsing.
 	test_must_fail git add ":(attr:labelB)" 2>actual &&
-	test_i18ngrep "magic not supported" actual
+	test_grep "magic not supported" actual
 '
=20
 test_expect_success 'abort on giving invalid label on the command line' =
'
@@ -269,12 +269,12 @@ test_expect_success 'check attribute list' '
=20
 test_expect_success 'backslash cannot be the last character' '
 	test_must_fail git ls-files ":(attr:label=3Dfoo\\ labelA=3Dbar)" 2>actu=
al &&
-	test_i18ngrep "not allowed as last character in attr value" actual
+	test_grep "not allowed as last character in attr value" actual
 '
=20
 test_expect_success 'backslash cannot be used as a value' '
 	test_must_fail git ls-files ":(attr:label=3Df\\\oo)" 2>actual &&
-	test_i18ngrep "for value matching" actual
+	test_grep "for value matching" actual
 '
=20
 test_expect_success 'reading from .gitattributes in a subdirectory (1)' =
'
diff --git a/t/t6136-pathspec-in-bare.sh b/t/t6136-pathspec-in-bare.sh
index ae8b5379e2..2db37a6596 100755
--- a/t/t6136-pathspec-in-bare.sh
+++ b/t/t6136-pathspec-in-bare.sh
@@ -15,11 +15,11 @@ test_expect_success 'log and ls-files in a bare repos=
itory' '
 		cd bare &&
 		test_must_fail git log -- .. >out 2>err &&
 		test_must_be_empty out &&
-		test_i18ngrep "outside repository" err &&
+		test_grep "outside repository" err &&
=20
 		test_must_fail git ls-files -- .. >out 2>err &&
 		test_must_be_empty out &&
-		test_i18ngrep "outside repository" err
+		test_grep "outside repository" err
 	)
 '
=20
@@ -28,11 +28,11 @@ test_expect_success 'log and ls-files in .git directo=
ry' '
 		cd .git &&
 		test_must_fail git log -- .. >out 2>err &&
 		test_must_be_empty out &&
-		test_i18ngrep "outside repository" err &&
+		test_grep "outside repository" err &&
=20
 		test_must_fail git ls-files -- .. >out 2>err &&
 		test_must_be_empty out &&
-		test_i18ngrep "outside repository" err
+		test_grep "outside repository" err
 	)
 '
=20
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 772238e582..2738b50c2a 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -311,13 +311,13 @@ test_expect_success 'Rename+D/F conflict; renamed f=
ile merges but dir in way' '
 	git checkout -q renamed-file-has-no-conflicts^0 &&
 	test_must_fail git merge --strategy=3Drecursive dir-in-way >output &&
=20
-	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
-	test_i18ngrep "Auto-merging dir" output &&
+	test_grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
+	test_grep "Auto-merging dir" output &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	then
-		test_i18ngrep "moving it to dir~HEAD instead" output
+		test_grep "moving it to dir~HEAD instead" output
 	else
-		test_i18ngrep "Adding as dir~HEAD instead" output
+		test_grep "Adding as dir~HEAD instead" output
 	fi &&
=20
 	test_stdout_line_count =3D 3 git ls-files -u &&
@@ -338,13 +338,13 @@ test_expect_success 'Same as previous, but merged o=
ther way' '
 	test_must_fail git merge --strategy=3Drecursive renamed-file-has-no-con=
flicts >output 2>errors &&
=20
 	! grep "error: refusing to lose untracked file at" errors &&
-	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
-	test_i18ngrep "Auto-merging dir" output &&
+	test_grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
+	test_grep "Auto-merging dir" output &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	then
-		test_i18ngrep "moving it to dir~renamed-file-has-no-conflicts instead"=
 output
+		test_grep "moving it to dir~renamed-file-has-no-conflicts instead" out=
put
 	else
-		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" ou=
tput
+		test_grep "Adding as dir~renamed-file-has-no-conflicts instead" output
 	fi &&
=20
 	test_stdout_line_count =3D 3 git ls-files -u &&
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-=
corner-cases.sh
index 076b6a74d5..80d7b5eaba 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -476,7 +476,7 @@ test_expect_success 'handle rename-with-content-merge=
 vs. add' '
 		git checkout A^0 &&
=20
 		test_must_fail git merge -s recursive B^0 >out &&
-		test_i18ngrep "CONFLICT (.*/add)" out &&
+		test_grep "CONFLICT (.*/add)" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 2 out &&
@@ -522,7 +522,7 @@ test_expect_success 'handle rename-with-content-merge=
 vs. add, merge other way'
 		git checkout B^0 &&
=20
 		test_must_fail git merge -s recursive A^0 >out &&
-		test_i18ngrep "CONFLICT (.*/add)" out &&
+		test_grep "CONFLICT (.*/add)" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 2 out &&
@@ -602,7 +602,7 @@ test_expect_success 'handle rename/rename (2to1) conf=
lict correctly' '
 		git checkout B^0 &&
=20
 		test_must_fail git merge -s recursive C^0 >out &&
-		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
+		test_grep "CONFLICT (\(.*\)/\1)" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 2 out &&
@@ -914,8 +914,8 @@ test_expect_merge_algorithm failure success 'rad-chec=
k: rename/add/delete confli
 		# be flexible in the type of console output message(s) reported
 		# for this particular case; we will be more stringent about the
 		# contents of the index and working directory.
-		test_i18ngrep "CONFLICT (.*/add)" out &&
-		test_i18ngrep "CONFLICT (rename.*/delete)" out &&
+		test_grep "CONFLICT (.*/add)" out &&
+		test_grep "CONFLICT (rename.*/delete)" out &&
 		test_must_be_empty err &&
=20
 		git ls-files -s >file_count &&
@@ -988,8 +988,8 @@ test_expect_merge_algorithm failure success 'rrdd-che=
ck: rename/rename(2to1)/del
 		# be flexible in the type of console output message(s) reported
 		# for this particular case; we will be more stringent about the
 		# contents of the index and working directory.
-		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
-		test_i18ngrep "CONFLICT (rename.*delete)" out &&
+		test_grep "CONFLICT (\(.*\)/\1)" out &&
+		test_grep "CONFLICT (rename.*delete)" out &&
 		test_must_be_empty err &&
=20
 		git ls-files -s >file_count &&
@@ -1068,7 +1068,7 @@ test_expect_merge_algorithm failure success 'mod6-c=
heck: chains of rename/rename
=20
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep "CONFLICT (rename/rename)" out &&
+		test_grep "CONFLICT (rename/rename)" out &&
 		test_must_be_empty err &&
=20
 		git ls-files -s >file_count &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-d=
irectories.sh
index 944de75b80..88d1cf2cde 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -276,7 +276,7 @@ test_expect_success '1d: Directory renames cause a re=
name/rename(2to1) conflict'
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
+		test_grep "CONFLICT (\(.*\)/\1)" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 8 out &&
@@ -515,7 +515,7 @@ test_expect_success '2a: Directory split into two on =
one side, with equal number
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT.*directory rename split" out &&
+		test_grep "CONFLICT.*directory rename split" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 3 out &&
@@ -591,7 +591,7 @@ test_expect_success '2b: Directory split into two on =
one side, with equal number
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:x/d &&
 		test_cmp expect actual &&
-		test_i18ngrep ! "CONFLICT.*directory rename split" out
+		test_grep ! "CONFLICT.*directory rename split" out
 	)
 '
=20
@@ -726,8 +726,8 @@ test_expect_success '3b: Avoid implicit rename if inv=
olved as source on current
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
-		test_i18ngrep ! CONFLICT.*rename/rename.*y/d out &&
+		test_grep CONFLICT.*rename/rename.*z/d.*x/d.*w/d out &&
+		test_grep ! CONFLICT.*rename/rename.*y/d out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 5 out &&
@@ -938,7 +938,7 @@ test_expect_success '5a: Merge directories, other sid=
e adds files to original an
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT.*implicit dir rename" out &&
+		test_grep "CONFLICT.*implicit dir rename" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 6 out &&
@@ -1013,7 +1013,7 @@ test_expect_success '5b: Rename/delete in order to =
get add/add/add conflict' '
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+		test_grep "CONFLICT (add/add).* y/d" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 5 out &&
@@ -1094,8 +1094,8 @@ test_expect_success '5c: Transitive rename would ca=
use rename/rename/rename/add/
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
-		test_i18ngrep "CONFLICT (add/add).* y/d" out &&
+		test_grep "CONFLICT (rename/rename).*x/d.*w/d.*z/d" out &&
+		test_grep "CONFLICT (add/add).* y/d" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 9 out &&
@@ -1179,7 +1179,7 @@ test_expect_success '5d: Directory/file/file confli=
ct due to directory rename' '
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (file/directory).*y/d" out &&
+		test_grep "CONFLICT (file/directory).*y/d" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 6 out &&
@@ -1278,7 +1278,7 @@ test_expect_success '6a: Tricky rename/delete' '
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).*z/c.*y/c" out &&
+		test_grep "CONFLICT (rename/delete).*z/c.*y/c" out &&
=20
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
@@ -1740,8 +1740,8 @@ test_expect_success '7a: rename-dir vs. rename-dir =
(NOT split evenly) PLUS add-o
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
-		test_i18ngrep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
+		test_grep "CONFLICT (rename/rename).*z/b.*y/b.*w/b" out &&
+		test_grep "CONFLICT (rename/rename).*z/c.*y/c.*x/c" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 7 out &&
@@ -1813,7 +1813,7 @@ test_expect_success '7b: rename/rename(2to1), but o=
nly due to transitive rename'
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (\(.*\)/\1)" out &&
+		test_grep "CONFLICT (\(.*\)/\1)" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 4 out &&
@@ -1900,7 +1900,7 @@ test_expect_success '7c: rename/rename(1to...2or3);=
 transitive rename may add co
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
+		test_grep "CONFLICT (rename/rename).*x/d.*w/d.*y/d" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 5 out &&
@@ -1965,7 +1965,7 @@ test_expect_success '7d: transitive rename involved=
 in rename/delete; how is it
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+		test_grep "CONFLICT (rename/delete).*x/d.*y/d" out &&
=20
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
@@ -2071,7 +2071,7 @@ test_expect_success '7e: transitive rename in renam=
e/delete AND dirs in the way'
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (rename/delete).*x/d.*y/d" out &&
+		test_grep "CONFLICT (rename/delete).*x/d.*y/d" out &&
=20
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
@@ -2330,7 +2330,7 @@ test_expect_success '8c: modify/delete or rename+mo=
dify/delete' '
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out &&
-		test_i18ngrep "CONFLICT (modify/delete).* z/d" out &&
+		test_grep "CONFLICT (modify/delete).* z/d" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 5 out &&
@@ -2491,8 +2491,8 @@ test_expect_success '8e: Both sides rename, one sid=
e adds to original directory'
 		git checkout A^0 &&
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out 2>err &&
-		test_i18ngrep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
-		test_i18ngrep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out &&
+		test_grep CONFLICT.*rename/rename.*z/c.*y/c.*w/c out &&
+		test_grep CONFLICT.*rename/rename.*z/b.*y/b.*w/b out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 7 out &&
@@ -2741,7 +2741,7 @@ test_expect_success '9c: Doubly transitive rename?'=
 '
 		git checkout A^0 &&
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out &&
-		test_i18ngrep "WARNING: Avoiding applying x -> z rename to x/f" out &&
+		test_grep "WARNING: Avoiding applying x -> z rename to x/f" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 6 out &&
@@ -2830,10 +2830,10 @@ test_expect_success '9d: N-way transitive rename?=
' '
 		git checkout A^0 &&
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out &&
-		test_i18ngrep "WARNING: Avoiding applying z -> y rename to z/t" out &&
-		test_i18ngrep "WARNING: Avoiding applying y -> x rename to y/a" out &&
-		test_i18ngrep "WARNING: Avoiding applying x -> w rename to x/b" out &&
-		test_i18ngrep "WARNING: Avoiding applying w -> v rename to w/c" out &&
+		test_grep "WARNING: Avoiding applying z -> y rename to z/t" out &&
+		test_grep "WARNING: Avoiding applying y -> x rename to y/a" out &&
+		test_grep "WARNING: Avoiding applying x -> w rename to x/b" out &&
+		test_grep "WARNING: Avoiding applying w -> v rename to w/c" out &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 7 out &&
@@ -3215,7 +3215,7 @@ test_expect_success '10a: Overwrite untracked with =
normal rename/delete' '
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out 2>err &&
 		test_path_is_missing .git/MERGE_HEAD &&
-		test_i18ngrep "The following untracked working tree files would be ove=
rwritten by merge" err &&
+		test_grep "The following untracked working tree files would be overwri=
tten by merge" err &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 1 out &&
@@ -3287,7 +3287,7 @@ test_expect_success '10b: Overwrite untracked with =
dir rename + delete' '
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: The following untracked working tree files woul=
d be overwritten by merge" err &&
+			test_grep "error: The following untracked working tree files would be=
 overwritten by merge" err &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 1 out &&
@@ -3296,8 +3296,8 @@ test_expect_success '10b: Overwrite untracked with =
dir rename + delete' '
 			git ls-files -o >out &&
 			test_line_count =3D 5 out
 		else
-			test_i18ngrep "CONFLICT (rename/delete).*Version B\^0 of y/d left in =
tree at y/d~B\^0" out &&
-			test_i18ngrep "Error: Refusing to lose untracked file at y/e; writing=
 to y/e~B\^0 instead" out &&
+			test_grep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree=
 at y/d~B\^0" out &&
+			test_grep "Error: Refusing to lose untracked file at y/e; writing to =
y/e~B\^0 instead" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 3 out &&
@@ -3377,7 +3377,7 @@ test_expect_success '10c1: Overwrite untracked with=
 dir rename/rename(1to2)' '
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: The following untracked working tree files woul=
d be overwritten by merge" err &&
+			test_grep "error: The following untracked working tree files would be=
 overwritten by merge" err &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 4 out &&
@@ -3386,8 +3386,8 @@ test_expect_success '10c1: Overwrite untracked with=
 dir rename/rename(1to2)' '
 			git ls-files -o >out &&
 			test_line_count =3D 3 out
 		else
-			test_i18ngrep "CONFLICT (rename/rename)" out &&
-			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~=
B\^0 instead" out &&
+			test_grep "CONFLICT (rename/rename)" out &&
+			test_grep "Refusing to lose untracked file at y/c; adding as y/c~B\^0=
 instead" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 6 out &&
@@ -3428,7 +3428,7 @@ test_expect_success '10c2: Overwrite untracked with=
 dir rename/rename(1to2), oth
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: The following untracked working tree files woul=
d be overwritten by merge" err &&
+			test_grep "error: The following untracked working tree files would be=
 overwritten by merge" err &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 4 out &&
@@ -3437,8 +3437,8 @@ test_expect_success '10c2: Overwrite untracked with=
 dir rename/rename(1to2), oth
 			git ls-files -o >out &&
 			test_line_count =3D 3 out
 		else
-			test_i18ngrep "CONFLICT (rename/rename)" out &&
-			test_i18ngrep "Refusing to lose untracked file at y/c; adding as y/c~=
HEAD instead" out &&
+			test_grep "CONFLICT (rename/rename)" out &&
+			test_grep "Refusing to lose untracked file at y/c; adding as y/c~HEAD=
 instead" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 6 out &&
@@ -3517,7 +3517,7 @@ test_expect_success '10d: Delete untracked with dir=
 rename/rename(2to1)' '
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: The following untracked working tree files woul=
d be overwritten by merge" err &&
+			test_grep "error: The following untracked working tree files would be=
 overwritten by merge" err &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 6 out &&
@@ -3526,8 +3526,8 @@ test_expect_success '10d: Delete untracked with dir=
 rename/rename(2to1)' '
 			git ls-files -o >out &&
 			test_line_count =3D 3 out
 		else
-			test_i18ngrep "CONFLICT (rename/rename)" out &&
-			test_i18ngrep "Refusing to lose untracked file at y/wham" out &&
+			test_grep "CONFLICT (rename/rename)" out &&
+			test_grep "Refusing to lose untracked file at y/wham" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 6 out &&
@@ -3606,7 +3606,7 @@ test_expect_merge_algorithm failure success '10e: D=
oes git complain about untrac
 		echo random >z/c &&
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out 2>err=
 &&
-		test_i18ngrep ! "following untracked working tree files would be overw=
ritten by merge" err &&
+		test_grep ! "following untracked working tree files would be overwritt=
en by merge" err &&
=20
 		git ls-files -s >out &&
 		test_line_count =3D 3 out &&
@@ -3690,9 +3690,9 @@ test_expect_success '11a: Avoid losing dirty conten=
ts with simple rename' '
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
-			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+			test_grep "Refusing to lose dirty file at z/c" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 2 out &&
@@ -3770,10 +3770,10 @@ test_expect_success '11b: Avoid losing dirty file=
 involved in directory rename'
 		then
 			test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursiv=
e B^0 >out 2>err &&
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
 			git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out 2>er=
r &&
-			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+			test_grep "Refusing to lose dirty file at z/c" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 3 out &&
@@ -3853,9 +3853,9 @@ test_expect_success '11c: Avoid losing not-uptodate=
 with rename + D/F conflict'
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
-			test_i18ngrep "following files would be overwritten by merge" err
+			test_grep "following files would be overwritten by merge" err
 		fi &&
=20
 		grep -q stuff y/c &&
@@ -3927,9 +3927,9 @@ test_expect_success '11d: Avoid losing not-uptodate=
 with rename + D/F conflict'
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
-			test_i18ngrep "Refusing to lose dirty file at z/c" out &&
+			test_grep "Refusing to lose dirty file at z/c" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 4 out &&
@@ -4013,10 +4013,10 @@ test_expect_success '11e: Avoid deleting not-upto=
date with dir rename/rename(1to
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
-			test_i18ngrep "CONFLICT (rename/rename)" out &&
-			test_i18ngrep "Refusing to lose dirty file at y/c" out &&
+			test_grep "CONFLICT (rename/rename)" out &&
+			test_grep "Refusing to lose dirty file at y/c" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 7 out &&
@@ -4102,10 +4102,10 @@ test_expect_success '11f: Avoid deleting not-upto=
date with dir rename/rename(2to
 		if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 		then
 			test_path_is_missing .git/MERGE_HEAD &&
-			test_i18ngrep "error: Your local changes to the following files would=
 be overwritten by merge" err
+			test_grep "error: Your local changes to the following files would be =
overwritten by merge" err
 		else
-			test_i18ngrep "CONFLICT (rename/rename)" out &&
-			test_i18ngrep "Refusing to lose dirty file at y/wham" out &&
+			test_grep "CONFLICT (rename/rename)" out &&
+			test_grep "Refusing to lose dirty file at y/wham" out &&
=20
 			git ls-files -s >out &&
 			test_line_count =3D 4 out &&
@@ -5417,8 +5417,8 @@ test_expect_success '13a(conflict): messages for ne=
wly added files' '
=20
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep CONFLICT..file.location.*z/e/f.added.in.B^0.*y/e/f out &=
&
-		test_i18ngrep CONFLICT..file.location.*z/d.added.in.B^0.*y/d out &&
+		test_grep CONFLICT..file.location.*z/e/f.added.in.B^0.*y/e/f out &&
+		test_grep CONFLICT..file.location.*z/d.added.in.B^0.*y/d out &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5441,8 +5441,8 @@ test_expect_success '13a(info): messages for newly =
added files' '
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out 2>err=
 &&
=20
-		test_i18ngrep Path.updated:.*z/e/f.added.in.B^0.*y/e/f out &&
-		test_i18ngrep Path.updated:.*z/d.added.in.B^0.*y/d out &&
+		test_grep Path.updated:.*z/e/f.added.in.B^0.*y/e/f out &&
+		test_grep Path.updated:.*z/d.added.in.B^0.*y/d out &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5507,8 +5507,8 @@ test_expect_success '13b(conflict): messages for tr=
ansitive rename with conflict
=20
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep CONFLICT.*content.*Merge.conflict.in.y/d out &&
-		test_i18ngrep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/=
d out &&
+		test_grep CONFLICT.*content.*Merge.conflict.in.y/d out &&
+		test_grep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d ou=
t &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5529,8 +5529,8 @@ test_expect_success '13b(info): messages for transi=
tive rename with conflicted c
=20
 		test_must_fail git -c merge.directoryRenames=3Dtrue merge -s recursive=
 B^0 >out 2>err &&
=20
-		test_i18ngrep CONFLICT.*content.*Merge.conflict.in.y/d out &&
-		test_i18ngrep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y=
/d out &&
+		test_grep CONFLICT.*content.*Merge.conflict.in.y/d out &&
+		test_grep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d o=
ut &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5593,7 +5593,7 @@ test_expect_success '13c(conflict): messages for re=
name/rename(1to1) via transit
=20
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/=
d out &&
+		test_grep CONFLICT..file.location.*x/d.renamed.to.z/d.*moved.to.y/d ou=
t &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5614,7 +5614,7 @@ test_expect_success '13c(info): messages for rename=
/rename(1to1) via transitive
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out 2>err=
 &&
=20
-		test_i18ngrep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y=
/d out &&
+		test_grep Path.updated:.*x/d.renamed.to.z/d.in.B^0.*moving.it.to.y/d o=
ut &&
=20
 		git ls-files >paths &&
 		! grep z/ paths &&
@@ -5682,8 +5682,8 @@ test_expect_success '13d(conflict): messages for re=
name/rename(1to1) via dual tr
=20
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep CONFLICT..file.location.*a/y.renamed.to.b/y.*moved.to.d/=
y out &&
-		test_i18ngrep CONFLICT..file.location.*a/y.renamed.to.c/y.*moved.to.d/=
y out &&
+		test_grep CONFLICT..file.location.*a/y.renamed.to.b/y.*moved.to.d/y ou=
t &&
+		test_grep CONFLICT..file.location.*a/y.renamed.to.c/y.*moved.to.d/y ou=
t &&
=20
 		git ls-files >paths &&
 		! grep b/ paths &&
@@ -5706,8 +5706,8 @@ test_expect_success '13d(info): messages for rename=
/rename(1to1) via dual transi
=20
 		git -c merge.directoryRenames=3Dtrue merge -s recursive B^0 >out 2>err=
 &&
=20
-		test_i18ngrep Path.updated.*a/y.renamed.to.b/y.*moving.it.to.d/y out &=
&
-		test_i18ngrep Path.updated.*a/y.renamed.to.c/y.*moving.it.to.d/y out &=
&
+		test_grep Path.updated.*a/y.renamed.to.b/y.*moving.it.to.d/y out &&
+		test_grep Path.updated.*a/y.renamed.to.c/y.*moving.it.to.d/y out &&
=20
 		git ls-files >paths &&
 		! grep b/ paths &&
@@ -5821,9 +5821,9 @@ test_expect_success '13e: directory rename detectio=
n in recursive case' '
=20
 		git -c merge.directoryRenames=3Dconflict merge -s recursive C^0 >out 2=
>err &&
=20
-		test_i18ngrep ! CONFLICT out &&
-		test_i18ngrep ! BUG: err &&
-		test_i18ngrep ! core.dumped err &&
+		test_grep ! CONFLICT out &&
+		test_grep ! BUG: err &&
+		test_grep ! core.dumped err &&
 		test_must_be_empty err &&
=20
 		git ls-files >paths &&
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unr=
elated-index-changes.sh
index a61f20c22f..7677c5f08d 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -178,7 +178,7 @@ test_expect_success 'merge-recursive, when index=3D=3D=
head but head!=3DHEAD' '
 	test_when_finished "git clean -fd" &&  # Do not leave untracked around
 	# Merge B & F, with B as "head"
 	git merge-recursive A -- B F > out &&
-	test_i18ngrep "Already up to date" out
+	test_grep "Already up to date" out
 '
=20
 test_expect_success 'recursive, when file has staged changes not matchin=
g HEAD nor what a merge would give' '
@@ -194,7 +194,7 @@ test_expect_success 'recursive, when file has staged =
changes not matching HEAD n
 	test_must_fail git merge -s recursive E^0 2>err &&
 	git rev-parse --verify :subdir/a >actual &&
 	test_cmp expect actual &&
-	test_i18ngrep "changes to the following files would be overwritten" err
+	test_grep "changes to the following files would be overwritten" err
 '
=20
 test_expect_success 'recursive, when file has staged changes matching wh=
at a merge would give' '
@@ -210,7 +210,7 @@ test_expect_success 'recursive, when file has staged =
changes matching what a mer
 	test_must_fail git merge -s recursive E^0 2>err &&
 	git rev-parse --verify :subdir/a >actual &&
 	test_cmp expect actual &&
-	test_i18ngrep "changes to the following files would be overwritten" err
+	test_grep "changes to the following files would be overwritten" err
 '
=20
 test_expect_success 'octopus, unrelated file touched' '
diff --git a/t/t6425-merge-rename-delete.sh b/t/t6425-merge-rename-delete=
.sh
index 93cd2869b1..b95b064311 100755
--- a/t/t6425-merge-rename-delete.sh
+++ b/t/t6425-merge-rename-delete.sh
@@ -21,8 +21,8 @@ test_expect_success 'rename/delete' '
 	git commit -m "delete" &&
=20
 	test_must_fail git merge --strategy=3Drecursive rename >output &&
-	test_i18ngrep "CONFLICT (rename/delete): A.* renamed .*to B.* in rename=
" output &&
-	test_i18ngrep "CONFLICT (rename/delete): A.*deleted in HEAD." output
+	test_grep "CONFLICT (rename/delete): A.* renamed .*to B.* in rename" ou=
tput &&
+	test_grep "CONFLICT (rename/delete): A.*deleted in HEAD." output
 '
=20
 test_done
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-=
unneeded-updates.sh
index fd21c1a486..b059475ed0 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -375,7 +375,7 @@ test_expect_success '2c: Modify b & add c VS rename b=
->c' '
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge -s recursive B^0 >out 2>err &&
=20
-		test_i18ngrep "CONFLICT (.*/add):" out &&
+		test_grep "CONFLICT (.*/add):" out &&
 		test_must_be_empty err &&
=20
 		git ls-files -s >index_files &&
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index 07067bb347..ca15e6dd6d 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -308,13 +308,13 @@ test_expect_success 'fail if the index has unresolv=
ed entries' '
=20
 	test_must_fail git merge "$c5" &&
 	test_must_fail git merge "$c5" 2> out &&
-	test_i18ngrep "not possible because you have unmerged files" out &&
+	test_grep "not possible because you have unmerged files" out &&
 	git add -u &&
 	test_must_fail git merge "$c5" 2> out &&
-	test_i18ngrep "You have not concluded your merge" out &&
+	test_grep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
 	test_must_fail git merge "$c5" 2> out &&
-	test_i18ngrep "Your local changes to the following files would be overw=
ritten by merge:" out
+	test_grep "Your local changes to the following files would be overwritt=
en by merge:" out
 '
=20
 test_expect_success 'merge-recursive remove conflict' '
@@ -713,7 +713,7 @@ test_expect_success 'merge-recursive remembers the na=
mes of all base trees' '
 	test_must_fail git -c merge.verbosity=3D5 merge-recursive $(cat trees) =
-- $c1 $c3 >out &&
=20
 	# ...but make sure it fails in the expected way
-	test_i18ngrep CONFLICT.*rename/rename out &&
+	test_grep CONFLICT.*rename/rename out &&
=20
 	# merge-recursive prints in reverse order, but we do not care
 	sort <trees >expect &&
diff --git a/t/t6433-merge-toplevel.sh b/t/t6433-merge-toplevel.sh
index b16031465f..0f611c4003 100755
--- a/t/t6433-merge-toplevel.sh
+++ b/t/t6433-merge-toplevel.sh
@@ -151,7 +151,7 @@ test_expect_success 'refuse two-project merge by defa=
ult, quit before --autostas
 	echo change >>one.t &&
 	git diff >expect &&
 	test_must_fail git merge --autostash five 2>err &&
-	test_i18ngrep ! "stash" err &&
+	test_grep ! "stash" err &&
 	git diff >actual &&
 	test_cmp expect actual
 '
@@ -169,7 +169,7 @@ test_expect_success 'two-project merge with --allow-u=
nrelated-histories with --a
 	echo change >>one.t &&
 	git diff one.t >expect &&
 	git merge --allow-unrelated-histories --autostash five 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git diff one.t >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index c0b7bd7c3f..4f4376421e 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -104,12 +104,12 @@ test_expect_success 'will not overwrite unstaged ch=
anges in renamed file' '
 	if test "$GIT_TEST_MERGE_ALGORITHM" =3D ort
 	then
 		test_must_fail git merge c1a >out 2>err &&
-		test_i18ngrep "would be overwritten by merge" err &&
+		test_grep "would be overwritten by merge" err &&
 		test_cmp important other.c &&
 		test_path_is_missing .git/MERGE_HEAD
 	else
 		test_must_fail git merge c1a >out &&
-		test_i18ngrep "Refusing to lose dirty file at other.c" out &&
+		test_grep "Refusing to lose dirty file at other.c" out &&
 		test_path_is_file other.c~HEAD &&
 		test $(git hash-object other.c~HEAD) =3D $(git rev-parse c1a:c1.c) &&
 		test_cmp important other.c
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index c9a86f2e94..f1440697d1 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -479,7 +479,7 @@ test_expect_merge_algorithm failure success !FAIL_PRE=
REQS 'directory/submodule c
 		# We do not want files within the submodule to prevent the
 		# merge from starting; we should not be writing to such paths
 		# anyway.
-		test_i18ngrep ! "refusing to lose untracked file at" err
+		test_grep ! "refusing to lose untracked file at" err
 	)
 '
=20
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 69509d0c11..4a188cefb0 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -41,7 +41,7 @@ test_expect_success 'gc does not leave behind pid file'=
 '
=20
 test_expect_success 'gc --gobbledegook' '
 	test_expect_code 129 git gc --nonsense 2>err &&
-	test_i18ngrep "[Uu]sage: git gc" err
+	test_grep "[Uu]sage: git gc" err
 '
=20
 test_expect_success 'gc -h with invalid configuration' '
@@ -52,7 +52,7 @@ test_expect_success 'gc -h with invalid configuration' =
'
 		echo "[gc] pruneexpire =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git gc -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage" broken/usage
+	test_grep "[Uu]sage" broken/usage
 '
=20
 test_expect_success 'gc is not aborted due to a stale symref' '
@@ -155,7 +155,7 @@ test_expect_success 'auto gc with too many loose obje=
cts does not attempt to cre
 	test_commit "$(test_oid obj4)" &&
=20
 	git gc --auto 2>err &&
-	test_i18ngrep ! "^warning:" err &&
+	test_grep ! "^warning:" err &&
 	ls .git/objects/pack/pack-*.pack | sort >post_packs &&
 	comm -1 -3 existing_packs post_packs >new &&
 	comm -2 -3 existing_packs post_packs >del &&
@@ -166,15 +166,15 @@ test_expect_success 'auto gc with too many loose ob=
jects does not attempt to cre
 test_expect_success 'gc --no-quiet' '
 	GIT_PROGRESS_DELAY=3D0 git -c gc.writeCommitGraph=3Dtrue gc --no-quiet =
>stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
+	test_grep "Computing commit graph generation numbers" stderr
 '
=20
 test_expect_success TTY 'with TTY: gc --no-quiet' '
 	test_terminal env GIT_PROGRESS_DELAY=3D0 \
 		git -c gc.writeCommitGraph=3Dtrue gc --no-quiet >stdout 2>stderr &&
 	test_must_be_empty stdout &&
-	test_i18ngrep "Enumerating objects" stderr &&
-	test_i18ngrep "Computing commit graph generation numbers" stderr
+	test_grep "Enumerating objects" stderr &&
+	test_grep "Computing commit graph generation numbers" stderr
 '
=20
 test_expect_success 'gc --quiet' '
@@ -321,7 +321,7 @@ test_expect_success 'background auto gc does not run =
if gc.log is present and re
 	test_config gc.autodetach true &&
 	echo fleem >.git/gc.log &&
 	git gc --auto 2>err &&
-	test_i18ngrep "^warning:" err &&
+	test_grep "^warning:" err &&
 	test_config gc.logexpiry 5.days &&
 	test-tool chmtime =3D-345600 .git/gc.log &&
 	git gc --auto &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index f136ea76f7..879a6dce60 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -296,7 +296,7 @@ test_expect_success 'git mv error on conflicted file'=
 '
 	EOF
=20
 	test_must_fail git mv conflict newname 2>actual &&
-	test_i18ngrep "conflicted" actual
+	test_grep "conflicted" actual
 '
=20
 test_expect_success 'git mv should overwrite symlink to a file' '
@@ -482,7 +482,7 @@ test_expect_success 'checking out a commit before sub=
module moved needs manual u
 	git mv sub sub2 &&
 	git commit -m "moved sub to sub2" &&
 	git checkout -q HEAD^ 2>actual &&
-	test_i18ngrep "^warning: unable to rmdir '\''sub2'\'':" actual &&
+	test_grep "^warning: unable to rmdir '\''sub2'\'':" actual &&
 	git status -s sub2 >actual &&
 	echo "?? sub2/" >expected &&
 	test_cmp expected actual &&
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 9b46da7aaa..05079c7246 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -30,21 +30,21 @@ test_expect_success PERL 'git reset -p' '
 	test_write_lines n y | git reset -p >output &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar &&
-	test_i18ngrep "Unstage" output
+	test_grep "Unstage" output
 '
=20
 test_expect_success PERL 'git reset -p HEAD^' '
 	test_write_lines n y | git reset -p HEAD^ >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
-	test_i18ngrep "Apply" output
+	test_grep "Apply" output
 '
=20
 test_expect_success PERL 'git reset -p HEAD^^{tree}' '
 	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar &&
-	test_i18ngrep "Apply" output
+	test_grep "Apply" output
 '
=20
 test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
diff --git a/t/t7106-reset-unborn-branch.sh b/t/t7106-reset-unborn-branch=
.sh
index a0b67a0b84..d20e5709f9 100755
--- a/t/t7106-reset-unborn-branch.sh
+++ b/t/t7106-reset-unborn-branch.sh
@@ -42,7 +42,7 @@ test_expect_success PERL 'reset -p' '
=20
 	git ls-files >actual &&
 	test_must_be_empty actual &&
-	test_i18ngrep "Unstage" output
+	test_grep "Unstage" output
 '
=20
 test_expect_success 'reset --soft is a no-op' '
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file=
.sh
index af5ea406db..020db201d5 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -161,19 +161,19 @@ test_expect_success 'error conditions' '
 	git rm fileA.t &&
=20
 	test_must_fail git reset --pathspec-from-file=3Dlist --patch 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot b=
e used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--patch. cannot be us=
ed together" err &&
=20
 	test_must_fail git reset --pathspec-from-file=3Dlist -- fileA.t 2>err &=
&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git reset --pathspec-file-nul 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err &&
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err &&
=20
 	test_must_fail git reset --soft --pathspec-from-file=3Dlist 2>err &&
-	test_i18ngrep -e "fatal: Cannot do soft reset with paths" err &&
+	test_grep -e "fatal: Cannot do soft reset with paths" err &&
=20
 	test_must_fail git reset --hard --pathspec-from-file=3Dlist 2>err &&
-	test_i18ngrep -e "fatal: Cannot do hard reset with paths" err
+	test_grep -e "fatal: Cannot do hard reset with paths" err
 '
=20
 test_done
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 772480a345..7ee180f81d 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -238,7 +238,7 @@ test_expect_success '"reset --keep HEAD^" fails with =
pending merge' '
 	git reset --hard third &&
 	test_must_fail git merge branch1 &&
 	test_must_fail git reset --keep HEAD^ 2>err.log &&
-	test_i18ngrep "middle of a merge" err.log
+	test_grep "middle of a merge" err.log
 '
=20
 # The next test will test the following:
@@ -264,7 +264,7 @@ test_expect_success '"reset --keep HEAD" fails with p=
ending merge' '
 	git reset --hard third &&
 	test_must_fail git merge branch1 &&
 	test_must_fail git reset --keep HEAD 2>err.log &&
-	test_i18ngrep "middle of a merge" err.log
+	test_grep "middle of a merge" err.log
 '
=20
 test_expect_success '--merge is ok with added/deleted merge' '
@@ -290,7 +290,7 @@ test_expect_success '--keep fails with added/deleted =
merge' '
 	git diff --exit-code file3 &&
 	git diff --exit-code branch3 file3 &&
 	test_must_fail git reset --keep HEAD 2>err.log &&
-	test_i18ngrep "middle of a merge" err.log
+	test_grep "middle of a merge" err.log
 '
=20
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 35b9e6ed6b..c2550f3028 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -217,7 +217,7 @@ test_expect_success 'switch to another branch while c=
arrying a deletion' '
 	git rm two &&
=20
 	test_must_fail git checkout simple 2>errs &&
-	test_i18ngrep overwritten errs &&
+	test_grep overwritten errs &&
=20
 	test_must_fail git read-tree --quiet -m -u HEAD simple 2>errs &&
 	test_must_be_empty errs
@@ -229,7 +229,7 @@ test_expect_success 'checkout to detach HEAD (with ad=
vice declined)' '
 	git checkout -f renamer &&
 	git clean -f &&
 	git checkout renamer^ 2>messages &&
-	test_i18ngrep "HEAD is now at $rev" messages &&
+	test_grep "HEAD is now at $rev" messages &&
 	test_line_count =3D 1 messages &&
 	H=3D$(git rev-parse --verify HEAD) &&
 	M=3D$(git show-ref -s --verify refs/heads/main) &&
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0ef7b78457..1a310a45fd 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -735,7 +735,7 @@ test_expect_success MINGW 'handle clean & core.longpa=
ths =3D false nicely' '
 	test_must_fail git clean -xdf 2>.git/err &&
 	# grepping for a strerror string is unportable but it is OK here with
 	# MINGW prereq
-	test_i18ngrep "too long" .git/err
+	test_grep "too long" .git/err
 '
=20
 test_expect_success 'clean untracked paths by pathspec' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d9fbabb2b9..00c1f1aab1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -60,7 +60,7 @@ test_expect_success 'submodule init aborts on missing .=
gitmodules file' '
 	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
 	# missing the .gitmodules file here
 	test_must_fail git submodule init 2>actual &&
-	test_i18ngrep "No url found for submodule path" actual
+	test_grep "No url found for submodule path" actual
 '
=20
 test_expect_success 'submodule update aborts on missing .gitmodules file=
' '
@@ -68,7 +68,7 @@ test_expect_success 'submodule update aborts on missing=
 .gitmodules file' '
 	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
 	# missing the .gitmodules file here
 	git submodule update sub 2>actual &&
-	test_i18ngrep "Submodule path .sub. not initialized" actual
+	test_grep "Submodule path .sub. not initialized" actual
 '
=20
 test_expect_success 'submodule update aborts on missing gitmodules url' =
'
@@ -100,7 +100,7 @@ test_expect_success 'status should ignore inner git r=
epo when not added' '
 	) &&
 	test_must_fail git submodule status inner 2>output.err &&
 	rm -fr inner &&
-	test_i18ngrep "^error: .*did not match any file(s) known to git" output=
.err
+	test_grep "^error: .*did not match any file(s) known to git" output.err
 '
=20
 test_expect_success 'setup - repository in init subdirectory' '
@@ -196,7 +196,7 @@ test_expect_success 'redirected submodule add does no=
t show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirect=
ed \
 		2>err &&
 	! grep % err &&
-	test_i18ngrep ! "Checking connectivity" err
+	test_grep ! "Checking connectivity" err
 '
=20
 test_expect_success 'redirected submodule add --progress does show progr=
ess' '
@@ -263,7 +263,7 @@ test_expect_success 'submodule add relays add --dry-r=
un stderr' '
 		cd addtest &&
 		: >.git/index.lock &&
 		! git submodule add "$submodurl" sub-while-locked 2>output.err &&
-		test_i18ngrep "^fatal: .*index\.lock" output.err &&
+		test_grep "^fatal: .*index\.lock" output.err &&
 		test_path_is_missing sub-while-locked
 	)
 '
@@ -405,7 +405,7 @@ test_expect_success 'submodule add in subdirectory wi=
th relative path should fai
 		cd addtest/sub &&
 		test_must_fail git submodule add ../../ submod3 2>../../output.err
 	) &&
-	test_i18ngrep toplevel output.err
+	test_grep toplevel output.err
 '
=20
 test_expect_success 'setup - add an example entry to .gitmodules' '
@@ -486,7 +486,7 @@ test_expect_success 'status should still be "missing"=
 after initializing' '
=20
 test_failure_with_unknown_submodule () {
 	test_must_fail git submodule $1 no-such-submodule 2>output.err &&
-	test_i18ngrep "^error: .*no-such-submodule" output.err
+	test_grep "^error: .*no-such-submodule" output.err
 }
=20
 test_expect_success 'init should fail with unknown submodule' '
@@ -644,7 +644,7 @@ test_expect_success 'update --init' '
 	test_must_fail git config submodule.example.url &&
=20
 	git submodule update init 2> update.out &&
-	test_i18ngrep "not initialized" update.out &&
+	test_grep "not initialized" update.out &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&
=20
 	git submodule update --init init &&
@@ -661,7 +661,7 @@ test_expect_success 'update --init from subdirectory'=
 '
 	(
 		cd sub &&
 		git submodule update ../init 2>update.out &&
-		test_i18ngrep "not initialized" update.out &&
+		test_grep "not initialized" update.out &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
=20
 		git submodule update --init ../init
@@ -1121,7 +1121,7 @@ test_expect_success 'submodule deinit from subdirec=
tory' '
 		cd sub &&
 		git submodule deinit ../init >../output
 	) &&
-	test_i18ngrep "\\.\\./init" output &&
+	test_grep "\\.\\./init" output &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
 	test -f example2/.git &&
@@ -1136,8 +1136,8 @@ test_expect_success 'submodule deinit . deinits all=
 initialized submodules' '
 	git submodule deinit . >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-	test_i18ngrep "Cleared directory .init" actual &&
-	test_i18ngrep "Cleared directory .example2" actual &&
+	test_grep "Cleared directory .init" actual &&
+	test_grep "Cleared directory .example2" actual &&
 	rmdir init example2
 '
=20
@@ -1149,8 +1149,8 @@ test_expect_success 'submodule deinit --all deinits=
 all initialized submodules'
 	git submodule deinit --all >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-	test_i18ngrep "Cleared directory .init" actual &&
-	test_i18ngrep "Cleared directory .example2" actual &&
+	test_grep "Cleared directory .init" actual &&
+	test_grep "Cleared directory .example2" actual &&
 	rmdir init example2
 '
=20
@@ -1160,8 +1160,8 @@ test_expect_success 'submodule deinit deinits a sub=
module when its work tree is
 	git submodule deinit init example2 >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-	test_i18ngrep ! "Cleared directory .init" actual &&
-	test_i18ngrep "Cleared directory .example2" actual &&
+	test_grep ! "Cleared directory .init" actual &&
+	test_grep "Cleared directory .example2" actual &&
 	rmdir init
 '
=20
@@ -1173,7 +1173,7 @@ test_expect_success 'submodule deinit fails when th=
e submodule contains modifica
 	test -f example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep "Cleared directory .init" actual &&
 	rmdir init
 '
=20
@@ -1185,7 +1185,7 @@ test_expect_success 'submodule deinit fails when th=
e submodule contains untracke
 	test -f example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep "Cleared directory .init" actual &&
 	rmdir init
 '
=20
@@ -1200,30 +1200,30 @@ test_expect_success 'submodule deinit fails when =
the submodule HEAD does not mat
 	test -f example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep "Cleared directory .init" actual &&
 	rmdir init
 '
=20
 test_expect_success 'submodule deinit is silent when used on an uninitia=
lized submodule' '
 	git submodule update --init &&
 	git submodule deinit init >actual &&
-	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" ac=
tual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep "Submodule .example. (.*) unregistered for path .init" actual=
 &&
+	test_grep "Cleared directory .init" actual &&
 	git submodule deinit init >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" =
actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep ! "Submodule .example. (.*) unregistered for path .init" actu=
al &&
+	test_grep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" =
actual &&
-	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example=
2" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep ! "Submodule .example. (.*) unregistered for path .init" actu=
al &&
+	test_grep "Submodule .example2. (.*) unregistered for path .example2" a=
ctual &&
+	test_grep "Cleared directory .init" actual &&
 	git submodule deinit . >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" =
actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .examp=
le2" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep ! "Submodule .example. (.*) unregistered for path .init" actu=
al &&
+	test_grep ! "Submodule .example2. (.*) unregistered for path .example2"=
 actual &&
+	test_grep "Cleared directory .init" actual &&
 	git submodule deinit --all >actual &&
-	test_i18ngrep ! "Submodule .example. (.*) unregistered for path .init" =
actual &&
-	test_i18ngrep ! "Submodule .example2. (.*) unregistered for path .examp=
le2" actual &&
-	test_i18ngrep "Cleared directory .init" actual &&
+	test_grep ! "Submodule .example. (.*) unregistered for path .init" actu=
al &&
+	test_grep ! "Submodule .example2. (.*) unregistered for path .example2"=
 actual &&
+	test_grep "Cleared directory .init" actual &&
 	rmdir init example2
 '
=20
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index ff09443a0a..19b6135d11 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -163,7 +163,7 @@ test_expect_success '"git submodule sync" should upda=
te submodule URLs - subdire
 		cd sub &&
 		git submodule sync >../../output
 	) &&
-	test_i18ngrep "\\.\\./submodule" output &&
+	test_grep "\\.\\./submodule" output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
@@ -194,7 +194,7 @@ test_expect_success '"git submodule sync --recursive"=
 should update all submodul
 		cd sub &&
 		git submodule sync --recursive >../../output
 	) &&
-	test_i18ngrep "\\.\\./submodule/sub-submodule" output &&
+	test_grep "\\.\\./submodule/sub-submodule" output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 00651c25cb..8491b8c58b 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -945,7 +945,7 @@ test_expect_success 'submodule update places git-dir =
in superprojects git-dir re
 	git clone super_update_r super_update_r2 &&
 	(cd super_update_r2 &&
 	 git submodule update --init --recursive >actual &&
-	 test_i18ngrep "Submodule path .submodule/subsubmodule.: checked out" a=
ctual &&
+	 test_grep "Submodule path .submodule/subsubmodule.: checked out" actua=
l &&
 	 (cd submodule/subsubmodule &&
 	  git log > ../../expected
 	 ) &&
@@ -1025,7 +1025,7 @@ test_expect_success 'submodule update clone shallow=
 submodule outside of depth'
 		# unadvertised objects, so restrict this test to v0.
 		test_must_fail env GIT_TEST_PROTOCOL_VERSION=3D0 \
 			git submodule update --init --depth=3D1 2>actual &&
-		test_i18ngrep "Direct fetching of that commit failed." actual &&
+		test_grep "Direct fetching of that commit failed." actual &&
 		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
 		git submodule update --init --depth=3D1 >actual &&
 		git -C submodule log --oneline >out &&
@@ -1039,7 +1039,7 @@ test_expect_success 'submodule update --recursive d=
rops module name before recur
 	  git checkout HEAD^
 	 ) &&
 	 git submodule update --recursive deeper/submodule >actual &&
-	 test_i18ngrep "Submodule path .deeper/submodule/subsubmodule.: checked=
 out" actual
+	 test_grep "Submodule path .deeper/submodule/subsubmodule.: checked out=
" actual
 	)
 '
=20
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index c0167944ab..31271f8e0a 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -45,7 +45,7 @@ test_expect_success 'configuration parsing with error' =
'
 	(
 		cd repo &&
 		test_must_fail test-tool submodule-config "" s 2>actual &&
-		test_i18ngrep "bad config" actual
+		test_grep "bad config" actual
 	)
 '
=20
@@ -101,7 +101,7 @@ test_expect_success 'error in history of one submodul=
e config lets continue, std
 				>actual \
 				2>actual_stderr &&
 		test_cmp expect_error actual &&
-		test_i18ngrep "submodule-blob $sha1:.gitmodules" actual_stderr >/dev/n=
ull
+		test_grep "submodule-blob $sha1:.gitmodules" actual_stderr >/dev/null
 	)
 '
=20
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.s=
h
index 101afff30f..24f30e3bf9 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -13,13 +13,13 @@ test_expect_success 'create embedded repository' '
 test_expect_success 'git-add on embedded repository warns' '
 	test_when_finished "git rm --cached -f embed" &&
 	git add embed 2>stderr &&
-	test_i18ngrep warning stderr
+	test_grep warning stderr
 '
=20
 test_expect_success '--no-warn-embedded-repo suppresses warning' '
 	test_when_finished "git rm --cached -f embed" &&
 	git add --no-warn-embedded-repo embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_grep ! warning stderr
 '
=20
 test_expect_success 'no warning when updating entry' '
@@ -27,14 +27,14 @@ test_expect_success 'no warning when updating entry' =
'
 	git add embed &&
 	git -C embed commit --allow-empty -m two &&
 	git add embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_grep ! warning stderr
 '
=20
 test_expect_success 'submodule add does not warn' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
 	git -c protocol.file.allow=3Dalways \
 		submodule add ./embed submodule 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_grep ! warning stderr
 '
=20
 test_done
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.s=
h
index 7cf72b9a07..2ab566e717 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -41,7 +41,7 @@ test_expect_success 'remove ./ protection from .gitmodu=
les url' '
 test_expect_success 'clone rejects unprotected dash' '
 	test_when_finished "rm -rf dst" &&
 	test_must_fail git clone --recurse-submodules . dst 2>err &&
-	test_i18ngrep ignoring err
+	test_grep ignoring err
 '
=20
 test_expect_success 'fsck rejects unprotected dash' '
@@ -63,7 +63,7 @@ test_expect_success 'trailing backslash is handled corr=
ectly' '
 	mv .new .gitmodules &&
 	git commit -am "Add testmodule" &&
 	test_must_fail git clone --verbose --recurse-submodules . dolly 2>err &=
&
-	test_i18ngrep ! "unknown option" err
+	test_grep ! "unknown option" err
 '
=20
 test_expect_success 'fsck rejects missing URL scheme' '
diff --git a/t/t7417-submodule-path-url.sh b/t/t7417-submodule-path-url.s=
h
index 2f4b25dfd7..5e3051da8b 100755
--- a/t/t7417-submodule-path-url.sh
+++ b/t/t7417-submodule-path-url.sh
@@ -21,7 +21,7 @@ test_expect_success 'create submodule with dash in path=
' '
 test_expect_success 'clone rejects unprotected dash' '
 	test_when_finished "rm -rf dst" &&
 	git clone --recurse-submodules . dst 2>err &&
-	test_i18ngrep ignoring err
+	test_grep ignoring err
 '
=20
 test_expect_success 'fsck rejects unprotected dash' '
@@ -46,7 +46,7 @@ test_expect_success MINGW 'submodule paths disallows tr=
ailing spaces' '
 	git -C super update-ref refs/heads/main $commit &&
=20
 	test_must_fail git clone --recurse-submodules super dst 2>err &&
-	test_i18ngrep "sub " err
+	test_grep "sub " err
 '
=20
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 0d0c3f2c68..35a31acd4d 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -238,7 +238,7 @@ test_expect_success 'fsck detects non-blob .gitmodule=
s' '
 		git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree &&
=20
 		test_must_fail git fsck 2>output &&
-		test_i18ngrep gitmodulesBlob output
+		test_grep gitmodulesBlob output
 	)
 '
=20
@@ -252,8 +252,8 @@ test_expect_success 'fsck detects corrupt .gitmodules=
' '
 		git commit -m "broken gitmodules" &&
=20
 		git fsck 2>output &&
-		test_i18ngrep gitmodulesParse output &&
-		test_i18ngrep ! "bad config" output
+		test_grep gitmodulesParse output &&
+		test_grep ! "bad config" output
 	)
 '
=20
@@ -275,7 +275,7 @@ test_expect_success WINDOWS 'prevent git~1 squatting =
on Windows' '
 		hash=3D"$(echo x | git hash-object -w --stdin)" &&
 		test_must_fail git update-index --add \
 			--cacheinfo 160000,$rev,d\\a 2>err &&
-		test_i18ngrep "Invalid path" err &&
+		test_grep "Invalid path" err &&
 		git -c core.protectNTFS=3Dfalse update-index --add \
 			--cacheinfo 100644,$modules,.gitmodules \
 			--cacheinfo 160000,$rev,c \
@@ -289,7 +289,7 @@ test_expect_success WINDOWS 'prevent git~1 squatting =
on Windows' '
 	then
 		test_must_fail git -c core.protectNTFS=3Dfalse \
 			clone --recurse-submodules squatting squatting-clone 2>err &&
-		test_i18ngrep -e "directory not empty" -e "not an empty directory" err=
 &&
+		test_grep -e "directory not empty" -e "not an empty directory" err &&
 		! grep gitdir squatting-clone/d/a/git~2
 	fi
 '
@@ -314,7 +314,7 @@ test_expect_success 'git dirs of sibling submodules m=
ust not be nested' '
 		git commit -m nested
 	) &&
 	test_must_fail git clone --recurse-submodules nested clone 2>err &&
-	test_i18ngrep "is inside git dir" err
+	test_grep "is inside git dir" err
 '
=20
 test_done
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-t=
emplate-squash-signoff.sh
index 5fcaa0b4f2..4dca8d97a7 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -555,7 +555,7 @@ test_expect_success 'commit without staging files fai=
ls and displays hints' '
 	git commit -m initial &&
 	echo "changes" >>file &&
 	test_must_fail git commit -m update >actual &&
-	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git=
 commit -a\")" actual
+	test_grep "no changes added to commit (use \"git add\" and/or \"git com=
mit -a\")" actual
 '
=20
 test_done
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic=
-functionality.sh
index fb5417d5e7..3d8500a52e 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -21,7 +21,7 @@ test_expect_success 'initial status' '
 	echo bongo bongo >file &&
 	git add file &&
 	git status >actual &&
-	test_i18ngrep "No commits yet" actual
+	test_grep "No commits yet" actual
 '
=20
 test_expect_success 'fail initial amend' '
@@ -141,7 +141,7 @@ test_expect_success 'template "emptyness" check does =
not kick in with -F' '
 test_expect_success 'template "emptyness" check' '
 	git checkout HEAD file && echo >>file && git add file &&
 	test_must_fail git commit -t file 2>err &&
-	test_i18ngrep "did not edit" err
+	test_grep "did not edit" err
 '
=20
 test_expect_success 'setup: commit message from file' '
@@ -671,7 +671,7 @@ test_expect_success 'commit a file whose name is a da=
sh' '
 	git add ./- &&
 	test_tick &&
 	git commit -m "add dash" >output </dev/null &&
-	test_i18ngrep " changed, 5 insertions" output
+	test_grep " changed, 5 insertions" output
 '
=20
 test_expect_success '--only works on to-be-born branch' '
diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index b5bf7de7cd..61c8e810cc 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -706,14 +706,14 @@ test_expect_success 'cleanup commit message (whites=
pace config, -m)' '
 test_expect_success 'message shows author when it is not equal to commit=
ter' '
 	echo >>negative &&
 	git commit -e -m "sample" -a &&
-	test_i18ngrep \
+	test_grep \
 	  "^# Author: *A U Thor <author@example.com>\$" \
 	  .git/COMMIT_EDITMSG
 '
=20
 test_expect_success 'message shows date when it is explicitly set' '
 	git commit --allow-empty -e -m foo --date=3D"2010-01-02T03:04:05" &&
-	test_i18ngrep \
+	test_grep \
 	  "^# Date: *Sat Jan 2 03:04:05 2010 +0000" \
 	  .git/COMMIT_EDITMSG
 '
@@ -728,7 +728,7 @@ test_expect_success AUTOIDENT 'message shows committe=
r when it is automatic' '
 	) &&
 	# the ident is calculated from the system, so we cannot
 	# check the actual value, only that it is there
-	test_i18ngrep "^# Committer: " .git/COMMIT_EDITMSG
+	test_grep "^# Committer: " .git/COMMIT_EDITMSG
 '
=20
 write_script .git/FAKE_EDITOR <<EOF
@@ -860,9 +860,9 @@ try_commit () {
 	GIT_EDITOR=3D.git/FAKE_EDITOR git commit -a $* $use_template &&
 	case "$use_template" in
 	'')
-		test_i18ngrep ! "^## Custom template" .git/COMMIT_EDITMSG ;;
+		test_grep ! "^## Custom template" .git/COMMIT_EDITMSG ;;
 	*)
-		test_i18ngrep "^## Custom template" .git/COMMIT_EDITMSG ;;
+		test_grep "^## Custom template" .git/COMMIT_EDITMSG ;;
 	esac
 }
=20
@@ -870,53 +870,53 @@ try_commit_status_combo () {
=20
 	test_expect_success 'commit' '
 		try_commit "" &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --status' '
 		try_commit --status &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --no-status' '
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit with commit.status =3D yes' '
 		test_config commit.status yes &&
 		try_commit "" &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit with commit.status =3D no' '
 		test_config commit.status no &&
 		try_commit "" &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --status with commit.status =3D yes' '
 		test_config commit.status yes &&
 		try_commit --status &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --no-status with commit.status =3D yes' '
 		test_config commit.status yes &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --status with commit.status =3D no' '
 		test_config commit.status no &&
 		try_commit --status &&
-		test_i18ngrep "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 	test_expect_success 'commit --no-status with commit.status =3D no' '
 		test_config commit.status no &&
 		try_commit --no-status &&
-		test_i18ngrep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
+		test_grep ! "^# Changes to be committed:" .git/COMMIT_EDITMSG
 	'
=20
 }
@@ -930,13 +930,13 @@ try_commit_status_combo
 test_expect_success 'commit --status with custom comment character' '
 	test_config core.commentchar ";" &&
 	try_commit --status &&
-	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
+	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
=20
 test_expect_success 'switch core.commentchar' '
 	test_commit "#foo" foo &&
 	GIT_EDITOR=3D.git/FAKE_EDITOR git -c core.commentChar=3Dauto commit --a=
mend &&
-	test_i18ngrep "^; Changes to be committed:" .git/COMMIT_EDITMSG
+	test_grep "^; Changes to be committed:" .git/COMMIT_EDITMSG
 '
=20
 test_expect_success 'switch core.commentchar but out of options' '
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d050091345..46566d529e 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -37,19 +37,19 @@ test_expect_success 'setup' '
=20
 test_expect_success 'status clean' '
 	git status >output &&
-	test_i18ngrep "nothing to commit" output
+	test_grep "nothing to commit" output
 '
=20
 test_expect_success 'commit --dry-run -a clean' '
 	test_must_fail git commit --dry-run -a >output &&
-	test_i18ngrep "nothing to commit" output
+	test_grep "nothing to commit" output
 '
=20
 test_expect_success 'status with modified file in submodule' '
 	(cd sub && git reset --hard) &&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content)" output
+	test_grep "modified:   sub (modified content)" output
 '
=20
 test_expect_success 'status with modified file in submodule (porcelain)'=
 '
@@ -73,7 +73,7 @@ test_expect_success 'status with modified file in submo=
dule (short)' '
 test_expect_success 'status with added file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content)" output
+	test_grep "modified:   sub (modified content)" output
 '
=20
 test_expect_success 'status with added file in submodule (porcelain)' '
@@ -96,12 +96,12 @@ test_expect_success 'status with untracked file in su=
bmodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (untracked content)" output
+	test_grep "modified:   sub (untracked content)" output
 '
=20
 test_expect_success 'status -uno with untracked file in submodule' '
 	git status -uno >output &&
-	test_i18ngrep "^nothing to commit" output
+	test_grep "^nothing to commit" output
 '
=20
 test_expect_success 'status with untracked file in submodule (porcelain)=
' '
@@ -122,7 +122,7 @@ test_expect_success 'status with added and untracked =
file in submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (modified content, untracked content)" o=
utput
+	test_grep "modified:   sub (modified content, untracked content)" outpu=
t
 '
=20
 test_expect_success 'status with added and untracked file in submodule (=
porcelain)' '
@@ -140,7 +140,7 @@ test_expect_success 'status with modified file in mod=
ified submodule' '
 	(cd sub && echo "next change" >foo && git commit -m "next change" foo) =
&&
 	echo "changed" >sub/foo &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" output
+	test_grep "modified:   sub (new commits, modified content)" output
 '
=20
 test_expect_success 'status with modified file in modified submodule (po=
rcelain)' '
@@ -155,7 +155,7 @@ test_expect_success 'status with modified file in mod=
ified submodule (porcelain)
 test_expect_success 'status with added file in modified submodule' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" output
+	test_grep "modified:   sub (new commits, modified content)" output
 '
=20
 test_expect_success 'status with added file in modified submodule (porce=
lain)' '
@@ -170,7 +170,7 @@ test_expect_success 'status with untracked file in mo=
dified submodule' '
 	(cd sub && git reset --hard) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, untracked content)" output
+	test_grep "modified:   sub (new commits, untracked content)" output
 '
=20
 test_expect_success 'status with untracked file in modified submodule (p=
orcelain)' '
@@ -184,7 +184,7 @@ test_expect_success 'status with added and untracked =
file in modified submodule'
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	echo "content" >sub/new-file &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content, untracke=
d content)" output
+	test_grep "modified:   sub (new commits, modified content, untracked co=
ntent)" output
 '
=20
 test_expect_success 'status with added and untracked file in modified su=
bmodule (porcelain)' '
@@ -209,7 +209,7 @@ test_expect_success 'setup .git file for sub' '
 test_expect_success 'status with added file in modified submodule with .=
git file' '
 	(cd sub && git reset --hard && echo >foo && git add foo) &&
 	git status >output &&
-	test_i18ngrep "modified:   sub (new commits, modified content)" output
+	test_grep "modified:   sub (new commits, modified content)" output
 '
=20
 test_expect_success 'status with a lot of untracked files in the submodu=
le' '
@@ -234,12 +234,12 @@ test_expect_success 'rm submodule contents' '
=20
 test_expect_success 'status clean (empty submodule dir)' '
 	git status >output &&
-	test_i18ngrep "nothing to commit" output
+	test_grep "nothing to commit" output
 '
=20
 test_expect_success 'status -a clean (empty submodule dir)' '
 	test_must_fail git commit --dry-run -a >output &&
-	test_i18ngrep "nothing to commit" output
+	test_grep "nothing to commit" output
 '
=20
 cat >status_expect <<\EOF
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 916470c48b..c3281b192e 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -89,7 +89,7 @@ test_expect_success 'submodule log is stripped out too =
with -v' '
 		export GIT_EDITOR &&
 		test_must_fail git commit -a -v 2>err
 	) &&
-	test_i18ngrep "Aborting commit due to empty commit message." err
+	test_grep "Aborting commit due to empty commit message." err
 '
=20
 test_expect_success 'verbose diff is stripped out with set core.commentC=
har' '
@@ -98,7 +98,7 @@ test_expect_success 'verbose diff is stripped out with =
set core.commentChar' '
 		export GIT_EDITOR &&
 		test_must_fail git -c core.commentchar=3D";" commit -a -v 2>err
 	) &&
-	test_i18ngrep "Aborting commit due to empty commit message." err
+	test_grep "Aborting commit due to empty commit message." err
 '
=20
 test_expect_success 'status does not verbose without --verbose' '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 6928fd89f5..1607df4c2a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -19,7 +19,7 @@ test_expect_success 'status -h in broken repository' '
 		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git status -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage" broken/usage
+	test_grep "[Uu]sage" broken/usage
 '
=20
 test_expect_success 'commit -h in broken repository' '
@@ -31,7 +31,7 @@ test_expect_success 'commit -h in broken repository' '
 		echo "[status] showuntrackedfiles =3D CORRUPT" >>.git/config &&
 		test_expect_code 129 git commit -h >usage 2>&1
 	) &&
-	test_i18ngrep "[Uu]sage" broken/usage
+	test_grep "[Uu]sage" broken/usage
 '
=20
 test_expect_success 'create upstream branch' '
@@ -72,7 +72,7 @@ test_expect_success 'setup' '
 '
=20
 test_expect_success 'status (1)' '
-	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" output
+	test_grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
 '
=20
 strip_comments () {
@@ -1542,12 +1542,12 @@ test_expect_success 'git commit will commit a sta=
ged but ignored submodule' '
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git config --add submodule.subname.ignore all &&
 	git status -s --ignore-submodules=3Ddirty >output &&
-	test_i18ngrep "^M. sm" output &&
+	test_grep "^M. sm" output &&
 	GIT_EDITOR=3D"echo hello >>\"\$1\"" &&
 	export GIT_EDITOR &&
 	git commit -uno &&
 	git status -s --ignore-submodules=3Ddirty >output &&
-	test_i18ngrep ! "^M. sm" output
+	test_grep ! "^M. sm" output
 '
=20
 test_expect_success 'git commit --dry-run will show a staged but ignored=
 submodule' '
@@ -1572,13 +1572,13 @@ EOF
 	git commit -uno --dry-run >output &&
 	test_cmp expect output &&
 	git status -s --ignore-submodules=3Ddirty >output &&
-	test_i18ngrep "^M. sm" output
+	test_grep "^M. sm" output
 '
=20
 test_expect_success 'git commit -m will commit a staged but ignored subm=
odule' '
 	git commit -uno -m message &&
 	git status -s --ignore-submodules=3Ddirty >output &&
-	test_i18ngrep ! "^M. sm" output &&
+	test_grep ! "^M. sm" output &&
 	git config --remove-section submodule.subname &&
 	git config -f .gitmodules  --remove-section submodule.subname
 '
@@ -1591,7 +1591,7 @@ test_expect_success 'show stash info with "--show-s=
tash"' '
 	git stash &&
 	git status >expected_default &&
 	git status --show-stash >expected_with_stash &&
-	test_i18ngrep "^Your stash currently has 1 entry$" expected_with_stash
+	test_grep "^Your stash currently has 1 entry$" expected_with_stash
 '
=20
 test_expect_success 'no stash info with "--show-stash --no-show-stash"' =
'
@@ -1618,14 +1618,14 @@ test_expect_success 'no additional info if no sta=
sh entries' '
 test_expect_success '"No commits yet" should be noted in status output' =
'
 	git checkout --orphan empty-branch-1 &&
 	git status >output &&
-	test_i18ngrep "No commits yet" output
+	test_grep "No commits yet" output
 '
=20
 test_expect_success '"No commits yet" should not be noted in status outp=
ut' '
 	git checkout --orphan empty-branch-2 &&
 	test_commit test-commit-1 &&
 	git status >output &&
-	test_i18ngrep ! "No commits yet" output
+	test_grep ! "No commits yet" output
 '
=20
 test_expect_success '"Initial commit" should be noted in commit template=
' '
@@ -1633,7 +1633,7 @@ test_expect_success '"Initial commit" should be not=
ed in commit template' '
 	touch to_be_committed_1 &&
 	git add to_be_committed_1 &&
 	git commit --dry-run >output &&
-	test_i18ngrep "Initial commit" output
+	test_grep "Initial commit" output
 '
=20
 test_expect_success '"Initial commit" should not be noted in commit temp=
late' '
@@ -1642,7 +1642,7 @@ test_expect_success '"Initial commit" should not be=
 noted in commit template' '
 	touch to_be_committed_2 &&
 	git add to_be_committed_2 &&
 	git commit --dry-run >output &&
-	test_i18ngrep ! "Initial commit" output
+	test_grep ! "Initial commit" output
 '
=20
 test_expect_success '--no-optional-locks prevents index update' '
diff --git a/t/t7509-commit-authorship.sh b/t/t7509-commit-authorship.sh
index 5d890949f7..fd8c8f8f0b 100755
--- a/t/t7509-commit-authorship.sh
+++ b/t/t7509-commit-authorship.sh
@@ -99,7 +99,7 @@ test_expect_success '--amend option with empty author' =
'
 	echo "Empty author test" >>foo &&
 	test_tick &&
 	test_must_fail git commit -a -m "empty author" --amend 2>err &&
-	test_i18ngrep "empty ident" err
+	test_grep "empty ident" err
 '
=20
 test_expect_success '--amend option with missing author' '
@@ -112,7 +112,7 @@ test_expect_success '--amend option with missing auth=
or' '
 	echo "Missing author test" >>foo &&
 	test_tick &&
 	test_must_fail git commit -a -m "malformed author" --amend 2>err &&
-	test_i18ngrep "empty ident" err
+	test_grep "empty ident" err
 '
=20
 test_expect_success '--reset-author makes the commit ours even with --am=
end option' '
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.s=
h
index 9ab2ae2f3b..b37de0af49 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -15,7 +15,7 @@ test_expect_success 'empty name and missing email' '
 		sane_unset GIT_AUTHOR_EMAIL &&
 		GIT_AUTHOR_NAME=3D &&
 		test_must_fail git commit --allow-empty -m foo 2>err &&
-		test_i18ngrep ! "(null)" err
+		test_grep ! "(null)" err
 	)
 '
=20
@@ -40,8 +40,8 @@ test_expect_success 'empty configured name does not aut=
o-detect' '
 		sane_unset GIT_AUTHOR_NAME &&
 		test_must_fail \
 			git -c user.name=3D commit --allow-empty -m foo 2>err &&
-		test_i18ngrep "empty ident name" err &&
-		test_i18ngrep "Author identity unknown" err
+		test_grep "empty ident name" err &&
+		test_grep "Author identity unknown" err
 	)
 '
=20
@@ -50,8 +50,8 @@ test_expect_success 'empty configured name does not aut=
o-detect for committer' '
 		sane_unset GIT_COMMITTER_NAME &&
 		test_must_fail \
 			git -c user.name=3D commit --allow-empty -m foo 2>err &&
-		test_i18ngrep "empty ident name" err &&
-		test_i18ngrep "Committer identity unknown" err
+		test_grep "empty ident name" err &&
+		test_grep "Committer identity unknown" err
 	)
 '
=20
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 8348e3ae7d..7ee69ecdd4 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -322,14 +322,14 @@ do
 			rm -f marker &&
 			git status >actual &&
 			test_path_is_file marker &&
-			test_i18ngrep ! "Changes not staged for commit:" actual &&
+			test_grep ! "Changes not staged for commit:" actual &&
 			if test $uc_val =3D true
 			then
-				test_i18ngrep ! "Untracked files:" actual
+				test_grep ! "Untracked files:" actual
 			fi &&
 			if test $uc_val =3D false
 			then
-				test_i18ngrep "Untracked files:" actual
+				test_grep "Untracked files:" actual
 			fi &&
 			rm -f marker
 		'
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warni=
ng.sh
index 184b258989..3b63c34a30 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -13,27 +13,27 @@ test_expect_success setup '
=20
 test_expect_success 'no warning if hook is not ignored' '
 	git commit --allow-empty -m "more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_grep ! -e "hook was ignored" message
 '
=20
 test_expect_success POSIXPERM 'warning if hook is ignored' '
 	test_hook --disable pre-commit &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep -e "hook was ignored" message
+	test_grep -e "hook was ignored" message
 '
=20
 test_expect_success POSIXPERM 'no warning if advice.ignoredHook set to f=
alse' '
 	test_config advice.ignoredHook false &&
 	test_hook --disable pre-commit &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_grep ! -e "hook was ignored" message
 '
=20
 test_expect_success 'no warning if unset advice.ignoredHook and hook rem=
oved' '
 	test_hook --remove pre-commit &&
 	test_unconfig advice.ignoredHook &&
 	git commit --allow-empty -m "even more" 2>message &&
-	test_i18ngrep ! -e "hook was ignored" message
+	test_grep ! -e "hook was ignored" message
 '
=20
 test_done
diff --git a/t/t7525-status-rename.sh b/t/t7525-status-rename.sh
index 22bf5c7e5d..a9210d3a3a 100755
--- a/t/t7525-status-rename.sh
+++ b/t/t7525-status-rename.sh
@@ -21,81 +21,81 @@ test_expect_success 'setup' '
=20
 test_expect_success 'status no-options' '
 	git status >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'status --no-renames' '
 	git status --no-renames >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status.renames inherits from diff.renames false' '
 	git -c diff.renames=3Dfalse status >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status.renames inherits from diff.renames true' '
 	git -c diff.renames=3Dtrue status >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'status.renames overrides diff.renames false' '
 	git -c diff.renames=3Dtrue -c status.renames=3Dfalse status >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status.renames overrides from diff.renames true' '
 	git -c diff.renames=3Dfalse -c status.renames=3Dtrue status >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'status status.renames=3Dfalse' '
 	git -c status.renames=3Dfalse status >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status status.renames=3Dtrue' '
 	git -c status.renames=3Dtrue status >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'commit honors status.renames=3Dfalse' '
 	git -c status.renames=3Dfalse commit --dry-run >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'commit honors status.renames=3Dtrue' '
 	git -c status.renames=3Dtrue commit --dry-run >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'status config overridden' '
 	git -c status.renames=3Dtrue status --no-renames >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status score=3D100%' '
 	git status -M=3D100% >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual &&
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual &&
=20
 	git status --find-renames=3D100% >actual &&
-	test_i18ngrep "deleted:" actual &&
-	test_i18ngrep "new file:" actual
+	test_grep "deleted:" actual &&
+	test_grep "new file:" actual
 '
=20
 test_expect_success 'status score=3D01%' '
 	git status -M=3D01% >actual &&
-	test_i18ngrep "renamed:" actual &&
+	test_grep "renamed:" actual &&
=20
 	git status --find-renames=3D01% >actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "renamed:" actual
 '
=20
 test_expect_success 'copies not overridden by find-renames' '
@@ -103,12 +103,12 @@ test_expect_success 'copies not overridden by find-=
renames' '
 	git add copy &&
=20
 	git -c status.renames=3Dcopies status -M=3D01% >actual &&
-	test_i18ngrep "copied:" actual &&
-	test_i18ngrep "renamed:" actual &&
+	test_grep "copied:" actual &&
+	test_grep "renamed:" actual &&
=20
 	git -c status.renames=3Dcopies status --find-renames=3D01% >actual &&
-	test_i18ngrep "copied:" actual &&
-	test_i18ngrep "renamed:" actual
+	test_grep "copied:" actual &&
+	test_grep "renamed:" actual
 '
=20
 test_done
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-fi=
le.sh
index ad011bb9f1..c97c550021 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -141,25 +141,25 @@ test_expect_success 'error conditions' '
 	>empty_list &&
=20
 	test_must_fail git commit --pathspec-from-file=3Dlist --interactive -m =
"Commit" 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--p=
atch. cannot be used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--interactive/--patch=
. cannot be used together" err &&
=20
 	test_must_fail git commit --pathspec-from-file=3Dlist --patch -m "Commi=
t" 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--p=
atch. cannot be used together" err &&
+	test_grep -e "options .--pathspec-from-file. and .--interactive/--patch=
. cannot be used together" err &&
=20
 	test_must_fail git commit --pathspec-from-file=3Dlist --all -m "Commit"=
 2>err &&
-	test_i18ngrep -e "options .--pathspec-from-file. and .-a. cannot be use=
d together" err &&
+	test_grep -e "options .--pathspec-from-file. and .-a. cannot be used to=
gether" err &&
=20
 	test_must_fail git commit --pathspec-from-file=3Dlist -m "Commit" -- fi=
leA.t 2>err &&
-	test_i18ngrep -e ".--pathspec-from-file. and pathspec arguments cannot =
be used together" err &&
+	test_grep -e ".--pathspec-from-file. and pathspec arguments cannot be u=
sed together" err &&
=20
 	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
-	test_i18ngrep -e "the option .--pathspec-file-nul. requires .--pathspec=
-from-file." err &&
+	test_grep -e "the option .--pathspec-file-nul. requires .--pathspec-fro=
m-file." err &&
=20
 	test_must_fail git commit --pathspec-from-file=3Dempty_list --include -=
m "Commit" 2>err &&
-	test_i18ngrep -e "No paths with --include/--only does not make sense." =
err &&
+	test_grep -e "No paths with --include/--only does not make sense." err =
&&
=20
 	test_must_fail git commit --pathspec-from-file=3Dempty_list --only -m "=
Commit" 2>err &&
-	test_i18ngrep -e "No paths with --include/--only does not make sense." =
err
+	test_grep -e "No paths with --include/--only does not make sense." err
 '
=20
 test_done
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index fdc607277c..e5ff073099 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -175,7 +175,7 @@ test_expect_success 'merge -h with invalid index' '
 		>.git/index &&
 		test_expect_code 129 git merge -h 2>usage
 	) &&
-	test_i18ngrep "[Uu]sage: git merge" broken/usage
+	test_grep "[Uu]sage: git merge" broken/usage
 '
=20
 test_expect_success 'reject non-strategy with a git-merge-foo name' '
@@ -681,7 +681,7 @@ test_debug 'git log --graph --decorate --oneline --al=
l'
 test_expect_success 'in-index merge' '
 	git reset --hard c0 &&
 	git merge --no-ff -s resolve c1 >out &&
-	test_i18ngrep "Wonderful." out &&
+	test_grep "Wonderful." out &&
 	verify_parents $c0 $c1
 '
=20
@@ -697,7 +697,7 @@ test_expect_success 'merge with --autostash' '
 	git reset --hard c1 &&
 	git merge-file file file.orig file.9 &&
 	git merge --autostash c2 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&
 	test_cmp result.1-5-9 file
@@ -708,7 +708,7 @@ test_expect_success 'merge with merge.autoStash' '
 	git reset --hard c1 &&
 	git merge-file file file.orig file.9 &&
 	git merge c2 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&
 	test_cmp result.1-5-9 file
@@ -718,7 +718,7 @@ test_expect_success 'fast-forward merge with --autost=
ash' '
 	git reset --hard c0 &&
 	git merge-file file file.orig file.5 &&
 	git merge --autostash c1 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	test_cmp result.1-5 file
 '
=20
@@ -728,7 +728,7 @@ test_expect_success 'failed fast-forward merge with -=
-autostash' '
 	cp file.5 other &&
 	test_when_finished "rm other" &&
 	test_must_fail git merge --autostash c1 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	test_cmp file.5 file
 '
=20
@@ -736,7 +736,7 @@ test_expect_success 'octopus merge with --autostash' =
'
 	git reset --hard c1 &&
 	git merge-file file file.orig file.3 &&
 	git merge --autostash c2 c3 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5-9 merge-result &&
 	test_cmp result.1-3-5-9 file
@@ -746,7 +746,7 @@ test_expect_success 'failed merge (exit 2) with --aut=
ostash' '
 	git reset --hard c1 &&
 	git merge-file file file.orig file.5 &&
 	test_must_fail git merge -s recursive --autostash c2 c3 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	test_cmp result.1-5 file
 '
=20
@@ -755,7 +755,7 @@ test_expect_success 'conflicted merge with --autostas=
h, --abort restores stash'
 	cp file.1 file &&
 	test_must_fail git merge --autostash c7 &&
 	git merge --abort 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	test_cmp file.1 file
 '
=20
@@ -767,7 +767,7 @@ test_expect_success 'completed merge (git commit) wit=
h --no-commit and --autosta
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git commit 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&
 	test_cmp result.1-5-9 file
@@ -781,7 +781,7 @@ test_expect_success 'completed merge (git merge --con=
tinue) with --no-commit and
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git merge --continue 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-5 merge-result &&
 	test_cmp result.1-5-9 file
@@ -795,7 +795,7 @@ test_expect_success 'aborted merge (merge --abort) wi=
th --no-commit and --autost
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git merge --abort 2>err &&
-	test_i18ngrep "Applied autostash." err &&
+	test_grep "Applied autostash." err &&
 	git diff >actual &&
 	test_cmp expect actual
 '
@@ -808,7 +808,7 @@ test_expect_success 'aborted merge (reset --hard) wit=
h --no-commit and --autosta
 	git stash show -p MERGE_AUTOSTASH >actual &&
 	test_cmp expect actual &&
 	git reset --hard 2>err &&
-	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
+	test_grep "Autostash exists; creating a new stash entry." err &&
 	git diff --exit-code
 '
=20
@@ -821,7 +821,7 @@ test_expect_success 'quit merge with --no-commit and =
--autostash' '
 	test_cmp expect actual &&
 	git diff HEAD >expect &&
 	git merge --quit 2>err &&
-	test_i18ngrep "Autostash exists; creating a new stash entry." err &&
+	test_grep "Autostash exists; creating a new stash entry." err &&
 	git diff HEAD >actual &&
 	test_cmp expect actual
 '
@@ -832,7 +832,7 @@ test_expect_success 'merge with conflicted --autostas=
h changes' '
 	git diff >expect &&
 	test_when_finished "test_might_fail git stash drop" &&
 	git merge --autostash c3 2>err &&
-	test_i18ngrep "Applying autostash resulted in conflicts." err &&
+	test_grep "Applying autostash resulted in conflicts." err &&
 	git show HEAD:file >merge-result &&
 	test_cmp result.1-9 merge-result &&
 	git stash show -p >actual &&
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index bd238d89b0..8cebe2dbe1 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -30,117 +30,117 @@ test_expect_success 'setup' '
 test_expect_success 'pull.rebase not set, ff possible' '
 	git reset --hard c0 &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Dtrue' '
 	git reset --hard c0 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Dfalse' '
 	git reset --hard c0 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Donly' '
 	git reset --hard c0 &&
 	test_config pull.ff only &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --rebase given' '
 	git reset --hard c0 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --no-rebase given' '
 	git reset --hard c0 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c0 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --no-ff given' '
 	git reset --hard c0 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --ff-only given' '
 	git reset --hard c0 &&
 	git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set (not-fast-forward)' '
 	git reset --hard c2 &&
 	test_must_fail git -c color.advice=3Dalways pull . c1 2>err &&
 	test_decode_color <err >decoded &&
-	test_i18ngrep "<YELLOW>hint: " decoded &&
-	test_i18ngrep "You have divergent branches" decoded
+	test_grep "<YELLOW>hint: " decoded &&
+	test_grep "You have divergent branches" decoded
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Dtrue (not-fast-fo=
rward)' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Dfalse (not-fast-f=
orward)' '
 	git reset --hard c2 &&
 	test_config pull.ff false &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and pull.ff=3Donly (not-fast-fo=
rward)' '
 	git reset --hard c2 &&
 	test_config pull.ff only &&
 	test_must_fail git pull . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --rebase given (not-fast-fo=
rward)' '
 	git reset --hard c2 &&
 	git pull --rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --no-rebase given (not-fast=
-forward)' '
 	git reset --hard c2 &&
 	git pull --no-rebase . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --ff given (not-fast-forwar=
d)' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --no-ff given (not-fast-for=
ward)' '
 	git reset --hard c2 &&
 	git pull --no-ff . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_expect_success 'pull.rebase not set and --ff-only given (not-fast-f=
orward)' '
 	git reset --hard c2 &&
 	test_must_fail git pull --ff-only . c1 2>err &&
-	test_i18ngrep ! "You have divergent branches" err
+	test_grep ! "You have divergent branches" err
 '
=20
 test_does_rebase () {
@@ -202,7 +202,7 @@ test_falls_back_to_full_merge () {
 test_attempts_fast_forward () {
 	git reset --hard c2 &&
 	test_must_fail git "$@" . c1 2>err &&
-	test_i18ngrep "Not possible to fast-forward, aborting" err
+	test_grep "Not possible to fast-forward, aborting" err
 }
=20
 #
@@ -328,23 +328,23 @@ test_expect_success 'pull.rebase=3Dfalse and --ff, =
ff not possible' '
 test_expect_success 'Multiple heads warns about inability to fast forwar=
d' '
 	git reset --hard c1 &&
 	test_must_fail git pull . c2 c3 2>err &&
-	test_i18ngrep "You have divergent branches" err
+	test_grep "You have divergent branches" err
 '
=20
 test_expect_success 'Multiple can never be fast forwarded' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.ff=3Donly pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "You have divergent branches" err &&
+	test_grep ! "You have divergent branches" err &&
 	# In addition to calling out "cannot fast-forward", we very much
 	# want the "multiple branches" piece to be called out to users.
-	test_i18ngrep "Cannot fast-forward to multiple branches" err
+	test_grep "Cannot fast-forward to multiple branches" err
 '
=20
 test_expect_success 'Cannot rebase with multiple heads' '
 	git reset --hard c0 &&
 	test_must_fail git -c pull.rebase=3Dtrue pull . c1 c2 c3 2>err &&
-	test_i18ngrep ! "You have divergent branches" err &&
-	test_i18ngrep "Cannot rebase onto multiple branches." err
+	test_grep ! "You have divergent branches" err &&
+	test_grep "Cannot rebase onto multiple branches." err
 '
=20
 test_expect_success 'merge c1 with c2' '
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index c0e9425115..d6975ca48d 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -50,7 +50,7 @@ pre_merge_head=3D"$(git rev-parse HEAD)"
=20
 test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
 	test_must_fail git merge --abort 2>output &&
-	test_i18ngrep MERGE_HEAD output
+	test_grep MERGE_HEAD output
 '
=20
 test_expect_success 'fails without MERGE_HEAD (unstarted merge): .git/ME=
RGE_HEAD sanity' '
@@ -64,7 +64,7 @@ test_expect_success 'fails without MERGE_HEAD (complete=
d merge)' '
 	# Merge successfully completed
 	post_merge_head=3D"$(git rev-parse HEAD)" &&
 	test_must_fail git merge --abort 2>output &&
-	test_i18ngrep MERGE_HEAD output
+	test_grep MERGE_HEAD output
 '
=20
 test_expect_success 'fails without MERGE_HEAD (completed merge): .git/ME=
RGE_HEAD sanity' '
diff --git a/t/t7612-merge-verify-signatures.sh b/t/t7612-merge-verify-si=
gnatures.sh
index f5c90cc22a..84ddb56851 100755
--- a/t/t7612-merge-verify-signatures.sh
+++ b/t/t7612-merge-verify-signatures.sh
@@ -41,54 +41,54 @@ test_expect_success GPG 'create signed commits' '
 test_expect_success GPG 'merge unsigned commit with verification' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures side-unsigned 2>=
mergeerror &&
-	test_i18ngrep "does not have a GPG signature" mergeerror
+	test_grep "does not have a GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge unsigned commit with merge.verifySignatur=
es=3Dtrue' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only side-unsigned 2>mergeerror &&
-	test_i18ngrep "does not have a GPG signature" mergeerror
+	test_grep "does not have a GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with bad signature with verificati=
on' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures $(cat forged.com=
mit) 2>mergeerror &&
-	test_i18ngrep "has a bad GPG signature" mergeerror
+	test_grep "has a bad GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with bad signature with merge.veri=
fySignatures=3Dtrue' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only $(cat forged.commit) 2>mergeerror &&
-	test_i18ngrep "has a bad GPG signature" mergeerror
+	test_grep "has a bad GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with veri=
fication' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2=
>mergeerror &&
-	test_i18ngrep "has an untrusted GPG signature" mergeerror
+	test_grep "has an untrusted GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with veri=
fication and high minTrustLevel' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config gpg.minTrustLevel marginal &&
 	test_must_fail git merge --ff-only --verify-signatures side-untrusted 2=
>mergeerror &&
-	test_i18ngrep "has an untrusted GPG signature" mergeerror
+	test_grep "has an untrusted GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with veri=
fication and low minTrustLevel' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config gpg.minTrustLevel undefined &&
 	git merge --ff-only --verify-signatures side-untrusted >mergeoutput &&
-	test_i18ngrep "has a good GPG signature" mergeoutput
+	test_grep "has a good GPG signature" mergeoutput
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with merg=
e.verifySignatures=3Dtrue' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
-	test_i18ngrep "has an untrusted GPG signature" mergeerror
+	test_grep "has an untrusted GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge commit with untrusted signature with merg=
e.verifySignatures=3Dtrue and minTrustLevel' '
@@ -96,20 +96,20 @@ test_expect_success GPG 'merge commit with untrusted =
signature with merge.verify
 	test_config merge.verifySignatures true &&
 	test_config gpg.minTrustLevel marginal &&
 	test_must_fail git merge --ff-only side-untrusted 2>mergeerror &&
-	test_i18ngrep "has an untrusted GPG signature" mergeerror
+	test_grep "has an untrusted GPG signature" mergeerror
 '
=20
 test_expect_success GPG 'merge signed commit with verification' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	git merge --verbose --ff-only --verify-signatures side-signed >mergeout=
put &&
-	test_i18ngrep "has a good GPG signature" mergeoutput
+	test_grep "has a good GPG signature" mergeoutput
 '
=20
 test_expect_success GPG 'merge signed commit with merge.verifySignatures=
=3Dtrue' '
 	test_when_finished "git reset --hard && git checkout initial" &&
 	test_config merge.verifySignatures true &&
 	git merge --verbose --ff-only side-signed >mergeoutput &&
-	test_i18ngrep "has a good GPG signature" mergeoutput
+	test_grep "has a good GPG signature" mergeoutput
 '
=20
 test_expect_success GPG 'merge commit with bad signature without verific=
ation' '
@@ -133,7 +133,7 @@ test_expect_success GPG 'merge unsigned commit into u=
nborn branch' '
 	test_when_finished "git checkout initial" &&
 	git checkout --orphan unborn &&
 	test_must_fail git merge --verify-signatures side-unsigned 2>mergeerror=
 &&
-	test_i18ngrep "does not have a GPG signature" mergeerror
+	test_grep "does not have a GPG signature" mergeerror
 '
=20
 test_done
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 00f28fb558..9fc1626fbf 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -23,7 +23,7 @@ test_expect_success '--geometric with no packs' '
 		cd geometric &&
=20
 		git repack --write-midx --geometric 2 >out &&
-		test_i18ngrep "Nothing new to pack" out
+		test_grep "Nothing new to pack" out
 	)
 '
=20
@@ -38,7 +38,7 @@ test_expect_success '--geometric with one pack' '
=20
 		git repack --geometric 2 >out &&
=20
-		test_i18ngrep "Nothing new to pack" out
+		test_grep "Nothing new to pack" out
 	)
 '
=20
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 59d3847bf8..6a36be1e63 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -28,14 +28,14 @@ prompt_given ()
=20
 test_expect_success 'basic usage requires no repo' '
 	test_expect_code 129 git difftool -h >output &&
-	test_i18ngrep ^usage: output &&
+	test_grep ^usage: output &&
 	# create a ceiling directory to prevent Git from finding a repo
 	mkdir -p not/repo &&
 	test_when_finished rm -r not &&
 	test_expect_code 129 \
 	env GIT_CEILING_DIRECTORIES=3D"$(pwd)/not" \
 	git -C not/repo difftool -h >output &&
-	test_i18ngrep ^usage: output
+	test_grep ^usage: output
 '
=20
 # Create a file on main and change it on branch
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 39d6d713ec..bdacb57dcb 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1386,7 +1386,7 @@ test_expect_success 'grep --no-index pattern -- pat=
h' '
=20
 test_expect_success 'grep --no-index complains of revs' '
 	test_must_fail git grep --no-index o main -- 2>err &&
-	test_i18ngrep "cannot be used with revs" err
+	test_grep "cannot be used with revs" err
 '
=20
 test_expect_success 'grep --no-index prefers paths to revs' '
@@ -1399,7 +1399,7 @@ test_expect_success 'grep --no-index prefers paths =
to revs' '
=20
 test_expect_success 'grep --no-index does not "diagnose" revs' '
 	test_must_fail git grep --no-index o :1:hello.c 2>err &&
-	test_i18ngrep ! -i "did you mean" err
+	test_grep ! -i "did you mean" err
 '
=20
 cat >expected <<EOF
diff --git a/t/t7811-grep-open.sh b/t/t7811-grep-open.sh
index 1dd07141a7..fe38d88a1a 100755
--- a/t/t7811-grep-open.sh
+++ b/t/t7811-grep-open.sh
@@ -63,7 +63,7 @@ test_expect_success SIMPLEPAGER 'git grep -O' '
=20
 test_expect_success 'git grep -O --cached' '
 	test_must_fail git grep --cached -O GREP_PATTERN >out 2>msg &&
-	test_i18ngrep open-files-in-pager msg
+	test_grep open-files-in-pager msg
 '
=20
 test_expect_success 'git grep -O --no-index' '
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-su=
bmodules.sh
index d37c83b464..167fe66150 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -348,7 +348,7 @@ test_incompatible_with_recurse_submodules ()
 {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git grep -e. --recurse-submodules $1 2>actual &&
-		test_i18ngrep 'not supported with --recurse-submodules' actual
+		test_grep 'not supported with --recurse-submodules' actual
 	"
 }
=20
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern=
.sh
index fdb2355649..4353be5adb 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -26,7 +26,7 @@ nul_match_internal () {
 			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail env LC_ALL=3D\"$lc_all\" git grep $extra_flags -f f $f=
lags a 2>stderr &&
-			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr
+			test_grep ! 'This is only supported with -P under PCRE v2' stderr
 		"
 	elif test "$matches" =3D P
 	then
@@ -34,7 +34,7 @@ nul_match_internal () {
 			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
 			test_must_fail env LC_ALL=3D\"$lc_all\" git grep -f f $flags a 2>stde=
rr &&
-			test_i18ngrep 'This is only supported with -P under PCRE v2' stderr
+			test_grep 'This is only supported with -P under PCRE v2' stderr
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches valu=
e $matches" 'false'
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 487e326b3f..760079b411 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -33,13 +33,13 @@ test_systemd_analyze_verify () {
=20
 test_expect_success 'help text' '
 	test_expect_code 129 git maintenance -h >actual &&
-	test_i18ngrep "usage: git maintenance <subcommand>" actual &&
+	test_grep "usage: git maintenance <subcommand>" actual &&
 	test_expect_code 129 git maintenance barf 2>err &&
-	test_i18ngrep "unknown subcommand: \`barf'\''" err &&
-	test_i18ngrep "usage: git maintenance" err &&
+	test_grep "unknown subcommand: \`barf'\''" err &&
+	test_grep "usage: git maintenance" err &&
 	test_expect_code 129 git maintenance 2>err &&
-	test_i18ngrep "error: need a subcommand" err &&
-	test_i18ngrep "usage: git maintenance" err
+	test_grep "error: need a subcommand" err &&
+	test_grep "usage: git maintenance" err
 '
=20
 test_expect_success 'run [--auto|--quiet]' '
@@ -131,12 +131,12 @@ test_expect_success 'commit-graph auto condition' '
=20
 test_expect_success 'run --task=3Dbogus' '
 	test_must_fail git maintenance run --task=3Dbogus 2>err &&
-	test_i18ngrep "is not a valid task" err
+	test_grep "is not a valid task" err
 '
=20
 test_expect_success 'run --task duplicate' '
 	test_must_fail git maintenance run --task=3Dgc --task=3Dgc 2>err &&
-	test_i18ngrep "cannot be selected multiple times" err
+	test_grep "cannot be selected multiple times" err
 '
=20
 test_expect_success 'run --task=3Dprefetch with no remotes' '
@@ -377,12 +377,12 @@ test_expect_success 'pack-refs task' '
=20
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=3Ddaily 2>err &&
-	test_i18ngrep "at most one" err
+	test_grep "at most one" err
 '
=20
 test_expect_success 'invalid --schedule value' '
 	test_must_fail git maintenance run --schedule=3Dannually 2>err &&
-	test_i18ngrep "unrecognized --schedule" err
+	test_grep "unrecognized --schedule" err
 '
=20
 test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
@@ -576,15 +576,15 @@ test_expect_success !MINGW 'register and unregister=
 with regex metacharacters' '
=20
 test_expect_success 'start --scheduler=3D<scheduler>' '
 	test_expect_code 129 git maintenance start --scheduler=3Dfoo 2>err &&
-	test_i18ngrep "unrecognized --scheduler argument" err &&
+	test_grep "unrecognized --scheduler argument" err &&
=20
 	test_expect_code 129 git maintenance start --no-scheduler 2>err &&
-	test_i18ngrep "unknown option" err &&
+	test_grep "unknown option" err &&
=20
 	test_expect_code 128 \
 		env GIT_TEST_MAINT_SCHEDULER=3D"launchctl:true,schtasks:true" \
 		git maintenance start --scheduler=3Dcrontab 2>err &&
-	test_i18ngrep "fatal: crontab scheduler is not available" err
+	test_grep "fatal: crontab scheduler is not available" err
 '
=20
 test_expect_success 'start from empty cron table' '
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.s=
h
index 8bcd39e81b..731265541a 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -207,7 +207,7 @@ EOF
=20
 test_expect_success 'blame -L with invalid start' '
 	test_must_fail git blame -L5 tres 2>errors &&
-	test_i18ngrep "has only 2 lines" errors
+	test_grep "has only 2 lines" errors
 '
=20
 test_expect_success 'blame -L with invalid end' '
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index b18633dee1..9a03b0f361 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -129,14 +129,14 @@ test_expect_success override_ignore_revs_file '
 	'
 test_expect_success bad_files_and_revs '
 	test_must_fail git blame file --ignore-rev NOREV 2>err &&
-	test_i18ngrep "cannot find revision NOREV to ignore" err &&
+	test_grep "cannot find revision NOREV to ignore" err &&
=20
 	test_must_fail git blame file --ignore-revs-file NOFILE 2>err &&
-	test_i18ngrep "could not open.*: NOFILE" err &&
+	test_grep "could not open.*: NOFILE" err &&
=20
 	echo NOREV >ignore_norev &&
 	test_must_fail git blame file --ignore-revs-file ignore_norev 2>err &&
-	test_i18ngrep "invalid object name: NOREV" err
+	test_grep "invalid object name: NOREV" err
 '
=20
 # For ignored revs that have added 'unblamable' lines, mark those lines =
with a
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index a60b05ad3f..5307947db8 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -371,7 +371,7 @@ test_expect_success $PREREQ,!AUTOIDENT 'broken implic=
it ident aborts send-email'
 		--smtp-server=3D"$(pwd)/fake.sendmail" \
 		--to=3Dto@example.com \
 		$patches </dev/null 2>errors &&
-	test_i18ngrep "tell me who you are" errors
+	test_grep "tell me who you are" errors
 	)
 '
=20
@@ -2062,7 +2062,7 @@ test_expect_success $PREREQ 'aliases and sendemail.=
identity' '
 		-c sendemail.aliasesfile=3Ddefault-aliases \
 		-c sendemail.cloud.aliasesfile=3Dcloud-aliases \
 		send-email -1 2>stderr &&
-	test_i18ngrep "cloud-aliases" stderr
+	test_grep "cloud-aliases" stderr
 '
=20
 test_sendmail_aliases () {
@@ -2427,7 +2427,7 @@ test_expect_success $PREREQ 'invoke hook' '
 			--to=3Dnobody@example.com \
 			--smtp-server=3D"$(pwd)/../fake.sendmail" \
 			../another.patch 2>err &&
-		test_i18ngrep "rejected by sendemail-validate hook" err
+		test_grep "rejected by sendemail-validate hook" err
 	)
 '
=20
@@ -2483,7 +2483,7 @@ test_expect_success $PREREQ 'test that sendmail con=
fig is rejected' '
 		--to=3Dnobody@example.com \
 		--smtp-server=3D"$(pwd)/fake.sendmail" \
 		HEAD^ 2>err &&
-	test_i18ngrep "found configuration options for '"'"sendmail"'"'" err
+	test_grep "found configuration options for '"'"sendmail"'"'" err
 '
=20
 test_expect_success $PREREQ 'test that sendmail config rejection is spec=
ific' '
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ac237a1f90..dbb5042b0b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2879,7 +2879,7 @@ test_expect_success 'S: filemodify with garbage aft=
er mark must fail' '
 	COMMIT
 	M 100644 :403x hello.c
 	EOF
-	test_i18ngrep "space after mark" err
+	test_grep "space after mark" err
 '
=20
 # inline is misspelled; fast-import thinks it is some unknown dataref
@@ -2895,7 +2895,7 @@ test_expect_success 'S: filemodify with garbage aft=
er inline must fail' '
 	inline
 	BLOB
 	EOF
-	test_i18ngrep "nvalid dataref" err
+	test_grep "nvalid dataref" err
 '
=20
 test_expect_success 'S: filemodify with garbage after sha1 must fail' '
@@ -2908,7 +2908,7 @@ test_expect_success 'S: filemodify with garbage aft=
er sha1 must fail' '
 	COMMIT
 	M 100644 ${sha1}x hello.c
 	EOF
-	test_i18ngrep "space after SHA1" err
+	test_grep "space after SHA1" err
 '
=20
 #
@@ -2923,7 +2923,7 @@ test_expect_success 'S: notemodify with garbage aft=
er mark dataref must fail' '
 	COMMIT
 	N :202x :302
 	EOF
-	test_i18ngrep "space after mark" err
+	test_grep "space after mark" err
 '
=20
 test_expect_success 'S: notemodify with garbage after inline dataref mus=
t fail' '
@@ -2938,7 +2938,7 @@ test_expect_success 'S: notemodify with garbage aft=
er inline dataref must fail'
 	note blob
 	BLOB
 	EOF
-	test_i18ngrep "nvalid dataref" err
+	test_grep "nvalid dataref" err
 '
=20
 test_expect_success 'S: notemodify with garbage after sha1 dataref must =
fail' '
@@ -2951,7 +2951,7 @@ test_expect_success 'S: notemodify with garbage aft=
er sha1 dataref must fail' '
 	COMMIT
 	N ${sha1}x :302
 	EOF
-	test_i18ngrep "space after SHA1" err
+	test_grep "space after SHA1" err
 '
=20
 #
@@ -2966,7 +2966,7 @@ test_expect_success 'S: notemodify with garbage aft=
er mark commit-ish must fail'
 	COMMIT
 	N :202 :302x
 	EOF
-	test_i18ngrep "after mark" err
+	test_grep "after mark" err
 '
=20
 #
@@ -2999,7 +2999,7 @@ test_expect_success 'S: from with garbage after mar=
k must fail' '
 	EOF
=20
 	# now evaluate the error
-	test_i18ngrep "after mark" err
+	test_grep "after mark" err
 '
=20
=20
@@ -3018,7 +3018,7 @@ test_expect_success 'S: merge with garbage after ma=
rk must fail' '
 	merge :303x
 	M 100644 :403 hello.c
 	EOF
-	test_i18ngrep "after mark" err
+	test_grep "after mark" err
 '
=20
 #
@@ -3033,7 +3033,7 @@ test_expect_success 'S: tag with garbage after mark=
 must fail' '
 	tag S
 	TAG
 	EOF
-	test_i18ngrep "after mark" err
+	test_grep "after mark" err
 '
=20
 #
@@ -3043,7 +3043,7 @@ test_expect_success 'S: cat-blob with garbage after=
 mark must fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	cat-blob :403x
 	EOF
-	test_i18ngrep "after mark" err
+	test_grep "after mark" err
 '
=20
 #
@@ -3053,7 +3053,7 @@ test_expect_success 'S: ls with garbage after mark =
must fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	ls :302x hello.c
 	EOF
-	test_i18ngrep "space after mark" err
+	test_grep "space after mark" err
 '
=20
 test_expect_success 'S: ls with garbage after sha1 must fail' '
@@ -3061,7 +3061,7 @@ test_expect_success 'S: ls with garbage after sha1 =
must fail' '
 	test_must_fail git fast-import --import-marks=3Dmarks <<-EOF 2>err &&
 	ls ${sha1}x hello.c
 	EOF
-	test_i18ngrep "space after tree-ish" err
+	test_grep "space after tree-ish" err
 '
=20
 ###
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index a4b3cb9492..53af8e34ac 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -54,7 +54,7 @@ test_expect_success 'git p4 sync uninitialized repo' '
 	(
 		cd "$git" &&
 		test_must_fail git p4 sync 2>errs &&
-		test_i18ngrep "Perhaps you never did" errs
+		test_grep "Perhaps you never did" errs
 	)
 '
=20
@@ -86,7 +86,7 @@ test_expect_success 'git p4 sync existing branch withou=
t changes' '
 		test_commit head &&
 		git p4 sync --branch=3Ddepot //depot@all &&
 		git p4 sync --branch=3Drefs/remotes/p4/depot >out &&
-		test_i18ngrep "No changes to import!" out
+		test_grep "No changes to import!" out
 	)
 '
=20
@@ -101,7 +101,7 @@ test_expect_success 'git p4 sync existing branch with=
 relative name' '
 		test_commit head &&
 		git p4 sync --branch=3Dbranch1 //depot@all &&
 		git p4 sync --branch=3Dp4/branch1 >out &&
-		test_i18ngrep "No changes to import!" out
+		test_grep "No changes to import!" out
 	)
 '
=20
@@ -116,7 +116,7 @@ test_expect_success 'git p4 sync existing branch with=
 nested path' '
 		test_commit head &&
 		git p4 sync --branch=3Dp4/some/path //depot@all &&
 		git p4 sync --branch=3Dsome/path >out &&
-		test_i18ngrep "No changes to import!" out
+		test_grep "No changes to import!" out
 	)
 '
=20
@@ -131,7 +131,7 @@ test_expect_success 'git p4 sync branch explicit ref =
without p4 in path' '
 		test_commit head &&
 		git p4 sync --branch=3Drefs/remotes/someremote/depot //depot@all &&
 		git p4 sync --branch=3Drefs/remotes/someremote/depot >out &&
-		test_i18ngrep "No changes to import!" out
+		test_grep "No changes to import!" out
 	)
 '
=20
@@ -143,7 +143,7 @@ test_expect_success 'git p4 sync nonexistent ref' '
 		test_commit head &&
 		git p4 sync --branch=3Ddepot //depot@all &&
 		test_must_fail git p4 sync --branch=3Ddepot2 2>errs &&
-		test_i18ngrep "Perhaps you never did" errs
+		test_grep "Perhaps you never did" errs
 	)
 '
=20
@@ -155,7 +155,7 @@ test_expect_success 'git p4 sync existing non-p4-impo=
rted ref' '
 		test_commit head &&
 		git p4 sync --branch=3Ddepot //depot@all &&
 		test_must_fail git p4 sync --branch=3Drefs/heads/master 2>errs &&
-		test_i18ngrep "Perhaps you never did" errs
+		test_grep "Perhaps you never did" errs
 	)
 '
=20
@@ -290,7 +290,7 @@ test_expect_success 'exit when p4 fails to produce ma=
rshaled output' '
 		export PATH &&
 		test_expect_code 1 git p4 clone --dest=3D"$git" //depot >errs 2>&1
 	) &&
-	test_i18ngrep ! Traceback errs
+	test_grep ! Traceback errs
 '
=20
 # Hide a file from p4d, make sure we catch its complaint.  This won't fa=
il in
@@ -301,7 +301,7 @@ test_expect_success 'exit gracefully for p4 server er=
rors' '
 	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
 	test_when_finished cleanup_git &&
 	test_expect_code 1 git p4 clone --dest=3D"$git" //depot@1 >out 2>err &&
-	test_i18ngrep "Error from p4 print" err
+	test_grep "Error from p4 print" err
 '
=20
 test_expect_success 'clone --bare should make a bare repository' '
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 759a14fa87..73cca0d143 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -135,7 +135,7 @@ test_expect_success 'sync specific detected branch' '
 	(
 		cd "$git" &&
 		git p4 sync --branch=3Ddepot/branch2 >out &&
-		test_i18ngrep "No changes to import!" out
+		test_grep "No changes to import!" out
 	)
 '
=20
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 7d4109f29d..af4b286f9d 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -75,7 +75,7 @@ test_expect_success 'submit --dry-run' '
 		test_commit "dry-run1" &&
 		test_commit "dry-run2" &&
 		git p4 submit --dry-run >out &&
-		test_i18ngrep "Would apply" out
+		test_grep "Would apply" out
 	) &&
 	(
 		cd "$cli" &&
@@ -99,7 +99,7 @@ test_expect_success 'submit --dry-run --export-labels' =
'
 		git commit -m "dry-run2" dry-run2 &&
 		git tag -m "dry-run-tag1" dry-run-tag1 HEAD^ &&
 		git p4 submit --dry-run --export-labels >out &&
-		test_i18ngrep "Would create p4 label" out
+		test_grep "Would create p4 label" out
 	) &&
 	(
 		cd "$cli" &&
@@ -443,7 +443,7 @@ test_expect_success 'description with Jobs section an=
d bogus following text' '
 		# build a job
 		make_job $(cat jobname) &&
 		test_must_fail git p4 submit 2>err &&
-		test_i18ngrep "Unknown field name" err
+		test_grep "Unknown field name" err
 	) &&
 	(
 		cd "$cli" &&
@@ -461,9 +461,9 @@ test_expect_success 'submit --prepare-p4-only' '
 		git add prep-only-add &&
 		git commit -m "prep only add" &&
 		git p4 submit --prepare-p4-only >out &&
-		test_i18ngrep "prepared for submission" out &&
-		test_i18ngrep "must be deleted" out &&
-		test_i18ngrep ! "everything below this line is just the diff" out
+		test_grep "prepared for submission" out &&
+		test_grep "must be deleted" out &&
+		test_grep ! "everything below this line is just the diff" out
 	) &&
 	(
 		cd "$cli" &&
diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.s=
h
index 0ca9937de6..c766fd159f 100755
--- a/t/t9815-git-p4-submit-fail.sh
+++ b/t/t9815-git-p4-submit-fail.sh
@@ -35,7 +35,7 @@ test_expect_success 'conflict on one commit' '
 		git add file1 &&
 		git commit -m "line3 in file1 will conflict" &&
 		test_expect_code 1 git p4 submit >out &&
-		test_i18ngrep "No commits applied" out
+		test_grep "No commits applied" out
 	)
 '
=20
@@ -58,7 +58,7 @@ test_expect_success 'conflict on second of two commits'=
 '
 		git add file1 &&
 		git commit -m "line4 in file1 will conflict" &&
 		test_expect_code 1 git p4 submit >out &&
-		test_i18ngrep "Applied only the commits" out
+		test_grep "Applied only the commits" out
 	)
 '
=20
@@ -81,7 +81,7 @@ test_expect_success 'conflict on first of two commits, =
skip' '
 		# but this commit is okay
 		test_commit "okay_commit_after_skip" &&
 		echo s | test_expect_code 1 git p4 submit >out &&
-		test_i18ngrep "Applied only the commits" out
+		test_grep "Applied only the commits" out
 	)
 '
=20
@@ -104,7 +104,7 @@ test_expect_success 'conflict on first of two commits=
, quit' '
 		# but this commit is okay
 		test_commit "okay_commit_after_quit" &&
 		echo q | test_expect_code 1 git p4 submit >out &&
-		test_i18ngrep "No commits applied" out
+		test_grep "No commits applied" out
 	)
 '
=20
@@ -144,7 +144,7 @@ test_expect_success 'conflict on first of two commits=
, --conflict=3Dskip' '
 		# but this commit is okay
 		test_commit "okay_commit_after_auto_skip" &&
 		test_expect_code 1 git p4 submit --conflict=3Dskip >out &&
-		test_i18ngrep "Applied only the commits" out
+		test_grep "Applied only the commits" out
 	)
 '
=20
@@ -167,7 +167,7 @@ test_expect_success 'conflict on first of two commits=
, --conflict=3Dquit' '
 		# but this commit is okay
 		test_commit "okay_commit_after_auto_quit" &&
 		test_expect_code 1 git p4 submit --conflict=3Dquit >out &&
-		test_i18ngrep "No commits applied" out
+		test_grep "No commits applied" out
 	)
 '
=20
--=20
2.42.0-530-g692be87cbb

