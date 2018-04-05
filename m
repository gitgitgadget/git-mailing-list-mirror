Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EF91F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbeDEC7U (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:59:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33837 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeDEC7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:59:17 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so17166111plq.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gH6FL75BFg8YQvNVtyY4YrnWLgP4AjFY9tsUqG04EE=;
        b=fUBeZWrEGnJHWUEvSR4Xq2r7bDrCSAF8QuEreGfSY9WQYMM8C2gO6gS5T5IodtV1XR
         m6WP/xK7N3DTVZbsP1ckJtiZbCQQLX/N8Yl3IdVnXPwwnwyOd30jIKdrKVazWmmMbpiG
         kyO1zI4SdvMsdikt5bwQ4yNZROb+IyVuuxlmdvmmTzRQRGhdkiWiv9M8+c0KKW9TW1kp
         3aZsBWPZKz1Ajmj6L+SGo8Oe0ZZUjRR9IlEyND9KSydHToQ3X5i0b/hAMlWqgaWnBVb8
         p+xVE5UCrrqz+KuN6OugtIWCehnfUo3RjHvkdHL9MoQXrdrh5cl6F5R/TN+X7KKkg3i6
         g1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gH6FL75BFg8YQvNVtyY4YrnWLgP4AjFY9tsUqG04EE=;
        b=Mp4K080RvhnuPU12TTfyi629JLLp6gyRkDnepRo4g3iMYL9LsOJzVbq7L/33yxdZCc
         5v79Zpd3yqlpENJ/hnsZPSyXl2EftZRr9POAqoOX5cCaWeI1UkzCz14H3LTHcydOGvGK
         3kUWsivg6eaQmWJAuRDK9uIaxg/nFbPvgVjGQUlPHQ4pPITLIh6ARIpQyRna0UMg5v8G
         h1To/8zidhPpm/A1uJpA/+dxSxha6F3IqcAO79aaFszlIsI7wA/1E4ajiffIf8QfKaR9
         zm6Fdyk86cpzPfH7RhRM6mqbrZuew9ru/U4f1rjiXIaDGJpqvhd3qh2+g1vV9OIo9v9p
         ldeA==
X-Gm-Message-State: AElRT7HKQS1sH8+r0t0kaDKTYa2DvfUVDc7lC1koT8lhbbPegzmKiIeS
        ZjVDLjUsawNXpAy74cB1EFCPUxv4ox72QQ==
X-Google-Smtp-Source: AIpwx49sBEPtMqG+f2Ou1sP2tzLI8BDkk6tTEiSbeZTSJrmBIx7ylpR7CEcxyVAvkDSfLjn/xdlh7Q==
X-Received: by 2002:a17:902:b095:: with SMTP id p21-v6mr20840712plr.31.1522897156700;
        Wed, 04 Apr 2018 19:59:16 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id v186sm12399435pfb.182.2018.04.04.19.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:59:15 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:59:14 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 2/3] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <20180405025914.GC49902@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522896713.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding `--type=color` to the `git-config(1)` builtin,
let's introduce a color parsing utility, `git_config_color` in a similar
fashion to `git_config_<type>`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 10 ++++++++++
 config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/config.c b/config.c
index b0c20e6cb..33366b52c 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
 	return 0;
 }
 
+int git_config_color(char *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index ef70a9cac..0e060779d 100644
--- a/config.h
+++ b/config.h
@@ -59,6 +59,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
+extern int git_config_color(char *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-- 
2.17.0

