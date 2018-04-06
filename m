Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1781F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeDFGaU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:30:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43113 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFGaS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:30:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id j2so70776pff.10
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gH6FL75BFg8YQvNVtyY4YrnWLgP4AjFY9tsUqG04EE=;
        b=Blt3q1kRL54tjc2D7aGxjN7rc+vBhahSsMD3b9mplnlAeI2nAFwCUJaPZ2JnvL7Yah
         xvyluJ3Os2VdwqsJ5MsIcAzILqNPrr/luy+IEsUFpHnZq+Q1MtzH5Dj7PzWrTcrUlw19
         VF5yYTuL9bK2A/SXRsI9OT8GrRLbeaoAiN7dPSQYiQHQkqqp1PFHYhd//HncZPayqe2K
         MJ9RSwDvmJ4sdlJLtRVjlJgJlS+QfptsJCNwcJR1she+Y3ZYJIQadk6ZSzaNUvdSDPcM
         EzsrHJ7M/C9RfvHOnDDLmmy6zc4GZBqysQyJq3GAWwbE8j7J09vfdSZB0y56SvqTcWoc
         jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gH6FL75BFg8YQvNVtyY4YrnWLgP4AjFY9tsUqG04EE=;
        b=j4oG5ZPjrM2Nvxo5/DYJOgCInDKA/szOHZMugCB+6npuF1ae9Xck7Lk0SYZbIox0iX
         kvvEVNFrtZFzq6qDdLTQEnn6pZxnkxObQuXqFrmwCIbTY+MXJu0gJ8qCL6URMocCponv
         HyeS0PjnkY+UOMrOI2ma+2Wiji3/GcYvWj0UiGpYSmdTl0z8D1RYS6Res5nEgq2xKwq7
         0Mbqj8Mpe0PvirGSl7bekSTNuhl55t2YLYRxWjtxEqQIHZJwk6noChIyNFpqxXNiKV3G
         +xS8r3YRB0yoplwkVgCWALveupIh11gF5QgKsFzTGiCi9zVGsc51CzNBeunuCa/GkpHL
         U6Ow==
X-Gm-Message-State: AElRT7FoU2lMwVOuxu9kti/S4V4Iszm4eIHJPgXea0mXNWp70Alp2Bx5
        2pL1a6oG6swkNTbb1101D+fnj7SVMF4=
X-Google-Smtp-Source: AIpwx4+nYHJZ7PG2QnfcOk+LRfKczVn9aBTWaiv/n9VKHpiDXlxp1e22n0P96/6LtQmaa8X8/Jgu+g==
X-Received: by 10.101.87.201 with SMTP id q9mr17224000pgr.215.1522996217385;
        Thu, 05 Apr 2018 23:30:17 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id c187sm17721704pfa.181.2018.04.05.23.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:30:16 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:30:15 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v5 2/3] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <20180406063015.GC662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522996150.git.me@ttaylorr.com>
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

