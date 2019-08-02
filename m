Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0E81F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406913AbfHBJ5b (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:57:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41130 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406906AbfHBJ53 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so72247529ljg.8
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/mkRSPOhZqzzguOzOHp9b4AxQzYxh/Ey6mL0ccDOfA=;
        b=DVBWHVIUBSrXII67fXmB7pnsiHX9yN0pcerfHNVZq8Bqt6uf4BvLMIbGCB30/IHvqn
         iF0slG0VLDza7IKCV48uPMNKqG0TIPL0bb58ib/7zPeTXdixSAfgnuNKAM9QY/quIVII
         oTc+WB048yfpx0igZd5L+BUbOATYivv4E7LBZI56TJPjvP5ty8hIfifvyqTOHlbj8OTz
         AqMe5zztC3lIhfP2WERX9R7SvPP9tCbcKp1L1lE+ROcnccVGBTYgYVJSte74pIc9dIHF
         pynaUpmOM1OX2L/OnFm7hUlf2v5gWaNPdIkhFIFnamyuY0l3qi0qiYddDaA8UYm+P38H
         OeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/mkRSPOhZqzzguOzOHp9b4AxQzYxh/Ey6mL0ccDOfA=;
        b=fHy8HtckOIQCW9jFGv6qPg/yFloHnn0nr9j1b9mL22Z21f7t414FRcxQXHDH1je/jE
         Hw+ZS5w/EcWyJqYQQPOAR4WYfLLjjNRJW1oQ3OHyOBjYi9iowIoMLBS0E8AfVlo2XQDv
         XYqnUXN+gAn3NkLMNTZ6hojjYMsLdW5vC8f/lPLemAQ6Gcj/kl7layON0tUB07gn/SdS
         JQNYehuodYQc1MyMoVbMxq8slbH+8ZVTUMcqhazd/VzUUhQVPc9N4fIL/71jizctT0RL
         cqsd0tDyC14+JIicYGCwOgk6oNtm5DPn2YQy5wlfw7uqujaTlA9TDWFkstfjr97GJDkG
         q4sw==
X-Gm-Message-State: APjAAAWv4n7CTQ3LG0UvV0ljKiLEh/YpPgX4mLAOn8qeR7qfcVACL0Yp
        dSiRu+3f6or5qJxLTvrhHDQ=
X-Google-Smtp-Source: APXvYqwm1HOC71qLvIAuP9ndwvXR8cI8XC3gjupyT+GyLYNZUTGFLoBh0BKDUj3xrCRE+aWwqIis1Q==
X-Received: by 2002:a2e:9753:: with SMTP id f19mr70494522ljj.113.1564739846969;
        Fri, 02 Aug 2019 02:57:26 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:26 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 2/5] t7503: avoid touch when mtime doesn't matter
Date:   Fri,  2 Aug 2019 11:56:36 +0200
Message-Id: <fa13d568021cdcaf66365b783218270dcfb0c79a.1564737003.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <cover.1564737003.git.martin.agren@gmail.com>
References: <cover.1564695892.git.steadmon@google.com> <cover.1564737003.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

AFAIU, we avoid using `touch` unless we really do want to update the
mtime. Here, we just want to create empty files, so write `>foo`
instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 5cc6c98375..a6f1240aa2 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -43,7 +43,8 @@ test_expect_success 'root commit' '
 
 test_expect_success 'with no hook' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "foo" >file &&
 	git add file &&
 	git commit -m "first" &&
@@ -52,7 +53,8 @@ test_expect_success 'with no hook' '
 
 test_expect_success 'with no hook (merge)' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	git checkout side &&
 	git merge -m "merge master" master &&
 	git checkout master &&
@@ -61,7 +63,8 @@ test_expect_success 'with no hook (merge)' '
 
 test_expect_success '--no-verify with no hook' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "bar" >file &&
 	git add file &&
 	git commit --no-verify -m "bar" &&
@@ -70,7 +73,8 @@ test_expect_success '--no-verify with no hook' '
 
 test_expect_success '--no-verify with no hook (merge)' '
 	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
@@ -80,7 +84,7 @@ test_expect_success '--no-verify with no hook (merge)' '
 test_expect_success 'with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
-	touch actual_hooks &&
+	>actual_hooks &&
 	echo "$PRECOMMIT" >expected_hooks &&
 	echo "more" >>file &&
 	git add file &&
@@ -91,7 +95,7 @@ test_expect_success 'with succeeding hook' '
 test_expect_success 'with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PREMERGE" &&
-	touch actual_hooks &&
+	>actual_hooks &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
 	git merge -m "merge master" master &&
@@ -102,7 +106,8 @@ test_expect_success 'with succeeding hook (merge)' '
 test_expect_success '--no-verify with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "even more" >>file &&
 	git add file &&
 	git commit --no-verify -m "even more" &&
@@ -112,7 +117,8 @@ test_expect_success '--no-verify with succeeding hook' '
 test_expect_success '--no-verify with succeeding hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PREMERGE" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
@@ -122,7 +128,7 @@ test_expect_success '--no-verify with succeeding hook (merge)' '
 test_expect_success 'with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
-	touch actual_hooks &&
+	>actual_hooks &&
 	echo "$PRECOMMIT" >expected_hooks &&
 	echo "another" >>file &&
 	git add file &&
@@ -133,7 +139,8 @@ test_expect_success 'with failing hook' '
 test_expect_success '--no-verify with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "stuff" >>file &&
 	git add file &&
 	git commit --no-verify -m "stuff" &&
@@ -143,7 +150,7 @@ test_expect_success '--no-verify with failing hook' '
 test_expect_success 'with failing hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PREMERGE" &&
-	touch actual_hooks &&
+	>actual_hooks &&
 	echo "$PREMERGE" >expected_hooks &&
 	git checkout side &&
 	test_must_fail git merge -m "merge master" master &&
@@ -154,7 +161,8 @@ test_expect_success 'with failing hook (merge)' '
 test_expect_success '--no-verify with failing hook (merge)' '
 	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PREMERGE" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
@@ -165,7 +173,8 @@ test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "content" >>file &&
 	git add file &&
 	git commit -m "content" &&
@@ -176,7 +185,8 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
-	touch expected_hooks actual_hooks &&
+	>expected_hooks &&
+	>actual_hooks &&
 	echo "more content" >>file &&
 	git add file &&
 	git commit --no-verify -m "more content" &&
-- 
2.23.0.rc0.30.g51cf315870

