Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FDC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 23:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379375AbiFPXUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFPXUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 19:20:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2027.outbound.protection.outlook.com [40.92.45.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF362A2D
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 16:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltLmnD/xJmf6ugN9qDbYLu2+0IslthWjgfvXYdbDslamW+cMODCI8QrUlcFbPBLaoGdIfS9l5A0yk+mKs4S9L0X21OyQwO/vfaV7kmCa7o9+/ifM8xJ6Rc+wKzYVdMfLd+jCJW41JHnROMPJaxhqwak91WMhiPgOdpN9H4RPdxlO7fFhps7/UlvGRz62soj4H1NjiNDSmkREJRoc4bPOM5wUq2fB/6nBh7mVTTYBxkKeE32HDyqkgJQXMAc6L5iVTOJUlBkPoNh6GanPrjvzVZgf5hfVxAQ6qGowwe19FN3kwKtSPF70yrrNyfAHUolKsyxgVbLNEZjEQiYqi5grBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1obI5U0Eq8UbLAVoIKyPD2AvyUptloZ2Vqh3w75ztxs=;
 b=Eiu0xl5xnebjfIl5wfpUG98QNvyWHicgAL33XAqKF/5p9JCG0GEvxlQ4g2NSqhbcfPp2luvZc5SSlN7xj/dc+cDa0oVCFTRWt5NBIRvX/PJQ26wOD1EoyQoZ1XCcL58oTLM/ZP/QieJWwrq3gn2W33IIr8kyA14634p8PkPDN4FsHWMEtCN8rFAwxiZ+HZ2Oq7aVMK3NCX3v0hYCQfLx9GiPFLz1+UXI7JPEIr4CcRNAvEiEZ38cnsGV8onWpOCw+yjJWQpZ939Y8EqWFwlpUoOufGLTxSyJ1sh7Am4Y+Dsb6xd4Qbhj/7kErnAnJ7z75RCEfDrM7o6ugyrw4gYBqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1obI5U0Eq8UbLAVoIKyPD2AvyUptloZ2Vqh3w75ztxs=;
 b=cupRH4n7dGneXMMVg6aM+bRI0kXqF3zO/eoPpTOrohqePqatyJL7+fBP+eQtLsmU6IdnmZ7dDAQnPT7g6Ui8mOT01SxyuQ2vbaKp/isee4KlNlLSRdI9Z4qxmFm+jNBjeJrbw/7SHQowRCD+kd8Xqgj6ixkkyCoRF1O5FDEilLZFcpsnObXtkp8MY3lwCLSK6D2TrBjNyuPQso35wxgdechLuSxb5UL9HzqgNUEhubcRZvF+Z20kjNjzKOjpgjS0zkCPRpB4xvFrPFTV++7w1sqhLSGparJhZhRn6t2w6yZ2VDT6keAC9CT+B1rNMCnp0mRSrz9cJlcyqv5i7u1v2Q==
Received: from DM6PR13MB2987.namprd13.prod.outlook.com (2603:10b6:5:6::24) by
 BLAPR13MB4659.namprd13.prod.outlook.com (2603:10b6:208:330::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.9; Thu, 16 Jun 2022 23:20:43 +0000
Received: from DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97]) by DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97%4]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 23:20:43 +0000
From:   Goss Geppert <gg.oss@outlook.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4 1/2] dir: traverse into repository
Date:   Thu, 16 Jun 2022 23:19:55 +0000
Message-ID: <DM6PR13MB29877F2E161FD450CC2BD8339DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220616231956.154-1-gg.oss@outlook.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220616231956.154-1-gg.oss@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PE7YuAgW6FgTLY/6VxAKprhF9Ms8H/sw]
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To DM6PR13MB2987.namprd13.prod.outlook.com
 (2603:10b6:5:6::24)
