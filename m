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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63710C433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C2364E27
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhBOAxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhBOAxm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:53:42 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE2C061756
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so7162022wrd.6
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DOUQxhcdhCaGf/O5jFWwCNwL+C49UskrpGE3NVYUJM4=;
        b=TfPlVrI7SgB+setL66teG2U1Iumz99Kbmh3o1+yP2YiZsMTE4bhR8lHMZ/sxKaiarw
         rVZpWddP+TSZCK6oO4c6l9Guh1SoNQta2lM+5pIlxusXq8jBLWimMZcmrjMkx7pYIgYM
         08en4pT6mbomgxW5anOxKezKj55J3bUteabQrS7xaHVvV6cwjuJ2SH8AmQWGqORN88W6
         JfmwLeKVct7dCC9ZR/R1rvqspHQb/TTSKqtaO5jy0WJMGVlD2DWM7JfbLHAC0FmSueL7
         wSjMH5D4OquW7uUAgUCyHk3vgc1ngT8PeDwfiXNeVL2/eGlfdjVRw+VDaCNxBIS4V5CF
         dfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOUQxhcdhCaGf/O5jFWwCNwL+C49UskrpGE3NVYUJM4=;
        b=n0gdHcrDFfGelylWobFjof9CHTUn439F4cBpmeDm/1z0ycbQ5aJZK1NJGpEWjbsKcz
         Xc0uuif0S7peqemXZ86iO7i68UMV/TaeZ9x/MSzs1IiLlLqV/mywBNO4VhqswxmIiv6w
         5Q0HVHWpBN7P73JMkXE1Xbi4jCECwSHeG4ipx2vbZqTCbgZtLS7TYaKVZUrVF9LAvxW/
         E2AttNhe1sDSqQmbRnlVEgT6CnDuCvSkBl0fpXJfLjwBMGcthbFNp+49hJEd/7z2jW3p
         a8Fvji5rdyQHRFcxth1nXbUiF1N8CuxO/nbx+wDsxSM518jCyM4QHTh+XDas0qjYYxwq
         jk7A==
X-Gm-Message-State: AOAM532SE6QthIaOClSOZlGheuR/0Bu6On3qmlIL8seQCRs41OZTzCQk
        J9zvKMDLRjmcCGIxmORPVQNH4LFY8nsrog==
X-Google-Smtp-Source: ABdhPJzCDHmdsWP1diRzxTP2XLJpAQsSosQAA+6+e+FqDpNYXE5sUt5uTnRctbwRSFIum6C14eJ1Kg==
X-Received: by 2002:adf:e809:: with SMTP id o9mr16175042wrm.137.1613350380004;
        Sun, 14 Feb 2021 16:53:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:52:59 -0800 (PST)
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
Subject: [PATCH 01/20] userdiff: refactor away the parse_bool() function
Date:   Mon, 15 Feb 2021 01:52:17 +0100
Message-Id: <20210215005236.11313-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 6680a0874f (drop odd return value semantics from
userdiff_config, 2012-02-07) we have not cared about the return values
of parse_tristate() or git_config_bool() v.s. falling through in
userdiff_config(), so let's do so in those cases to make the code
easier to read.

Having a wrapper function for git_config_bool() dates back to
d9bae1a178 (diff: cache textconv output, 2010-04-01) and
122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05), both of
which predated the change in 6680a0874f which made their return values
redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 userdiff.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 3f81a2261c..c147bcbb17 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -275,19 +275,12 @@ static int parse_funcname(struct userdiff_funcname *f, const char *k,
 	return 0;
 }
 
-static int parse_tristate(int *b, const char *k, const char *v)
+static void parse_tristate(int *b, const char *k, const char *v)
 {
 	if (v && !strcasecmp(v, "auto"))
 		*b = -1;
 	else
 		*b = git_config_bool(k, v);
-	return 0;
-}
-
-static int parse_bool(int *b, const char *k, const char *v)
-{
-	*b = git_config_bool(k, v);
-	return 0;
 }
 
 int userdiff_config(const char *k, const char *v)
@@ -312,16 +305,17 @@ int userdiff_config(const char *k, const char *v)
 		return parse_funcname(&drv->funcname, k, v, 0);
 	if (!strcmp(type, "xfuncname"))
 		return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
-	if (!strcmp(type, "binary"))
-		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
 		return git_config_string(&drv->external, k, v);
 	if (!strcmp(type, "textconv"))
 		return git_config_string(&drv->textconv, k, v);
-	if (!strcmp(type, "cachetextconv"))
-		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
 		return git_config_string(&drv->word_regex, k, v);
+	/* Don't care about the parse errors for these, fallthrough */
+	if (!strcmp(type, "cachetextconv"))
+		drv->textconv_want_cache = git_config_bool(k, v);
+	if (!strcmp(type, "binary"))
+		parse_tristate(&drv->binary, k, v);
 
 	return 0;
 }
-- 
2.30.0.284.gd98b1dd5eaa7

