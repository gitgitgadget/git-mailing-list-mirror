Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A02E1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751280AbdEaVpg (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:36 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36134 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdEaVpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:34 -0400
Received: by mail-pf0-f180.google.com with SMTP id m17so18558290pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkiKhFZ3U9CjzB/NSRe6cX3LmDu9o8tQOQG0ROsc+rA=;
        b=c8Wq1KjE6rApJJ86jC/7VzEY+rRjSLeqqlOoKWx6zmJeyga2VaHTdc1uZqPp4KhEqp
         jafEvn0t8i1RBfGlVUKDfmKw9Pu0Ifp010h68gBG01DvPsG0iGMtNHZLtLk7pDBo7kCh
         ENG8Im9TcE4zvhlGmdP3+vzxgP6EPlFA+O+UtRqNeLZ8g9WPPK34nsZLqqjQIXFA3bLO
         JYRYvSvcpA766RMHnxUXJfhcsBUG4VnBOTXe0iVC0Fa0Sy38NWVCPccHHbbRAEbDLz/Y
         r+ZsgbvBNibJ/QhowvkxaL6lYCLEjwLEAN4Xa5Z6fxrKtnOB+llrzU8yhDcEnwPjS52o
         XCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkiKhFZ3U9CjzB/NSRe6cX3LmDu9o8tQOQG0ROsc+rA=;
        b=RjJ/9C/dwpZ2sNZIoOBjHKJ/RocQoefGjGGPs1zirG2F1bSdaZAOU3t1iZiCknLwM1
         jjra8ZrO1uC6k9U7OjCeIbfrRjlhKpL6pryLaxiSNX0HqxGCcpVRn0h/ysuYCONCDirX
         9z9kuSJx0TvPTEflg5XCHDoBKG2CNOVFUL1y3gpyMrS+GnUdkoAievg8MMsix6CYxA4U
         XyEC+oZaVL6MomYZAVVCyb35K/QEOU9Up4lTqEjayNrArzIB6LwNKf1nLJlqGVdLkpWG
         Z4D6QtwiWxwzgpj2p6shYeYWcf1t0eCPOSLoUimRGAcS8flzbsviiYolAxCqEu2dGTZ/
         Xwhw==
X-Gm-Message-State: AODbwcBbKVozrmHcR1wp756DgYo65pbCHE3ejDJlS4ptepqetJgf/lcf
        mKcSFcfHct/AEXFE
X-Received: by 10.84.231.139 with SMTP id g11mr78155930plk.71.1496267119556;
        Wed, 31 May 2017 14:45:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 29/31] ls-files: factor out debug info into a function
Date:   Wed, 31 May 2017 14:44:15 -0700
Message-Id: <20170531214417.38857-30-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 3061af2c5..2849c9a65 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -94,6 +94,19 @@ static void write_name(const char *name)
 	strbuf_release(&full_name);
 }
 
+static void print_debug(const struct cache_entry *ce)
+{
+	if (debug_mode) {
+		const struct stat_data *sd = &ce->ce_stat_data;
+
+		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
+	}
+}
+
 static void show_dir_entry(const char *tag, struct dir_entry *ent)
 {
 	int len = max_prefix_len;
@@ -279,15 +292,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 		}
 		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
-		if (debug_mode) {
-			const struct stat_data *sd = &ce->ce_stat_data;
-
-			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-		}
+		print_debug(ce);
 	}
 
 	strbuf_release(&name);
-- 
2.13.0.506.g27d5fe0cd-goog

