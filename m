Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5CCC433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A873020709
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBc4S/08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgETRgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRgR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73375C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w64so3756239wmg.4
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E3wQCJHorM0hJxQbaTJEi71HjkPDVlKdhmJhn7DA7d8=;
        b=dBc4S/08xoQR3r0MkV+AchMxZ3JkY6yjrBiP/oEbSmUR5vdlHbpRwflDfRkvGlH8AY
         iV5OOkL6zFb+VCjGiJCroCZVhmBPFJgLAZIfwpD0IYtvnzzpj/zLqwjDcAqbWxvBIOBv
         MMeU8GZaYwpIyYo7qqb8m2k8QlDzHCIHebqt6YQ8B37ybSuMg4gaITtkx7U9MCo9GecL
         wWqhpm21eW9TeU0ZlodK0CHdTDL7Am63ezFsNyMFUzAu+eQYhyhln0ZXbr6SUGpABJn4
         C1sDMyvnT3SiHbZ7tDFAscQbrOheu4lYsudJ+YYPzaMfp2VVzDPQ8u+aC+0ft3sSsylH
         +iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E3wQCJHorM0hJxQbaTJEi71HjkPDVlKdhmJhn7DA7d8=;
        b=cbXAjlL3upJLriiDric/e0Ga18Fn3ME0Mjv8eQnJ5399ak9ghtjAoPqA4DxR5LzOxL
         n3YwOVpl9yunXNHuxczzpbmUYJzbS4JcMwk0ILjtzQmWUUazxAZeXMlXxeQU5+My9s9E
         5xVjYkuHoZsGQs3QPKKaHxTWFcvDzMJbL3+CziGKpZocxH+vk+YqAWSPfRc2bFA1rNtP
         sRr0BUqGfMj574fJS1YQEgYtHqwGXHRGT4rDZ07jOC7hYkOov4VZgYy6azXEce4TloUX
         NhkMwBX6CHuiOTun2NReMPXdKRRw9kCvy3hd4UFGYEl9BC1g6xRb++SzpyacYSIkgHvm
         OMVA==
X-Gm-Message-State: AOAM530kSL6uFWxJn2fxuu194S3aoP3LIMbzATBxhFtIK/sCvFF9fGNH
        EFy5Tx5h7PpuSfIY6URkwbHA5oL+
X-Google-Smtp-Source: ABdhPJzCC5WZzK1hPdmyuhyUhhNUVUU1ZA0xqp870edmX9gLzVvBCv+QKA9nKOt9hxTa07GXhoft7w==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr5752983wme.165.1589996175554;
        Wed, 20 May 2020 10:36:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x24sm3741410wrd.51.2020.05.20.10.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:15 -0700 (PDT)
