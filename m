Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A3B21F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfGERHQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36427 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfGERHO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so10640636wrs.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6wvmiwcN1lbUJpds7stAZn9MZbr7FrfWJV7GJLqgEY=;
        b=E58O7tPVjZ28ZIB/BQV4pNUiBFCq5jvTI/6gle6qhNcqHAYTLE/Xk/il2qVWL3PIi5
         d+F781cNCJ6vL4Kk+mhfqXsNxW7WIGoJrjlGbywF7gHmczEKDq7urHRXZCqDXaJpQQnb
         aBrMmmLb5MMYtGvvWWnIto45yh8z/QI1TMaEYqHmbFMi0nvNVvx09YqWB7YlSxlVv6KZ
         yyXqS///GHrQczvCPX+yOCYYcRpS1BHwEJKY2RXRClcMUz5LrvcK31CbiOou+7egQqGL
         +Z16kc4bUVv7+/a5XL79kRrUtJwkVNprpW12XavNtME99u1Vx4Ob0NDwkVNFQ66lzU3Q
         S0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6wvmiwcN1lbUJpds7stAZn9MZbr7FrfWJV7GJLqgEY=;
        b=gRNLXFmnmeXebZ2wiV5JRrywF29tWeJuvGJYV9+5+E1OhuSpwPYlHy4XprDPu2J9Ep
         EBLbsuRb/UEmufsgl6ydo9x1jnwInTjI5UWutsdgO/MGF7c5fzl3YVoaRc4/QAXgO8SB
         ioMbZneB8vl00LLODkcgDgyK9XLC/IJKcvvVqRc4fWaWW+8COOD61e3Y8tdKD61vdZTF
         yY2lcWz/x6MIN/v2fsrBiYt8L+/ErDqWwnrCowLXQC5C40RtBYLlUfjPUMGApWvUHmfE
         +n9WNfCHn80hLmG0WtpcaAsq+ERsO2PMVOZUmO0CREeja6jpIxPXiPYRYtCuseIea18l
         r7Fg==
X-Gm-Message-State: APjAAAXOml3fTm/9+83SWwi575UtRSeRoolGuVEu4SPqUFNeLawdVdpV
        5ThGoHyKRDk5nUfolU3kv5WKYsTf
X-Google-Smtp-Source: APXvYqxWrMAsSAyLHX0tnCzU17/SZAahVwAre+h2FJ77rq0BwP5i7YrwRcqLzKmAoBe60NTaaPraWA==
X-Received: by 2002:a5d:4403:: with SMTP id z3mr5004082wrq.29.1562346431041;
        Fri, 05 Jul 2019 10:07:11 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id o24sm12494988wmh.2.2019.07.05.10.07.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 13/14] range-diff: add filename to inner diff
Date:   Fri,  5 Jul 2019 18:06:29 +0100
Message-Id: <20190705170630.27500-14-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
 <20190705170630.27500-1-t.gummerer@gmail.com>
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
 range-diff.c          | 14 ++++++++++++--
 t/t3206-range-diff.sh | 16 ++++++++++------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index cc01f7f573..09cb1ddbb1 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -46,7 +46,7 @@ static int read_patches(const char *range, struct string_list *list)
 	struct strbuf buf = STRBUF_INIT, file = STRBUF_INIT;
 	struct patch_util *util = NULL;
 	int in_header = 1;
-	char *line;
+	char *line, *current_filename = NULL;
 	int offset, len;
 	size_t size;
 
@@ -120,6 +120,12 @@ static int read_patches(const char *range, struct string_list *list)
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
@@ -141,7 +147,10 @@ static int read_patches(const char *range, struct string_list *list)
 		} else if (skip_prefix(line, "@@ ", &p)) {
 			if (!(p = strstr(p, "@@")))
 				die(_("invalid hunk header in inner diff"));
-			strbuf_addstr(&buf, p);
+			strbuf_addstr(&buf, "@@");
+			if (current_filename && p[2])
+				strbuf_addf(&buf, " %s:", current_filename);
+			strbuf_addstr(&buf, p + 2);
 		} else if (!line[0])
 			/*
 			 * A completely blank (not ' \n', which is context)
@@ -172,6 +181,7 @@ static int read_patches(const char *range, struct string_list *list)
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

