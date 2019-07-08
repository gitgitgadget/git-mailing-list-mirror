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
	by dcvr.yhbt.net (Postfix) with ESMTP id CE17D1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfGHQh4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:37:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55199 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfGHQh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so164026wme.4
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=um/9zOcBiOyw+NiulWlXwTkJJZOb/1/RiYr67/KXdYil+Qhj242aLZMNOxbKpUvf7+
         7l/3/SoIBCEL9BfBTHuq6wdkS/YQNZNmUfRans+6XUf9Z/jjiq/sirCft+G+7hR5Pq14
         TdDjVN7iWCHtnkTJIZCQ0Z5PU6JOHQ+BnD8C8Wgk24x4aaGRzi87RkJZV5NhXFKTmDVR
         5lnviNw3kYOmYJAqjqWcF9lpG40+WFNjD/QdQo+XFxIykVAySaloWSHxocjnsOT3TXV1
         jW0HcYp8y/RWVwlFOGQ2Tx3FDa7Om32ZmteDh7rDVlZ6aFyMJp/JbsDrIJXllBSS/4Ok
         bQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=SnPd0Onl4F46ykZSviY5qiMr8uX8ijc4Pv5AleO/K7dnQsl7OpaHo3N9lzML7SrLsQ
         rios/qJ5QCjimVbYEMYTzCGY7fbHFICGhMNm9ppUY8EgGnbb+0ASGshbcX43MVTxm5yO
         toeCSF87MW+cojIdBNvTxOOzfd842oGo1ZdPojlXWbC12qQLrpGpsmOaOkCbRXENb67r
         K0ZQQyMEPF09Sp2vngkyDkBZoK/+pVLZw7ixW0fwgDpxVAcGTcu+s8mJfSdrAx+3H7L4
         xXqDK4FvQonR+RQnZTPC5j+Ivw7Reb1+VpcUXUDsIssQIkzoykRnY21DQ6Ksv2K80saB
         kWMg==
X-Gm-Message-State: APjAAAXaKMpA0OiBnfjp1TLaWuuI7LIXLRH3uXR/3SOu0ixCdJfmGwuz
        udsLn19N4FqMcRpQhWOucgJo3GXu
X-Google-Smtp-Source: APXvYqw9t5UKSQNkCTrWGjFuSFGJCNenqokPRjGysLOYECI/S8O+LlhN7CvtW8WpXhK27UKTGV+QAQ==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr16195191wme.74.1562603873819;
        Mon, 08 Jul 2019 09:37:53 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id d10sm19632112wro.18.2019.07.08.09.37.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:53 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 02/14] apply: only pass required data to skip_tree_prefix
Date:   Mon,  8 Jul 2019 17:33:03 +0100
Message-Id: <20190708163315.29912-3-t.gummerer@gmail.com>
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

Currently the 'skip_tree_prefix()' function takes 'struct apply_state'
as parameter, even though it only needs the p_value from that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index 599cf8956f..fc7083fcbc 100644
--- a/apply.c
+++ b/apply.c
@@ -1137,17 +1137,17 @@ static int gitdiff_unrecognized(struct apply_state *state,
  * Skip p_value leading components from "line"; as we do not accept
  * absolute paths, return NULL in that case.
  */
-static const char *skip_tree_prefix(struct apply_state *state,
+static const char *skip_tree_prefix(int p_value,
 				    const char *line,
 				    int llen)
 {
 	int nslash;
 	int i;
 
-	if (!state->p_value)
+	if (!p_value)
 		return (llen && line[0] == '/') ? NULL : line;
 
-	nslash = state->p_value;
+	nslash = p_value;
 	for (i = 0; i < llen; i++) {
 		int ch = line[i];
 		if (ch == '/' && --nslash <= 0)
@@ -1184,7 +1184,7 @@ static char *git_header_name(struct apply_state *state,
 			goto free_and_fail1;
 
 		/* strip the a/b prefix including trailing slash */
-		cp = skip_tree_prefix(state, first.buf, first.len);
+		cp = skip_tree_prefix(state->p_value, first.buf, first.len);
 		if (!cp)
 			goto free_and_fail1;
 		strbuf_remove(&first, 0, cp - first.buf);
@@ -1201,7 +1201,7 @@ static char *git_header_name(struct apply_state *state,
 		if (*second == '"') {
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail1;
-			cp = skip_tree_prefix(state, sp.buf, sp.len);
+			cp = skip_tree_prefix(state->p_value, sp.buf, sp.len);
 			if (!cp)
 				goto free_and_fail1;
 			/* They must match, otherwise ignore */
@@ -1212,7 +1212,7 @@ static char *git_header_name(struct apply_state *state,
 		}
 
 		/* unquoted second */
-		cp = skip_tree_prefix(state, second, line + llen - second);
+		cp = skip_tree_prefix(state->p_value, second, line + llen - second);
 		if (!cp)
 			goto free_and_fail1;
 		if (line + llen - cp != first.len ||
@@ -1227,7 +1227,7 @@ static char *git_header_name(struct apply_state *state,
 	}
 
 	/* unquoted first name */
-	name = skip_tree_prefix(state, line, llen);
+	name = skip_tree_prefix(state->p_value, line, llen);
 	if (!name)
 		return NULL;
 
@@ -1243,7 +1243,7 @@ static char *git_header_name(struct apply_state *state,
 			if (unquote_c_style(&sp, second, NULL))
 				goto free_and_fail2;
 
-			np = skip_tree_prefix(state, sp.buf, sp.len);
+			np = skip_tree_prefix(state->p_value, sp.buf, sp.len);
 			if (!np)
 				goto free_and_fail2;
 
@@ -1287,7 +1287,7 @@ static char *git_header_name(struct apply_state *state,
 			 */
 			if (!name[len + 1])
 				return NULL; /* no postimage name */
-			second = skip_tree_prefix(state, name + len + 1,
+			second = skip_tree_prefix(state->p_value, name + len + 1,
 						  line_len - (len + 1));
 			if (!second)
 				return NULL;
-- 
2.22.0.510.g264f2c817a

