Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075761F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeHOVjh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:37 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:56285 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeHOVjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:35 -0400
Received: by mail-it0-f67.google.com with SMTP id d10-v6so3007197itj.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mXY3ZaX9rdFBfrGiRF4se6WnLpPc/CAp616YI4ghT2Y=;
        b=HMdVZVg9sA4bxQuBKhPjkGv60uwfTY4dfAz7TJi/074sOeK7AST2ZCasDLkoTc2MsF
         vXIDs1L+rk2gkNQBezEIr2mKtFyicSBaGrOXZjPk+BZD+wxXuN+m7gTiYxxL6iDymQFP
         4OXDZarWQ9a5YBOL02N6705bGpafOWOsPwQqMCcFvIhQD7ZvD2mVPMOZZLPo6THeYMth
         9Tgr20+SHJt3nm02gZcuwAtHptTMkNpt0kkoE01qKAbxk8TVZEqRS9MT34Vv/dFpi8hk
         hBiksIQ66xPgOiNIk89h86lrxEZhjj7IXad6shmo/3OQ1YrhAPT1HWD89HOVgJrOeZgH
         stMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mXY3ZaX9rdFBfrGiRF4se6WnLpPc/CAp616YI4ghT2Y=;
        b=X4t6a3bxxJMUBkYEWzylHS7CPrt21dURooJ8TL860eBMa8pJNv2ehxaPB0vbmk7OoG
         uPm9tSoqnZy2tuxaeT1RQSv0VATg1cUOe0lZt0IQPBryaXUuZ4JCLhkOKhJgFuPS3x7K
         u1+NY8fMzrYz2BI2pTE4/TutSRM3HMGz1gJFnRdEw7aWk/7Uot4WYFpwgnWK2UNqY+ww
         ilINDkl7NQm093wGLfX7kDG2a9HhkBCdKx28D2Sgcdqu95rQ7toUuoftVDQfk+VvKe5a
         r5JyHNoiowAI6UcEMZzuR4dcVcK09vNjVZfpwZ4knn2JZgo6C4T4zv2Jf1PxBJydWVmO
         TIFA==
X-Gm-Message-State: AOUpUlH+2WN7J2lyLtubJvsWMQGgrounfVtmHiX84omGB4gPR6WHJtsB
        31EQ5rDVmlkT95MZ8+sGh6l8BCij
X-Google-Smtp-Source: AA+uWPwLi0W6q3soKpeegU5WlqminHxD0qSvPiZAxuIvj7ixGfBWgVJlXNQOWV3/WAkm72lX2Tt9ow==
X-Received: by 2002:a02:970a:: with SMTP id x10-v6mr22538019jai.137.1534358776265;
        Wed, 15 Aug 2018 11:46:16 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:15 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/6] chainlint: match quoted here-doc tags
Date:   Wed, 15 Aug 2018 14:45:48 -0400
Message-Id: <20180815184552.8418-3-sunshine@sunshineco.com>
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

A here-doc tag can be quoted ('EOF'/"EOF") or escaped (\EOF) to suppress
interpolation within the body. Although, chainlint recognizes escaped
tags, it does not know about quoted tags. For completeness, teach it to
recognize quoted tags, as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                      |  8 ++++----
 t/chainlint/here-doc.expect          |  4 ++++
 t/chainlint/here-doc.test            | 14 ++++++++++++++
 t/chainlint/subshell-here-doc.expect |  2 ++
 t/chainlint/subshell-here-doc.test   |  8 ++++++++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 2af1a687f8..07c624fe09 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -94,8 +94,8 @@
 
 # here-doc -- swallow it to avoid false hits within its body (but keep the
 # command to which it was attached)
-/<<[ 	]*[-\\]*[A-Za-z0-9_]/ {
-	s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/ {
+	s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 	s/[ 	]*<<//
 	:hereslurp
 	N
@@ -158,7 +158,7 @@ s/.*\n//
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
 # here-doc -- swallow it
-/<<[ 	]*[-\\]*[A-Za-z0-9_]/bheredoc
+/<<[ 	]*[-\\'"]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
@@ -268,7 +268,7 @@ bcheckchain
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
+s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
 :hereslurpsub
 N
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 33bc3cc0b4..534b065e38 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -2,4 +2,8 @@ boodle wobba        gorgo snoot        wafta snurb &&
 
 cat >foo &&
 
+cat >bar &&
+
+cat >boo &&
+
 horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
index 8986eefe74..ad4ce8afd9 100644
--- a/t/chainlint/here-doc.test
+++ b/t/chainlint/here-doc.test
@@ -14,6 +14,20 @@ boz
 woz
 Arbitrary_Tag_42
 
+# LINT: swallow 'quoted' here-doc
+cat <<'FUMP' >bar &&
+snoz
+boz
+woz
+FUMP
+
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
index 7c2da63bc7..74723e7340 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -5,5 +5,7 @@
 >) &&
 (
 	cat >bup &&
+	cat >bup2 &&
+	cat >bup3 &&
 	meep
 >)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
index 05139af0b5..f6b3ba4214 100644
--- a/t/chainlint/subshell-here-doc.test
+++ b/t/chainlint/subshell-here-doc.test
@@ -27,5 +27,13 @@
 	glink
 	FIZZ
 	ARBITRARY
+	cat <<-'ARBITRARY2' >bup2 &&
+	glink
+	FIZZ
+	ARBITRARY2
+	cat <<-"ARBITRARY3" >bup3 &&
+	glink
+	FIZZ
+	ARBITRARY3
 	meep
 )
-- 
2.18.0.267.gbc8be36ecb

