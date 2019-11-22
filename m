Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29107C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C32071C
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU4q6TEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKVTA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:26 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:41954 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:25 -0500
Received: by mail-pg1-f172.google.com with SMTP id 207so3730808pge.8
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9YdAX4TIwsHHj9lQ5ilIYWWQd50vgw03XRlmF/athw=;
        b=mU4q6TEh3/PNwP1ukbbnClHu1m/cHCDS4bXN+/IdeyN6z+tUt0/prlXk8BQmXaUYNZ
         m9y5tDPdxfIdXNg4ocdTU8aa35FADXloXoXdj6NmAj7h++0lj8gYreoe3uU7qSOdvbpK
         LatF8cb8VXWonztUdGQeZq0P5pz2kp3TXuMUXc873YQIgEPKqjZwot80nUnH1oTTRD0O
         zd28RbZufOrNRP5WvUA5Q4vRBE6nZNpSGtUCMYJrXGfXDaa4Wc/R1lfui/LOYC6T/t0d
         kmPGRLXmDdmy782NDYU6yltOlNfrjolgtQIPdXVNTDlVXSFtdVJ9ZBqM7qnKXehk6QKZ
         ivQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9YdAX4TIwsHHj9lQ5ilIYWWQd50vgw03XRlmF/athw=;
        b=qeEQDjp9nJgVCF2D137sU/MKrispdSSZ6WO5WY1S8O31iTCsS5/gOlCWlBX47zCieo
         PJwqqFhzj2VGK4XF+w2W2+QD+3WYt26Zuu0ubvMhW65vowYytzj1v3MUcrAiPpYxYyL7
         FsKeriA1ol4t9VOgrfPd3EZivlVQ+wWcazX79/bYCws6GcF/VTjjgZY7BnHyMvY/8l/P
         FuvkR/WGyOJXiFF+XHg6JHroP5QovHqt/jjsfCMq7pM8a9XRrKDAkOgFgYOZakZcMsAt
         OB6nG2Jich3lzpTG1gvQiZBO9H1yQJ+7KeTY5kPd7tF/wqt7ys11QdWiVuPJF/aPtJVR
         dMcg==
X-Gm-Message-State: APjAAAX/sjWjOZ1ezdNzo9fnOzoaiPtpia61EcFWDf/xoX1CK4GgY57n
        DQZLz3iqdb1YpL7CzIKfRi6/+idt
X-Google-Smtp-Source: APXvYqwYqYfSylXoeq9IuGnqy/77srtkcNamo/MjpnXSAv0XDN1nHfN9ey4spfCLQRaBSH8OiBCu5g==
X-Received: by 2002:a62:2b55:: with SMTP id r82mr18810012pfr.56.1574449223392;
        Fri, 22 Nov 2019 11:00:23 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id v14sm8196396pfe.94.2019.11.22.11.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:22 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 16/22] t7501: remove spaces after redirect operators
Message-ID: <082496570716db89c79718171249975b26146518.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
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
2.24.0.497.g17aadd8971

