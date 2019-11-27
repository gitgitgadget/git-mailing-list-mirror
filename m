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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771BC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D7720835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeV7ZguG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfK0Tx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45217 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfK0Tx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so10275399plz.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQSbzla2VsXVGIGD/kDLshGkcMr2JlalSddTEq6v7J0=;
        b=DeV7ZguGDnuuNkenDYlpFNGy+lFakrL31tJaN32FhkBuT0wrx9n2rZLJpImLBgW1S5
         YPACKr8mLcP5Hknc2oqhAiZq591fLe2J/lv0JSrO9dG68nv6XnjME8qB51fUYTVBck5j
         xgeQt2vqAuSJlS6XoGyHUW3pMAyxVe2adY+YmabfGoQ6lmkyYeDbQhxKDlyugytKKJb+
         lyDCtFltf3VYban3p7ypvYS5di1K7Ch0lTJHDcD3asLxyIJ2H66wU5bNYL5ZG8gMgWA0
         RDo6mu3TJTvPuCp4Mpn60l+7WCyCfyZFmIisFlyEHooXB7DzqTy/SjIT9CVf0f/0xFax
         s6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQSbzla2VsXVGIGD/kDLshGkcMr2JlalSddTEq6v7J0=;
        b=hhstD8kEcqeGXUzPYfV+77+IfYO7cGiD3wr5axYdUCupXexI1DI0e4gyaRZ3XsPvYK
         XqCnRTX98djbbVHQxGnEOgrO5BVteUV7MbdNtsONk9ed8zbD779B1ZhqSgvQd4SEx7LO
         7HzieX65Ya78B7/f9Syn9uE68SfEzH8d6erGadAbckC23OPBiYNZI45q80MzT//CVpK0
         rnEeXaAf7htXvTMngNm07JXnJgd2ndAF6yXNgfXtybBFfChDxg1U2fmyOAvP+cYaEdLR
         xFjAQn6e0N4krt/ZoAVaYZolGLK5RO4x+SIJxswxiJ93OavqMDNlI5zcR5mUd4dEftRa
         huYA==
X-Gm-Message-State: APjAAAWnNPnklHKxGTU26yMIW89B9U8DLws6lJAgkAjr8v5jOQM9f6Ej
        P4UMRCcVvpXC7i26qZaRXbbYNBoy
X-Google-Smtp-Source: APXvYqyvYq6SJn2TH0HmMeJAEF576b0XP7TQnTgvoPl0PLn5Apn0t85cNSsTVx4r9XNOzp7dse7cFA==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr6034372pla.158.1574884406648;
        Wed, 27 Nov 2019 11:53:26 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id 136sm17849396pfb.49.2019.11.27.11.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:26 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 09/26] t4015: stop losing return codes of git commands
Message-ID: <22ea5d736e98205c08716c0d898d280be7f6cbef.1574884302.git.liu.denton@gmail.com>
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

Currently, there are two ways where the return codes of git commands are
lost. The first way is when a command is in the upstream of a pipe. In a
pipe, only the return code of the last command is used. Thus, all other
commands will have their return codes masked. Rewrite pipes so that
there are no git commands upstream.

The other way is when a command is in a non-assignment command
substitution. The return code will be lost in favour of the surrounding
command's. Rewrite instances of this so that git commands are either run
on their own or in an assignment-only command substitution.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 119 ++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 47 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index eadaf57262..7fb83c8eff 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -16,7 +16,8 @@ test_expect_success "Ray Lehtiniemi's example" '
 	} while (0);
 	EOF
 	git update-index --add x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 
 	cat <<-\EOF >x &&
 	do
@@ -25,7 +26,8 @@ test_expect_success "Ray Lehtiniemi's example" '
 	}
 	while (0);
 	EOF
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	cat <<-EOF >expect &&
 	diff --git a/x b/x
@@ -63,7 +65,8 @@ test_expect_success 'another test, without options' '
 	EOF
 
 	git update-index x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 
 	tr "_" " " <<-\EOF >x &&
 	_	whitespace at beginning
