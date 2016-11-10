Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D4820229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966139AbcKJUfn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:43 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34065 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965015AbcKJUfP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:15 -0500
Received: by mail-pf0-f170.google.com with SMTP id n85so151868780pfi.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YpEjb37vFDHGw1z+hA6ciZZRVNNAPoo34Gq3l16VZ9A=;
        b=cIwvAUG5f6mnf4jEHT7mTR2PWnn12jy1AUZdYyKooRPF/KlKp+CUfH09MQU1T3Q4fl
         r8xAb2g8hyJ5P4sud/tmzMFeYOQZ3sc3WJFhgEcO77+V0vIzcUzL4TMdyIFX7H0tyZtF
         5Z919RIW8IPRVike9skO1lqeZG3+WcF7B8XSHBahyRlvIU6ymXtbrfMnCy/sug5qeblV
         yK6zj468rsTOUZikwuKnbBmevj7sqJwBK4kAAygENrxHwuMR+1oSKS0jSEyp3WYeyXFa
         IjiwGfMAZOtir4RxWV+bFUumFe3sg07zpaUp1xmLMgUdSCZz1ctrdsoHwS198egPGK/U
         9hyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YpEjb37vFDHGw1z+hA6ciZZRVNNAPoo34Gq3l16VZ9A=;
        b=bP8zexfWg/5T2wCCxIGwqfbgrgZB9U9MZLVhYirp3uBfRbCQ8bvCMoJ6XWytDg9+lI
         b6bpQ75mx2iDTq5dCxLADMpZhdXMEkOHAJxPcoli9JjpGKFrle2ghuBFs7NzyIcmEz9W
         oUY+Rkt74PlTVUWzUWuoB8b6yKLjAzd0AvMPsGaXAd6AqVRf0wXWBdq3AEclE/1H7dXX
         NgLKj8UgAUA1hVNyxY65VzAPQSMTqP5F5FXNWQ8SjIshhFOKLFLutLGoUDu0AvRSvgF9
         15TvPyglQ06bxNT/zYmk1O9q1TYreCiWruFeUUJ7U15VtXsCAPs2b4vTr2wm+Xd+fh7u
         +9GA==
X-Gm-Message-State: ABUngvfYntaw79W1wl0xuASxIzsdA5ydWxdtwVZx5rwBrQFo38eNkeohMcdbXXgV89A0tCWc
X-Received: by 10.98.17.80 with SMTP id z77mr13548699pfi.166.1478810114533;
        Thu, 10 Nov 2016 12:35:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id c142sm9340362pfb.23.2016.11.10.12.35.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:14 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 29/35] pathspec: move long magic parsing out of prefix_pathspec
Date:   Thu, 10 Nov 2016 12:34:22 -0800
Message-Id: <20161110203428.30512-30-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`prefix_pathspec` is quite a lengthy function and we plan on adding more.
Split it up for better readability. As we want to add code into the
inner loop of the long magic parsing, we also benefit from lower
indentation.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pathspec.c | 84 +++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 37 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 86f2b44..67678fc 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -88,6 +88,52 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
 	strbuf_addf(sb, ",prefix:%d)", prefixlen);
 }
 
+static void eat_long_magic(struct pathspec_item *item, const char *elt,
+		unsigned *magic, int *pathspec_prefix,
+		const char **copyfrom_, const char **long_magic_end)
+{
+	int i;
+	const char *copyfrom = *copyfrom_;
+	/* longhand */
+	const char *nextat;
+	for (copyfrom = elt + 2;
+	     *copyfrom && *copyfrom != ')';
+	     copyfrom = nextat) {
+		size_t len = strcspn(copyfrom, ",)");
+		if (copyfrom[len] == ',')
+			nextat = copyfrom + len + 1;
+		else
+			/* handle ')' and '\0' */
+			nextat = copyfrom + len;
+		if (!len)
+			continue;
+		for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
+			if (strlen(pathspec_magic[i].name) == len &&
+			    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
+				*magic |= pathspec_magic[i].bit;
+				break;
+			}
+			if (starts_with(copyfrom, "prefix:")) {
+				char *endptr;
+				*pathspec_prefix = strtol(copyfrom + 7,
+							  &endptr, 10);
+				if (endptr - copyfrom != len)
+					die(_("invalid parameter for pathspec magic 'prefix'"));
+				/* "i" would be wrong, but it does not matter */
+				break;
+			}
+		}
+		if (ARRAY_SIZE(pathspec_magic) <= i)
+			die(_("Invalid pathspec magic '%.*s' in '%s'"),
+			    (int) len, copyfrom, elt);
+	}
+	if (*copyfrom != ')')
+		die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
+	*long_magic_end = copyfrom;
+	copyfrom++;
+	*copyfrom_ = copyfrom;
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -150,43 +196,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	    (flags & PATHSPEC_LITERAL_PATH)) {
 		; /* nothing to do */
 	} else if (elt[1] == '(') {
-		/* longhand */
-		const char *nextat;
-		for (copyfrom = elt + 2;
-		     *copyfrom && *copyfrom != ')';
-		     copyfrom = nextat) {
-			size_t len = strcspn(copyfrom, ",)");
-			if (copyfrom[len] == ',')
-				nextat = copyfrom + len + 1;
-			else
-				/* handle ')' and '\0' */
-				nextat = copyfrom + len;
-			if (!len)
-				continue;
-			for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
-				if (strlen(pathspec_magic[i].name) == len &&
-				    !strncmp(pathspec_magic[i].name, copyfrom, len)) {
-					magic |= pathspec_magic[i].bit;
-					break;
-				}
-				if (starts_with(copyfrom, "prefix:")) {
-					char *endptr;
-					pathspec_prefix = strtol(copyfrom + 7,
-								 &endptr, 10);
-					if (endptr - copyfrom != len)
-						die(_("invalid parameter for pathspec magic 'prefix'"));
-					/* "i" would be wrong, but it does not matter */
-					break;
-				}
-			}
-			if (ARRAY_SIZE(pathspec_magic) <= i)
-				die(_("Invalid pathspec magic '%.*s' in '%s'"),
-				    (int) len, copyfrom, elt);
-		}
-		if (*copyfrom != ')')
-			die(_("Missing ')' at the end of pathspec magic in '%s'"), elt);
-		long_magic_end = copyfrom;
-		copyfrom++;
+		eat_long_magic(item, elt, &magic, &pathspec_prefix, &copyfrom, &long_magic_end);
 	} else {
 		/* shorthand */
 		for (copyfrom = elt + 1;
-- 
2.10.1.469.g00a8914

