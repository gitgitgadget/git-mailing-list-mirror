Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60881C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334AE20721
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGxr6Wpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgAJPGM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:06:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39345 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAJPGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 10:06:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so2085878qko.6
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSnjhvA55FZAe35aLhjH0fhzrLCsNijt3QeSM+UsyvY=;
        b=CGxr6WpyF114bcvKp9DiDrFSHE+ORd6cQQRt1O+6xFKnwaX13FQYehpRTPfUrYyyp8
         tBS6+VKjIUzbvY3kdjF/zhlRANrI75xX7DK1i2YEiUchs1rHIBP8qKxoslftbK4ULA+Z
         GIcPZV3eGe80HuJkGiKY902eB7hwhKVP5RWSiSFA474O0IUvTJ6kaUFCObLM3ly6oV6J
         TrR/we2so9lt/cWpfMpgMx3p30BlQ2J16TrvSZPxVGZL/VMAY2Lgjs46/4b3Ixhnhu26
         SBOR7rO7uqgHhTZOFu+uW6u7feWlT7CJdOA9BsZHeMUaTLRbIs1c86QK5Y0p6758HGHn
         //nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSnjhvA55FZAe35aLhjH0fhzrLCsNijt3QeSM+UsyvY=;
        b=fTXmTx4RCijjF9HVFwG0ft6rgzgZmXAirqYr7FMkVwAIkcW/gDeorejmdBcna/ogUY
         pw2QNouS73/yrh0CjI0xHap4FB7p2N83fqEx3+g7Q3XQS46jinsvILKumLAbnHSKb2jV
         C5h3F+nrdRFa7QadK3ToCjVAh4FzEPRwkM8HS38gmqL/4k1J89WGsOoC2CTOU7i7Drks
         INHQwKr4PHfSYn6gp1f+J91nfhnce2ope1+dcVa/9wlC9G2nj5TK1bxxbLOBipWY53k/
         C1s8Ylms/6L0ZcV70y0vFeMzmVPd8jCtbEnRk+FsGaBEgzEufbL5Lp4v/VvQuQgqKa64
         xqiA==
X-Gm-Message-State: APjAAAW2rtDiu7TJBub603Q7E4zotM9BEmXBvFmkf4gZCS5+B/BphpyT
        SmxEdDfBadET39UniG0ZMbhlyjgfkkQ=
X-Google-Smtp-Source: APXvYqyxzo2qZBHk9MV+7eOQsnOTECU2nFRAsSE45iH6+UlEaLPar5/kGlK6hnEoj3M1yQSbO+vKpQ==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr3688233qkb.215.1578668770772;
        Fri, 10 Jan 2020 07:06:10 -0800 (PST)
Received: from eyalsoha.corp.google.com ([2620:0:1003:512:ad66:81e4:4335:3c9d])
        by smtp.gmail.com with ESMTPSA id s20sm956258qkg.131.2020.01.10.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:06:09 -0800 (PST)
From:   Eyal Soha <shawarmakarma@gmail.com>
To:     peff@peff.net, git@vger.kernel.org
Cc:     Eyal Soha <shawarmakarma@gmail.com>
Subject: [PATCH 3/3] color.c: Alias RGB colors 8-15 to aixterm colors
Date:   Fri, 10 Jan 2020 10:05:47 -0500
Message-Id: <20200110150547.221314-3-shawarmakarma@gmail.com>
X-Mailer: git-send-email 2.24.1.591.g12029dc57d.dirty
In-Reply-To: <20200110150547.221314-1-shawarmakarma@gmail.com>
References: <20200110111516.GA474613@coredump.intra.peff.net>
 <20200110150547.221314-1-shawarmakarma@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
---
 color.c          | 7 ++++++-
 t/t4026-color.sh | 4 ++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/color.c b/color.c
index 4dbf12eff8..7f9f929fb6 100644
--- a/color.c
+++ b/color.c
@@ -132,11 +132,16 @@ static int parse_color(struct color *out, const char *name, int len)
 		else if (val < 0) {
 			out->type = COLOR_NORMAL;
 			return 0;
-		/* Rewrite low numbers as more-portable standard colors. */
+		/* Rewrite 0-7 as more-portable standard colors. */
 		} else if (val < 8) {
 			out->type = COLOR_ANSI;
 			out->value = val + COLOR_FOREGROUND_ANSI;
 			return 0;
+		/* Rewrite 8-15 as more-portable aixterm colors. */
+		} else if (val < 16) {
+			out->type = COLOR_ANSI;
+			out->value = val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;
+			return 0;
 		} else if (val < 256) {
 			out->type = COLOR_256;
 			out->value = val;
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 78c69de90a..c0b642c1ab 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -82,6 +82,10 @@ test_expect_success '0-7 are aliases for basic ANSI color names' '
 	color "0 7" "[30;47m"
 '
 
+test_expect_success '8-15 are aliases for aixterm color names' '
+	color "12 13" "[94;105m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
-- 
2.24.1.591.g12029dc57d.dirty

