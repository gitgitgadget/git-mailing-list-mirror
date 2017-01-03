Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19ABD1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 18:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760620AbdACSt4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 13:49:56 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34007 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753228AbdACStz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 13:49:55 -0500
Received: by mail-pf0-f173.google.com with SMTP id c4so77934954pfb.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1aM6tTs3WJhlduRar9DOocwYwfdre0Ej0s67EMZYShg=;
        b=eksaQGER7z0JMzcLnPBvipS93vZZrbuNd45nWPJZqAdaZnj4gQpB5U5Y/TCmnaHMAJ
         3Jhmyr6z/Mz+lfqLGMYvHipn1/iobJlu9dDZjvymz5Ql5oJNvnuhsqRrm+kfnfI/Vw4U
         dTFZTaNqqQ+SGhFZJ4AeS/xnz1Cawv2HbqzAhs7dEWQwm8NL7OfPxOdPL1Y8sBwEcpGI
         D5OBiqUTYZk+SRa3rLFpnSukWEWUXvrIW6KvvhggVrn9lg3wBrgbNaqgv6qdcOlQXxgx
         PpgNXitEutOjPQSKBTQ184vTMUn+oaatU9e4cpT1N0MTXMryenAZ2BhO2JFSeldb2KIt
         U/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1aM6tTs3WJhlduRar9DOocwYwfdre0Ej0s67EMZYShg=;
        b=XjL7GXEWIRqUeoeCZY/vr907doKVkVZDeewDG+ajwSctANOaxo39KgfgCqvXzAZu04
         yQouXrcR+Af9C3cQSZpOBeKOADf8eBIPuXYf5EdtXGlwZMN/vv1eeshxTPpphTLpJG0U
         OJhHWVcLMyvJvShOzLDXnBD4VGiL79TuBXhylCKlVepJreECXDXJ7uaxht78UZy4O3kn
         EK2/DYxib0orlOc8pSt5yk0G920kxXUJQH5eH1pFLF4EpbCeH7PXbTxnwwj87UYvjRR2
         lvJ38slTUuBlICDQ0lh/Jl27TTNI8wi8z7keiW7JIzYoOANDHZw6tutdX8ExRxEVtzrS
         K2yw==
X-Gm-Message-State: AIkVDXI5ACM9wMyjc86V8SeUVojCj+xFkkvTpQTYZQqQUSqSSPBKa0v/xOHyLn88aBg06pny
X-Received: by 10.99.121.69 with SMTP id u66mr115505484pgc.96.1483468983865;
        Tue, 03 Jan 2017 10:43:03 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id e5sm141421338pfd.77.2017.01.03.10.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 10:43:02 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v4 04/16] ls-tree: convert show_recursive to use the pathspec struct interface
Date:   Tue,  3 Jan 2017 10:42:29 -0800
Message-Id: <20170103184241.128409-5-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170103184241.128409-1-bmwill@google.com>
References: <1481670870-66754-1-git-send-email-bmwill@google.com>
 <20170103184241.128409-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'show_recursive()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0e30d8623..d7ebeb4ce 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,21 +31,18 @@ static const  char * const ls_tree_usage[] = {
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
-	const char **s;
+	int i;
 
 	if (ls_options & LS_RECURSIVE)
 		return 1;
 
-	s = pathspec._raw;
-	if (!s)
+	if (!pathspec.nr)
 		return 0;
 
-	for (;;) {
-		const char *spec = *s++;
+	for (i = 0; i < pathspec.nr; i++) {
+		const char *spec = pathspec.items[i].match;
 		int len, speclen;
 
-		if (!spec)
-			return 0;
 		if (strncmp(base, spec, baselen))
 			continue;
 		len = strlen(pathname);
@@ -59,6 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 			continue;
 		return 1;
 	}
+	return 0;
 }
 
 static int show_tree(const unsigned char *sha1, struct strbuf *base,
@@ -175,8 +173,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
-				  PATHSPEC_EXCLUDE,
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.11.0.390.gc69c2f50cf-goog

