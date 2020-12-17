Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05FAC2BBCA
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A4322D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbgLQBIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731327AbgLQBIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8261C0611C5
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so24912607wra.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Dw8457Xlfc/LyDER7Al275oh3wmJpBK9ZNA6HHjSEa0=;
        b=pwXvdH3hLW6sMlLJqTCZnChm1Awxjfln7+G12HL4l/sykS74sSG3+O2gVDtcVoKeYj
         HWdK3ii9TovJ0TJdjR3/O7TvRCVIlK8oe4Yt8/69GqTCqaIDtiFLG/VLJNl25scclqX0
         nAtDjIe8tm3dBjHCmexEogotX3z1/1Ivdq+pni91a5wqRuVmQdWTVFXEV0Rhn/PkY74z
         e1T/ZbOR1EmWcwf0ot8lQpLle/bOz4gYXohIbpPPI84i8+xctOecMnKyYgLx/K2j3tpl
         NjJAhL4nsTeSoJSV/eDREmu+DyCWCYsvv0SjrmBOCjqS+1FjS+aI0PRc64wft3iX9XRt
         B9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Dw8457Xlfc/LyDER7Al275oh3wmJpBK9ZNA6HHjSEa0=;
        b=jrZtLfy9RGwW5GYQXHgNzYHGHZ3KYjSOElQdoer1BpJAJUvcyht+5plsdSIMikIQLU
         beKrDJy2JhOIKgC6VI+3n16qu+kLRWEL85onMW9ZS4Y3/eCuIywufGnyW0Nkd1j/2Fhq
         k9kQLzQX2ZuWRVWtagFetAuVnIi8oqJOBZzJxrYQB32jTMoL6ig7tFFaRJ0lMi7t9tnb
         9gW/a2DB2PmKoDhdF69tQc0cEHkJsn0eeGHEau7NyBnZJNFkQhhRV2oqvm/7wjNWuP8U
         GGICXBsYtaPKox5pGXq9SMMRT2/A/OH882ewBrpP5nHq0RP6lEogzu2lpwYcrbhPvd51
         wIQw==
X-Gm-Message-State: AOAM531stU+frMLdHV01vrzrDdOqZzF5w/fDnCqb+k1iUMmUqFOSmlao
        5tueE9Y+mH+vGsDBPw8UoxZZaDl0CFU=
X-Google-Smtp-Source: ABdhPJy1UjXC7GpkyIzBHzy6+ZkLP9sZZbXy8nUivZ9TXXaRM5+rOlW9mesmluAbSqmQ8HD30GJY/Q==
X-Received: by 2002:adf:a29d:: with SMTP id s29mr40386108wra.272.1608167239399;
        Wed, 16 Dec 2020 17:07:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm5896414wra.94.2020.12.16.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:18 -0800 (PST)
Message-Id: <ac494c4431cf1fc77bb93a9753a30e5aa65731ed.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:08 +0000
Subject: [PATCH 09/11] t6302: use `main` as initial branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 66713e84e71 (tests: prepare aligned mentions of the default branch
name, 2020-10-23), we started adjusting this test script for the default
initial branch name changing to `main`.

However, there is no need to wait for that: let's adjust the test script
to stop relying on a specific initial branch name by setting it
explicitly. This allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq
from six test cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6302-for-each-ref-filter.sh | 59 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 0a21669f56d..9b8c8b2842f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -7,6 +7,7 @@ test_description='test for-each-refs usage of ref-filter APIs'
 
 test_expect_success 'setup some history and refs' '
 	test_commit one &&
+	git branch -M main &&
 	test_commit two &&
 	test_commit three &&
 	git checkout -b side &&
@@ -26,17 +27,17 @@ test_expect_success 'setup some history and refs' '
 	git tag $sign -m "A signed tag" signed-tag &&
 	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
 
-	git checkout master &&
-	git update-ref refs/odd/spot master
+	git checkout main &&
+	git update-ref refs/odd/spot main
 '
 
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/odd/spot
 	refs/tags/three
 	EOF
-	git for-each-ref --format="%(refname)" --points-at=master >actual &&
+	git for-each-ref --format="%(refname)" --points-at=main >actual &&
 	test_cmp expect actual
 '
 
@@ -53,13 +54,13 @@ test_expect_success 'check signed tags with --points-at' '
 
 test_expect_success 'filtering with --merged' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/odd/spot
 	refs/tags/one
 	refs/tags/three
 	refs/tags/two
 	EOF
-	git for-each-ref --format="%(refname)" --merged=master >actual &&
+	git for-each-ref --format="%(refname)" --merged=main >actual &&
 	test_cmp expect actual
 '
 
@@ -72,13 +73,13 @@ test_expect_success 'filtering with --no-merged' '
 	refs/tags/four
 	refs/tags/signed-tag
 	EOF
-	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	git for-each-ref --format="%(refname)" --no-merged=main >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'filtering with --contains' '
 	cat >expect <<-\EOF &&
