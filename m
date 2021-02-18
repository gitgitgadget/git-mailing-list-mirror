Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1885CC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D777764D9A
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBRAJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBRAI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C2C06178B
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:37 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o24so6286622wmh.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fr2c4hfFkVpZ8moOaf5/5ZSQdkrVLMKzsAkwXrHRcAs=;
        b=j9brlou8wu8NJ9BpqxaP5pfwSz+X5WGfkbwmBRPl6WQKAc+erGQpm+Bji6+EpTzINC
         JMDvDUtjJTndolm3gpPNr3G2bzO1nRmTU5GRwgLopsEeIT1m83+4D3SY09POvyzWPFx7
         EGmgSxWMhlCMGgMjLF+KW1HH9f1OCe+n+BVMZZLN2tKjI/ImCMZbnAmsZYAS81JJSEsy
         VnuRskcMbQNkpgjP/0mSmj+bb7wmC8V6T4l9jZHE5hETJiJT+PlXmAMUgn0D4KyYy56T
         +mMQNAEG8Qus/0LiVj9wJngo9//6vwLW4iupz4RHz7xvOKGVMq3yLcAMLbnOMTzoBNJi
         5o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fr2c4hfFkVpZ8moOaf5/5ZSQdkrVLMKzsAkwXrHRcAs=;
        b=R5L2PSv3XSIL1BwOyhh6WVlHOJ7kx2PJG5ZUzdlnnYrzg2OkFG/C2BPXa7uJwPkUOB
         YcszLhMmvkYyhMDl/mqYqk59Vn1FIcigBrDZWP1M7FRpCFgmQnX9KDfmMc+/oRXl6tP0
         L01BAHfRvk39BRIRgO32icoId/y+zXC8+6xPDsgv+qB3uzUJNCfTpraf2+PCGTXXYg7C
         ly8cpIsLvhuau4TVfMpVx4V6KHlAQzw8yuZqfWatu4Djtx9ZA5HhkBZDc/j0irTUCb+N
         o8eIvTRFwiosbLFnp3yRZaDUdJxQMjjRuSVNbk393oMM8cg4bFYZBWkPC1GbP+wqcob4
         X2fw==
X-Gm-Message-State: AOAM533oHoeQCXgRo5lGD7CgQcu+/xSOoLSJIOPtRQbHUhbrs/0bAblQ
        s1GviZfh4cW3lOVQBuG+rM2yuEaCZrwwyQ==
X-Google-Smtp-Source: ABdhPJwBGwN28VfN4jxkKrzFOxSm10tq3bCxA7+7B2vYbDUn2rNfe7KXm56YNzidvutBFVWpeAMZqw==
X-Received: by 2002:a1c:e145:: with SMTP id y66mr1054214wmg.145.1613606856248;
        Wed, 17 Feb 2021 16:07:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] grep/pcre2: use compile-time PCREv2 version test
Date:   Thu, 18 Feb 2021 01:07:24 +0100
Message-Id: <20210218000728.13995-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a use of pcre2_config(PCRE2_CONFIG_VERSION, ...) which I added
in 95ca1f987ed (grep/pcre2: better support invalid UTF-8 haystacks,
2021-01-24) with the same test done at compile-time.

It might be cuter to do this at runtime since we don't have to do the
"major >= 11 || (major >= 10 && ...)" test. But in the next commit
we'll add another version comparison that absolutely needs to be done
at compile-time, so we're better of being consistent across the board.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 18 ++++--------------
 grep.h |  3 +++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/grep.c b/grep.c
index 7d262a23d88..e58044474dc 100644
--- a/grep.c
+++ b/grep.c
@@ -400,21 +400,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
+#ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER
 	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
-	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS)) {
-		struct strbuf buf;
-		int len;
-		int err;
-
-		if ((len = pcre2_config(PCRE2_CONFIG_VERSION, NULL)) < 0)
-			BUG("pcre2_config(..., NULL) failed: %d", len);
-		strbuf_init(&buf, len + 1);
-		if ((err = pcre2_config(PCRE2_CONFIG_VERSION, buf.buf)) < 0)
-			BUG("pcre2_config(..., buf.buf) failed: %d", err);
-		if (versioncmp(buf.buf, "10.36") < 0)
-			options |= PCRE2_NO_START_OPTIMIZE;
-		strbuf_release(&buf);
-	}
+	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
+		options |= PCRE2_NO_START_OPTIMIZE;
+#endif
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
 					 p->patternlen, options, &error, &erroffset,
diff --git a/grep.h b/grep.h
index ae89d6254b3..54e52042cb9 100644
--- a/grep.h
+++ b/grep.h
@@ -4,6 +4,9 @@
 #ifdef USE_LIBPCRE2
 #define PCRE2_CODE_UNIT_WIDTH 8
 #include <pcre2.h>
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_36_OR_HIGHER
+#endif
 #else
 typedef int pcre2_code;
 typedef int pcre2_match_data;
-- 
2.30.0.284.gd98b1dd5eaa7

