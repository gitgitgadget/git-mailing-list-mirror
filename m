Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC0D201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755043AbdERXWi (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:38 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35873 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932639AbdERXW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id x64so29455190pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mYrKAduS1bpnD3rywZYw91e8K3KSRIdEZRVoBv2WG1o=;
        b=jOYCqmhLkcHtYA2c8ozyEYDsgLjiWQna+Bq9dorfI6AhRwNnjJmooG9+bQLRtI3Iw4
         5CZ30smzvHiQY+/gd+desMdrtE1pvEi8tb7OYL+S/lptUTCiSBTEU75HHrYTTT+GYEeI
         k/vIl/l8gh685xQdZSviGiNBYOoflPA6y0NWZLgI0SNi8Mk5V4ROzvMLQ1VB+XWNZAKp
         in49FUAPHT45IaUbrJ4eJmDOMqdduPT2HlQYbmZXtNt0/zUBM8stkjv9cphAwz8SLE2a
         vhPUYCx82vd7xlzXgtk7j75JedvSZTWFiAKLYDdqmIWBIDqpVSbFOZcUz9z8nvAvJSPV
         K96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mYrKAduS1bpnD3rywZYw91e8K3KSRIdEZRVoBv2WG1o=;
        b=sY3gl9c7ndE8fvVuO4ECw4B/EIydJa4J9BTe5igp2ziOelINZgPXfxfpEtR/vRvmxf
         6t9aayWxD6uyoOYoW36QL4VPL0HciipvLXOgrzRUpKBUCAl0L6eRceKZlo1pl6fHrqfM
         YH6avDxyOPKIMxzXGx7tKWLdR1Z1UK0jXaScwxggVfqkZyNqWyThLuK5oFRCrlSLZnU5
         9yP30esUOr5gUMGWG4tzJzcThdx54RA5ISXyaXNZIpU3tHwDXaYdWFFZ8zrWluvzRY/F
         lKevL9cMszwCulbVqchWjFjGL23M9iPDWaHCR17AScPdAj+c8DABN8hyBM/7MV7DkiGh
         aagA==
X-Gm-Message-State: AODbwcCHlDy9yoGTHYJQzvn0uRd4mSKt5itYUn0GSaexGug1x2DFtzlW
        e+27VRRpAqleQ16R
X-Received: by 10.84.140.5 with SMTP id 5mr7816103pls.113.1495149749005;
        Thu, 18 May 2017 16:22:29 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 15/23] ls-files: factor out debug info into a function
Date:   Thu, 18 May 2017 16:21:26 -0700
Message-Id: <20170518232134.163059-16-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 56fd6644f..6603538ec 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -93,6 +93,19 @@ static void write_name(const char *name)
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
@@ -278,15 +291,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
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
2.13.0.303.g4ebf302169-goog

