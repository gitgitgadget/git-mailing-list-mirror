Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1881F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeHOVje (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:34 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36527 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHOVje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:34 -0400
Received: by mail-io0-f193.google.com with SMTP id m4-v6so1825506iop.3
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IIMMCKXTOgvpWvCs93wsip1/ifoQD2LtUxvISuZRlUo=;
        b=Bq0WKIC+bT0P37Z+s3nBZt9NTTX3k7qRkZQ/lwP9vS2kxx+7dCo3/YuMMU+Y+UAOTV
         L+7FXVKngbNRTmpt9BXSsgOQU9GGvi7jAG6NAsAErhg+u4xKIFzr36xqyy3Ejcch+BzR
         0az0D29hugTWvZB3JheE3p4DLs7xz+z/F1bF+OlPsWdWEIuOjypsgZaaamUHNs9X60Wv
         MCV8IHWc0MtGdZh470MTGN3YuoeVgr2jQR4ssa3mT5ldRXTlUZ4krjpQwLora8fE2ixR
         1l+FcfcrincCr8IcX8mcN4ogY04H7i/jaQYnq+mddpTzZFfC14kB0gcQ+fXxfDlllptZ
         ayJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IIMMCKXTOgvpWvCs93wsip1/ifoQD2LtUxvISuZRlUo=;
        b=N3gSc2bT9WSD7fDrMpN74HhuFi/ko6UVI1Xyg6ZWl2DbgDNZwOgHfBmd19MKsfZAC7
         ejIEmBUS+x0JSHCXg3fLk0XvaRbbD1/s0iNIjZ7ru1UWt8TOyWsQzyOe2WVeQKMfPZ8+
         DK9QW2jI8lqUCNhPpJMSJ7MNKXmqYHOXdieu1Ltne7EUx1W85fTSVQ99ju21Wjs+9QDC
         YMxA2vJrOiRvXZPSSlC9wI8dCLIrokQ2k9hBvSBW8omgfSWAi/+5U8Mgf+tbEA5iRC89
         jl2zETn8l+gj26QZoHzJSk4etX3lo1qXEE5PDxgZ3isWIlb2ZJ0NZSIOizW1zqMSxHZe
         uXKA==
X-Gm-Message-State: AOUpUlF3A90Hvryb1uEltOysoqobixDyybnw8Px6zC/fd9/4kEEqteO3
        0BnC9xl7LO9VSfZvTHlQd8yZZ7zs
X-Google-Smtp-Source: AA+uWPx90LRWVuStwA46KCZw5iuvW2Lv0/T0oaHhWUsxwA4hCWoWb5kWbWVS8adOkwxNRMQPhPwgAg==
X-Received: by 2002:a6b:348f:: with SMTP id b137-v6mr22254311ioa.134.1534358774483;
        Wed, 15 Aug 2018 11:46:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:13 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/6] chainlint: improve robustness against "unusual" shell coding
Date:   Wed, 15 Aug 2018 14:45:46 -0400
Message-Id: <20180815184552.8418-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180813084739.16134-1-sunshine@sunshineco.com>
References: <20180813084739.16134-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which improves chainlint's robustness in the
face of unusual shell coding such as in contrib/subtree/t7900 which
triggered a false-positive[2].

Changes since v2:

* recognize "quoted" here-doc tag names (in addition to 'quoted'
  and \escaped)

Interdiff below.

[1]: https://public-inbox.org/git/20180813084739.16134-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20180730181356.GA156463@aiede.svl.corp.google.com/

Eric Sunshine (6):
  chainlint: match arbitrary here-docs tags rather than hard-coded names
  chainlint: match quoted here-doc tags
  chainlint: recognize multi-line $(...) when command cuddled with "$("
  chainlint: let here-doc and multi-line string commence on same line
  chainlint: recognize multi-line quoted strings more robustly
  chainlint: add test of pathological case which triggered false
    positive

 t/chainlint.sed                               | 98 ++++++++++++-------
 t/chainlint/here-doc-close-subshell.expect    |  2 +
 t/chainlint/here-doc-close-subshell.test      |  5 +
 .../here-doc-multi-line-command-subst.expect  |  5 +
 .../here-doc-multi-line-command-subst.test    |  9 ++
 t/chainlint/here-doc-multi-line-string.expect |  4 +
 t/chainlint/here-doc-multi-line-string.test   |  8 ++
 t/chainlint/here-doc.expect                   |  6 ++
 t/chainlint/here-doc.test                     | 21 ++++
 ...ti-line-nested-command-substitution.expect | 11 ++-
 ...ulti-line-nested-command-substitution.test | 11 ++-
 t/chainlint/multi-line-string.expect          | 10 +-
 t/chainlint/multi-line-string.test            | 12 +++
 t/chainlint/nested-here-doc.expect            |  2 +
 t/chainlint/nested-here-doc.test              | 10 ++
 t/chainlint/subshell-here-doc.expect          |  6 ++
 t/chainlint/subshell-here-doc.test            | 16 +++
 t/chainlint/t7900-subtree.expect              | 10 ++
 t/chainlint/t7900-subtree.test                | 22 +++++
 19 files changed, 227 insertions(+), 41 deletions(-)
 create mode 100644 t/chainlint/here-doc-close-subshell.expect
 create mode 100644 t/chainlint/here-doc-close-subshell.test
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.expect
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.test
 create mode 100644 t/chainlint/here-doc-multi-line-string.expect
 create mode 100644 t/chainlint/here-doc-multi-line-string.test
 create mode 100644 t/chainlint/t7900-subtree.expect
 create mode 100644 t/chainlint/t7900-subtree.test

Interdiff against v2:
diff --git a/t/chainlint.sed b/t/chainlint.sed
index 8544df38df..1da58b554b 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -94,8 +94,8 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
-	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 	s/[ 	]*<<//
 	:hereslurp
 	N
@@ -159,7 +159,7 @@ s/.*\n//
 }
 :folded
 # here-doc -- swallow it
-/<<[ 	]*[-\\']*[A-Za-z0-9_]/bheredoc
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -281,7 +281,7 @@ bfolded
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
+s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
 :hereslurpsub
 N
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index aff6568716..534b065e38 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -4,4 +4,6 @@ cat >foo &&
 
 cat >bar &&
 
+cat >boo &&
+
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index f2bb14b693..ad4ce8afd9 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -21,6 +21,13 @@ boz
 woz
 FUMP
 
+# LINT: swallow "quoted" here-doc
+cat <<"zump" >boo &&
+snoz
+boz
+woz
+zump
+
 # LINT: swallow here-doc (EOF is last line of test)
 horticulture <<\EOF
 gomez
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 7663ea7fc4..74723e7340 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -6,5 +6,6 @@
 (
 	cat >bup &&
 	cat >bup2 &&
+	cat >bup3 &&
 	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index b6b5a9b33a..f6b3ba4214 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -31,6 +31,9 @@
 	glink
 	FIZZ
 	ARBITRARY2
+	cat <<-"ARBITRARY3" >bup3 &&
+	glink
+	FIZZ
+	ARBITRARY3
 	meep
 )
-- 
2.18.0.267.gbc8be36ecb

