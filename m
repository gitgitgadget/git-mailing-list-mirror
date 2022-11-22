Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CEC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiKVWpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiKVWpT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 17:45:19 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD76BEB7E
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:45:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id l24so10045770edj.8
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxlysv/I8p1UcE4X/EY4p/zRTzIy54fbqG6NHJzLXzI=;
        b=ak24XJBBAA5TfFChVHPTTOH02AcCXwyPBUWOQbCZkTei0unbq2HobTu8clvInSbCcB
         34+y99HP7Bo6pnJSHfGSzoYhCkIAoiRE8TVITC0QVEqYwcSX9m5NxKLwrOT38jqavSro
         bTzQqgFixUen5XHb6b2jjdqcf7ResyQZ0q8NQkm0iyBoODMd++U69cN79jkMzcOCgnx7
         5CKMNaUDoqPuJBM0Y8escWLwwCGED3M23v70tmzy7lExJuLtOzt8uOM+CRAGg0uq71RU
         dQK+vIOogwdTl2ky2afQPX4BAnuaqrLhadXOm/JVBlramb0w3zTTBDrgziePe29egjpe
         4xJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxlysv/I8p1UcE4X/EY4p/zRTzIy54fbqG6NHJzLXzI=;
        b=e1p2uXkEFuqmYS2WrOrRlPrmUibDmzUU8D68IpUyDdgjNLArNOJ8w/8VKjTQNdAo3C
         3++FQlNFWTwliqRAruRh/xIZpdg3/jU0GyhZN30rddpbIDXxX2seRn+rWxvkQYwacx61
         RQYiMLt2p2WP9o1eY6bLMKHfhGSf3YAwGbTxc+FdcfWR+ettpBTTyM0JZIden19dLoyG
         uNZtQEHe/44nJPn9u4d2WagcGL0px2c9GU2viflXbhpF2WM5Z/INASQujp/qvjXc3vab
         0adG0YPj8HDMMc8+o5x/JTM3vkIVbMczG8oxQwk9MZ/iEc9v4s1XoDSvdvf/NOVo4OiT
         eSSQ==
X-Gm-Message-State: ANoB5plYjkVg9WlbmSVnfGaNbnTNfjt7fqizLkmR4KYE5nwvQ6e5RwTQ
        GHcLXv+Oo5j2wx5wzzmNo6EIFQ+dXObQjA==
X-Google-Smtp-Source: AA0mqf4KIcp3rbd2KtzRnHqik3M84UTCkQwiddmoCHp1l6ofXcTaXbKgnnM2pZ2C6lpGXwt2kZ5ekw==
X-Received: by 2002:a05:6402:35cf:b0:469:5ee9:4a76 with SMTP id z15-20020a05640235cf00b004695ee94a76mr5841720edc.405.1669157116060;
        Tue, 22 Nov 2022 14:45:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id kx21-20020a170907775500b0078128c89439sm6488663ejc.6.2022.11.22.14.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:45:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] submodule absorbgitdirs: use relative <from> and <to> paths
Date:   Tue, 22 Nov 2022 23:45:09 +0100
Message-Id: <patch-1.1-065be1da895-20221122T224306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1524.gdb7bac9ecc9
In-Reply-To: <kl6ltu2sdk1r.fsf@chooglen-macbookpro.roam.corp.google.com>
References: <kl6ltu2sdk1r.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When [1] changed the <from> and <to> paths to from absolute paths by
stripping away their common prefix we started displaying nonsensical
paths in cases where the "gitdir" wasn't "<worktree>/.git".

E.g. a repository at "/repos/repo.git" and a worktree at
"/worktrees/repo-main" would yield paths starting with
"worktrees/repo-main", as the only commonality was the initial "/".

It's harder to narrowly fix that problem than to just have
relocate_single_git_dir_into_superproject() display the same sorts of
paths we do for most other "submodule" commands. I.e. the "<to>"
should be relative to the "<from>" path, rather than relative to the
eventual superproject.

Let's do that, and add a test which checks that we're handling the
"git worktree" case properly. See [2] for the initial bug report.

1. a79e56cb0a6 (submodule--helper absorbgitdirs: no abspaths in
  "Migrating git...", 2022-11-09)
2. https://lore.kernel.org/git/kl6lmt8qv9gc.fsf@chooglen-macbookpro.roam.corp.google.com/

