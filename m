Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA5DC43215
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864122068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhJA8ZnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfKZBS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:26 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40528 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKZBS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:26 -0500
Received: by mail-pf1-f180.google.com with SMTP id i187so4128609pfc.7
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vH2YiKkHoEktTT4rNpGzF4Qp9y3oAMQj3787bOmrsp0=;
        b=lhJA8ZnOxGJokLYwarWUwyui0GkqVZwjI4y6qPKlIh++QJbRMMc7q2+9cTBbF+iAkm
         vx8rwumkJjDjihX38zkrjBpNfk1A9KPVsWWM1G6ruyLRphoCxPOe2eD6TH5TFhjBdg1t
         8oRIa8e9io+3y/CK2cvYGxWYHlfjuD8UxqohigbrFn86MWTfrZESger3p299mXwjZaLI
         4+Hb3POlvBhBa72IqP+zEuPXA98uV8uidaWlocYR1bXzV1MMP5k7O6QchC9AZQg6IHBj
         U6HlWNSOtRpwEevsaNT7T4j1pVLcLKxBL5G56L1QSHQj22940q6JVami+7N6EfM8V79x
         2GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vH2YiKkHoEktTT4rNpGzF4Qp9y3oAMQj3787bOmrsp0=;
        b=foIKnioR/ygLPg1bB+/GcVexgLvF8ws+XPspQxMFgc2tRHZzoeBfT0d59wTY0UKxt9
         ZZ6+iytBUrUzVF0qpuT2g6jtulVmog9SbcodNfUisQut8+0Uy8PFB4K8TzSkTBgBUuUA
         yvQV/8Xjkk2BsH/woPwnQh83Kaq7EJ+jKy1l9MXkSe+YZUd6d0U70f7+ssNqGRY3f8zD
         3dpRhiZCD0KDdY3R1TI7Fr599rvJJQgmJueUtVeXP651miGdV07ZjzYFsKfMcoGCm5rg
         tnx7yDNhzDJPjvTVMEcGjDyqlaKfrU+bCtFyA/oTXU7zGXtbq3TZbnwn5/tqCvXwXcUN
         M6GQ==
X-Gm-Message-State: APjAAAWKi+ptQZDigIGPgyEV5/J8kmM+CQgOdFbf/0+BIDt/h8P4o65g
        Xum7IKYZIGf5U3kytC3/FcW840+9
X-Google-Smtp-Source: APXvYqzkuRLTrqb3YOBacB1ffhNM/1dxeLvWGfcas9Sw29UQal8oIY3VO+ela24OYmZhVR4QDxBKpQ==
X-Received: by 2002:aa7:8216:: with SMTP id k22mr18658580pfi.149.1574731105246;
        Mon, 25 Nov 2019 17:18:25 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id y81sm10057559pfb.178.2019.11.25.17.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:24 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:23 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 16/27] t7501: remove spaces after redirect operators
Message-ID: <5eb7117fbef4c39aecbdbd25c9e1f0a637c4b0de.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
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

