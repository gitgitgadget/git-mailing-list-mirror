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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96512C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705A560FD8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbhERGUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346529AbhERGUn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:20:43 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EBC06175F
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:19:25 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id i5so6317460pgm.0
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnQloWP2jR/HnhDnkIow2yJqpLylPPjYtNg39bP0qes=;
        b=uN2+kZMQdaKbuDBKBt7EmIlaHVeiFO78pPZu+NImxW3cLGCRV8v3NEenwp/qnYgPGs
         Y9Bqs+hn16ZLSaaeNysKMFmawEJRd6lc+yUn0r7v7wsZRf2FWDX7v0loIaHwvCHiiuXq
         OW51VTVSYaGWqYZt3x5Y1La13tT6Bm4Z7m2MJ/sx6GI9Rld8TKQ/d2Zvf7gAuVW2VcML
         DqZhDfgKvCgxP4zDZWoa8ZsOTSHoezm5lHsSwfAt3hxbaA3i+7tWDt+OmWUEkmk2gWq+
         Aq00cKNJWkC03oTD8K5Z0p1pXKhznqFR4cmi2jl8V4KwwbXhZOHeet6FEcKtqy1BS09T
         86LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnQloWP2jR/HnhDnkIow2yJqpLylPPjYtNg39bP0qes=;
        b=kiRvqr7kxjD4kGLOZ+kB/yz3f03b5WLqoJAZNjkTwDSbZfsCFgjHUN8OQW5Y+6TT+o
         u0A+3yjSXMCj+HdyBP5CMl4EhzfiADGPx0eYqCdGhwWgKkndnUUyBdX8Dl0lQS0XWMNo
         qRKfe63OCTN5RSOHCqzmhVeJgTwiCDjiHG7uJaUl/y8yprYfz1/vczjhv75zTVBS5uyx
         bBuIo+WFUM644GsumkiMxDuUj1BO6XiGWX11NamVYuJrq28F7DvyvIG7zC1pcWfNnlrv
         yPrYul0GjqyXOj7wcmcUPz7y8y13u/Uha0Z1YaxJlIL4c6X3IZ69RLfjmY/VN8uAOROR
         xklQ==
X-Gm-Message-State: AOAM532w38MxOJDGeXDz1cjKo16w548VqCWaWklCZ8Qk1856G+q7wey9
        LotamGNWvoNrngTc+aNYzYLXDyAPUQY=
X-Google-Smtp-Source: ABdhPJwUmiLbcfd6eecz6jlNJMRpGN27cADF+Y3PldRESM93eaj8gVv/wJQh2RQFvRpxQV6WbWKJVw==
X-Received: by 2002:a63:175e:: with SMTP id 30mr3499425pgx.48.1621318764997;
        Mon, 17 May 2021 23:19:24 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id x21sm6742995pfr.124.2021.05.17.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 23:19:24 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] setup: split "extensions found" messages into singular and plural
Date:   Tue, 18 May 2021 00:19:17 -0600
Message-Id: <20210518061917.57556-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easier to translate this way.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 setup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 59e2facd9d..ead2f80cd8 100644
--- a/setup.c
+++ b/setup.c
@@ -666,7 +666,9 @@ int verify_repository_format(const struct repository_format *format,
 	if (format->version >= 1 && format->unknown_extensions.nr) {
 		int i;
 
-		strbuf_addstr(err, _("unknown repository extensions found:"));
+		strbuf_addstr(err, Q_("unknown repository extension found:",
+				      "unknown repository extensions found:",
+				      format->unknown_extensions.nr));
 
 		for (i = 0; i < format->unknown_extensions.nr; i++)
 			strbuf_addf(err, "\n\t%s",
@@ -678,7 +680,9 @@ int verify_repository_format(const struct repository_format *format,
 		int i;
 
 		strbuf_addstr(err,
-			      _("repo version is 0, but v1-only extensions found:"));
+			      Q_("repo version is 0, but v1-only extension found:",
+				 "repo version is 0, but v1-only extensions found:",
+				 format->v1_only_extensions.nr));
 
 		for (i = 0; i < format->v1_only_extensions.nr; i++)
 			strbuf_addf(err, "\n\t%s",
-- 
2.31.1