-	refs/heads/master
+	refs/heads/main
 	refs/heads/side
 	refs/odd/spot
 	refs/tags/annotated-tag
@@ -113,7 +114,7 @@ test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
+test_expect_success 'left alignment is default' '
 	cat >expect <<-\EOF &&
 	refname is refs/heads/main    |refs/heads/main
 	refname is refs/heads/side    |refs/heads/side
@@ -131,7 +132,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'left alignment is default' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
+test_expect_success 'middle alignment' '
 	cat >expect <<-\EOF &&
 	|  refname is refs/heads/main  |refs/heads/main
 	|  refname is refs/heads/side  |refs/heads/side
@@ -149,7 +150,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'middle alignment' '
 	test_cmp expect actual
 '
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'right alignment' '
+test_expect_success 'right alignment' '
 	cat >expect <<-\EOF &&
 	|    refname is refs/heads/main|refs/heads/main
 	|    refname is refs/heads/side|refs/heads/side
@@ -184,7 +185,7 @@ EOF
 test_align_permutations() {
 	while read -r option
 	do
-		test_expect_success PREPARE_FOR_MAIN_BRANCH "align:$option" '
+		test_expect_success "align:$option" '
 			git for-each-ref --format="|%(align:$option)refname is %(refname)%(end)|%(refname)" >actual &&
 			test_cmp expect actual
 		'
@@ -213,7 +214,7 @@ EOF
 
 # Individual atoms inside %(align:...) and %(end) must not be quoted.
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
+test_expect_success 'alignment with format quote' "
 	cat >expect <<-\EOF &&
 	|'       '\''main| A U Thor'\''       '|
 	|'       '\''side| A U Thor'\''       '|
@@ -231,7 +232,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'alignment with format quote' "
 	test_cmp expect actual
 "
 
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatting' "
+test_expect_success 'nested alignment with quote formatting' "
 	cat >expect <<-\EOF &&
 	|'           main               '|
 	|'           side               '|
@@ -251,7 +252,7 @@ test_expect_success PREPARE_FOR_MAIN_BRANCH 'nested alignment with quote formatt
 
 test_expect_success 'check `%(contents:lines=1)`' '
 	cat >expect <<-\EOF &&
-	master |three
+	main |three
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
@@ -269,7 +270,7 @@ test_expect_success 'check `%(contents:lines=1)`' '
 
 test_expect_success 'check `%(contents:lines=0)`' '
 	cat >expect <<-\EOF &&
-	master |
+	main |
 	side |
 	odd/spot |
 	annotated-tag |
@@ -287,7 +288,7 @@ test_expect_success 'check `%(contents:lines=0)`' '
 
 test_expect_success 'check `%(contents:lines=99999)`' '
 	cat >expect <<-\EOF &&
-	master |three
+	main |three
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
@@ -360,7 +361,7 @@ test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms'
 test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 	git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Author: %(authorname)%(end)" >actual &&
 	cat >expect <<-\EOF &&
-	refs/heads/master Author: A U Thor
+	refs/heads/main Author: A U Thor
 	refs/heads/side Author: A U Thor
 	refs/odd/spot Author: A U Thor
 	refs/tags/annotated-tag
@@ -381,7 +382,7 @@ test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No author%(end): %(refname)" >actual &&
 	cat >expect <<-\EOF &&
-	A U Thor: refs/heads/master
+	A U Thor: refs/heads/main
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
 	No author: refs/tags/annotated-tag
@@ -401,7 +402,7 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 test_expect_success 'ignore spaces in %(if) atom usage' '
 	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
 	cat >expect <<-\EOF &&
-	master: Head ref
+	main: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref
 	annotated-tag: Not Head ref
@@ -420,19 +421,19 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 '
 
 test_expect_success 'check %(if:equals=<string>)' '
-	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
+	git for-each-ref --format="%(if:equals=main)%(refname:short)%(then)Found main%(else)Not main%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
-	Found master
-	Not master
+	Found main
+	Not main
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'check %(if:notequals=<string>)' '
-	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
+	git for-each-ref --format="%(if:notequals=main)%(refname:short)%(then)Not main%(else)Found main%(end)" refs/heads/ >actual &&
 	cat >expect <<-\EOF &&
-	Found master
-	Not master
+	Found main
+	Not main
 	EOF
 	test_cmp expect actual
 '
@@ -443,11 +444,11 @@ test_expect_success '--merged is compatible with --no-merged' '
 
 test_expect_success 'validate worktree atom' '
 	cat >expect <<-EOF &&
-	master: $(pwd)
-	master_worktree: $(pwd)/worktree_dir
+	main: $(pwd)
+	main_worktree: $(pwd)/worktree_dir
 	side: not checked out
 	EOF
-	git worktree add -b master_worktree worktree_dir master &&
+	git worktree add -b main_worktree worktree_dir main &&
 	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
 	rm -r worktree_dir &&
 	git worktree prune &&
-- 
gitgitgadget

