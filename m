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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BDC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7867064FA4
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBDVHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhBDVHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:07:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AA6C061793
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so5150338wre.13
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hN5eqxAbcgOVluoOGksJ+3Djft9wOOrqeKVpO1EdDw4=;
        b=Km0tCbhKkV2peaiFGgGwAD2TkBsSCS/8txdk2A4zwHvBiWU816BqtXbLIHGP2N5Ibq
         WO4cUJRz7mCfq3oNzqemTMPIw36Z/PE0PedQPcyUJ7DpPWIn/gUtz2Qx6Tf+rz2LAqfD
         tm1llxK9J6TAu3nzZw2d9lp7NqI4tBe7NXim7I2sOsXKw7WAxuMJD4esa1OINGN2WAmR
         iYSBJa87aGICsvHtE5WjRYjLAHRv9DdtaXmKPSCRNlh3E4XG2+BdZkY9/woO5TyL971Q
         Coqio5Sa5esVtDycH7ItT5rMHTaQuzSJ7H2Ttodo49Pl8ekER3QrVC2WNQLELwYYivEn
         6kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hN5eqxAbcgOVluoOGksJ+3Djft9wOOrqeKVpO1EdDw4=;
        b=OnDbiVVbvMfysd35utjxhSDQsA06yIYGD0TjxUoEEmV/qKN7cdsLz2B+5HtY6OVm4i
         TX9r+6jH7wsulfFFlc1qPxk6pG3Qxsd75Xnv7cG1s5YfvvRCn+ENCEZKOIpOAG9Y388U
         lkfih3BtH7ZHkBGj/1/4w4AzNNybHK6mFkD9ajzqSaXDna8XVaGLCcYDpZWGWeRb68CK
         a1RfmI2c9OX27IR5gp0/CV86ffu0Z0/51K7kGMcBEZG/n/q4DSV5+ITcxPXTZdfprm/d
         W4Lb0SLWdt0VO2S3EKPBHvAfM9CIAoAyTOyXAOgV3WB5COlb3xxVpj7R2at20wrHd15E
         8NcQ==
X-Gm-Message-State: AOAM533kzyeivV1cUmopZGFoebbc5NfeJ5hnXt6u5PaoItN0oZj1+3Ks
        npV2Yrt4HvQJckx7h0IiBNnpAR6sWqTE2Q==
X-Google-Smtp-Source: ABdhPJwfxXJT58wAFLLI/WnleZf09l6ze2ZK0PAsQHSdjLlNfT1/BwbmSOzPnVA0QZoSK1PpHHBpYQ==
X-Received: by 2002:adf:f009:: with SMTP id j9mr1299943wro.35.1612472776451;
        Thu, 04 Feb 2021 13:06:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] grep/pcre2: use compile-time PCREv2 version test
Date:   Thu,  4 Feb 2021 22:05:52 +0100
Message-Id: <20210204210556.25242-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
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
index 7d262a23d8..e58044474d 100644
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
index ae89d6254b..54e52042cb 100644
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

