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
	by dcvr.yhbt.net (Postfix) with ESMTP id 754CE1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfGERG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:06:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44112 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfGERG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:06:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so9379388wrx.11
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=L/2uRcNf3aSJQFx2EHdPqtuIzDdbB9zD0t1Fpro5sC3XLLFsraBfisaU2/irYV39bG
         yFq6tqoQvdgydJ9a71sAAJ/48pkL5iQ1dq4g1NwCjlLJKt8U2CeWlLy+weaYphgHQf6O
         CWFpC3QEF1rYzlVO69eSgdVvwE7cubwR9EmEMSwKKrhVbxOzlW0bXlwYnFmbnaTQnfiT
         rvmFVIsRPehAFxhbuBBfhN00hP0CRBtfhobvmAacJ87fe3rnhezhX1lIKMyMdc1gwgQ4
         bFWr3opzkLAoU1bMJnO04BRO7pWoRkf4f3u+j7KVJ3MavbNmNzSlBlnFwY/j5arL+rHf
         IQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIbXyTxlwMdejKMx7NpVdVDXqC/2s+5mFLjBN4bTADg=;
        b=AAbZfRyyXpmrJqvCzBMHI6+YtpuDb+rEwRRuww7TMLj7Fz5OFc6p1ymO2T3hnVLVcA
         mIEc1hFI2Nsr7jlc4Y3zVrM7W0L2Pch4VipUR43X8clftuTo3LsKLlJCXD/lk6QH4PxK
         JluUBnU3If5m+G2sCafatFphAVZoucf7GpFHnCeyvKltD/GSAShZLflLDFwEtiWd1iN6
         LSfmrCaVWP6H2NOzIxwSQOkHOW1BoljG70KJc36tali+DLfGl1y2JqDtCK+v7d2cjfpz
         2t+IzQOzBAw1BwpMOKSAAoT4JEQrsRdLq9PbtE+6ZK0g0CIIEC8HOAaAxJlTEof8s26X
         74qQ==
X-Gm-Message-State: APjAAAWolmC/w2b00nMy8wUW9SBs5WscvydcX6MMSxCQuQwh39JFOlFk
        uI+F4yVrzHZiBnDl4Vxr8sjbJn2F
X-Google-Smtp-Source: APXvYqzqSoBmE8s5Dx/piHARo/VDSEnFeWjI7e5RVskCQmQFaQ6yno7gpxrL1FZVkOB7MJs2hsbnkg==
X-Received: by 2002:adf:a55b:: with SMTP id j27mr4890920wrb.154.1562346415127;
        Fri, 05 Jul 2019 10:06:55 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id g25sm6066734wmk.39.2019.07.05.10.06.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:06:54 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 02/14] apply: only pass required data to skip_tree_prefix
Date:   Fri,  5 Jul 2019 18:06:18 +0100
Message-Id: <20190705170630.27500-3-t.gummerer@gmail.com>
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

