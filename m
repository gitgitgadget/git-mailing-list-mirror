Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0737C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B806C20637
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWYtY0HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfK0Txo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:44 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43617 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Txn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so11447194pgq.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vH2YiKkHoEktTT4rNpGzF4Qp9y3oAMQj3787bOmrsp0=;
        b=kWYtY0HHj9sCpliIlb8m4s8R1qb9Z5lwmwdJH9Xt0Ml0pVpPjFPi8XfV7ENfXDroJ1
         AnylJLjo9QSShXR9DvLyBvzPIYQbnABpHBBzmhOIeveW8ucdnsoyBQ9meG0cYXPx+fpF
         AcywPxugCcuY044tfFM9vOVS9hdb2BAhk347D6CXwsa8pTocgGHMqvCUKSNOtFRxabl+
         o08enGtmVZ5N3aL9vNlyydMKHWwwixqCjDb1UmB3aB+0W8/SvDY8QO1djL8KG4Ke1ynS
         1xys/U6Mu/KA7inGdtZu+ruJp4+BtJFwYl2P+e9EDQFb3RG36AVeM/nThZLf1QkCuCwj
         x/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vH2YiKkHoEktTT4rNpGzF4Qp9y3oAMQj3787bOmrsp0=;
        b=hOAEPVH7M47A96v6QZmLKxsZfSiK7vImb2Rf5kShZ5DSZEm/0uYLhiT7Du2TqGMkCI
         LnS/ADMRMpj4vA1AGX5LgVyOkvDpXcdvWv3rHz/WDHz2XJIoZ7KrHdzjeR00nwK7B4Fc
         lLuc3v6qg5XPARQQGwlzymQZfofdyE4JQScPZ8ci5230VHm0Fk7woIX2rGx81qk/gO5q
         sxxUWzkxvYPvM9le6a7v1cgos+qajte6J03wC3mt6N7zhKi1pkVn9FLqUNHY8EXUaM/e
         NvsbUQmg4cGeiM3l/xCpPE+ERz2GxWbnym3zVYTb8nCrJBoHClJxEhojlN9dTyGrqvkR
         x/Sg==
X-Gm-Message-State: APjAAAX5n+q7U5aFB9DmUM3JuVSKi34Pc7aCqhueU4s9JZQufhVitneR
        ZX/ucJYE0Os5cL3jJe51zsCtFvzv
X-Google-Smtp-Source: APXvYqwwWSHGDG0vyYrX3E8V8bSuwPADTiIA2ltLetBeynvinAnOIvnLhuTx0P9NVghJx+E21RwdPw==
X-Received: by 2002:a63:fa0d:: with SMTP id y13mr6842015pgh.18.1574884422845;
        Wed, 27 Nov 2019 11:53:42 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id j14sm4198104pgs.57.2019.11.27.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:42 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:40 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 16/26] t7501: remove spaces after redirect operators
Message-ID: <5eb7117fbef4c39aecbdbd25c9e1f0a637c4b0de.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index f1349af56e..5765d33c53 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -150,7 +150,7 @@ test_expect_success 'setup: commit message from file' '
 test_expect_success 'amend commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-	sed -e "s/a file/an amend commit/g" < "$1" > "$1-"
+	sed -e "s/a file/an amend commit/g" <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 	chmod 755 editor &&
@@ -263,7 +263,7 @@ test_expect_success 'using message from other commit' '
 test_expect_success 'editing message from other commit' '
 	cat >editor <<-\EOF &&
 	#!/bin/sh
-	sed -e "s/amend/older/g"  < "$1" > "$1-"
+	sed -e "s/amend/older/g"  <"$1" >"$1-"
 	mv "$1-" "$1"
 	EOF
 	chmod 755 editor &&
@@ -367,7 +367,7 @@ test_expect_success 'amend commit to fix author' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --author="$author" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
@@ -382,7 +382,7 @@ test_expect_success 'amend commit to fix date' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --date="$newtick" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
@@ -448,7 +448,7 @@ test_expect_success 'signoff gap' '
 	git commit -s -m "welcome
 
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -468,7 +468,7 @@ test_expect_success 'signoff gap 2' '
 
 We have now
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo welcome &&
 		echo &&
@@ -489,7 +489,7 @@ test_expect_success 'signoff respects trailer config' '
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -506,7 +506,7 @@ Myfooter: x" &&
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -560,14 +560,14 @@ test_expect_success 'amend commit to fix author' '
 		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
 		expected &&
 	git commit --amend --author="$author" &&
-	git cat-file -p HEAD > current &&
+	git cat-file -p HEAD >current &&
 	test_cmp expected current
 
 '
 
 test_expect_success 'git commit <file> with dirty index' '
-	echo tacocat > elif &&
-	echo tehlulz > chz &&
+	echo tacocat >elif &&
+	echo tehlulz >chz &&
 	git add chz &&
 	git commit elif -m "tacocat is a palindrome" &&
 	git show --stat | grep elif &&
-- 
2.24.0.504.g3cd56eb17d