Message-Id: <3b363322b7dba8fc49c205bc9ac8717da1020350.1589996173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com>
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:08 +0000
Subject: [PATCH 2/6] t: use update-ref and show-ref to reading/writing refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Reading and writing .git/refs/* assumes that refs are stored in the 'files'
ref backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0002-gitfile.sh             |  2 +-
 t/t1400-update-ref.sh          | 32 ++++++++++++++++----------------
 t/t1506-rev-parse-diagnosis.sh |  2 +-
 t/t6050-replace.sh             |  2 +-
 t/t9020-remote-svn.sh          |  4 ++--
 5 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
index 0aa9908ea12..960ed150cb5 100755
--- a/t/t0002-gitfile.sh
+++ b/t/t0002-gitfile.sh
@@ -62,7 +62,7 @@ test_expect_success 'check commit-tree' '
 '
 
 test_expect_success 'check rev-list' '
-	echo $SHA >"$REAL/HEAD" &&
+	git update-ref "HEAD" "$SHA" &&
 	test "$SHA" = "$(git rev-list HEAD)"
 '
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e1197ac8189..27171f82612 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -37,15 +37,15 @@ test_expect_success setup '
 
 test_expect_success "create $m" '
 	git update-ref $m $A &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 test_expect_success "create $m with oldvalue verification" '
 	git update-ref $m $B $A &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "fail to delete $m with stale ref" '
 	test_must_fail git update-ref -d $m $A &&
-	test $B = "$(cat .git/$m)"
+	test $B = "$(git show-ref -s --verify $m)"
 '
 test_expect_success "delete $m" '
 	test_when_finished "rm -f .git/$m" &&
@@ -56,7 +56,7 @@ test_expect_success "delete $m" '
 test_expect_success "delete $m without oldvalue verification" '
 	test_when_finished "rm -f .git/$m" &&
 	git update-ref $m $A &&
-	test $A = $(cat .git/$m) &&
+	test $A = $(git show-ref -s --verify $m) &&
 	git update-ref -d $m &&
 	test_path_is_missing .git/$m
 '
@@ -69,15 +69,15 @@ test_expect_success "fail to create $n" '
 
 test_expect_success "create $m (by HEAD)" '
 	git update-ref HEAD $A &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 test_expect_success "create $m (by HEAD) with oldvalue verification" '
 	git update-ref HEAD $B $A &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "fail to delete $m (by HEAD) with stale ref" '
 	test_must_fail git update-ref -d HEAD $A &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "delete $m (by HEAD)" '
 	test_when_finished "rm -f .git/$m" &&
@@ -178,14 +178,14 @@ test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always'
 
 test_expect_success "create $m (by HEAD)" '
 	git update-ref HEAD $A &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 test_expect_success 'pack refs' '
 	git pack-refs --all
 '
 test_expect_success "move $m (by HEAD)" '
 	git update-ref HEAD $B $A &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "delete $m (by HEAD) should remove both packed and loose $m" '
 	test_when_finished "rm -f .git/$m" &&
@@ -255,7 +255,7 @@ test_expect_success '(not) change HEAD with wrong SHA1' '
 '
 test_expect_success "(not) changed .git/$m" '
 	test_when_finished "rm -f .git/$m" &&
-	! test $B = $(cat .git/$m)
+	! test $B = $(git show-ref -s --verify $m)
 '
 
 rm -f .git/logs/refs/heads/master
@@ -263,19 +263,19 @@ test_expect_success "create $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 test_expect_success "update $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:31" \
 	git update-ref HEAD $B $A -m "Switch" &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "set $m (logged by touch)" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:41" \
 	git update-ref HEAD $A &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 
 test_expect_success 'empty directory removal' '
@@ -319,19 +319,19 @@ test_expect_success "create $m (logged by config)" '
 	test_config core.logAllRefUpdates true &&
 	GIT_COMMITTER_DATE="2005-05-26 23:32" \
 	git update-ref HEAD $A -m "Initial Creation" &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 test_expect_success "update $m (logged by config)" '
 	test_config core.logAllRefUpdates true &&
 	GIT_COMMITTER_DATE="2005-05-26 23:33" \
 	git update-ref HEAD'" $B $A "'-m "Switch" &&
-	test $B = $(cat .git/$m)
+	test $B = $(git show-ref -s --verify $m)
 '
 test_expect_success "set $m (logged by config)" '
 	test_config core.logAllRefUpdates true &&
 	GIT_COMMITTER_DATE="2005-05-26 23:43" \
 	git update-ref HEAD $A &&
-	test $A = $(cat .git/$m)
+	test $A = $(git show-ref -s --verify $m)
 '
 
 cat >expect <<EOF
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 52edcbdcc32..dbf690b9c1b 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -207,7 +207,7 @@ test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
 	{
 		# we do not want to use rev-parse here, because
 		# we are testing it
-		cat .git/refs/heads/foobar &&
+		git show-ref -s refs/heads/foobar &&
 		printf "%s\n" --
 	} >expect &&
 	git rev-parse foobar -- >actual &&
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index e7e64e085dd..c80dc10b8f1 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -135,7 +135,7 @@ test_expect_success 'tag replaced commit' '
 test_expect_success '"git fsck" works' '
      git fsck master >fsck_master.out &&
      test_i18ngrep "dangling commit $R" fsck_master.out &&
-     test_i18ngrep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
+     test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_master.out &&
      test -z "$(git fsck)"
 '
 
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 6fca08e5e35..9fcfa969a9b 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -48,8 +48,8 @@ test_expect_success REMOTE_SVN 'simple fetch' '
 '
 
 test_debug '
-	cat .git/refs/svn/svnsim/master
-	cat .git/refs/remotes/svnsim/master
+	git show-ref -s refs/svn/svnsim/master
+	git show-ref -s refs/remotes/svnsim/master
 '
 
 test_expect_success REMOTE_SVN 'repeated fetch, nothing shall change' '
-- 
gitgitgadget

