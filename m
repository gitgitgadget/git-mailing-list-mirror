Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D909C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 06:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B706120D
	for <git@archiver.kernel.org>; Sat, 22 May 2021 06:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhEVG3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhEVG3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 02:29:52 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8507AC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 23:28:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 29so4864452pgu.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JEiPZ31gO8GPnWMaUd0IrlEibMZjBvBVVtcyySeG1U=;
        b=MrQ+jRNbKgelZbEZMlp8u2LVVqsM0eo7HJaQkssYjj7Dln4+aZVyyNla0Ma8wMTuO1
         99UVHNIa9QyxUw3WWKPnn3gpYgfsiGzQ9aMeqsLF09t49nfikxcVDzb0Qh2ExWrEK+NU
         1Jm++wwxFSpIdl2aVWCNPbXjplYamUxuj0ujjnJqLRp+9hteGoCS6ij9iJlP2X0kYk4k
         D9/q5jF1fhtVobJLW/HNmqYKavkg7S00ibY5PpsXtIu+pu6HGzEoPXrtXY6iKZK3kAB6
         iv+PW8z0bgRgKaOwbFNE5o2TmKSN3MkSmhwhDiwfCiLOmGwSU6IlXMIhBGWMgpU0ybH7
         H3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JEiPZ31gO8GPnWMaUd0IrlEibMZjBvBVVtcyySeG1U=;
        b=kjNfl8Xrpx9/a5UA9qxI9wv9AB3dzl78jXGooxSjSmYncRzgt+ot9qUnvu+axD9UOe
         uP//QUy9My+KZcW9wNT/uGPwWKEIMwF8TuATXF+JMDqM2Oj+QLuaVM+sMi4OKrqZGGUD
         o1UcCtuBIsA6f9/3L61gHq36LALcG537hueroDk3brGRiV8A/N6y8+/SWzGmdkvshoR2
         Px+XGHSkpwue7eVB4mfVUDJ9xWdKDF9OFAANIV3Y+i+uqxrHHT79lbq45X7eiaX9oqFn
         g+N8Y4XWwXlqv9pTyGmggGlM/h5h8Cwa+jIMW4nwUqMiCZmqFCTDz//LTPQpTX2CSjv6
         XDsw==
X-Gm-Message-State: AOAM533hu5kXVNKlTxddgYUNKMPLBKWOYQocYIH8sLO2/GfBLVWifSPc
        Tmm5PnuIAG5S1mQzZqFrQqmb7MYMV2UmAA==
X-Google-Smtp-Source: ABdhPJwQ4H7YBkYPDaWNa6rtI8Ln9Dmf4Z4JXNS/sIPU1EQd6ePog2sYJkULslsoVJR+Vh2Hr+Ka/w==
X-Received: by 2002:aa7:97ad:0:b029:2e0:26a8:8da5 with SMTP id d13-20020aa797ad0000b02902e026a88da5mr13731767pfq.37.1621664905815;
        Fri, 21 May 2021 23:28:25 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:812a:adcf:8995:bb0b:8236])
        by smtp.gmail.com with ESMTPSA id y66sm5948404pgb.14.2021.05.21.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 23:28:25 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] t: use configured TAR instead of tar
Date:   Sat, 22 May 2021 13:28:15 +0700
Message-Id: <20210522062815.17083-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.32.g107691cb07
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite that tar is available everywhere, it's not required by POSIX.
And, we're allow users to specify which tar they want to use in Makefile
knobs, and we prefer GNU tar in autotools script.

In our testsuite, 7 out of 9 tar-required-tests use "$TAR", the other
two use "tar".

Let's change the remaining two tests to "$TAR".

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 I found this when trying to remove tar from a chroot that used to test Git,
 such chroot has bsdtar, so I tried to set "TAR = bsdtar" in config.mak

 t/t3513-revert-submodule.sh | 4 ++--
 t/t6041-bisect-submodule.sh | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 74cd96e582..8bfe3ed246 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -14,7 +14,7 @@ test_description='revert can handle submodules'
 git_revert () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
+	"$TAR" cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	may_only_be_test_must_fail "$2" &&
 	$2 git checkout "$1" &&
 	if test -n "$2"
@@ -23,7 +23,7 @@ git_revert () {
 	fi &&
 	git revert HEAD &&
 	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+	"$TAR" xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index df1eff0fb8..82013fc903 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -8,7 +8,7 @@ test_description='bisect can handle submodules'
 git_bisect () {
 	git status -su >expect &&
 	ls -1pR * >>expect &&
-	tar cf "$TRASH_DIRECTORY/tmp.tar" * &&
+	"$TAR" cf "$TRASH_DIRECTORY/tmp.tar" * &&
 	GOOD=$(git rev-parse --verify HEAD) &&
 	may_only_be_test_must_fail "$2" &&
 	$2 git checkout "$1" &&
@@ -25,7 +25,7 @@ git_bisect () {
 	git bisect start &&
 	git bisect good $GOOD &&
 	rm -rf * &&
-	tar xf "$TRASH_DIRECTORY/tmp.tar" &&
+	"$TAR" xf "$TRASH_DIRECTORY/tmp.tar" &&
 	git status -su >actual &&
 	ls -1pR * >>actual &&
 	test_cmp expect actual &&
-- 
2.32.0.rc0.32.g107691cb07

