Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361C91F404
	for <e@80x24.org>; Mon, 13 Aug 2018 08:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeHML3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 07:29:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54095 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbeHML3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 07:29:35 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so11971466itw.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wAyVvwZUGbhi1SjGFbA1gtHDoeHkfHn7+ljhYMMJ6QE=;
        b=CfC414XBKZzKz7BuHdroio+P7R9F013L71sPldgoZJdsbfvDxgZUfZG6JRCLziEsOo
         7Mm/Q9xeFJRfbtGR71pk5YWfDS4r+oZqkRqEMvVN4U6KqMZU+5Kw19yWowdgvXa2By/j
         mqvFNoy4lXzx47hQ5WK4KHFNeKlZ89QI0hwxAkAvCheCU7JKAppGjLbEAQlqglKuf4bK
         Y05cwZiPUKn2CHyHLSqQMaKaKQKmrw00gCnj3lPsOh9SvRMhIBynoOWH2QqJQW1P4w4e
         r4fcUxtpqhvUlvCXixmWnImoExn839l8KgRXLZsTD3YrnyWQVRtp3x7zdv+k0H/JAQ71
         yepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wAyVvwZUGbhi1SjGFbA1gtHDoeHkfHn7+ljhYMMJ6QE=;
        b=aDwqqERSID1Msbr01Xf36/ONS762nQMptZ9tScHGXZCuFeF/VTOMa7dYILaABQBxAF
         BTflM2F7DSB6Gtg2Zz0lV45PvRbk0VhlHyeVpdLeOYF2lPURjQ/+C7iRTX764TONKtuO
         ip5dUpOZRpTlXnVpAM37wSVrWD7BXgC8QFwC/U91nYv8y1el3FoJy8ZtqRZrA7w2K4nC
         qfvw+iT1G/Q1TzInrIXzI8X2TbKB6fm+tDvMH9JXDrUuhsIpsfQNwyoA7RLzqScE8gMw
         sEfO4/vG96zdUe27STUIbhm1J/GdTc+05QhK4iLUBI3kjDZrd0+Ia++6Kwvkmgco5HdY
         EquQ==
X-Gm-Message-State: AOUpUlELDPeaauta9xh1VNEi3uzL4877HU8H8T1gi+bERGDEbAgQO1rn
        QzVYa/MxSLzJkMFYTAzYH3LWfbzn
X-Google-Smtp-Source: AA+uWPz92YIgBM2CE8AmQsoDS6c7+EShNlzgjYIY0UWnQsdVBFxMSLyoWTr9775YKypBRUknt/0vvw==
X-Received: by 2002:a24:55cd:: with SMTP id e196-v6mr9673224itb.8.1534150098571;
        Mon, 13 Aug 2018 01:48:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g23-v6sm5609405iob.88.2018.08.13.01.48.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 01:48:18 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/6] chainlint: recognize multi-line quoted strings more robustly
Date:   Mon, 13 Aug 2018 04:47:38 -0400
Message-Id: <20180813084739.16134-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180813084739.16134-1-sunshine@sunshineco.com>
References: <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180813084739.16134-1-sunshine@sunshineco.com>
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
index 6661e21f20..8544df38df 100644
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
2.18.0.267.gbc8be36ecb

