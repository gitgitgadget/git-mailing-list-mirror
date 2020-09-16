Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB04C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1429D21655
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlNceXHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgIPSLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgIPSK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:10:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE2C06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:58 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a17so7871753wrn.6
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=taLM5yJC4q70gBaQS2BtCUXe5AzClQ56TFn++ZP02kk=;
        b=QlNceXHF67znrNKRIDUDDfhxtSc2yDCxNLwaGZlr1zIu6iyC1AGUWdp2u0Xv/q3/0+
         Pee6NFE8ClZoYJHrc2OH8yBCaTpkq1u7E+WGHpJrTJDLmO86NBmISJea2qqUw+/grhIZ
         ctdlxk1DVbyIEZXfXXJJWj643cgmd4/XoBsslNYREq+GHq0l6EXEz9+iBNTSygifjLqp
         AxkPLSOKcuWq7mXdNtm4LBVquiovv8SbdWfFQcKCTfcjqWcRMXHgT0dBJhW4poN1pypY
         WKAKu7oFEtRuVuO7bg6IGTGktJDG4P/ig4s+tZEpddkW+ye6rHRj10O5nHaXCmnvM1ad
         bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=taLM5yJC4q70gBaQS2BtCUXe5AzClQ56TFn++ZP02kk=;
        b=TEHhH2IBAvs4EA0i3A3BVpJ9FefuIJugGvUsNpayrjxWEbgODzYitSnfgAXyqSS7h6
         YXUczIpCtOORn4JG8rzVj+UZOzUdGJUptrBTNv+3iwR6rtqUrpSSfJCfBV+9p2cT2B4M
         DjGHHI9NuxcAPRycaGcPtb/Fo86ZXdpuUMxu2JgD9qE/zsZDZWtSthQ/noFcFHK3gFrP
         nN7/naypfu8dLq3LgYhZ+c8NbhoEWdj8Tf2FfaB5tW6xLPNS7WzzodZmyFKkl0DkIjM6
         lsNrfTuPQtca10lMpOju/eDtC71xMMDRESHaTU4RDcSeTlXfoaQAwEsd7K8dblu2bQNQ
         Qr5g==
X-Gm-Message-State: AOAM530P3qkDqNtysdaPNi7uUUyt43oarmlVsaIBPiRQcDC7QVavVW5j
        sJgwPazbm39zuXlCDgGpliqyvJLg9w0=
X-Google-Smtp-Source: ABdhPJyoIw0nLlFy6+xIH1JlfHURIXWnbneW+ShNrCzBvAYCJc6k6eSFZ4TIOVrjSkYzSXBrV6GG6w==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr27634454wrr.406.1600279856702;
        Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a83sm6664734wmh.48.2020.09.16.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:10:56 -0700 (PDT)
Message-Id: <2f1d0a2df41f567bc1a8bc446c26e1cb8b6dc36c.1600279853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.git.1600279853.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 18:10:51 +0000
Subject: [PATCH 3/5] t3200: avoid variations of the `master` branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To avoid branch names with a loaded history, we already started to avoid
using the name "master" in a couple instances.

The `t3200-branch.sh` script uses variations of this name for branches
other than the default one. So let's change those names, as
"lowest-hanging fruits" in the effort to use more inclusive naming
throughout Git's source code.

In this particular instance, this requires a couple of non-trivial
adjustments, as the aligned output depends on the maximum length of the
displayed branches (which we now changed), and also on the alphabetical
order (which we now changed, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4c0734157b..c1b881c0b8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -234,10 +234,10 @@ test_expect_success 'git branch -M master master should work when master is chec
 	git branch -M master master
 '
 
-test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
+test_expect_success 'git branch -M main2 main2 should work when master is checked out' '
 	git checkout master &&
-	git branch master2 &&
-	git branch -M master2 master2
+	git branch main2 &&
+	git branch -M main2 main2
 '
 
 test_expect_success 'git branch -v -d t should work' '
@@ -324,8 +324,8 @@ test_expect_success 'git branch --list -v with --abbrev' '
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
-  a/b/c     bam       foo       l       * master    mb        o/o       q
-  abc       bar       j/k       m/m       master2   n         o/p       r
+  a/b/c    bam      foo      l        main2    mb       o/o      q
+  abc      bar      j/k      m/m    * master   n        o/p      r
 EOF
 	test_cmp expect actual
 '
@@ -345,8 +345,8 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   j/k
   l
   m/m
+  main2
 * master
-  master2
   mb
   n
   o/o
@@ -365,8 +365,8 @@ test_expect_success 'git branch with column.*' '
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
-  a/b/c   bam   foo   l   * master    mb   o/o   q
-  abc     bar   j/k   m/m   master2   n    o/p   r
+  a/b/c   bam   foo   l     main2    mb   o/o   q
+  abc     bar   j/k   m/m * master   n    o/p   r
 EOF
 	test_cmp expect actual
 '
@@ -377,7 +377,7 @@ test_expect_success 'git branch --column -v should fail' '
 
 test_expect_success 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
-	COLUMNS=80 git branch -v | cut -c -10 | sed "s/ *$//" >actual &&
+	COLUMNS=80 git branch -v | cut -c -9 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
@@ -388,8 +388,8 @@ test_expect_success 'git branch -v with column.ui ignored' '
   j/k
   l
   m/m
+  main2
 * master
-  master2
   mb
   n
   o/o
@@ -597,10 +597,10 @@ test_expect_success 'git branch -C master master should work when master is chec
 	git branch -C master master
 '
 
-test_expect_success 'git branch -C master5 master5 should work when master is checked out' '
+test_expect_success 'git branch -C main5 main5 should work when master is checked out' '
 	git checkout master &&
-	git branch master5 &&
-	git branch -C master5 master5
+	git branch main5 &&
+	git branch -C main5 main5
 '
 
 test_expect_success 'git branch -C ab cd should overwrite existing config for cd' '
@@ -711,11 +711,11 @@ test_expect_success 'deleting a self-referential symref' '
 '
 
 test_expect_success 'renaming a symref is not allowed' '
-	git symbolic-ref refs/heads/master2 refs/heads/master &&
-	test_must_fail git branch -m master2 master3 &&
-	git symbolic-ref refs/heads/master2 &&
+	git symbolic-ref refs/heads/main2 refs/heads/master &&
+	test_must_fail git branch -m main2 main3 &&
+	git symbolic-ref refs/heads/main2 &&
 	test_path_is_file .git/refs/heads/master &&
-	test_path_is_missing .git/refs/heads/master3
+	test_path_is_missing .git/refs/heads/main3
 '
 
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
-- 
gitgitgadget

