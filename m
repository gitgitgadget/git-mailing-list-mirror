Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161CBC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 02:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKICfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKICfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 21:35:51 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABF1C120
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 18:35:50 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 13so43321935ejn.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 18:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmDZmS/xzUD2JnQxv2478g7u+rfDKRe3Ze1+UrGNszA=;
        b=SWAT4stb3eN8Lekrk3CW7wpVeFFXG7Pol0qmxCGylQzP1aIU/hOAX6HJ57TcJzbTnD
         v3icsvzLuJNpc3FERZXj6NUWm3zETeTU1uGTyNpuHYxsA89Bq/MHg5Cn87juUsyyZEIb
         n1l4C/c5IRcyd2SpQrRyHbxSsdkjSTTXLLeV5n6mJde/IwivBAR0QebbEiNw8QeLXQpV
         ruESR/EO9Q75mF0nDIEkuWKnJBwO7ekahPWyNmgOrlfbl1r1qIPsDbpsPYbAXxXDHtaD
         D7xVGnC/EOQtvEY8K27LTH5OYUDITK9WSbkY2lvssPKOLQ0xVO55Ky+SvydrrTIBWAAb
         9Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmDZmS/xzUD2JnQxv2478g7u+rfDKRe3Ze1+UrGNszA=;
        b=qgCiw8eDGCpwfXw/DEMKYDCLs8zvcOD7vNPPy91Wjp5o5RANvFickoz7VO8hClgv8B
         AH1zCDt/STouNHLHXOJDM3yxp4kPWtXBOuK5ED8DkwbtjAvW75Q+X9/CT7oKE14s79K5
         Rbk01e7g12LqY43rN15JF15wn6zxIAn73XBUU4CqMuqXtVjpGfaMFhee6Fsl9s+BO5df
         3HN3rCo5e9Tanv1n+TNIf6mtd2x/uKLBjOGTUBoJEAIJIaO6uf3vrboWTpmCKAM403Ao
         18qjWzCNdeS7N8BHr/MqRO8w9e/s6wy8Yvbx118zTZUutiMKlgt+aM0Z081z+jebBXQD
         W/Dw==
X-Gm-Message-State: ACrzQf3VXfoqwiZOpvxUNkikLXU6gUBhFrTGRcoF2NnywkHRvTzYSXyg
        Evm36SM3NA0miCJLI5GntKBXOpvlML2cnw==
X-Google-Smtp-Source: AMsMyM7qGCD/STEWAff4ZPO0HT+K3gbOMPSfjIfewzxYZpeh/gLw5EY7QDydR4VFjd5SFId51TNT9Q==
X-Received: by 2002:a17:906:1c52:b0:7ad:c6c5:eae8 with SMTP id l18-20020a1709061c5200b007adc6c5eae8mr49118255ejg.439.1667961348884;
        Tue, 08 Nov 2022 18:35:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b0078c213ad441sm5335947ejb.101.2022.11.08.18.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 18:35:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
Date:   Wed,  9 Nov 2022 03:35:39 +0100
Message-Id: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "Migrating git directory" messages to avoid emitting
absolute paths. We could use "old_git_dir" and "new_gitdir.buf" here
sometimes, but not in all the cases covered by these tests,
i.e. sometimes the latter will be an absolute path with a different
prefix.

So let's just strip off the common prefix of the two strings, which
handles the cases where we have nested submodules nicely. Note that
this case is different than the one in get_submodule_displaypath() in
"builtin/submodule--helper.c" handles, as we're dealing with the paths
to the two ".git" here, not worktree paths.

Before this change we had no tests at all for this "Migrating git
directory" output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Something I hacked up a while ago, but which I'm prompted to send in
by [1] which added a test for this output, but did so with:

	+  cat >expect.err <<-EOF &&
	+  Migrating git directory of ${SQ}sub1/nested${SQ} from
	+  ${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/sub1/nested/.git${SQ} to
	+  ${SQ}/Users/chooglen/Code/git/t/trash directory.t7412-submodule-absorbgitdirs/.git/modules/sub1/modules/nested${SQ}

:)

Let's make this message a lot less verbose, and easier to test
instead.

1. https://lore.kernel.org/git/20221109004708.97668-2-chooglen@google.com/

 submodule.c                        |  8 +++++--
 t/t7412-submodule-absorbgitdirs.sh | 36 ++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/submodule.c b/submodule.c
index b958162d286..1f0032d183a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2274,6 +2274,7 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	size_t off = 0;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2298,9 +2299,12 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 		die(_("could not create directory '%s'"), new_gitdir.buf);
 	real_new_git_dir = real_pathdup(new_gitdir.buf, 1);
 
-	fprintf(stderr, _("Migrating git directory of '%s%s' from\n'%s' to\n'%s'\n"),
+	while (real_old_git_dir[off] && real_new_git_dir[off] &&
+	       real_old_git_dir[off] == real_new_git_dir[off])
+		off++;
+	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'\n"),
 		get_super_prefix_or_empty(), path,
-		real_old_git_dir, real_new_git_dir);
+		real_old_git_dir + off, real_new_git_dir + off);
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d2..a5cd6db7ac2 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -18,13 +18,19 @@ test_expect_success 'setup a real submodule' '
 '
 
 test_expect_success 'absorb the git dir' '
+	>expect &&
+	>actual &&
 	>expect.1 &&
 	>expect.2 &&
 	>actual.1 &&
 	>actual.2 &&
 	git status >expect.1 &&
 	git -C sub1 rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git fsck &&
 	test -f sub1/.git &&
 	test -d .git/modules/sub1 &&
@@ -37,7 +43,8 @@ test_expect_success 'absorb the git dir' '
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
 	test_when_finished "git submodule update --init" &&
 	git submodule deinit --all &&
-	git submodule absorbgitdirs &&
+	git submodule absorbgitdirs 2>err &&
+	test_must_be_empty err &&
 	test -d .git/modules/sub1 &&
 	test -d sub1 &&
 	! test -e sub1/.git
@@ -56,7 +63,11 @@ test_expect_success 'setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	Migrating git directory of '\''sub1/nested'\'' from '\''sub1/nested/.git'\'' to '\''.git/modules/sub1/modules/nested'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
@@ -87,7 +98,11 @@ test_expect_success 're-setup nested submodule' '
 test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >expect.1 &&
 	git -C sub1/nested rev-parse HEAD >expect.2 &&
-	git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	Migrating git directory of '\''sub1'\'' from '\''sub1/.git'\'' to '\''.git/modules/sub1'\''
+	EOF
+	git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	test -f sub1/.git &&
 	test -f sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
@@ -107,7 +122,11 @@ test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 test_expect_success 'absorbing the git dir fails for incomplete submodules' '
 	git status >expect.1 &&
 	git -C sub2 rev-parse HEAD >expect.2 &&
-	test_must_fail git submodule absorbgitdirs &&
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual &&
 	git -C sub2 fsck &&
 	test -d sub2/.git &&
 	git status >actual &&
@@ -127,8 +146,11 @@ test_expect_success 'setup a submodule with multiple worktrees' '
 '
 
 test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
-	test_must_fail git submodule absorbgitdirs sub3 2>error &&
-	test_i18ngrep "not supported" error
+	cat >expect <<-\EOF &&
+	fatal: could not lookup name for submodule '\''sub2'\''
+	EOF
+	test_must_fail git submodule absorbgitdirs 2>actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.38.0.1467.g709fbdff1a9

