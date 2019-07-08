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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AF921F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbfGHQh5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:37:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so17909698wru.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZ9kFX0N72mcSGgn7JN2fNtiXauZXqmYq3Ey8+GVM3Y=;
        b=oQRFcIFYb3ONF7X7nLmIyH/7xs89hWpG59Zv6saDE3cWBxduj9ECOJp2G1kCGziD/z
         7SKk9Ps43k8uasGj8sFgYPuBNJzB/+cD2jAKOZiQVBZo1CtKdyg6xZsKf9pq1xgTc6jT
         cF8VnGxx91G2g3GISLHnL3FS+qWLmcdxoECxP2tgR8XNzDH6+9AjSaaSaGOrTyTiEZ71
         guB3YT3AG2fQ1TIe/u2YhcceBCsOzM12v3oJBa3DbOs2AqaC90NS8lmFFf3pHmlMf9BP
         iFXNU3Tf2ScCZ3iG0guFoWZoEUZjF7rfmjebzKLCgXVMjpOPSCSYZSOeoLL2wfh4PR02
         Jbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZ9kFX0N72mcSGgn7JN2fNtiXauZXqmYq3Ey8+GVM3Y=;
        b=XQBzVI93U+g7O1xl1UuUxQconu7C1/Cs3fWZjg49b+VqofPkX5UySP65nrc/9V/J2f
         1bzMHyrZeTkYthQKBNoEy41QCC0tGRVogqY1nPhPCmLBYs0k680/HQgZQFjoGpB2Sftd
         WzFd9evf22Oh/tYkQe6s0RLwA74llrtG9+A4qc5hl263B8NK/WrE4tIZXIb4cO1ZlpdB
         Nl2IwVykLd2G4jNtlEGwxiW+1H2asOdUcLU61tpho7Od7Lyb+bqyfQ6xIIGN4zRcFdRp
         M5zUmr9qN+2EL2ctPJDLPj2DOnkQ7m4lPicJB8NUm9kzzJu8saHdtYDohsAwGN7RQ7J4
         ks/g==
X-Gm-Message-State: APjAAAX1oXse9LdRfA+hWecSDx9myjTYcjR1ERQhfq1fML57+cnXFry5
        LIDoxdyT+3bSwEGAYPOeRg/3jCeX
X-Google-Smtp-Source: APXvYqx8b9Pq49IVR6hqZzc8+caVfrV5K8edcU/a8Zf8KPcbkKQJLNWT4VYOsCyuwjlxzP0CPoAIRA==
X-Received: by 2002:adf:f182:: with SMTP id h2mr13990794wro.132.1562603875261;
        Mon, 08 Jul 2019 09:37:55 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id x129sm40204wmg.44.2019.07.08.09.37.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:54 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 03/14] apply: only pass required data to git_header_name
Date:   Mon,  8 Jul 2019 17:33:04 +0100
Message-Id: <20190708163315.29912-4-t.gummerer@gmail.com>
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

Currently the 'git_header_name()' function takes 'struct apply_state'
as parameter, even though it only needs the p_value from that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index fc7083fcbc..ac668e754d 100644
--- a/apply.c
+++ b/apply.c
@@ -1164,7 +1164,7 @@ static const char *skip_tree_prefix(int p_value,
  * creation or deletion of an empty file.  In any of these cases,
  * both sides are the same name under a/ and b/ respectively.
  */
-static char *git_header_name(struct apply_state *state,
+static char *git_header_name(int p_value,
 			     const char *line,
 			     int llen)
 {
@@ -1184,7 +1184,7 @@ static char *git_header_name(struct apply_state *state,
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(state->p_value, first.buf, first.len);
+		cp = skip_tree_prefix(p_value, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1201,7 +1201,7 @@ static char *git_header_name(struct apply_state *state,
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(state->p_value, sp.buf, sp.len);
+			cp = skip_tree_prefix(p_value, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1212,7 +1212,7 @@ static char *git_header_name(struct apply_state *state,
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(state->p_value, second, line + llen - second);
+		cp = skip_tree_prefix(p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1227,7 +1227,7 @@ static char *git_header_name(struct apply_state *state,
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(state->p_value, line, llen);
+	name = skip_tree_prefix(p_value, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1243,7 +1243,7 @@ static char *git_header_name(struct apply_state *state,
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(state->p_value, sp.buf, sp.len);
+			np = skip_tree_prefix(p_value, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1287,7 +1287,7 @@ static char *git_header_name(struct apply_state *state,
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(state->p_value, name + len + 1,
+			second = skip_tree_prefix(p_value, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
@@ -1333,7 +1333,7 @@ static int parse_git_header(struct apply_state *state,
 	 * or removing or adding empty files), so we get
 	 * the default name from the header.
 	 */
-	patch->def_name = git_header_name(state, line, len);
+	patch->def_name = git_header_name(state->p_value, line, len);
 	if (patch->def_name && state->root.len) {
 		char *s = xstrfmt("%s%s", state->root.buf, patch->def_name);
 		free(patch->def_name);
-- 
2.22.0.510.g264f2c817a

