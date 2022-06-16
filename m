Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB6CCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 23:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379416AbiFPXoz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379407AbiFPXox (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 19:44:53 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2036.outbound.protection.outlook.com [40.92.42.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090AF54F81
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 16:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0JFLhoEuJQcQ3WhWNbRU4+3Dr4aP6k5dtRrsz6E1tDiw61WeG+nh/4B3xVGpQpqxVimZx16iae66pb8uapVhTCv0jIPdIZ4CNjD8EBLI/QSbIWS3h41SHTzxrTtFXhYPZHMSRuFEMdWic9H1/6vyydra1Dn0MuyN3OVlEbDV1CflQ3fCLe+5jqIyYatIppAlEJvLDAj651ziN7U0BV8Lskyi0viU1QGWLs43YihE1iTcyBTeo7HxbfyUBf14+r/b+y0G6wYy0JXhkeiAG9PbpffFp6F0oSpDW0x+MpdGz2sGp31Sy3Wgd93bdxwX4ES97HvoV1ms9ORUbZToZRnGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1obI5U0Eq8UbLAVoIKyPD2AvyUptloZ2Vqh3w75ztxs=;
 b=ipltxm7uIlMCPQ6dRO1OMuar7p8sIvh3EP+/uwdO89GpTt+c9fF1l0FJVuhR/50Uypgrzr2fjRhGgF4JjmE75zTIF4n1EanJLnW5pRwPNG9X2jaFNOSn+p19f1euZDeyYHPFjW/hvHQ7C7W8W55gMz9MJCrmyu8ylwW/DSE63W30RKZn+lD4vMTynmz6Brt3j1cFEpMHa0RmD0/6bN5utrCjzQRD2LbkZbZziqDqAEWC/1FcpsM2HuCZ+Rzgy4QWYA6yzaNDquYoAG5DgnS7F2eW4JZEzRJ63R6UXLNuOxHHKFKgpfXQZOaHiGR4j3t3Wheq6T4CjgSvtqWnnwJQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1obI5U0Eq8UbLAVoIKyPD2AvyUptloZ2Vqh3w75ztxs=;
 b=Iw9d++f/Q6+17jS+oTNgV0UzpQoqetYHHdr1vSuvAGPV/H7Sxerahh959/pvxrN5cdbaWVnrEWfiEQP8KgBCV9fhb8jMOnd3Rveh+6xDY2UvDe+1AbxPpil8AMncThf/17EzY1YXXu1oaxBjh0QFefkb0C4vUkhFC3JPpMrXC4sdBZ8AA2BUTFhCMVx2/+7JmtzDwVxvQcqaUEDbLM3FN7GsHsR/EUewbFELVgfKmOq7ekzwIrW3VCcY3el3gUZRoKq0YREGfefvgmJoVZ400r2I7BAjOxURgoWpVuljjouzN39o4KSJFXMw+YVWGTyeleXQIzIotd0/KHo4mJS88g==
Received: from DM6PR13MB2987.namprd13.prod.outlook.com (2603:10b6:5:6::24) by
 DM6PR13MB2521.namprd13.prod.outlook.com (2603:10b6:5:c1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.6; Thu, 16 Jun 2022 23:44:50 +0000
Received: from DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97]) by DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97%4]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 23:44:50 +0000
From:   Goss Geppert <gg.oss@outlook.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4 1/2] dir: traverse into repository
Date:   Thu, 16 Jun 2022 23:44:32 +0000
Message-ID: <DM6PR13MB29875B5203E253D1AF983A169DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220616234433.225-1-gg.oss@outlook.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220616234433.225-1-gg.oss@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [+aWZXo8S+/yr/r3Ju2RRzcrh/kf8vlnB]
X-ClientProxiedBy: MN2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:208:e8::38) To DM6PR13MB2987.namprd13.prod.outlook.com
 (2603:10b6:5:6::24)
