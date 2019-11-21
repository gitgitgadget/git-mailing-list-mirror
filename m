Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7389C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF63320878
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvbjlkcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKUAqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:46:25 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:36244 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfKUAqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:46:25 -0500
Received: by mail-pj1-f42.google.com with SMTP id cq11so630310pjb.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 16:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E7SjqG9ZEj6JTo82rPwwK2v/d9fpiw49U5srTM8skSo=;
        b=XvbjlkcN7g06xzKhcJDuENZwvrE2eAfICQWcl/RE/6RM0qn+fDSIoA14Wbw0m0q+mE
         8tBWJiZU1mdCThXzZUwgZc0gWNCYriCGe5DDwIRW5r8GXo6kiAJ0OzyOMS/I+Tora+6p
         SG0/Rr+EgUI2H6ZSde0sQ0EzPDl/EEV9nXvRibuAaQUoQJQHHuz0bX3A3MboWWrRzUHG
         5qO0yV7u4wJibRRYEURAQw1najPn4C+S2ZuabQxJCAGcy+n5yV0EjUPIHbhekcnMG50S
         IM0nIVjnmFfFdHvUAY5So1JGMNSm+VYoIdHKxsscvRTWv3MoglL+BX/o6PFjWW7btlef
         pz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E7SjqG9ZEj6JTo82rPwwK2v/d9fpiw49U5srTM8skSo=;
        b=E0N0hYN9g8iDyRemaZNIb94YSiZoc1jl4BPf2P+8cNdh0NJKo5Qm7qUeUT1L6CWyqj
         yLTdGdeCN7O9HUtLxjgcf3BIYOAuW3xdoeOlw+ST42xRYz9mynKSE20WgYnPtQi6T54f
         fvEFyQQZ6VqGBQ/vqi8K9FQoCMqbOFXgOA3+ztQn7z4OJ33wrhoap3sa/dDEsZPTnawL
         0sSqKE/7W4NvYv8L8xza+UIo/7hDR4bzTsOncfuVvMMVU8riVhojhoseSVA3fCgf6s4m
         Mh+gkUjnEXBbNn/aOXiNs+AbP5QIc4YHWBva3Mah7ifVDBn2P5dssFfu/vEOxww/bm8N
         3BYQ==
X-Gm-Message-State: APjAAAVYIycMmt9/n22j3x1WT7uA6cb8jvyimh6SggrIcUZiAPwhBLJX
        BCd6DmYBBSxxdpccAgeg0rQpTWUn
X-Google-Smtp-Source: APXvYqxB7f1ItuF4N1nZWb7aO1wGvCMNeY2hj72Tzke2l3WRgXCn0fzRI06esb0ZOrBpQfU2QYMcBg==
X-Received: by 2002:a17:902:9682:: with SMTP id n2mr5706258plp.336.1574297184127;
        Wed, 20 Nov 2019 16:46:24 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id x2sm394888pge.76.2019.11.20.16.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:46:23 -0800 (PST)
Date:   Wed, 20 Nov 2019 16:46:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 15/21] t7501: remove spaces after redirect operators
Message-ID: <63eebe1df6f7c0983cdbbf835ac2c42c84317158.1574296987.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
 <cover.1574296987.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574296987.git.liu.denton@gmail.com>
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
2.24.0.450.g7a9a4598a9

