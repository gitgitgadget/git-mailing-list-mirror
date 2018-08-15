Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3ECA1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeHOVjf (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:35 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51572 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHOVjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:35 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so3023427itf.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+l40/Y4qFpad+eT9QoV8ua7EypiSs4sVN2W3uOi3Gts=;
        b=GPMpaca3Q1g/M8V5LWFtN5AqBxpa8s/YQRFNt00F98qubgdNdB9EhasDDY1bpPMvUw
         j9dWwRs9+pEGCylcWnD76MzFsoBlPbba13yV4VmY1v7OoNR4umuOmNIeBjkaEhv52Lbn
         uUybwTzGT+rnNPFq/B9EnVTQp8bacUHgsZIJ7kt0xUIZ629TysKjeaaOXECB/C89t8e7
         4UZLKsQu63RIEpIznMFfziZ+IeaLhSHBGfuCLBb/cfTtZ5ZcSZ6P22N2Y1YHD1jy60DO
         iYhVyF4d4a1HCAzIEPM6oOfOhWhl15k1AohymQhJtocCiAo7V9yimjiVXiA2QW+2/oWP
         fwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+l40/Y4qFpad+eT9QoV8ua7EypiSs4sVN2W3uOi3Gts=;
        b=hVU7t0QBXwRcD28NlHi1JVB1dU0CLVSdqUUS0698mIcphfxNCXfI4PmBNV2IMfSCFj
         xveW/RqtkJmLV0JKU1Q+SS9yHn1JSKBTKPE4FcdX/B8cyVJfku1A3os59eGy38GkJaE0
         OMgBtvP8mJM545xKKEb0aZm7OkMT0FxmL9gabocMqBULs3O3/Dw07hmSyZ5lKi/ukO5B
         mTX4XxguRCbwC8KeVzV9QHiS4JXnigF7RASfVbe8NN0cNPZUTakHiY4Iqml9v6QT7Pt8
         pADE/U4CJOhFEOfx26CqJ4v5f8CbQjB/6WlRJDi6abDarBXhHRoax8uAp/IsB7LA1yn5
         sDiA==
X-Gm-Message-State: AOUpUlHFnDKjOeuIYuEj3pFXk1o3gqHC0v1DL+2QXvXJ9ynzMQ7Xg0XQ
        jIoKHakDD5DWTL3dIbQBHN2LL+Ey
X-Google-Smtp-Source: AA+uWPwCoEUXPAXNStXyLJ9bQAQe9NOYHTZnzQ620y7DJp70KNCN4I9XOKJ1qXtI7zphMNHhLQBDeg==
X-Received: by 2002:a02:3344:: with SMTP id k4-v6mr24489228jak.45.1534358775397;
        Wed, 15 Aug 2018 11:46:15 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:14 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/6] chainlint: match arbitrary here-docs tags rather than hard-coded names
Date:   Wed, 15 Aug 2018 14:45:47 -0400
Message-Id: <20180815184552.8418-2-sunshine@sunshineco.com>
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

chainlint.sed swallows top-level here-docs to avoid being fooled by
content which might look like start-of-subshell. It likewise swallows
here-docs in subshells to avoid marking content lines as breaking the
&&-chain, and to avoid being fooled by content which might look like
end-of-subshell, start-of-nested-subshell, or other specially-recognized
constructs.

At the time of implementation, it was believed that it was not possible
to support arbitrary here-doc tag names since 'sed' provides no way to
stash the opening tag name in a variable for later comparison against a
line signaling end-of-here-doc. Consequently, tag names are hard-coded,
with "EOF" being the only tag recognized at the top-level, and only
"EOF", "EOT", and "INPUT_END" being recognized within subshells. Also,
special care was taken to avoid being confused by here-docs nested
within other here-docs.

In practice, this limited number of hard-coded tag names has been "good
enough" for the 13000+ existing Git test, despite many of those tests
using tags other than the recognized ones, since the bodies of those
here-docs do not contain content which would fool the linter.
Nevertheless, the situation is not ideal since someone writing new
tests, and choosing a name not in the "blessed" set could potentially
trigger a false-positive.

To address this shortcoming, upgrade chainlint.sed to handle arbitrary
here-doc tag names, both at the top-level and within subshells.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                      | 57 +++++++++++++++++-----------
 t/chainlint/here-doc.expect          |  2 +
 t/chainlint/here-doc.test            |  7 ++++
 t/chainlint/nested-here-doc.expect   |  2 +
 t/chainlint/nested-here-doc.test     | 10 +++++
 t/chainlint/subshell-here-doc.expect |  4 ++
 t/chainlint/subshell-here-doc.test   |  8 ++++
 7 files changed, 67 insertions(+), 23 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 5f0882cb38..2af1a687f8 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -61,6 +61,22 @@
 # "else", and "fi" in if-then-else likewise must not end with "&&", thus
 # receives similar treatment.
 #
+# Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
+# line such as "cat <<EOF >out" is seen, the here-doc tag is moved to the front
+# of the line enclosed in angle brackets as a sentinel, giving "<EOF>cat >out".
+# As each subsequent line is read, it is appended to the target line and a
+# (whitespace-loose) back-reference match /^<(.*)>\n\1$/ is attempted to see if
+# the content inside "<...>" matches the entirety of the newly-read line. For
+# instance, if the next line read is "some data", when concatenated with the
+# target line, it becomes "<EOF>cat >out\nsome data", and a match is attempted
+# to see if "EOF" matches "some data". Since it doesn't, the next line is
+# attempted. When a line consisting of only "EOF" (and possible whitespace) is
+# encountered, it is appended to the target line giving "<EOF>cat >out\nEOF",
+# in which case the "EOF" inside "<...>" does match the text following the
+# newline, thus the closing here-doc tag has been found. The closing tag line
+# and the "<...>" prefix on the target line are then discarded, leaving just
+# the target line "cat >out".
+#
 # To facilitate regression testing (and manual debugging), a ">" annotation is
 # applied to the line containing ")" which closes a subshell, ">>" to a line
 # closing a nested subshell, and ">>>" to a line closing both at once. This
@@ -78,14 +94,17 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\]*EOF[ 	]*/ {
-	s/[ 	]*<<[ 	]*[-\\]*EOF//
-	h
+/<<[ 	]*[-\\]*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+	s/[ 	]*<<//
 	:hereslurp
 	N
-	s/.*\n//
-	/^[ 	]*EOF[ 	]*$/!bhereslurp
-	x
+	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
+		s/\n.*$//
+		bhereslurp
+	}
+	s/^<[^>]*>//
+	s/\n.*$//
 }
 
 # one-liner "(...) &&"
@@ -139,9 +158,7 @@ s/.*\n//
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
 # here-doc -- swallow it
-/<<[ 	]*[-\\]*EOF/bheredoc
-/<<[ 	]*[-\\]*EOT/bheredoc
-/<<[ 	]*[-\\]*INPUT_END/bheredoc
+/<<[ 	]*[-\\]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -249,23 +266,17 @@ s/\n//
 bcheckchain
 
 # found here-doc -- swallow it to avoid false hits within its body (but keep
-# the command to which it was attached); take care to handle here-docs nested
-# within here-docs by only recognizing closing tag matching outer here-doc
-# opening tag
+# the command to which it was attached)
 :heredoc
-/EOF/{ s/[ 	]*<<[ 	]*[-\\]*EOF//; s/^/EOF/; }
-/EOT/{ s/[ 	]*<<[ 	]*[-\\]*EOT//; s/^/EOT/; }
-/INPUT_END/{ s/[ 	]*<<[ 	]*[-\\]*INPUT_END//; s/^/INPUT_END/; }
+s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+s/[ 	]*<<//
 :hereslurpsub
 N
-/^EOF.*\n[ 	]*EOF[ 	]*$/bhereclose
-/^EOT.*\n[ 	]*EOT[ 	]*$/bhereclose
-/^INPUT_END.*\n[ 	]*INPUT_END[ 	]*$/bhereclose
-bhereslurpsub
-:hereclose
-s/^EOF//
-s/^EOT//
-s/^INPUT_END//
+/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
+	s/\n.*$//
+	bhereslurpsub
+}
+s/^<[^>]*>//
 s/\n.*$//
 bcheckchain
 
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 2328fe7753..33bc3cc0b4 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,3 +1,5 @@
 boodle wobba        gorgo snoot        wafta snurb &&
 
+cat >foo &&
+
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index bd36f6e1d3..8986eefe74 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -7,6 +7,13 @@ quoth the raven,
 nevermore...
 EOF
 
+# LINT: swallow here-doc with arbitrary tag
+cat <<-Arbitrary_Tag_42 >foo &&
+snoz
+boz
+woz
+Arbitrary_Tag_42
+
 # LINT: swallow here-doc (EOF is last line of test)
 horticulture <<\EOF
 gomez
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 559301e005..0c9ef1cfc6 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -1,3 +1,5 @@
+cat >foop &&
+
 (
 	cat &&
 ?!AMP?!	cat
diff --git a/t/chainlint/nested-here-doc.test b/t/chainlint/nested-here-doc.test
index 027e0bb3ff..f35404bf0f 100644
--- a/t/chainlint/nested-here-doc.test
+++ b/t/chainlint/nested-here-doc.test
@@ -1,3 +1,13 @@
+# LINT: inner "EOF" not misintrepreted as closing ARBITRARY here-doc
+cat <<ARBITRARY >foop &&
+naddle
+fub <<EOF
+	nozzle
+	noodle
+EOF
+formp
+ARBITRARY
+
 (
 # LINT: inner "EOF" not misintrepreted as closing INPUT_END here-doc
 	cat <<-\INPUT_END &&
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 19d5aff233..7c2da63bc7 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -2,4 +2,8 @@
 	echo wobba 	       gorgo snoot 	       wafta snurb &&
 ?!AMP?!	cat >bip
 	echo >bop
+>) &&
+(
+	cat >bup &&
+	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index 9c3564c247..05139af0b5 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -20,4 +20,12 @@
 	wednesday
 	pugsly
 	EOF
+) &&
+(
+# LINT: swallow here-doc with arbitrary tag
+	cat <<-\ARBITRARY >bup &&
+	glink
+	FIZZ
+	ARBITRARY
+	meep
 )
-- 
2.18.0.267.gbc8be36ecb

