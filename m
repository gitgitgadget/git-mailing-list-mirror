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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283ACC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FAF64F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBCD3n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhBCD3j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BFC06178C
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id g10so22585509wrx.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hN5eqxAbcgOVluoOGksJ+3Djft9wOOrqeKVpO1EdDw4=;
        b=cysloLqFYDyiJADv2++3lG5yNYKy5JyMg58dEoEqI2dLKY9HEMzucQtQUKuTHaVNLu
         ius/UZExQefXqYeXkXzlRuU/pBOgnAMRtp3gdIOp39Bge8ZXDQ7Rk+Thm+LuujffMv+n
         0mtxZ1RbTDwC1nP7rnhg79Yt6C0b/mhXLJeLkt371S7Py7ZKlvhviZJtaglE3Ty+Y91M
         xG6sv/a1HcVAPMZGRAATH9QkhUpIrDOBi1O4nV+qp5W3Q1w6urYAp97SJRZwN3/Ouxov
         WjXgDz1mf5mHhHNvqmKpZR0kZvILZDFAM5xMzt3gN0sYaZeaKB9l1pv69+NGmhF0OXRw
         fgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hN5eqxAbcgOVluoOGksJ+3Djft9wOOrqeKVpO1EdDw4=;
        b=c7EIMkIXtMddgEmN5s3BaMOwNrsLluexLmb6vtaPH4SMKG37fiojKLSVAywm8Squw6
         9v3tqxzKzbilcX9kCk8oUDAIrFA8sLutW6Q4FMvwLTySiWI6qF80DaysfM3N+a+LcaHK
         iWnn0Z+MIXqHfMt5hLzW1G6EXI1sZ+sspLEFlCJ4UXl1wvhdhJTWJ9M39Jm8+M2zIC7E
         naeSODyq+ANVlQH7qUw7slHl/Uc9HtueldAA6StYLvxdgApvFpUkc9zGNsWc+L0NWHSC
         mA84zjI15gm1bhks50aM9Sk2gheAqozo2YnuFjMKjOj0Xg+6GoNI3b7k0Uh8cVK+5j7W
         7zQA==
X-Gm-Message-State: AOAM531hepSGmFWp2Axf9UPh5/BUy8Pds6HO5IpYVipWWFcurvSorSIv
        NMIuvdDGhodxyQjDiqN7hKOWKgqG8MXvLA==
X-Google-Smtp-Source: ABdhPJwT+l6rrZIB6Jfhtuq6WsjMn/A62YzIdQkqtCLvL5Y0GGTIYhLsc4672DIbm/YqC+UxLw1MzA==
X-Received: by 2002:a05:6000:1803:: with SMTP id m3mr1066870wrh.34.1612322903477;
        Tue, 02 Feb 2021 19:28:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/25] grep/pcre2: use compile-time PCREv2 version test
Date:   Wed,  3 Feb 2021 04:27:53 +0100
Message-Id: <20210203032811.14979-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
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

