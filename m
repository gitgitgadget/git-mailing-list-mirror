Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93B91F424
	for <e@80x24.org>; Thu, 26 Apr 2018 04:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDZEZf (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 00:25:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37904 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbeDZEZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 00:25:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id o76so12449698pfi.5
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 21:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gTV5xXXKr+RpBO7qPmX2gMTrISIrxqcmhuGOn52Zeyg=;
        b=kP7oKlHdVBby44Zgj3wiprKZ35uYchvYmkqFmQdCBQv9OE/MVVP/FYvdqT7Yrv9Diz
         DEMq22Uip/ik4evq8u7RebUdMkfaXmEbd/jV17MRAbd+UNUgJMQHddV1ifchA0hTXfdN
         toxp6OyjlOdlgANSCoIaUEy/SOhnfXrnp1NVup/oD98YUUUl6/OcpiQAq72FH8770KTV
         b/du6ICM4cab9iCWZfusYWFlRXhTMBUa844iy/xZvckLClohkv4uj1MLKHyd37mgJc+v
         3DHgaTBdnbAiph/Lf5kKNXnJjJG6Flkp50WRDBeUFyrqAitWdCgeesC9H+3Cd8pOncAD
         r1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gTV5xXXKr+RpBO7qPmX2gMTrISIrxqcmhuGOn52Zeyg=;
        b=QnZER46x3Z0mR8r904vhKZ2W1ZzkXvhRTMxXt5UT96hvv2xPxVVe8GaIbuQn7zGj6J
         qtSuTU3GJnKbYVI27I8lZdKWdSX26qsflTCOtlhIn1KWIOLYvPXD6bL9RX7YGInEtSHS
         0OGZTuSaloL2s3edkwxGESJT40dSX4stXBofjZz8LJ78dAFn0194X7/ydN0SMXM6kqOz
         EnRb9QOX3yp6JDQHFepHyJEvSCdhldfJY5L5VefwPrHkAIa0CSaZruEqd4j+eoBYES0I
         7gmTAhBPL+2/EaG3y/nWmEEQlGwk/ursbEpnLO65zT/vsGpdVkkhPjUB+whBk6AD9z72
         Ox8w==
X-Gm-Message-State: ALQs6tDnKOgBDpO4ghU8rb1CmqIYEHHPA/sh6biiwAztUia6zhsD11T8
        bziG4zk7GyYWbh+VxcpCy0h2nl06vxo=
X-Google-Smtp-Source: AB8JxZrlpiMOCD+P4oSYs74AngueTjuj4KHEB2Cx5cbRd04qjyInQXTKtCH/2C/Er3LEpHJECB8VXw==
X-Received: by 2002:a17:902:b483:: with SMTP id y3-v6mr5128471plr.157.1524716729089;
        Wed, 25 Apr 2018 21:25:29 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id w9sm36423318pfl.45.2018.04.25.21.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 21:25:28 -0700 (PDT)
Date:   Wed, 25 Apr 2018 21:25:27 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 4/5] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <9af7952db38403dc7ed7aed1fea66d12c3cd5361.1524716420.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524716420.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
index 62c56099bf..d14813bef7 100644
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
index ef70a9cac1..0e060779d9 100644
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

