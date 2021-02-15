Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AEEC433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BCA64E56
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBOAzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhBOAyi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:54:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CBFC061356
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:12 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id x4so6503605wmi.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oM3HQNyR2za0oGTolLI2lA7mIStPA4ZEqd0a5CNNwx8=;
        b=MZJ2TGUrSM1kRhN6dU9N2AIdVXwTvT9vmXWMl2MIf6YVaUniz0fvyQ/2Gh6tXBp/8t
         91IVPwyJALwgfw6sV6KLph+bmIZDAi+RmZ1N+s7c8zY1WgGkE+Pd7WOzQaKOpq0YaY17
         ztBEHsbzuBPr283SsoaIUivubSeobkQgVrAQQ3VAxFwlMKY+fkzNEG2Ob7lhmTEsNAW5
         IouEEeGOOT73UNOGGw8owZzscdV+WUAbvnm1Ogzt5LKNBe9orY9IZJQdz5qmg1a03y60
         qBgiqhZfsUmw731Td7WTVifQaqEsrhGLZuqv1LTBBNKK8ubUbs5Ao0s1KVTSBiECCVT0
         5jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oM3HQNyR2za0oGTolLI2lA7mIStPA4ZEqd0a5CNNwx8=;
        b=sZA/EZBthXYj9loDZ71YorRGjwMLNIvcDWmkG/lZcN7LczwRcKcvhL6TCs0JAp3uDp
         goLrxhEvbQWQy6pRRWU9CXqwZU1iwX7meUi3Iy9OIUglzLreowRStYMLgpfaSZFqQWOc
         bVrSlfnIbnFhyka+TbqY73/qIO4+DGseRKhUj8k//ovbvZvalCqzc2HACvaKgK8vIqPg
         h9iLwZPFVVSz4cPDZgORktcTkQrV4PO7aA9CRCOlfu/MXFX+ismMOtRaIvANKcXTn16b
         SzX2klP2Hv2vggRE2xhztXgJHIu22DjGX9hoP1yga19w1yvNKhx73ymUhSryB4m/MTPQ
         ALjw==
X-Gm-Message-State: AOAM5310tnridKtWgJ04YflT2HE9n2JqkqCMphzjnNJ/GkMIpo9aBHXG
        d+8Za0/pFegu7nNkP/k6bmPWnkY+lt5dzQ==
X-Google-Smtp-Source: ABdhPJy8eAHA2zy8SZI08HZJzuLcDjAECTTRFLPSiE91BKDKFU08Zdx3nT0F9DC0WFzK0vPmzcrcYQ==
X-Received: by 2002:a05:600c:204b:: with SMTP id p11mr11901781wmg.129.1613350391163;
        Sun, 14 Feb 2021 16:53:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/20] gitattributes doc: document multi-line userdiff patterns
Date:   Mon, 15 Feb 2021 01:52:31 +0100
Message-Id: <20210215005236.11313-16-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the multi-line userdiff patterns and how their matching and
the negation syntax works.

These patterns have been supported since f258475a6e (Per-path
attribute based hunk header selection., 2007-07-06), and have had
their current semantics ever since 3d8dccd74a (diff: fix "multiple
regexp" semantics to find hunk header comment, 2008-09-20).

But we had no documentation for them, let's fix that, and also add
tests showing how some of the things being discussed here work.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/gitattributes.txt | 17 ++++++++++++++++
 t/t4018/custom.sh               | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 90992e2136..225c17b90d 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -794,6 +794,23 @@ backslashes; the pattern above picks a line that begins with a
 backslash, and zero or more occurrences of `sub` followed by
 `section` followed by open brace, to the end of line.
 
+Multiple patterns can be supplied by seperating them with
+newlines. They will be matched one at a time and are compiled as
+separate patterns, and thus the first capture in each such pattern is
+`$1`, see further discussion of captures below.
+
+Patterns that begin with "!" are negated (to match a literal "!" at
+the start of a line use e.g. "[!]"). A matching negated pattern will
+cause the matching line to be skipped. Use it to blacklist otherwise
+matching non-negated patterns. The last pattern must not be negated,
+we'll error out if that's the case.
+
+If the pattern contains a `$1` capture it will be used instead of the
+entire matching line (`$0`) to display the hunk header. This can be
+used e.g. to strip whitespace from the beginning of the line, or to
+only display the function name as part of a longer function
+definition.
+
 There are built-in patterns shipped as part of git itself. A more
 advanced version of the `tex` pattern discussed above is one of them.
 
diff --git a/t/t4018/custom.sh b/t/t4018/custom.sh
index b68d96a8af..cccf468c3a 100755
--- a/t/t4018/custom.sh
+++ b/t/t4018/custom.sh
@@ -122,3 +122,38 @@ test_expect_success 'custom: teardown' '
 	test_unconfig diff.custom.funcname &&
 	test_unconfig diff.custom.xfuncname
 '
+
+test_expect_success 'custom: negation syntax, ! is magic' '
+	git config diff.custom.xfuncname "!negation
+line"
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+line
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
+test_expect_success 'custom: negation syntax, use [!] to override ! magic' '
+	git config diff.custom.xfuncname "[!]negation
+line"
+'
+
+test_diff_funcname 'custom: config precedence' \
+	8<<\EOF_HUNK 9<<\EOF_TEST
+!negation
+EOF_HUNK
+line
+!negation
+
+ChangeMe
+
+baz
+EOF_TEST
+
-- 
2.30.0.284.gd98b1dd5eaa7

