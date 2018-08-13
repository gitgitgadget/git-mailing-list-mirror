Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 612941F428
	for <e@80x24.org>; Mon, 13 Aug 2018 08:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbeHML3d (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 07:29:33 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35045 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeHML3c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 07:29:32 -0400
Received: by mail-it0-f50.google.com with SMTP id 139-v6so12667649itf.0
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMUgqQdxGWddaf6PzKcMS3umIPTPXJS+RBhNFN4oxiM=;
        b=K8Xb+To0Lckll5DXe+jkC9oxwSt96W8/28EJBWOI6FjYRXRUPGQdkCaoTSppO4VyZD
         tViJJOTCYJ8L5QzFIML0M4Pd18+EJnlv7zMuMgIY1bD8GPC+spTQfZQCF+9eJRFozNrY
         tmAjVZrMuiIvbjIHZ2Hz8NRM2ExjE2yC7nbw+RSEZZRSqsCac9lGuXcZ0xB/0rfTMa73
         aEEBFhQj2hV1extgCZ78E8vXEblS+S8VGXNFJgH5dXQ7qvlrrY+NJTWXJVo2lH38mVon
         BZ8TLizNvcZft/R8pV2bzUUoz4gMw76wDOwlX7DEwCKktckHZLpBkaDlnIsXVD+sOdo4
         sZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bMUgqQdxGWddaf6PzKcMS3umIPTPXJS+RBhNFN4oxiM=;
        b=N/BIf9UooBv+78guS4r/+FW6WO0vVuMMWMR7EnCzQzMlH5l7xjniXfBsumvwYEKWnN
         nWSTnpkHxvEBESYlmd707EWFnK7xgCT+ux1eM2+LcJchZSdk+xPzsezMrSkfgmf134nS
         0RokTihaTRnfQQtYdNqYzO5CetjKWdqyeSFYe7wDsVPo5r/FbL4Tpv2X8nOFu2gR8dF4
         DzVVmuOKTUFg6tXz4LWDMITWJLLXn5C9W014dx+CVy2kvBlPLwAM2/0V39yIvP/jlWj9
         Uuw5LZ533pD6g+UcayNyR9axKJRa/8Mi/OoLpIQryNpZ7ph1kObR0jfVZT90AYPfsmZD
         kepA==
X-Gm-Message-State: AOUpUlGnT6HxIIvwtPO9ec/c5HLmjRnCJjK3fD5JLJZtQuOEvTDFE2n0
        F0LHfl62cU/AifGw4P4FyXgvkel8
X-Google-Smtp-Source: AA+uWPzWTJJNu5kpeVlZJ1RiDuy5An+Jj6B288WcxNN9LrNRog3zX0MyC6p+Li8KeHZLpadszHWJzQ==
X-Received: by 2002:a24:d104:: with SMTP id w4-v6mr9536547itg.29.1534150096067;
        Mon, 13 Aug 2018 01:48:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g23-v6sm5609405iob.88.2018.08.13.01.48.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 01:48:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/6] chainlint: match 'quoted' here-doc tags
Date:   Mon, 13 Aug 2018 04:47:35 -0400
Message-Id: <20180813084739.16134-3-sunshine@sunshineco.com>
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

A here-doc tag can be quoted ('EOF') or escaped (\EOF) to suppress
interpolation within the body. Although, chainlint recognizes escaped
tags, it does not know about quoted tags. For completeness, teach it to
recognize quoted tags, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                      | 8 ++++----
 t/chainlint/here-doc.expect          | 2 ++
 t/chainlint/here-doc.test            | 7 +++++++
 t/chainlint/subshell-here-doc.expect | 1 +
 t/chainlint/subshell-here-doc.test   | 4 ++++
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 2af1a687f8..2901494e8a 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -94,8 +94,8 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\]*[A-Za-z0-9_]/ {
-	s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+/<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 	s/[ 	]*<<//
 	:hereslurp
 	N
@@ -158,7 +158,7 @@ s/.*\n//
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
 # here-doc -- swallow it
-/<<[ 	]*[-\\]*[A-Za-z0-9_]/bheredoc
+/<<[ 	]*[-\\']*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -268,7 +268,7 @@ bcheckchain
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 s/[ 	]*<<//
 :hereslurpsub
 N
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 33bc3cc0b4..aff6568716 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -2,4 +2,6 @@ boodle wobba        gorgo snoot        wafta snurb &&
 
 cat >foo &&
 
+cat >bar &&
+
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index 8986eefe74..f2bb14b693 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -14,6 +14,13 @@ boz
 woz
 Arbitrary_Tag_42
 
+# LINT: swallow 'quoted' here-doc
+cat <<'FUMP' >bar &&
+snoz
+boz
+woz
+FUMP
+
 # LINT: swallow here-doc (EOF is last line of test)
 horticulture <<\EOF
 gomez
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index 7c2da63bc7..7663ea7fc4 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -5,5 +5,6 @@
 >) &&
 (
 	cat >bup &&
+	cat >bup2 &&
 	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index 05139af0b5..b6b5a9b33a 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -27,5 +27,9 @@
 	glink
 	FIZZ
 	ARBITRARY
+	cat <<-'ARBITRARY2' >bup2 &&
+	glink
+	FIZZ
+	ARBITRARY2
 	meep
 )
-- 
2.18.0.267.gbc8be36ecb

