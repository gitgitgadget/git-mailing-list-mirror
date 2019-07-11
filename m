Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DFE1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGKQJZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33045 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfGKQJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so6969401wru.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udrGBbeDOfJexYXQeYvgplKe+0XhIyUM+81mT/hCb/k=;
        b=Y8klEKFTFbZBRYbtzAlJHZ/sVhwAqTHhGRK54uqH13UtcdEotjITefPxxQJJsPEy/Y
         3L3VfHSakxmyUs2aND3raGAl3xflql3dQiKzf+92zfsyKUZVesIFGvGPz+WEYC/gZiSd
         S+wMUiv3k2WxWgy1aZjEKw8zIkSpLabltA0Es+PQc1+GO1fsjq0pfWArusFtTK3B+4y+
         xQCAw0pflkOTHALh5vD2cUwQHJwZnkVCPWunGj9LQr1jawm2agRArO+glVQEVvH4cpYG
         7ahEOm0Y9B9c4u7x0NfTg+T/PCpe/VcZKDQWFy4XPRovXwK5mnv42wcsqcIZ126dicZg
         1D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udrGBbeDOfJexYXQeYvgplKe+0XhIyUM+81mT/hCb/k=;
        b=XVK14y51GEXSBd4Xa50CAmE4UdKkdO9Ie2CUyWw11H1xNmyW0krDr9Aoqu/p9qfWax
         EA7ar1byjgaPRwpn027SspNx/YXadrusHNPmwAqgbe62qX9h9hR2ilek7V+NdKOWFDGV
         RAMhxemypiuKVukgHa+X+ZM2E+ddYFsS9d7DRZIoINetiwWCiLSXle5HLwuC9j103zKe
         fYMB6agYLqHv7VjVHjq5l7t1GFYffb3FZsm6kJ4V0kFlvFH58xOakcmXwjJ/1E+4NbnO
         W7ulHoCyP4lz+5zDXL8kux028M3EOteS2y6NKxHxRrXZxkP8wmb6dhrub8ZPDQYStBNQ
         GqUQ==
X-Gm-Message-State: APjAAAVLf4TWDRl/QdR12+WHIAmtFvMaEMWHzZ6ZOHFcZ7VWKHrDJlQ6
        QBJg7hKYE6gk+XJru1Ji0GiqdTsSZ2Q=
X-Google-Smtp-Source: APXvYqz4CWXjsjIDsqH2on43ukpjuhR3mHHqKTXe0gCjwbg2iuEninimLC5Us4SahvGbSAjo8byydg==
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr6040583wrx.196.1562861362299;
        Thu, 11 Jul 2019 09:09:22 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id y12sm3549237wrm.79.2019.07.11.09.09.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:21 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 13/14] range-diff: add filename to inner diff
Date:   Thu, 11 Jul 2019 17:08:50 +0100
Message-Id: <20190711160851.14380-14-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a range-diff it's not always clear which file a certain funcname of
the inner diff belongs to, because the diff header (or section header
as added in a previous commit) is not always visible in the
range-diff.

Add the filename to the inner diffs header, so it's always visible to
users.

This also allows us to add the filename + the funcname to the outer
diffs hunk headers using a custom userdiff pattern, which will be done
in the next commit.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c          | 15 +++++++++++++--
 t/t3206-range-diff.sh | 16 ++++++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 5f64380fe4..7a96a587f1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -46,7 +46,7 @@ static int read_patches(const char *range, struct string_list *list)
 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
 	struct patch_util *util = NULL;
 	int in_header = 1;
-	char *line;
+	char *line, *current_filename = NULL;
 	int offset, len;
 	size_t size;
 
@@ -125,6 +125,12 @@ static int read_patches(const char *range, struct string_list *list)
 			else
 				strbuf_addstr(&buf, patch.new_name);
 
+			free(current_filename);
+			if (patch.is_delete > 0)
+				current_filename = xstrdup(patch.old_name);
+			else
+				current_filename = xstrdup(patch.new_name);
+
 			if (patch.new_mode && patch.old_mode &&
 			    patch.old_mode != patch.new_mode)
 				strbuf_addf(&buf, " (mode change %06o => %06o)",
@@ -145,7 +151,11 @@ static int read_patches(const char *range, struct string_list *list)
 			continue;
 		} else if (skip_prefix(line, "@@ ", &p)) {
 			p = strstr(p, "@@");
-			strbuf_addstr(&buf, p ? p : "@@");
+			strbuf_addstr(&buf, "@@");
+			if (current_filename && p[2])
+				strbuf_addf(&buf, " %s:", current_filename);
+			if (p)
+				strbuf_addstr(&buf, p + 2);
 		} else if (!line[0])
 			/*
 			 * A completely blank (not ' \n', which is context)
@@ -177,6 +187,7 @@ static int read_patches(const char *range, struct string_list *list)
 	if (util)
 		string_list_append(list, buf.buf)->util = util;
 	strbuf_release(&buf);
+	free(current_filename);
 
 	if (finish_command(&cp))
 		return -1;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index c277756057..d4de270979 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -110,7 +110,7 @@ test_expect_success 'changed commit' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@
-	     @@ A
+	     @@ file: A
 	      9
 	      10
 	    - B
@@ -169,7 +169,7 @@ test_expect_success 'changed commit with sm config' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@
-	     @@ A
+	     @@ file: A
 	      9
 	      10
 	    - B
@@ -203,20 +203,24 @@ test_expect_success 'renamed file' '
 	    Z    s/11/B/
 	    Z
 	    - ## file ##
+	    -@@ file: A
 	    + ## renamed-file ##
-	    Z@@ A
+	    +@@ renamed-file: A
 	    Z 8
 	    Z 9
+	    Z 10
 	4:  a63e992 ! 4:  1e6226b s/12/B/
 	    @@
 	    Z
 	    Z    s/12/B/
 	    Z
 	    - ## file ##
+	    -@@ file: A
 	    + ## renamed-file ##
-	    Z@@ A
+	    +@@ renamed-file: A
 	    Z 9
 	    Z 10
+	    Z B
 	EOF
 	test_cmp expected actual
 '
@@ -248,7 +252,7 @@ test_expect_success 'file added and later removed' '
 	    +    s/11/B/ + remove file
 	    Z
 	    Z ## file ##
-	    Z@@ A
+	    Z@@ file: A
 	    @@
 	    Z 12
 	    Z 13
@@ -310,7 +314,7 @@ test_expect_success 'dual-coloring' '
 	:      14<RESET>
 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
 	:    <REVERSE><CYAN>@@<RESET>
-	:    <CYAN> @@ A<RESET>
+	:    <CYAN> @@ file: A<RESET>
 	:      9<RESET>
 	:      10<RESET>
 	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
-- 
2.22.0.510.g264f2c817a

