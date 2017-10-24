Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A616A20437
	for <e@80x24.org>; Tue, 24 Oct 2017 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbdJXS7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 14:59:35 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:55327 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbdJXS7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 14:59:31 -0400
Received: by mail-io0-f195.google.com with SMTP id p186so24968714ioe.12
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NBOoA6MnZhrHWdfqLkJ65aapB1TqOi3Sd2UDrdcahZw=;
        b=U9Yln7j2zaXXwQqs4WNyRBp4w6mMYj6pVem0ViExQ5c3ErxXeO2Wnm5aOdSvrxvxDN
         ryzXpItj6URBkaM98R3r0KvXwbB7MygbLNpNJF9+Rl0zRCyFmktpnhgaGigXby73qfYi
         J9zwIbuiyS41XIU1MoAxRzgOJrQBpYdK99O/vj6FywYFtFlbcihcubVNenUomsVsPxeZ
         +duEclDlDSNMetOg1AqtjrG2oRZe5h9VDw5UkP0HSe9fs8i5/uRyAGsi+y/0CnCiUW9/
         dwdiFKrcCnCULyEqqPo24NOKtmv7dYvoSpAt+8BFrjw7JCzq8z+FdEC3WJB2gxM/1ILO
         YVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NBOoA6MnZhrHWdfqLkJ65aapB1TqOi3Sd2UDrdcahZw=;
        b=SnWAL9C+RDbyAfk9f/fRr8F2miKggxuJ0n7MTiyjMfcpHYhURS6y+k28KGebFjU5DP
         3IYegDqapp972vgkmBej+bUuU+Hl2SMbIdBDex3E8uHOKh35RpgSnsC9f6MCqfCva1vx
         36cVUVdO0EA5kUsg0O9OQAv2xFJR0OImImZN19uajz7HobMJ6hDTpC9Le9YbyLloGcFj
         +uGFV2Wgq5vOEIP7Tb745sOZ7T7Q/7c5oI76jkNVfmkvxsgv0Tjy/9kpLTpRa6lsYoLY
         9VMBiKT8BcLy7KrhJGHgcmnrC18uG7yFPEDsEcUAWwt+xA29bf10cCtn9GrFQ0rruG32
         eY+Q==
X-Gm-Message-State: AMCzsaV3i/clp/aYmM+UZ+Z/aEXW/URQOYVryq+jTt5+aPPSH82Psocd
        O8aBu42iWEVwkb4mrw6znSpMxfxoECw=
X-Google-Smtp-Source: ABhQp+SEFJy2jjbRWIh9tEL/PBJL8pDXsoirki4MvfETB7UYTj45ZpCa4SLoVSyBcuqHOPiqBn9vYw==
X-Received: by 10.107.83.2 with SMTP id h2mr13294491iob.239.1508871569913;
        Tue, 24 Oct 2017 11:59:29 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id o29sm391933ioi.29.2017.10.24.11.59.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 11:59:29 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] diff.c: get rid of duplicate implementation
Date:   Tue, 24 Oct 2017 11:59:17 -0700
Message-Id: <20171024185917.20515-5-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024185917.20515-1-sbeller@google.com>
References: <20171024185917.20515-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementations in diff.c to detect moved lines
needs to compare strings and hash strings, which is
implemented in that file, as well as in the xdiff
library.

Remove the rather recent implementation in diff.c
and rely on the well exercised code in the xdiff lib.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 82 ++++--------------------------------------------------------------
 1 file changed, 4 insertions(+), 78 deletions(-)

diff --git a/diff.c b/diff.c
index c4a669ffa8..e6814b9e9c 100644
--- a/diff.c
+++ b/diff.c
@@ -707,88 +707,14 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int next_byte(const char **cp, const char **endp,
-		     const struct diff_options *diffopt)
-{
-	int retval;
-
-	if (*cp >= *endp)
-		return -1;
-
-	if (isspace(**cp)) {
-		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_CHANGE)) {
-			while (*cp < *endp && isspace(**cp))
-				(*cp)++;
-			/*
-			 * After skipping a couple of whitespaces,
-			 * we still have to account for one space.
-			 */
-			return (int)' ';
-		}
-
-		if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE)) {
-			while (*cp < *endp && isspace(**cp))
-				(*cp)++;
-			/*
-			 * return the first non-ws character via the usual
-			 * below, unless we ate all of the bytes
-			 */
-			if (*cp >= *endp)
-				return -1;
-		}
-	}
-
-	retval = (unsigned char)(**cp);
-	(*cp)++;
-	return retval;
-}
-
 static int moved_entry_cmp(const struct diff_options *diffopt,
 			   const struct moved_entry *a,
 			   const struct moved_entry *b,
 			   const void *keydata)
 {
-	const char *ap = a->es->line, *ae = a->es->line + a->es->len;
-	const char *bp = b->es->line, *be = b->es->line + b->es->len;
-
-	if (!(diffopt->xdl_opts & XDF_WHITESPACE_FLAGS))
-		return a->es->len != b->es->len  || memcmp(ap, bp, a->es->len);
-
-	if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
-		while (ae > ap && isspace(ae[-1]))
-			ae--;
-		while (be > bp && isspace(be[-1]))
-			be--;
-	}
-
-	while (1) {
-		int ca, cb;
-		ca = next_byte(&ap, &ae, diffopt);
-		cb = next_byte(&bp, &be, diffopt);
-		if (ca != cb)
-			return 1;
-		if (ca < 0)
-			return 0;
-	}
-}
-
-static unsigned get_string_hash(struct emitted_diff_symbol *es, struct diff_options *o)
-{
-	if (o->xdl_opts & XDF_WHITESPACE_FLAGS) {
-		static struct strbuf sb = STRBUF_INIT;
-		const char *ap = es->line, *ae = es->line + es->len;
-		int c;
-
-		strbuf_reset(&sb);
-		while (ae > ap && isspace(ae[-1]))
-			ae--;
-		while ((c = next_byte(&ap, &ae, o)) >= 0)
-			strbuf_addch(&sb, c);
-
-		return memhash(sb.buf, sb.len);
-	} else {
-		return memhash(es->line, es->len);
-	}
+	return !xdiff_compare_lines(a->es->line, a->es->len,
+				    b->es->line, b->es->len,
+				    diffopt->xdl_opts);
 }
 
 static struct moved_entry *prepare_entry(struct diff_options *o,
@@ -797,7 +723,7 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	struct moved_entry *ret = xmalloc(sizeof(*ret));
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[line_no];
 
-	ret->ent.hash = get_string_hash(l, o);
+	ret->ent.hash = xdiff_hash_string(l->line, l->len, o->xdl_opts);
 	ret->es = l;
 	ret->next_line = NULL;
 
-- 
2.15.0.rc2.6.g953226eb5f

