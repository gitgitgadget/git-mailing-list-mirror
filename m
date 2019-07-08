Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789A61F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbfGHQiP (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbfGHQiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so6703508wrf.11
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udrGBbeDOfJexYXQeYvgplKe+0XhIyUM+81mT/hCb/k=;
        b=GasmtXop4HDDG3GjSwvnGZI8tHVcRGGvG5cDxVWCYyoMaeFOrDcyLzULO4+6BcR9UU
         WvhGJvHKjurUoYPv81Yx3fg/VFMaXKSW+UWht34xU81HSYu+WxOxDT5ZR+mpRO3KdmHE
         RE4bvXQBPI+psp2lXgX9g7blWGQ8Jf+gyoIckJb8eAnXvOLC4RfQ3ALlT3FwFjC00NW7
         Hu+RkSTmAjFdNleHYM9ywahjvnsCRM9i8rG9nHuRcRYAVNDgY6RaSf/iTCErEZJYmVF6
         qaid4Zv1V7ACjeFMR7S+Q/112FeCv5+BsVbkrnEr25fH4SfdlwZUiww2aYOd3XuKMzUI
         Tg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udrGBbeDOfJexYXQeYvgplKe+0XhIyUM+81mT/hCb/k=;
        b=lTVrRwen27eL6VBAlinUAniWqHVml4htKTcsxWA+NSQV/vet3EmB2iimEMEKNhOgK3
         OuJeCRT8fRbGDLbFM7szeJ01vZjitfygFImvbOyI2a7h7Frvme3Wbzpkh+/YziMIjzxW
         IfRofAuC/R95a7xnjhC9fnDN8ycOVLcWJagSRjEJpby1GEylnauc09CR6ogqbzvTFA7q
         0rZLlyPlb/zZNYdQCmsIAJpeZHQLOs5wGbrzvD4ukx8/5l+DfIkC9XtjeTm1MHqcsZ5i
         6QmI9hXAfo8g09WG5b/YgsVWzy5z9yyWmsRY+DsIY/lECGMDu8K//4wDIB9iG+0YRvBR
         /A5A==
X-Gm-Message-State: APjAAAXAfm0y6ove1EcwG4b74XyH2S6L+HQn1ErzSDb4sVfq6j/Uj8lp
        I+7nThXO9twqcL53N67CkKwkkBl2
X-Google-Smtp-Source: APXvYqwi7WZAgjIGwtm3yFnQ/xXkZJ+Qn5655AAIYPdQb7/+xq/w6n2SB3Kt9cUtauNFxAttx6i0xQ==
X-Received: by 2002:adf:f182:: with SMTP id h2mr13991529wro.132.1562603889231;
        Mon, 08 Jul 2019 09:38:09 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id y6sm113966wmd.16.2019.07.08.09.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 13/14] range-diff: add filename to inner diff
Date:   Mon,  8 Jul 2019 17:33:14 +0100
Message-Id: <20190708163315.29912-14-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
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

