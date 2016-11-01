Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4983C20229
	for <e@80x24.org>; Tue,  1 Nov 2016 20:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbcKAUIe (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 16:08:34 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34517 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbcKAUId (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 16:08:33 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so100201765pfi.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8kjoZ0mwcHXQdz9xOzn0ODA1HlP6MOqCl5PJToXLhzY=;
        b=BrhPgRtodii+C/JUqGx9mGjzt5pEq54rvSX4u7HjJS/918RuoYYOLEiJZMQGPHwOmP
         bULbhN+ZCUGb+0pNgEg9KAIzBxoQGKG6yKTcqWNNJ1ej5uC5cPPivwdDvg1F7C71hHzn
         Jl9N+Y5p0PG9lXyH0XJnsGRP1EtpAk/LftOv6UopIdye9EZcYNe83fIPSzVzj19HKIPy
         fc7+BdgR/4xzCaPW+h3Mw/3SHMaSJKJO+QetoA4sMeRqCc7LwLGxh6XhHPckqChLVr/x
         LFeyKVwtf64OS7SmHHYb4u5eNA2+buN02YcvnY2DYBgmaxbA6/3+h3pkmlU4mYaYFAM1
         3nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8kjoZ0mwcHXQdz9xOzn0ODA1HlP6MOqCl5PJToXLhzY=;
        b=bjXTDB9Cin2TPA0Y8XLeD7p2Na9E1LfAuGaF/OBg8Eo8T6IOATSvnCCfRxgvXfnuqY
         e96oigiW2hCi/rJUqiUlvoEuBTKYqRDzYU5NHxhDHfJ5cjfwKIWg/VodxFrUzzbLA0vR
         Pi0YxWRZGa7GSuXIiYiCy/y5WmblSWk9u6XdDXfTK+kbnfrse7PEIe6ELiZf/jRCASQ9
         t9jBNZitnFC/uzcx0nt/zQUBLEg6HVnf5ZSOZO7oevR4kvCdAWeEJZufqszONK4HTMHT
         l8EiD6b7lRDznPSnP4KrVkE/l77WAeMMuIwG64Li6LRJMvTPUsEo4lagx22rPFHeMXHN
         TX4w==
X-Gm-Message-State: ABUngveZcItDNHGAjuiUugFG5ctyu1BsGZzXBR9oGf0B5yWkfVqkQlPSp0UDFB/PtdEEqsZZ
X-Received: by 10.98.92.68 with SMTP id q65mr62418208pfb.53.1478030912341;
        Tue, 01 Nov 2016 13:08:32 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id v4sm44093272pfb.52.2016.11.01.13.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Nov 2016 13:08:31 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        christian.couder@gmail.com
Subject: [PATCH v2 1/5] trailer: be stricter in parsing separators
Date:   Tue,  1 Nov 2016 13:08:21 -0700
Message-Id: <c7db0aafb543845382e1835e3704273d3596e6bb.1478028700.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1478028700.git.jonathantanmy@google.com>
In-Reply-To: <cover.1478028700.git.jonathantanmy@google.com>
References: <cover.1477698917.git.jonathantanmy@google.com> <cover.1478028700.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, a line is interpreted to be a trailer line if it contains a
separator. Make parsing stricter by requiring the text on the left of
the separator, if not the empty string, to be of the "<token><optional
whitespace>" form.

(The find_separator function distinguishes the no-separator case from
the separator-starts-line case because some callers of this function
need such a distinction.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 trailer.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/trailer.c b/trailer.c
index f0ecde2..0ee634f 100644
--- a/trailer.c
+++ b/trailer.c
@@ -563,15 +563,26 @@ static int token_matches_item(const char *tok, struct arg_item *item, int tok_le
 }
 
 /*
- * Return the location of the first separator in line, or -1 if there is no
- * separator.
+ * If the given line is of the form 
+ * "<token><optional whitespace><separator>..." or "<separator>...", return the
+ * location of the separator. Otherwise, return -1.
  */
 static int find_separator(const char *line, const char *separators)
 {
-	int loc = strcspn(line, separators);
-	if (!line[loc])
-		return -1;
-	return loc;
+	int whitespace_found = 0;
+	const char *c;
+	for (c = line; *c; c++) {
+		if (strchr(separators, *c))
+			return c - line;
+		if (!whitespace_found && (isalnum(*c) || *c == '-'))
+			continue;
+		if (c != line && (*c == ' ' || *c == '\t')) {
+			whitespace_found = 1;
+			continue;
+		}
+		break;
+	}
+	return -1;
 }
 
 /*
-- 
2.8.0.rc3.226.g39d4020

