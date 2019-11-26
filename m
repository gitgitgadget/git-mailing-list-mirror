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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147DCC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63A42068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0IMkENs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKZBS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:29 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43213 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKZBS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:28 -0500
Received: by mail-pg1-f179.google.com with SMTP id b1so8093179pgq.10
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5J2Kfgd0IMTB5KtGw7AQr8y2Occ9OOTYJigPQz2KI7w=;
        b=W0IMkENsBRz0SLEjuFCmKqzmX96zxAmeJmG/ftzYQ/SxKrnos6Isezbvw3pY9o8/t3
         9ImllhEoP4KtGndvFZc54kS9UATMU4D9+za5D21Jw7R4OTXBHx3+m3tkLUkz3wQtDKP/
         4qdsS64jVS3vuYPHkMhGDUEtAKVh68rCDbFNEazGEibRGVOW7C0Wo44c33B+FQHzKZWn
         NuSaZMSXGRP5c69qQ5tUxeJ77ww+HZXI5gQR0ON6rqKSlLE57j+PLXoPFGy3APWo7Coc
         c+cDHew8f7/EV1kx4C8AoSdx7pwfjwlbKy62JzbY1RM/e7yBEYONnyihcTigKKpgFhlC
         gW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5J2Kfgd0IMTB5KtGw7AQr8y2Occ9OOTYJigPQz2KI7w=;
        b=D5EDcCl/ihZdyDpcP49TYqV1GitXpF5u5IdFTUTcdmD8JgUTISxgZY5vb/7dYwAsOA
         GOo4FLitlUjSaK2Q+FalWAqcIQJ3M+2x87o0p8xNOfKbbm7Rcd4xja7+Y6zZFsi6iZuz
         PSwqQeUEfycJJZc4t7I8hhbJXHSwOnMGq6GLMyK1zLt8WXHCY9IJ5CudjwuF7cxLDgV+
         sLQ8CPtCcdDQnSsUbMbWPrw4U3PdTiUAF1adSYZ9Bh87N/r6R4blw7YauhCAhN/ng+hL
         FWiaTv/aoUP98ja3P7SCRbG4SoHKGWre18YJ60uIAxtm00VdEZUjJct9tu+INiVUX3sv
         FzEQ==
X-Gm-Message-State: APjAAAWfXnj1qBGaavRTTkfBVFjPxVCHWXpCgOYxdMcwbu1QVYuRb2Mr
        38DenTHp3FyZkjbq0dWoRQTTh6IY
X-Google-Smtp-Source: APXvYqwu08ODi7XSWkvuX3HK7yi3fudH41ZgkIHGRQaLhjAidLorM9ipEus179An5qg5eptodO6Qlw==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr38133912pfo.30.1574731107582;
        Mon, 25 Nov 2019 17:18:27 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id u24sm9865973pfh.48.2019.11.25.17.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:26 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:25 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 17/27] t7501: stop losing return codes of git commands
Message-ID: <bad732adc8067804bb35e46026ddcf736c4eb2ce.1574731022.git.liu.denton@gmail.com>
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

In a pipe, only the return code of the last command is used. Thus, all
other commands will have their return codes masked. Rewrite pipes so
that there are no git commands upstream so that we will know if a
command fails.

In the 'interactive add' test case, we prepend a `test_must_fail` to
`git commit --interactive`. When there are no changes to commit,
`git commit` will exit with status code 1. Following along with the rest
of the file, we use `test_must_fail` to test for this case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 69 +++++++++++++++------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 5765d33c53..110b4bf459 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -285,9 +285,8 @@ test_expect_success 'overriding author from command line' '
 '
 
 test_expect_success PERL 'interactive add' '
-	echo 7 |
-	git commit --interactive |
-	grep "What now"
+	echo 7 | test_must_fail git commit --interactive >out &&
+	grep "What now" out
 '
 
 test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
@@ -362,10 +361,10 @@ test_expect_success 'amend commit to fix author' '
 	oldtick=$GIT_AUTHOR_DATE &&
 	test_tick &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $oldtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -377,10 +376,10 @@ test_expect_success 'amend commit to fix date' '
 	test_tick &&
 	newtick=$GIT_AUTHOR_DATE &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $newtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --date="$newtick" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -409,12 +408,13 @@ test_expect_success 'sign off (1)' '
 	echo 1 >positive &&
 	git add positive &&
 	git commit -s -m "thank you" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo thank you &&
 		echo &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 
@@ -428,13 +428,14 @@ test_expect_success 'sign off (2)' '
 	git commit -s -m "thank you
 
 $existing" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo thank you &&
 		echo &&
 		echo $existing &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 
@@ -448,13 +449,14 @@ test_expect_success 'signoff gap' '
 	git commit -s -m "welcome
 
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo welcome &&
 		echo &&
 		echo $alt &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 '
@@ -468,15 +470,16 @@ test_expect_success 'signoff gap 2' '
 
 We have now
 $alt" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo welcome &&
 		echo &&
 		echo We have now &&
 		echo $alt &&
 		echo &&
-		git var GIT_COMMITTER_IDENT |
-		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /"
+		git var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
 	) >expected &&
 	test_cmp expected actual
 '
@@ -489,7 +492,8 @@ test_expect_success 'signoff respects trailer config' '
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -506,7 +510,8 @@ Myfooter: x" &&
 
 non-trailer line
 Myfooter: x" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo subject &&
 		echo &&
@@ -538,7 +543,8 @@ test_expect_success 'multiple -m' '
 	>negative &&
 	git add negative &&
 	git commit -m "one" -m "two" -m "three" &&
-	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit HEAD >commit &&
+	sed -e "1,/^\$/d" commit >actual &&
 	(
 		echo one &&
 		echo &&
@@ -555,10 +561,10 @@ test_expect_success 'amend commit to fix author' '
 	oldtick=$GIT_AUTHOR_DATE &&
 	test_tick &&
 	git reset --hard &&
-	git cat-file -p HEAD |
+	git cat-file -p HEAD >commit &&
 	sed -e "s/author.*/author $author $oldtick/" \
-		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" > \
-		expected &&
+		-e "s/^\(committer.*> \).*$/\1$GIT_COMMITTER_DATE/" \
+		commit >expected &&
 	git commit --amend --author="$author" &&
 	git cat-file -p HEAD >current &&
 	test_cmp expected current
@@ -570,8 +576,10 @@ test_expect_success 'git commit <file> with dirty index' '
 	echo tehlulz >chz &&
 	git add chz &&
 	git commit elif -m "tacocat is a palindrome" &&
-	git show --stat | grep elif &&
-	git diff --cached | grep chz
+	git show --stat >stat &&
+	grep elif stat &&
+	git diff --cached >diff &&
+	grep chz diff
 '
 
 test_expect_success 'same tree (single parent)' '
@@ -584,7 +592,8 @@ test_expect_success 'same tree (single parent)' '
 test_expect_success 'same tree (single parent) --allow-empty' '
 
 	git commit --allow-empty -m "forced empty" &&
-	git cat-file commit HEAD | grep forced
+	git cat-file commit HEAD >commit &&
+	grep forced commit
 
 '
 
-- 
2.24.0.504.g3cd56eb17d

