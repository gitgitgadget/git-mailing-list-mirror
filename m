Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4CC208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 08:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbeHGKfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:35:18 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:39546 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbeHGKfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:35:17 -0400
Received: by mail-io0-f194.google.com with SMTP id o22-v6so13318463ioh.6
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vz5ljrqYNGB4195FMK1Q3ceegJIQPtGizLsoHidkUxM=;
        b=ZVt9Eh5GhiarMEx9/M3Se2vNUgUnvv8Kr/TZoJiQnBdX4Q8bcMFgWIRPU6cq8OD53N
         /GoPqR8VU2mDwLjsgYiHdUjHA/W73RkSKjHNypACdhzn0LVaQBcuopcb9VWv5GMAKDUs
         mv0UTE28wR8cUbO4N1M/YplNUWYoVrf/0vrLV+LrOR2UmAqwHo6sHqVS+DJVJLXem586
         0EzSuuNjTytzMlfWZfjMtC6Bou15/tejbp5vfZgG0Qtahb/CLV3Q8dZJzACF4M14LZyb
         CVMdFZFY/PInlpcMCH67Wye5tAQE4gKRza1qBSbUD9dsCaMma+q5x4XkruYCio77TIbO
         Itsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Vz5ljrqYNGB4195FMK1Q3ceegJIQPtGizLsoHidkUxM=;
        b=LLeGgp3wu8V9tHn13rVTwBkUmMGyrlm4+umuWzJ3gcH/avfoVQb7OZhWbkHZc9a5Oe
         c/pnrodnywrMTTOvpt3pp9l1oAAmEVHjyThx+NeNvWEmwrFYnF0X0VJghIIQK4NYW3lv
         rSbz8ndDIgCP4i8q1yZiDvBS1X3EICwKy0iKfOLhNlOiTv2OADAFmwgTMEDULuD0JBmo
         oSrmeqdTkHA7f+2lfaAysQEHjOWt/uz7NvoNdHlRNwz5nZv2KO5rI10sSE0QD9nqdYw5
         2B/EJiWhW18+mWSC+uyB1RUKI5BU6SCDuuWSiVu3NOtzKd8mmYxo9QOqdZqMKeU5NKMQ
         bjBQ==
X-Gm-Message-State: AOUpUlGhdNUoGZyp7FCNXQWkj3iXlXtnjKARQtJ/5jghTXHMmVN4fXqi
        HmqKMMJtCTW5VyKHUS9hTPyME64S
X-Google-Smtp-Source: AA+uWPzEtPaYqXtBwYJ8krCsm5mdMVkbgcrFaiYrjAFsLQ0eOfHaut0XDoY4brvUdHMmtf3B5b3sWg==
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr18586605iom.238.1533630124295;
        Tue, 07 Aug 2018 01:22:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e19-v6sm210792ioc.46.2018.08.07.01.22.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 01:22:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 4/5] chainlint: recognize multi-line quoted strings more robustly
Date:   Tue,  7 Aug 2018 04:21:34 -0400
Message-Id: <20180807082135.60913-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

chainlint.sed recognizes multi-line quoted strings within subshells:

    echo "abc
        def" >out &&

so it can avoid incorrectly classifying lines internal to the string as
breaking the &&-chain. To identify the first line of a multi-line
string, it checks if the line contains a single quote. However, this is
fragile and can be easily fooled by a line containing multiple strings:

    echo "xyz" "abc
        def" >out &&

Make detection more robust by checking for an odd number of quotes
rather than only a single one.

(Escaped quotes are not handled, but support may be added later.)

The original multi-line string recognizer rather cavalierly threw away
all but the final quote, whereas the new one is careful to retain all
quotes, so the "expected" output of a couple existing chainlint tests is
updated to account for this new behavior.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                               | 32 +++++++++++++------
 t/chainlint/here-doc-multi-line-string.expect |  2 +-
 t/chainlint/multi-line-string.expect          | 10 ++++--
 t/chainlint/multi-line-string.test            | 12 +++++++
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 6c891bf383..338163c2f5 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -151,10 +151,10 @@ s/.*\n//
 :slurp
 # incomplete line "...\"
 /\\$/bincomplete
-# multi-line quoted string "...\n..."
-/^[^"]*"[^"]*$/bdqstring
-# multi-line quoted string '...\n...' (but not contraction in string "it's so")
-/^[^']*'[^']*$/{
+# multi-line quoted string "...\n..."?
+/"/bdqstring
+# multi-line quoted string '...\n...'? (but not contraction in string "it's")
+/'/{
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
 :folded
@@ -250,20 +250,32 @@ N
 s/\\\n//
 bslurp
 
-# found multi-line double-quoted string "...\n..." -- slurp until end of string
+# check for multi-line double-quoted string "...\n..." -- fold to one line
 :dqstring
-s/"//g
+# remove all quote pairs
+s/"\([^"]*\)"/@!\1@!/g
+# done if no dangling quote
+/"/!bdqdone
+# otherwise, slurp next line and try again
 N
 s/\n//
-/"/!bdqstring
+bdqstring
+:dqdone
+s/@!/"/g
 bfolded
 
-# found multi-line single-quoted string '...\n...' -- slurp until end of string
+# check for multi-line single-quoted string '...\n...' -- fold to one line
 :sqstring
-s/'//g
+# remove all quote pairs
+s/'\([^']*\)'/@!\1@!/g
+# done if no dangling quote
+/'/!bsqdone
+# otherwise, slurp next line and try again
 N
 s/\n//
-/'/!bsqstring
+bsqstring
+:sqdone
+s/@!/'/g
 bfolded
 
 # found here-doc -- swallow it to avoid false hits within its body (but keep
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 1e5b724b9d..32038a070c 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,4 +1,4 @@
 (
-?!AMP?!	cat && echo multi-line	string"
+?!AMP?!	cat && echo "multi-line	string"
 	bap
 >)
diff --git a/t/chainlint/multi-line-string.expect b/t/chainlint/multi-line-string.expect
index 8334c4cc8e..170cb59993 100644
--- a/t/chainlint/multi-line-string.expect
+++ b/t/chainlint/multi-line-string.expect
@@ -1,9 +1,15 @@
 (
-	x=line 1		line 2		line 3" &&
-?!AMP?!	y=line 1		line2'
+	x="line 1		line 2		line 3" &&
+?!AMP?!	y='line 1		line2'
 	foobar
 >) &&
 (
 	echo "there's nothing to see here" &&
 	exit
+>) &&
+(
+	echo "xyz" "abc		def		ghi" &&
+	echo 'xyz' 'abc		def		ghi' &&
+	echo 'xyz' "abc		def		ghi" &&
+	barfoo
 >)
diff --git a/t/chainlint/multi-line-string.test b/t/chainlint/multi-line-string.test
index 14cb44d51c..287ab89705 100644
--- a/t/chainlint/multi-line-string.test
+++ b/t/chainlint/multi-line-string.test
@@ -12,4 +12,16 @@
 # LINT: starting multi-line single-quoted string
 	echo "there's nothing to see here" &&
 	exit
+) &&
+(
+	echo "xyz" "abc
+		def
+		ghi" &&
+	echo 'xyz' 'abc
+		def
+		ghi' &&
+	echo 'xyz' "abc
+		def
+		ghi" &&
+	barfoo
 )
-- 
2.18.0.758.g1932418f46