X-Microsoft-Original-Message-ID: <20220616231956.154-2-gg.oss@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfaee976-5a7b-4b89-446b-08da4feed5ec
X-MS-TrafficTypeDiagnostic: BLAPR13MB4659:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FY1PG1SKEoEKHti3BzoDWsQCn6G5bRhoyUEc175juJCds/lnqqkEy2+Pp5PxCdMArw5Zxl/hITHvGluefUfCRgjUdVUQMP+94sXlD0uWF1CzfEokt6wCVqTMJ7CV+heD9PNN0WWQgyoOFOFxd4gOswgfc6ZC0yaMBEnO3a42a6fFsu4fuf4ZtWOsnTqhB7/ntOD/teduQ9ny0aQ4FcO6VztaI6fimh+6vDHqVSGBqKmbIYXTLQDYWzc/0fCVayzSDzdCunUgGElrtu1kjkvME/gr1LorwDDZUdLFkqpDQL4Hr154ukqAkiYgwumqANEiWusaVJBYB74VTkPbeEkbqZie+lYgj9xyA/52mMiNeZ7AywFbRH1vQMCh8JuI1H//Ka8hlXPSinWdo2LxD8PK3KdFnNadTtbhdcbd0XdsohvMwb/R9qoOqwY+FjsnqEyZV+1yFh2a8+YPFGi5dFYPQxyYf1XAW+Mit94nriA6llBmOhGGFNQgSw0dtHyqWGc/zTLeXUKcYhs5S+lpD4UVT/hrGCrr7tWnXToBHAw0+2GQKv9LyLSDoRikcHAtUJkUIxXSEQWKmHEIPI3UzU7FdA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3JDg86/hWd45vehzZk5Zg5BF4Q8k5KoHYa6p9EmdqOgV28KqBS1hHUuCXqD6?=
 =?us-ascii?Q?NdgXebb/8wa48g1LC40TBmyJqKXuj9VWZROpXzDnna+ZMo4xHbWbhmYsuYP5?=
 =?us-ascii?Q?EBJ3GgfjdIiaKH9/ShZ3qZkNz1YIgu7yhjrUdzD5FO48K4TsjZTz3kaMW0mx?=
 =?us-ascii?Q?2oHsqG1cyyqhGrxJtPlJCzX+cAriTpIkqrl6jVOWC5Sx010AHHvh/vU4UKkv?=
 =?us-ascii?Q?3BWFJt0GNDyrCvPfQadmRleRx5dbGAXpIfrOfE4h4CycSwp+efSLj0Tp/HZ8?=
 =?us-ascii?Q?wWuGoZ72hb/AS0Qn8vFgf81vOcHT0Vr/SjRdCTWxTybTrUUAdp1RoAhe8tE5?=
 =?us-ascii?Q?/6zFbw8szJF9FUdM24iNbtQ7aao8M6v4QM3QmqwWj1FxbeXbhfwpXBPWUB/V?=
 =?us-ascii?Q?AyFM8oI1cbwYke1rsmMsBN4GWzeSfNX365p4HEYA3zc4U5MAFq8dLGNtrCEb?=
 =?us-ascii?Q?mk+R8hXiHK0FsA7ZU/+yARAj313Y3Y6TFxj2DG0/RB/uaYQnfSm6N1CCQ2lK?=
 =?us-ascii?Q?GR7KnIB/T2sox/87n7+mqqCiTmLrJikE76+KPZYcBvRhhRL8movIeMPZj7cw?=
 =?us-ascii?Q?oF0EuukZxui8i6rsdkIIXf5kHnG/IRe1sFI7r9zpZ+JP0ntE306vzkdzrnER?=
 =?us-ascii?Q?O/j87+hJ8GmfU7Hq3IizXQ7xZ5GywzzTJ/Be4GoWhXoWdN7AwTnAftekafRU?=
 =?us-ascii?Q?x7Ilr7zmuPOT5G9wJTne8HnDyoPK6s0K2zUNUuuQQIgRRoMRni+LafiTMPjS?=
 =?us-ascii?Q?syGJCnlIOMGhJSIfAPlpCYBCDyL2M3E/GGFgi0dE3us0JgsP+QThrQaM5D9w?=
 =?us-ascii?Q?267nizVMybb4mtVJZgC5PdKbEmefyVsdN5FfmPZ6Vb7LPuKgKxb4o9tVRIYh?=
 =?us-ascii?Q?I3QNgGX++Lmt5RpAkBWZDgfhEVJNKjhIte96NId5LDIt20ZuJosRWykSqDTL?=
 =?us-ascii?Q?isrgxdN+n/zMF7L+i66IW/4hKzVQ5LIbKg5ZSuaRMxHYKCR/8hUwYwxb3o/b?=
 =?us-ascii?Q?YAwUepA9CjcFT9UM9MWeQr/WKm5LRpQmFYAvnDeHyBAqes5907CsaXZoXpJ6?=
 =?us-ascii?Q?oCcZuTJ2JI9gMvvPHoun66sLn/vG7dR5AVCDhklJ96W66kTICNx73YvdiMCL?=
 =?us-ascii?Q?CKWD4AK6JCj/SYqLoZrfanNkFiF9pxBcDtZqXkvyxQW63GcYpkEO2/4XkY0s?=
 =?us-ascii?Q?9DWbncdPUjWaZeV0/qantyiD3EWP42wPr1Oezv85n3O7Ct8Ro/LB3rG8slNB?=
 =?us-ascii?Q?T77fuiGwhF/8z6brSsR6KprD+8gnLTX3bfspexTvSp32rFPwnWf0jIeHMHSX?=
 =?us-ascii?Q?y4PxnKA2u9yKmL727adESFvyUrbM1WuLxNfpvj9xZ01oDr4+6S0XvntgpQrb?=
 =?us-ascii?Q?6iQaVFQq3nBYVXcVQUy5DoJf57xFGjz2lObkcFkA9h+T41QNNWHhrKdF4sHn?=
 =?us-ascii?Q?PDAiLkzfkGU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfaee976-5a7b-4b89-446b-08da4feed5ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB2987.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 23:20:43.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4659
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Goss Geppert <ggossdev@gmail.com>

