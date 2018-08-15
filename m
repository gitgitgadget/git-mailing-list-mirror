Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6471F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeHOVji (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54186 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHOVji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:38 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so3018000itw.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QnS8vIvXY5H+PROpdIGje/lYuChyg+g7Qj4ORQVcD9s=;
        b=SKfb6CM9SZxW/fzVt6AVBli48vx9QSZDGkghisXWvsUCwN0qPvR2liYrnwEcFaMoSq
         THIlFC+7mGzGzp/jYwt7NqiMazED/XcaLAhKv8sQ4PmdVeycd2Nly8yqH+i3nmdUKzwV
         aYIApipr5h3qRkLRvfNlP6eXv/f9lGxcxzNKpMrRif6m5xlBHQ8f7W+hmRsoP3kheLPP
         iYs54kkeG5NmsAp2vXaDSfi8jIdclISiraX0d19GMXCDmEs5fyV8Bpk4jOzs0qEQTpoV
         L8QeshbM6F+tS5AW9jhsmleHVOecvk/H7fDmNS7EbkynJl9/hK508TMoZTNBkHuORImk
         qd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QnS8vIvXY5H+PROpdIGje/lYuChyg+g7Qj4ORQVcD9s=;
        b=AlUbWcwQz4KxDkCMbfmTN2KrXt3fT25dPQ4tqvsuQNJvzzo1fOpT8fRYUez35EGDRR
         ncx+Gtus1kMhpTs0eQuAWRTUt4dWsS5ZVtUFU1eG35Qi5m4QhMQLYddQ3mcJXB6ABcu2
         Ilnkhu6kdTq/FSLRL5GYc9Gef6CzwXJynGykmwR0CaZVzmAnAUtT4uUl2usnYt5NI1KY
         YsAHGyGYQ42D5+umFXTEFBCyHaix/NAVfddsvKHB+1PJmfNCw/lskQaPYkTzU6cLrtIf
         SkJknknrn8iChMSd4Z0Vdp7pkc9jB1W/sQqsego2C+EpGLO/nJNPZ6TRXOXhdy7vykKs
         c13w==
X-Gm-Message-State: AOUpUlFfwwtC2VwkN8Ligz08xxIE8D4/ziG9ttDE0K8s+j91fhshDJg2
        s0x5lhL/DUG0YbyDS4ORe02lAlVT
X-Google-Smtp-Source: AA+uWPzBW2oUTzEiyNT9wH2BgMNrEhVJmYAQvPMdW1LUNV5cHoEPsE52ErygK3L1K3ByMa7iOSSRQA==
X-Received: by 2002:a02:a60e:: with SMTP id c14-v6mr22932099jam.69.1534358778710;
        Wed, 15 Aug 2018 11:46:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:18 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 5/6] chainlint: recognize multi-line quoted strings more robustly
Date:   Wed, 15 Aug 2018 14:45:51 -0400
Message-Id: <20180815184552.8418-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180815184552.8418-1-sunshine@sunshineco.com>
References: <20180813084739.16134-1-sunshine@sunshineco.com>
 <20180815184552.8418-1-sunshine@sunshineco.com>
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
index 41cb6ef865..1da58b554b 100644
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