Reported-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Mon, Nov 21 2022, Glen Choo wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> * ab/submodule-no-abspath (2022-11-09) 1 commit
>>   (merged to 'next' on 2022-11-18 at 34d0accc7b)
>>  + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
>>  (this branch is used by ab/remove--super-prefix.)
>>
>>  Remove an absolute path in the "Migrating git directory" message.
>>
>>  Will merge to 'master'.
>>  source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
>>
>
> (Sorry, I should have spoken up before this got merged to 'next'.)
>
> I have some reservations about this that I mentioned in [1], namely:
>
> - Does this work correctly when using a worktree?
> - If "absorbgitdirs" becomes consistent with other "git submodule"
>   subcommands and prints relative paths to submodules, then this
>   produces the wrong result.
>
> We probably won't see any complaints about this for a while, since
> submodules + worktrees are an uncommon combination, but I expect that
> we'll have to revert this at some point.
>
> [1] https://lore.kernel.org/git/kl6lmt8qv9gc.fsf@chooglen-macbookpro.roam.corp.google.com

Hi, sorry about the delay in getting back to you on that. I think the
below should fix the bug you noted, and also improve the output in
general so we use the same sort of relative paths we use for other
"submodule" commands.

Branch & passing CI at:
https://github.com/avar/git/tree/avar/submodule--helper-absorbgitdirs-no-abspath-in-message-fixup

 submodule.c                        | 18 +++++++++++-------
 t/t7412-submodule-absorbgitdirs.sh | 25 ++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index c47358097fd..a464c99a27f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2271,9 +2271,12 @@ int validate_submodule_git_dir(char *git_dir, const char *submodule_name)
 static void relocate_single_git_dir_into_superproject(const char *path)
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
+	char *rel_old_git_dir;
+	const char *rel_new_git_dir;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
-	size_t off = 0;
+	const char *super_prefix = get_super_prefix();
+	const char *sp = super_prefix ? super_prefix : "";
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2285,6 +2288,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 		return;
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
+	rel_old_git_dir = xstrfmt("%s%s", sp, old_git_dir);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 	if (!sub)
@@ -2293,23 +2297,23 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	submodule_name_to_gitdir(&new_gitdir, the_repository, sub->name);
 	if (validate_submodule_git_dir(new_gitdir.buf, sub->name) < 0)
 		die(_("refusing to move '%s' into an existing git dir"),
-		    real_old_git_dir);
+		    rel_old_git_dir);
 	if (safe_create_leading_directories_const(new_gitdir.buf) < 0)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
+
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
+	rel_new_git_dir = relative_path(real_new_git_dir, real_old_git_dir,
+					&new_gitdir);
 
-	while (real_old_git_dir[off] && real_new_git_dir[off] &&
-	       real_old_git_dir[off] == real_new_git_dir[off])
-		off++;
 	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
-		get_super_prefix_or_empty(), path,
-		real_old_git_dir + off, real_new_git_dir + off);
+		sp, path, rel_old_git_dir, rel_new_git_dir);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
+	free(rel_old_git_dir);
 	strbuf_release(&new_gitdir);
 }
 
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index a5cd6db7ac2..0afa0fe3a83 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -27,7 +27,7 @@ test_expect_success 'absorb the git dir' '
 	git status >expect.1 &&
 	git -C sub1 rev-parse HEAD >expect.2 &&
 	cat >expect <<-\EOF &&
-	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''../../.git/modules/sub1'\''
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
@@ -64,7 +64,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
 	cat >expect <<-\EOF &&
-	Migrating git directory of '\''sub1/nested'\'' from '\''sub1/nested/.git'\'' to '\''.git/modules/sub1/modules/nested'\''
+	Migrating git directory of '\''sub1/nested'\'' from '\''sub1/nested/.git'\'' to '\''../../../.git/modules/sub1/modules/nested'\''
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
@@ -99,7 +99,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
 	cat >expect <<-\EOF &&
-	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''../../.git/modules/sub1'\''
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
@@ -112,6 +112,25 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	test_cmp expect.2 actual.2
 '
 
+test_expect_success 'absorb the git dir outside of primary worktree' '
+	test_when_finished "rm -rf repo-bare.git" &&
+	git clone --bare . repo-bare.git &&
+	test_when_finished "rm -rf repo-wt" &&
+	git -C repo-bare.git worktree add ../repo-wt &&
+
+	test_when_finished "rm -f .gitconfig" &&
+	test_config_global protocol.file.allow always &&
+	git -C repo-wt submodule update --init &&
+	git init repo-wt/sub2 &&
+	test_commit -C repo-wt/sub2 A &&
+	git -C repo-wt submodule add ./sub2 sub2 &&
+	cat >expect <<-EOF &&
+	Migrating git directory of '\''sub2'\'' from '\''sub2/.git'\'' to '\''../../../repo-bare.git/worktrees/repo-wt/modules/sub2'\''
+	EOF
+	DO_IT=1 git -C repo-wt submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
-- 
2.38.0.1524.gdb7bac9ecc9