X-Microsoft-Original-Message-ID: <20220616234433.225-2-gg.oss@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe9c3c8a-d19a-463c-02b8-08da4ff2333c
X-MS-TrafficTypeDiagnostic: DM6PR13MB2521:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6YYVUKBfMOJsyaSFzW3drbUKlK8XMlMCY7Z0/+cDAVdjFL2VHAhAjlDAIqPLAgxPipAvXxYwVlYsQRItVukF3yVAeKxR2JfNAmFqKuMSWhQF+3UOA5/NZrzidRaeKOISa+FGlhY5EOI72SGayQyEeU2kRSW1Zlbbu9qM5LLi9RO/0UTaL7g3oudgnCG6mZhk6MW1VHem78UWPel2OsbYZrNIa9Hui6aH0g+nMvCoCIc04JATNcXeBbS1BfJxjOu8dxmhwjftRgvzU7kZBAdu4NYddYlYea4Cc/h+4Se37wxFq7gqYNt8dIE8E6ToHEhdWeiaWUzlOtgSEV6OE4gbnc0QXb1Ff76XowVvZNl+BR0poTH9jxE/QcZPSf0anICbAPJEA9qEDEowjPvOzNM4z4izHWzd/W6zl3soDiwegVgby98yZj4HEHZRz8Mg1R8yu3qWOwvr/Y1dv7nkr39/nWkFwIdtQwxGNvNScvHTTkCmNz81OBVBjfkxt/tfdoPs+P2eGo23eXjQDjDa1uZncXoObRjDoijnqNYUGlAKGERJjy9LTBHArw28w5b0v8lzBJCJJ0jKRL2u4cbPBNy2g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j5ANBV2jHGcJaIAo2YkggQp770xsZEJM1JpXwvlfaUnGNUBCCWGNSqUDx1l5?=
 =?us-ascii?Q?CZlmOTjHOHN0fzcsoiPNY7BuPhBQGOHsXdVSnx66tDBYcUhNe7vyqqJk0Ac0?=
 =?us-ascii?Q?NdNQN9x11m3Gh6r3GGLnndi7LRBry0eGRdFxvQptvypgW+VSFWRpm5Y7pXgI?=
 =?us-ascii?Q?IZOky4Y4diZNzcNQJ4qW0jHFJ1Jy29OJYqLUWqm5R/F54/9gNL4pwE4WdSMo?=
 =?us-ascii?Q?QHCnArr7qdYngEZG6sKoMN1S+4ZH5Hjw0yqYewH1p2/W3R7jvo19XM+RVAt+?=
 =?us-ascii?Q?iZ+vBg8SWptEk2dyekry85zKl3o6fJOEMVKco4GUxiOcDOp9U5Teupz1FBnz?=
 =?us-ascii?Q?LkU7mwSjQLVDTKQusAizJKZPiELPXr7Inqxnz5PECMk16Is+mJB3dA2fjElf?=
 =?us-ascii?Q?vDYWMrjiqiDCtFDPJ+T6j+xDWeJ2GoLMBaolMULgOUnGDcXI5+MscBBGb3Ej?=
 =?us-ascii?Q?VH3/POT9pFLUbobit7+C/T1U6ku6BkGiuYIy5CRWPN7aTs6R5JTFVqeWtExG?=
 =?us-ascii?Q?976N+yxTLhKV7MilCo6zr8Yd/aWV9uDiRUriFOjIByUgiUvZHGiKkBiEaSEC?=
 =?us-ascii?Q?jUpUzBckHCAaaNf1+DDEnEa+Z5OrkZzWMYkqNPAD8qGxNdqnxuQkfdyQdLCC?=
 =?us-ascii?Q?zMBcFTiugUuY7Hm+KlulB72qt3HjZhifzf4nssSX5xAyzc1+d6yuq3jtEOGU?=
 =?us-ascii?Q?LWWdOVUGflOs4UFcmBK9Koo1+8hGLXj5BTYWQ1p7EgHsOdvODqDYJMw0fsaT?=
 =?us-ascii?Q?ALALJNokNV1hC5OeCY2oPn3kdxMfdCc89aEtXAs4o1qTVUaM9c6+/V5LV6SI?=
 =?us-ascii?Q?RbmG5JArpO8tz4G4mASM4p0LY/WnNe/svn0OarZQC4El8kFjLYm9kijP8MKn?=
 =?us-ascii?Q?FG3hE26GEgBwhBHYw+wGfdEWKNuMDtjW/gmbpm8lobKdErlDuPORcpUD/m5a?=
 =?us-ascii?Q?5V8hMgcaETKPDuLWO+QISyXvVJ9bBRTBD0n/oyBYfV6U68QzHEasmhgfoT0R?=
 =?us-ascii?Q?FsnZcvK3AuS+PloFn2fHprhzNl2vAfbTRLDpDGdgXISHS34FpIfdsYxer8Mr?=
 =?us-ascii?Q?ZFTyRIGTUKlgnK+ZoVpuocY1DTpgRJOYe/ROjp+FImqwSnPTWI5iGSDnb/7u?=
 =?us-ascii?Q?w1U9iMSIhrJ0PI2bGdWKKetePktDIljxnjJl5kX3AsX0bn43XYH1pxLSe0hy?=
 =?us-ascii?Q?5/PmjF+UEU4OdFhQW4F669WtnQfzW0HNnmlIcgrlj2MPbmAEkwfZSDTWhPdO?=
 =?us-ascii?Q?hrRI4wau8cYpe/pPcPhNYisV+CStWdYgr0a4/ZOONQlmHp6DV4rKf0fGKack?=
 =?us-ascii?Q?LtKTMjxBhQa/2XLy1LUBJ/VFzGyvJUhiDeAyUUGD4JM4m9C9zKALMopb7Dpq?=
 =?us-ascii?Q?/AG2q2xufAH4SKMOmYFqOVxVHVJbn8w5/4YK9T+LVrOpcR7yVXMkhD2lxuRu?=
 =?us-ascii?Q?6pdhSJ7G4u4=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9c3c8a-d19a-463c-02b8-08da4ff2333c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB2987.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 23:44:48.8940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2521
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

