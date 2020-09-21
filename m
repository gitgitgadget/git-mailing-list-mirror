Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D39C4727F
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A823A60
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ0uZvr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgIUWBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUWBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:01:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E15C0613CF
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k18so1062581wmj.5
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OGsfOc3S0PE/4vkc7IqrM3gcS0GA+iGg6M6p3MVsdaw=;
        b=VZ0uZvr1jQ8paJv3hJXwS3vieG/dnOGpatAix3V3EpBjksV1nxSBT2HHOcSxm6yBkE
         soNI3eEFJB4StwB5+u+TWTtMeBCrI6wro4IhnHQhgJ5IGL6V85+TxxbpotNy+WW1AerO
         I+gfafjWkswnmWzaOTs10zYEqwI6I8w6Xye24XSpfHNy1ewMRs0r72a+iKXNtjby3S4y
         8gmMMxRT5lrdx1Ik6zttNs/UtpxFWHUdXGYRlRI3b5DCtkIrqvVHnWnmGizMRPN7/0FD
         cvRxYwEPAchpKX4EgD7cGmqm3GbPtv+lRoNwuVsO1AOOxbTivUspCogCvB/Pbxzao4le
         va0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OGsfOc3S0PE/4vkc7IqrM3gcS0GA+iGg6M6p3MVsdaw=;
        b=AVoVKSkEJ715jxtjk5ptY4BSAMYpm/TRKaOe5kE9iu8PKKKvEDO0vNZr3/D8cC5pL0
         3ZmL4UnCLi7cg8GUVyz+GiXRHY4B+hPPNFIfoxPkepfzRy1SfQUPOTv2BxPZ2gQJT096
         p6ktLL9xxEUHyrM09efeWYoba6WduLU3Y/EK4VdBf/ico4HrWKo6r7dGtThjbyHxxdgR
         d5siV5gu90T9lPGdBpFKoMg0VHR+EiQRH0mhAnB0IPYgMtE9UF+zemZgETWH3sn13oYW
         q+Nv06G44392bUAZj03SmsxM0jqiPPthsAP7N1IvnCReJBYz4rdSJLHtaH/eWevWhjFF
         QJBg==
X-Gm-Message-State: AOAM532X1ED0WqE/uv7uHXt52cF7EET5sVTFlN+koqGwP+/6+1VjqzZQ
        PoXbf3pOYwDDPQDgIF89BAjQ1SOvykk=
X-Google-Smtp-Source: ABdhPJwAOUTYj5DoAoFYrLOXiVHaYhori2xXZa9XqiYzs1c1QYI1tfrRPo6BXaHiQpSaeiXQiiMRKg==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr1302014wmh.14.1600725691050;
        Mon, 21 Sep 2020 15:01:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm1360890wmi.37.2020.09.21.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 15:01:30 -0700 (PDT)
Message-Id: <8d8e9abfe2ad141a75ee54446393f8b54b1fb990.1600725687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com>
        <pull.734.v2.git.1600725687.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Sep 2020 22:01:24 +0000
Subject: [PATCH v2 3/5] t3200: avoid variations of the `master` branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To avoid branch names with a loaded history, we already started to avoid
using the name "master" in a couple instances.

The `t3200-branch.sh` script uses variations of this name for branches
other than the default one. So let's change those names, as
"lowest-hanging fruits" in the effort to use more inclusive naming
throughout Git's source code. While at it, make those branch names
independent from the default branch name.

In this particular instance, this rename requires a couple of
non-trivial adjustments, as the aligned output depends on the maximum
length of the displayed branches (which we now changed), and also on the
alphabetical order (which we now changed, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 4c0734157b..cc27e3bfdb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -234,10 +234,10 @@ test_expect_success 'git branch -M master master should work when master is chec
 	git branch -M master master
 '
 
-test_expect_success 'git branch -M master2 master2 should work when master is checked out' '
+test_expect_success 'git branch -M topic topic should work when master is checked out' '
 	git checkout master &&
-	git branch master2 &&
-	git branch -M master2 master2
+	git branch topic &&
+	git branch -M topic topic
 '
 
 test_expect_success 'git branch -v -d t should work' '
@@ -324,8 +324,8 @@ test_expect_success 'git branch --list -v with --abbrev' '
 test_expect_success 'git branch --column' '
 	COLUMNS=81 git branch --column=column >actual &&
 	cat >expect <<\EOF &&
-  a/b/c     bam       foo       l       * master    mb        o/o       q
-  abc       bar       j/k       m/m       master2   n         o/p       r
+  a/b/c    bam      foo      l      * master   n        o/p      r
+  abc      bar      j/k      m/m      mb       o/o      q        topic
 EOF
 	test_cmp expect actual
 '
@@ -346,13 +346,13 @@ test_expect_success 'git branch --column with an extremely long branch name' '
   l
   m/m
 * master
-  master2
   mb
   n
   o/o
   o/p
   q
   r
+  topic
   $long
 EOF
 	test_cmp expect actual
@@ -365,8 +365,8 @@ test_expect_success 'git branch with column.*' '
 	git config --unset column.branch &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
-  a/b/c   bam   foo   l   * master    mb   o/o   q
-  abc     bar   j/k   m/m   master2   n    o/p   r
+  a/b/c   bam   foo   l   * master   n     o/p   r
+  abc     bar   j/k   m/m   mb       o/o   q     topic
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
@@ -389,13 +389,13 @@ test_expect_success 'git branch -v with column.ui ignored' '
   l
   m/m
 * master
-  master2
   mb
   n
   o/o
   o/p
   q
   r
+  topic
 EOF
 	test_cmp expect actual
 '
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
+	git symbolic-ref refs/heads/topic refs/heads/master &&
+	test_must_fail git branch -m topic new-topic &&
+	git symbolic-ref refs/heads/topic &&
 	test_path_is_file .git/refs/heads/master &&
-	test_path_is_missing .git/refs/heads/master3
+	test_path_is_missing .git/refs/heads/new-topic
 '
 
 test_expect_success SYMLINKS 'git branch -m u v should fail when the reflog for u is a symlink' '
-- 
gitgitgadget