@@ -73,7 +76,8 @@ test_expect_success 'another test, without options' '
 	unchanged line
 	CR at end
 	EOF
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	tr "Q_" "\015 " <<-EOF >expect &&
 	diff --git a/x b/x
@@ -526,13 +530,15 @@ test_expect_success 'ignore-blank-lines: mix changes and blank lines' '
 test_expect_success 'check mixed spaces and tabs in indent' '
 	# This is indented with SP HT SP.
 	echo " 	 foo();" >x &&
-	git diff --check | grep "space before tab in indent"
+	test_must_fail git diff --check >check &&
+	grep "space before tab in indent" check
 '
 
 test_expect_success 'check mixed tabs and spaces in indent' '
 	# This is indented with HT SP HT.
 	echo "	 	foo();" >x &&
-	git diff --check | grep "space before tab in indent"
+	test_must_fail git diff --check >check &&
+	grep "space before tab in indent" check
 '
 
 test_expect_success 'check with no whitespace errors' '
@@ -753,20 +759,23 @@ test_expect_success 'check tab-in-indent excluded from wildcard whitespace attri
 test_expect_success 'line numbers in --check output are correct' '
 	echo "" >x &&
 	echo "foo(); " >>x &&
-	git diff --check | grep "x:2:"
+	test_must_fail git diff --check >check &&
+	grep "x:2:" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 	echo "foo();" >x &&
 	echo "" >>x &&
-	git diff --check | grep "new blank line"
+	test_must_fail git diff --check >check &&
+	grep "new blank line" check
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
 	{ echo a; echo b; echo; echo; } >x &&
 	git add x &&
 	{ echo a; echo; echo; echo; echo; } >x &&
-	git diff --check | grep "new blank line"
+	test_must_fail git diff --check >check &&
+	grep "new blank line" check
 '
 
 test_expect_success 'checkdiff allows new blank lines' '
@@ -794,14 +803,16 @@ test_expect_success 'whitespace-only changes reported across renames' '
 	git reset --hard &&
 	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
 	git add x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$hash_x") &&
 	git commit -m "base" &&
 	sed -e "5s/^/ /" x >z &&
 	git rm x &&
 	git add z &&
-	after=$(git rev-parse --short $(git hash-object z)) &&
-	git diff -w -M --cached |
-	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" >actual &&
+	hash_z=$(git hash-object z) &&
+	after=$(git rev-parse --short "$hash_z") &&
+	git diff -w -M --cached >actual.raw &&
+	sed -e "/^similarity index /s/[0-9][0-9]*/NUM/" actual.raw >actual &&
 	cat <<-EOF >expect &&
 	diff --git a/x b/z
 	similarity index NUM%
@@ -840,7 +851,8 @@ test_expect_success 'combined diff with autocrlf conversion' '
 	git config core.autocrlf true &&
 	test_must_fail git merge master &&
 
-	git diff | sed -e "1,/^@@@/d" >actual &&
+	git diff >actual.raw &&
+	sed -e "1,/^@@@/d" actual.raw >actual &&
 	! grep "^-" actual
 
 '
@@ -864,11 +876,14 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	git config core.whitespace blank-at-eol &&
 	git reset --hard &&
 	echo "test" >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -m "initial" x &&
 	echo "{NTN}" | tr "NT" "\n\t" >>x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
-	git diff --color | test_decode_color >current &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
+	git diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -891,17 +906,19 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
-	git diff --color |
-	test_decode_color >current &&
+	git diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -925,14 +942,16 @@ test_expect_success 'ws-error-highlight test setup' '
 		echo "0. blank-at-eol " &&
 		echo "1. blank-at-eol "
 	} >x &&
-	before=$(git rev-parse --short $(git hash-object x)) &&
+	old_hash_x=$(git hash-object x) &&
+	before=$(git rev-parse --short "$old_hash_x") &&
 	git commit -a --allow-empty -m preimage &&
 	{
 		echo "0. blank-at-eol " &&
 		echo "1. still-blank-at-eol " &&
 		echo "2. and a new line "
 	} >x &&
