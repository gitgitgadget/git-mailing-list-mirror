Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F38CC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D5D2083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KadvGrmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEGKAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726572AbgEGKAC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 06:00:02 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE3BC0610D5
        for <git@vger.kernel.org>; Thu,  7 May 2020 03:00:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e26so5761896wmk.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 03:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WAvJwU/XeJRtWLWA3rNMorqhg/uR9TciG0No5VqYjE0=;
        b=KadvGrmKVXCnnY7FSDjq9YVlsn+Ge8FL5p+YUqPDmztYfCDpl/Mu11TS0LCGJME+9R
         9/ABB5qsX53jUAOgmj/AQqGWa5CDe4Q3X/LWMr5G2VAYVDz6hSTijsH9j59IfTYOii+E
         uGYISaa/HtkeiUl2rgBp37I7HAudd4sgsqaezXfTu0y3JaTjXSBmui6QkS0sxQXGaghM
         GeDjj1FGn8a1ycOpAI0tpj9LpzGRKZELWLXKW+KknwBzhKx45gskcymv/oFly4SafPA1
         Zhoa/pG64vrknczF7khdHz+vHvMFpdbrOMEcFkgxuN85RuCmjFiySR8tXYQ9gu2XhNm7
         VOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WAvJwU/XeJRtWLWA3rNMorqhg/uR9TciG0No5VqYjE0=;
        b=LkoxWBF1JAyFpyWJB/HxQ8msk8igEWa5zGOkFmbthPJxTV1jochcc6la7LR67YgIZE
         bSdxoS0YnE71f2KipyP7vXaaVEKWRhEJL9dp+zvETYULSuF59ItUQKnPZwiLju6X+R+E
         jsbhMgTGOJvl1jnFEFeNTZKLQy56F57FH0NI6uNrBVhDr/WISPgo+PULlcduBtSY6dJ/
         H69Uz17Cxlj7oeqs7XpkXW/gcVcux1i7mFnmlCnN1yaOaKP9ykwMjX27S4drzGl0JZvv
         n4SiAyalCKFTqdR/RyATCFeWXTOUA+riGdJ1QDTlUC7XgibpnAST5BW6oox9YdsK/brk
         jRgg==
X-Gm-Message-State: AGi0PubLux+0+VnGcZ4AxsABK3yyiQ5lGQUoAW3ERPB9Bk0T8Kpoc/2X
        pV+LxN9fDu+VLqOCdPOn9dwL5MaD
X-Google-Smtp-Source: APiQypLspxSluQBolsrB+J/OmNc/0BkhihFHfAa3MmPI4/aBS3dcKJhbYsruzowCifOlDE1mHUnyzg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr9319200wmd.119.1588845600532;
        Thu, 07 May 2020 03:00:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16sm4335769wrv.62.2020.05.07.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:59 -0700 (PDT)
Message-Id: <2abcbd1af99e7d465c52c4a187c24ec1d6f557a2.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:44 +0000
Subject: [PATCH v12 11/12] t: use update-ref and show-ref to reading/writing
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

