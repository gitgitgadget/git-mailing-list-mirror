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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E22E1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfGERHK (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:07:10 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37201 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfGERHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:07:09 -0400
Received: by mail-wr1-f50.google.com with SMTP id n9so1461887wrr.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/ueWbv3h2I/NDQO9J3kaQ5tAa9DjsWFQXjijZ6/KJ4=;
        b=Mrg5NKSIYMDWyQ9JgU4AT1sta2/GfXOgNIHyK52D8wGLZtam6M98idYOO0IZ9OjhCw
         LxX+oYuJhjzrYkVpzBmidc4r/aKEfQaIwqaSadOvXQOSDOtrOHWZ2M/meGcB+5dUX/er
         Y1q+1/RNurTTCqtfW5yyINtvqGpPc/af8XIHDHIUTKB/Y9EyEdmBLKc+THT26XbjgJY2
         3GqwPxzofe1t9sS1weKqiCEwo8xPPmrMAXtklMjeffm3ug14yJzJqU54SUcBDxqFzqYZ
         IBuDnjCXyYAeGl0poSzO+QI7z1EHSC25/efCvkweYbmALFoGBJoroUBQzJUPEJBPdfVD
         fCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/ueWbv3h2I/NDQO9J3kaQ5tAa9DjsWFQXjijZ6/KJ4=;
        b=XLB+4tZj7wL61oJqDMKFTu/mrAVdVXk9nL81cdblc77MVLhGXXbXAzJlCizqHt4uUo
         RJnlmqQyaUMEEVDunn+ZmJJDw9iCL1dOZZkk6ejkYV22fpWoarCj/xNNZa1I7GiBntQL
         mPvEuz9mnsKuJI6+UqVqCaTYsc+ktydr/IwIBYhDY5OMVQ9R3VT/0wrJbTfcN53tYNeg
         DVN1xz3yi9zKkHY3zlMECILaTbIBgLNaGrDa7oxZYkayC7HdXDTp+wHr+osRoZNlJkmr
         LWp0F2sC5mZxanHrs3Osk9Ic2U0/64aXZetiwCEsjjWOIS0XltzRuK0ZH1aQMs0xKjub
         zjXQ==
X-Gm-Message-State: APjAAAXJ6gmVrDGuZubeLPGdcGqZhlu51f3PB6ylUn7zj9rnIrpxF9yn
        YGNRsYKBC6cMnozL7oW4yfxO8xLX
X-Google-Smtp-Source: APXvYqxH8FwO+DflJtN88UkI0z4VuYgqICyd35Kv+eVmxXduYkj5w5monWmasj0fh7u324d5lLNUWw==
X-Received: by 2002:a5d:4f92:: with SMTP id d18mr4809440wru.132.1562346426496;
        Fri, 05 Jul 2019 10:07:06 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id v18sm11217128wrs.80.2019.07.05.10.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:07:05 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 10/14] range-diff: don't remove funcname from inner diff
Date:   Fri,  5 Jul 2019 18:06:26 +0100
Message-Id: <20190705170630.27500-11-t.gummerer@gmail.com>
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
 range-diff.c          | 8 +++++---
 t/t3206-range-diff.sh | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 916afa44c0..484b1ec5a9 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -113,9 +113,11 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addch(&buf, '\n');
 			}
 			continue;
-		} else if (starts_with(line, "@@ "))
-			strbuf_addstr(&buf, "@@");
-		else if (!line[0] || starts_with(line, "index "))
+		} else if (skip_prefix(line, "@@ ", &p)) {
+			if (!(p = strstr(p, "@@")))
+				die(_("invalid hunk header in inner diff"));
+			strbuf_addstr(&buf, p);
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

