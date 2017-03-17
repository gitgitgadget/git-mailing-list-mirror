Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC06120951
	for <e@80x24.org>; Fri, 17 Mar 2017 18:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbdCQSnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 14:43:22 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36379 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdCQSnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 14:43:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id g2so47161620pge.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AyBpsOB0On6WtVOc7xxzF+YLa6NL1Sn7R89vR8+eimQ=;
        b=C7mD83aQusxydf/MUMEWODMvy102XCqYDPoVKSimJn7/ri8EN2yxGiK7pcxONmBGYr
         gq3baX7Z9YcpoawMzbXI7q7nvW/xOthhZ3H5ZhooXrQY0MXQX4/I765R0fbaPf0+UlfU
         0urgGgMQW9NejVAP7r/uJGwlcUcf2seXq7GfAfXJ64gNB173XTo4OSIEuoSxznSDW2aW
         P8UQnCXFg6J5Uv0XPOzM+isgblldKvw4kDe/BMUbRwlx+GdO4T+afS8RzQSB/Si0liAU
         nzbz0yks2nUw81AJipxwLuiV/I0F/2FJeRGAftU78401Z8BRAb+QltOidiX7FSFsD+h0
         wW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AyBpsOB0On6WtVOc7xxzF+YLa6NL1Sn7R89vR8+eimQ=;
        b=e6ZeGSp6Mm1zLNahOCQ/luRfQCCsq97WNxz3ae2e/cPaootU1m2R8rO3gqBDkpa4xK
         1qx53c2ds+hhN+uBcDPSErG38LGKwrTbJ0DEsz3bKLvbzW42SH7UDJd1n6azE5Jl0FlO
         FMGbFjw4ZSYWSBDOATrZYRbdcsFLCG4S/RmHzKLZmgfda/3490uM68YihuaAS2WQURbi
         u4UWzA2KHtahqjUgrt1GSi2tuFZ+uLqO0UdN30XF5V/ZEdPTvsdyFHRnOoSZ6PSYKvGh
         JbDj0jeApX0dKOTl4BLHaudkQvoFUDcMkpZYMRvy08vAfnTG1AeeeqoC81S+GZQ7qs4V
         aVaQ==
X-Gm-Message-State: AFeK/H0bW4Qs1q6QZ+bKVfAdl8YR7vtP/PIFUNSL0R5LQ2JYfYqiueajhsOBrwACwIaFGbVo
X-Received: by 10.98.96.65 with SMTP id u62mr18619087pfb.219.1489776121516;
        Fri, 17 Mar 2017 11:42:01 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 73sm18209216pfh.56.2017.03.17.11.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 11:42:00 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        rahul.bedarkar@imgtec.com
Subject: [PATCH 1/2] grep: set default output method
Date:   Fri, 17 Mar 2017 11:41:54 -0700
Message-Id: <20170317184155.128674-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317182403.GA110341@google.com>
References: <20170317182403.GA110341@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 grep.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/grep.c b/grep.c
index 0dbdc1d00..56ef0ecbf 100644
--- a/grep.c
+++ b/grep.c
@@ -12,6 +12,11 @@ static int grep_source_is_binary(struct grep_source *gs);
 
 static struct grep_opt grep_defaults;
 
+static void std_output(struct grep_opt *opt, const void *buf, size_t size)
+{
+	fwrite(buf, size, 1, stdout);
+}
+
 /*
  * Initialize the grep_defaults template with hardcoded defaults.
  * We could let the compiler do this, but without C99 initializers
@@ -42,6 +47,7 @@ void init_grep_defaults(void)
 	color_set(opt->color_selected, "");
 	color_set(opt->color_sep, GIT_COLOR_CYAN);
 	opt->color = -1;
+	opt->output = std_output;
 }
 
 static int parse_pattern_type_arg(const char *opt, const char *arg)
@@ -152,6 +158,7 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->pathname = def->pathname;
 	opt->regflags = def->regflags;
 	opt->relative = def->relative;
+	opt->output = def->output;
 
 	color_set(opt->color_context, def->color_context);
 	color_set(opt->color_filename, def->color_filename);
@@ -1379,11 +1386,6 @@ static int look_ahead(struct grep_opt *opt,
 	return 0;
 }
 
-static void std_output(struct grep_opt *opt, const void *buf, size_t size)
-{
-	fwrite(buf, size, 1, stdout);
-}
-
 static int fill_textconv_grep(struct userdiff_driver *driver,
 			      struct grep_source *gs)
 {
-- 
2.12.0.367.g23dc2f6d3c-goog