Since 8d92fb2927 (dir: replace exponential algorithm with a linear one,
2020-04-01) traversing into a repository's directory tree when the
traversal began outside the repository's standard location has failed
because the encountered repository was identified as a nested foreign
repository.

Prior to this commit, the failure to traverse into a repository's
default worktree location was observable from a user's perspective under
either of the following conditions (there may be others):

    1) Set the `core.worktree` location to a parent directory of the
       default worktree; or
    2) Use the `--git_dir` option while the working directory is outside
       the repository's default worktree location

Under either of these conditions, symptoms of the failure to traverse
into the repository's default worktree location include the inability to
add files to the index or get a list of untracked files via ls-files.

This commit adds a check to determine whether a nested repository that
is encountered in recursing a path is actually `the_repository`.  If so,
we simply treat the directory as if it doesn't contain a nested
repository.

The commit includes test-cases to reduce the likelihood of future
regressions.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c                          |  19 +++
 t/t2205-add-worktree-config.sh | 265 +++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)
 create mode 100755 t/t2205-add-worktree-config.sh

diff --git a/dir.c b/dir.c
index 6ca2ef5f04..c4f41247e0 100644
--- a/dir.c
+++ b/dir.c
@@ -1893,9 +1893,28 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 
 	if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
 		!(dir->flags & DIR_NO_GITLINKS)) {
+		/*
+		 * Determine if `dirname` is a nested repo by confirming that:
+		 * 1) we are in a nonbare repository, and
+		 * 2) `dirname` is not an immediate parent of `the_repository->gitdir`,
+		 *    which could occur if the git_dir or worktree location was
+		 *    manually configured by the user; see t2205 testcases 1-3 for
+		 *    examples where this matters
+		 */
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
+
+		if (nested_repo) {
+			char *real_dirname, *real_gitdir;
+			strbuf_addstr(&sb, ".git");
+			real_dirname = real_pathdup(sb.buf, 1);
+			real_gitdir = real_pathdup(the_repository->gitdir, 1);
+
+			nested_repo = !!strcmp(real_dirname, real_gitdir);
+			free(real_gitdir);
+			free(real_dirname);
+		}
 		strbuf_release(&sb);
 	}
 	if (nested_repo) {
diff --git a/t/t2205-add-worktree-config.sh b/t/t2205-add-worktree-config.sh
new file mode 100755
index 0000000000..43d950de64
--- /dev/null
+++ b/t/t2205-add-worktree-config.sh
@@ -0,0 +1,265 @@
+#!/bin/sh
+
+test_description='directory traversal respects user config
+
+This test verifies the traversal of the directory tree when the traversal begins
+outside the repository.  Two instances for which this can occur are tested:
+
+	1) The user manually sets the worktree.  For this instance, the test sets
+	   the worktree two levels above the `.git` directory and checks whether we
+	   are able to add to the index those files that are in either (1) the
+	   manually configured worktree directory or (2) the standard worktree
+	   location with respect to the `.git` directory (i.e. ensuring that the
+	   encountered `.git` directory is not treated as belonging to a foreign
+	   nested repository).
+	2) The user manually sets the `git_dir` while the working directory is
+	   outside the repository.  The test checks that files inside the
+	   repository can be added to the index.
+	'
+
+. ./test-lib.sh
+
+test_expect_success '1a: setup--config worktree' '
+	mkdir test1 &&
+	(
+	cd test1 &&
+	test_create_repo repo &&
+	git --git-dir="repo/.git" config core.worktree "$(pwd)" &&
+
+	mkdir -p outside-tracked outside-untracked &&
+	mkdir -p repo/inside-tracked repo/inside-untracked &&
+	>file-tracked &&
+	>file-untracked &&
+	>outside-tracked/file &&
+	>outside-untracked/file &&
+	>repo/file-tracked &&
+	>repo/file-untracked &&
+	>repo/inside-tracked/file &&
+	>repo/inside-untracked/file &&
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	../file-tracked
+	../outside-tracked/file
+	file-tracked
+	inside-tracked/file
+	EOF
+
+	cat >expect-untracked-unsorted <<-EOF &&
+	../file-untracked
+	../outside-untracked/file
+	file-untracked
+	inside-untracked/file
+	EOF
+
+	cat >expect-all-dir-unsorted <<-EOF &&
+	../file-untracked
+	../file-tracked
+	../outside-untracked/
+	../outside-tracked/
+	./
+	EOF
+
+	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
+
+	cat >.gitignore <<-EOF
+	.gitignore
+	actual-*
+	expect-*
+	EOF
+	)
+'
+
+test_expect_success '1b: pre-add all' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-all-unsorted &&
+	sort actual-all-unsorted >actual-all &&
+	sort expect-all-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '1c: pre-add dir all' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	git -C repo ls-files -o --directory --exclude-standard "$parent_dir" >actual-all-dir-unsorted &&
+	sort actual-all-dir-unsorted >actual-all &&
+	sort expect-all-dir-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '1d: post-add tracked' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	(
+		cd repo &&
+		git add file-tracked &&
+		git add inside-tracked &&
+		git add ../outside-tracked &&
+		git add "$parent_dir/file-tracked" &&
+		git ls-files "$parent_dir" >../actual-tracked-unsorted
+	) &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_expect_success '1e: post-add untracked' '
+	(
+	cd test1 &&
+	local parent_dir="$(pwd)" &&
+	git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-untracked-unsorted &&
+	sort actual-untracked-unsorted >actual-untracked &&
+	sort expect-untracked-unsorted >expect-untracked &&
+	test_cmp expect-untracked actual-untracked
+	)
+'
+
+test_expect_success '2a: setup--set git-dir' '
+	mkdir test2 &&
+	(
+	cd test2 &&
+	test_create_repo repo &&
+	# create two foreign repositories that should remain untracked
+	test_create_repo repo-outside &&
+	test_create_repo repo/repo-inside &&
+
+	mkdir -p repo/inside-tracked repo/inside-untracked &&
+	>repo/file-tracked &&
+	>repo/file-untracked &&
+	>repo/inside-tracked/file &&
+	>repo/inside-untracked/file &&
+	>repo-outside/file &&
+	>repo/repo-inside/file &&
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	repo/file-tracked
+	repo/inside-tracked/file
+	EOF
+
+	cat >expect-untracked-unsorted <<-EOF &&
+	repo/file-untracked
+	repo/inside-untracked/file
+	repo/repo-inside/
+	repo-outside/
+	EOF
+
+	cat >expect-all-dir-unsorted <<-EOF &&
+	repo/
+	repo-outside/
+	EOF
+
+	cat expect-tracked-unsorted expect-untracked-unsorted >expect-all-unsorted &&
+
+	cat >.gitignore <<-EOF
+	.gitignore
+	actual-*
+	expect-*
+	EOF
+	)
+'
+
+test_expect_success '2b: pre-add all' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-all-unsorted &&
+	sort actual-all-unsorted >actual-all &&
+	sort expect-all-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '2c: pre-add dir all' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --directory --exclude-standard >actual-all-dir-unsorted &&
+	sort actual-all-dir-unsorted >actual-all &&
+	sort expect-all-dir-unsorted >expect-all &&
+	test_cmp expect-all actual-all
+	)
+'
+
+test_expect_success '2d: post-add tracked' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git add repo/file-tracked &&
+	git --git-dir=repo/.git add repo/inside-tracked &&
+	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_expect_success '2e: post-add untracked' '
+	(
+	cd test2 &&
+	git --git-dir=repo/.git ls-files -o --exclude-standard >actual-untracked-unsorted &&
+	sort actual-untracked-unsorted >actual-untracked &&
+	sort expect-untracked-unsorted >expect-untracked &&
+	test_cmp expect-untracked actual-untracked
+	)
+'
+
+test_expect_success '3a: setup--add repo dir' '
+	mkdir test3 &&
+	(
+	cd test3 &&
+	test_create_repo repo &&
+
+	mkdir -p repo/inside-tracked repo/inside-ignored &&
+	>repo/file-tracked &&
+	>repo/file-ignored &&
+	>repo/inside-tracked/file &&
+	>repo/inside-ignored/file &&
+
+	cat >.gitignore <<-EOF &&
+	.gitignore
+	actual-*
+	expect-*
+	*ignored
+	EOF
+
+	cat >expect-tracked-unsorted <<-EOF &&
+	repo/file-tracked
+	repo/inside-tracked/file
+	EOF
+
+	cat >expect-ignored-unsorted <<-EOF
+	repo/file-ignored
+	repo/inside-ignored/
+	.gitignore
+	actual-ignored-unsorted
+	expect-ignored-unsorted
+	expect-tracked-unsorted
+	EOF
+	)
+'
+
+test_expect_success '3b: ignored' '
+	(
+	cd test3 &&
+	git --git-dir=repo/.git ls-files -io --directory --exclude-standard >actual-ignored-unsorted &&
+	sort actual-ignored-unsorted >actual-ignored &&
+	sort expect-ignored-unsorted >expect-ignored &&
+	test_cmp expect-ignored actual-ignored
+	)
+'
+
+test_expect_success '3c: add repo' '
+	(
+	cd test3 &&
+	git --git-dir=repo/.git add repo &&
+	git --git-dir=repo/.git ls-files >actual-tracked-unsorted &&
+	sort actual-tracked-unsorted >actual-tracked &&
+	sort expect-tracked-unsorted >expect-tracked &&
+	test_cmp expect-tracked actual-tracked
+	)
+'
+
+test_done
-- 
2.36.0