-	after=$(git rev-parse --short $(git hash-object x)) &&
+	new_hash_x=$(git hash-object x) &&
+	after=$(git rev-parse --short "$new_hash_x") &&
 
 	cat >expect.default-old <<-EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
@@ -974,32 +993,32 @@ test_expect_success 'ws-error-highlight test setup' '
 
 test_expect_success 'test --ws-error-highlight option' '
 
-	git diff --color --ws-error-highlight=default,old |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=default,old >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
-	git diff --color --ws-error-highlight=all |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=all >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
-	git diff --color --ws-error-highlight=none |
-	test_decode_color >current &&
+	git diff --color --ws-error-highlight=none >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
 
 test_expect_success 'test diff.wsErrorHighlight config' '
 
-	git -c diff.wsErrorHighlight=default,old diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=default,old diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
-	git -c diff.wsErrorHighlight=all diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=all diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
-	git -c diff.wsErrorHighlight=none diff --color |
-	test_decode_color >current &&
+	git -c diff.wsErrorHighlight=none diff --color >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
@@ -1007,18 +1026,18 @@ test_expect_success 'test diff.wsErrorHighlight config' '
 test_expect_success 'option overrides diff.wsErrorHighlight' '
 
 	git -c diff.wsErrorHighlight=none \
-		diff --color --ws-error-highlight=default,old |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=default,old >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.default-old current &&
 
 	git -c diff.wsErrorHighlight=default \
-		diff --color --ws-error-highlight=all |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=all >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.all current &&
 
 	git -c diff.wsErrorHighlight=all \
-		diff --color --ws-error-highlight=none |
-	test_decode_color >current &&
+		diff --color --ws-error-highlight=none >current.raw &&
+	test_decode_color <current.raw >current &&
 	test_cmp expect.none current
 
 '
@@ -1038,7 +1057,8 @@ test_expect_success 'detect moved code, complete file' '
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
-	git diff HEAD --color-moved=zebra --color --no-renames | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat >expected <<-EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
@@ -1141,9 +1161,12 @@ test_expect_success 'detect malicious moved code, inside file' '
 			bar();
 		}
 	EOF
-	after_main=$(git rev-parse --short $(git hash-object main.c)) &&
-	after_test=$(git rev-parse --short $(git hash-object test.c)) &&
-	git diff HEAD --no-renames --color-moved=zebra --color | test_decode_color >actual &&
+	hash_main=$(git hash-object main.c) &&
+	after_main=$(git rev-parse --short "$hash_main") &&
+	hash_test=$(git hash-object test.c) &&
+	after_test=$(git rev-parse --short "$hash_test") &&
+	git diff HEAD --no-renames --color-moved=zebra --color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index $before_main..$after_main 100644<RESET>
@@ -1192,7 +1215,8 @@ test_expect_success 'plain moved code, inside file' '
 	test_config color.diff.oldMovedAlternative "blue" &&
 	test_config color.diff.newMovedAlternative "yellow" &&
 	# needs previous test as setup
-	git diff HEAD --no-renames --color-moved=plain --color | test_decode_color >actual &&
+	git diff HEAD --no-renames --color-moved=plain --color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
 	cat <<-EOF >expected &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>index $before_main..$after_main 100644<RESET>
@@ -1771,7 +1795,8 @@ test_expect_success 'move detection with submodules' '
 	! grep BRED decoded_actual &&
 
 	# nor did we mess with it another way
-	git diff --submodule=diff --color | test_decode_color >expect &&
+	git diff --submodule=diff --color >expect.raw &&
+	test_decode_color <expect.raw >expect &&
 	test_cmp expect decoded_actual &&
 	rm -rf bananas &&
 	git submodule deinit bananas
-- 
2.24.0.504.g3cd56eb17d

