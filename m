Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC251F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbfGKQJU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44911 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfGKQJS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so6896903wrf.11
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I66tsNV2uTuOAR7JVNCEJFP+b6dKf2BHOOpTBcnMnc0=;
        b=OA0Nbi4ciaCLCDprL5rBOe+CqHkucCDB5fCJootCsmcMsJd5gnoVld2wZYFhmNS1PZ
         NnG4/EiDtrRpXErcmuYca6ZNQi2d0mY226toI6vHNyz21CzjLl31pD6Aut6FINmJYQ9h
         Q6fFjEscWyKgb1/pQenNpfVwewWv2l4RXSgBPQ1wyoWRP1RwuS3drW71IwWeOxq/+Lba
         lo93ZyXESLVHjlvG3FRMMLaLtEYkXFrG/KQMDqGG4aWZTj/pcyNPngjL+PyaV1ZpRYtW
         6+7EZ3G+AocjNKMwu2+yNIaiSZScZkFccnFGVte0N8ddf5FESv8CiWL77eUy3f8/ebE5
         u8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I66tsNV2uTuOAR7JVNCEJFP+b6dKf2BHOOpTBcnMnc0=;
        b=cHJmj3G46/LXnnKbPV+Jtnj0kw8xEI42vUdFt5Xf8EBDfLQ7ZX+8w6XifT0WYsPwXP
         PuOL+n8NuXMuTy60fFSBVLrgG2J+R/BbzAqB1WwupaeNNgaffJzvwgtqqVmZE1EIIfL5
         4qEdcIrutIJEc5aVfvkJENjm2RlGoDa09qvMz4U1zH6kj7xnp3uAZIowDqSPUpVOtZ1g
         eEK3w3T6UwUdS8/YsAfTs9lJiQa6WgWt+FzzXeMWAWd7AFIoIFdMHuOJFvJeAToMZ71F
         DVjQMCLVHvKcaUBZg2qbk1QgaggmkkwWB5PTT+InawYN5+cRCh9Mj4Ze/0J4us+O6ntx
         dBag==
X-Gm-Message-State: APjAAAWzUtYA0kIZknq13d5oPmHswOVWczQgJst9aSgp3n7KEQl6MlEz
        39zNzAmMCZQTec22BBRQOBlXHR3KF2c=
X-Google-Smtp-Source: APXvYqwy1RylEONXB5rRhKKC9CP0C7M7KaWX45CSfNtzekCRXJhqZz3YircoCDHS+zI6CwC8ArLHTQ==
X-Received: by 2002:adf:de10:: with SMTP id b16mr5790917wrm.296.1562861355999;
        Thu, 11 Jul 2019 09:09:15 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id r5sm6274233wmh.35.2019.07.11.09.09.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:15 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 10/14] range-diff: don't remove funcname from inner diff
Date:   Thu, 11 Jul 2019 17:08:47 +0100
Message-Id: <20190711160851.14380-11-t.gummerer@gmail.com>
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

When postprocessing the inner diff in range-diff, we currently replace
the whole hunk header line with just "@@".  This matches how 'git
tbdiff' used to handle hunk headers as well.

Most likely this is being done because line numbers in the hunk header
are not relevant without other changes.  They can for example easily
change if a range is rebased, and lines are added/removed before a
change that we actually care about in our ranges.

However it can still be useful to have the function name that 'git
diff' extracts as additional context for the change.

Note that it is not guaranteed that the hunk header actually shows up
in the range-diff, and this change only aims to improve the case where
a hunk header would already be included in the final output.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c          | 7 ++++---
 t/t3206-range-diff.sh | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 784fac301b..a5202d8b6c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -119,9 +119,10 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addch(&buf, '\n');
 			}
 			continue;
-		} else if (starts_with(line, "@@ "))
-			strbuf_addstr(&buf, "@@");
-		else if (!line[0] || starts_with(line, "index "))
+		} else if (skip_prefix(line, "@@ ", &p)) {
+			p = strstr(p, "@@");
+			strbuf_addstr(&buf, p ? p : "@@");
+		} else if (!line[0] || starts_with(line, "index "))
 			/*
 			 * A completely blank (not ' \n', which is context)
 			 * line is not valid in a diff.  We skip it
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 048feaf6dd..aebd4e3693 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -110,7 +110,7 @@ test_expect_success 'changed commit' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@ -8,7 +8,7 @@
-	     @@
+	     @@ A
 	      9
 	      10
 	    - B
@@ -169,7 +169,7 @@ test_expect_success 'changed commit with sm config' '
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
 	    @@ -8,7 +8,7 @@
-	     @@
+	     @@ A
 	      9
 	      10
 	    - B
@@ -231,7 +231,7 @@ test_expect_success 'dual-coloring' '
 	:      14<RESET>
 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
 	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
-	:    <CYAN> @@<RESET>
+	:    <CYAN> @@ A<RESET>
 	:      9<RESET>
 	:      10<RESET>
 	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
-- 
2.22.0.510.g264f2c817a

