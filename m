Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E41C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE6D206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW7SAKRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbgEKTqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731477AbgEKTqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD9C061A0E
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h17so3620011wrc.8
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WAvJwU/XeJRtWLWA3rNMorqhg/uR9TciG0No5VqYjE0=;
        b=VW7SAKRT8+SegF+oLjUUK+izZGaN5ziiCRNjtp+zmM0QAQvzBeu2qXNXWk+yCEuP3Q
         pCVbHdSPs90Q5meBbOYksZL7rsS12lmJV0KEbUe01Dz+Md4Lvjp+8lTlUCaXXOevkw4C
         YOh6lS2nK/UaadiQ/3J9EFQwc+GnogJyjGoYwsCvrfPBy3nLgkoWoOJ1/0OQ9+/7jZvO
         T20cE8Zs10Z1UlPsk4Tb0yE/6kEAsx4qyih0ZCZJvz1Dj9HjcKqKGf9fXlNmMogBafm2
         bT3hMjop14NHhLNaYbfbBYi5WMcwc1dM9x/JA9ZZy7BW2pPOr7y8NKgovslzmAg4zrKs
         GqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WAvJwU/XeJRtWLWA3rNMorqhg/uR9TciG0No5VqYjE0=;
        b=Zme9M1rYMFGCo9NQRQZiK//PN7It8YRi4tvLQ2GdhfWqNTfseffGF94NbG9f4pfdFh
         iSb+4I7gfo+2B1Vv3n9KtJbejuAqusTvoFY73r2LX6G9g7w2/6r/Gt7czyhFvgujUtsH
         QDhBjh6MjA3IGDO8lYOO0A2G7rUZeT3OJ2j3ty2LBpHmBiwfYBCg5O+klVP/mj4qEYF1
         GU0E0/qRXR+8Q5SOkk+Rlkx6TexZqREzFzNgSBLOQ+3QLv3bOx72Wx5H4a9hUZsq6WO4
         sZHWl4HHCH+iw2V246BF9lCIak82k7keLbBJdLEIQTO/pXGw6cBPizEi+/ii15VeBxKY
         nWxg==
X-Gm-Message-State: AGi0Pub+JQ8AnTOEP2MdTVCmI3dR6cVx8Gin3Lu0egZgJ1o7uX98K3DM
        rfDjr/mPva6330WVKRr561pcvWlD
X-Google-Smtp-Source: APiQypI4I8HtrtG7dUK3I/wg9Tv//p20uvMhY0MkyF3ueLbR/bHCwYlxiYssUkoClrZjW99eG2WprQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr17610929wru.321.1589226392183;
        Mon, 11 May 2020 12:46:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm19650852wrc.24.2020.05.11.12.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:31 -0700 (PDT)
Message-Id: <dbf45fe8753c5782f1d1d87d2da47bf72b086506.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:17 +0000
Subject: [PATCH v13 02/13] t: use update-ref and show-ref to reading/writing
 refs
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

