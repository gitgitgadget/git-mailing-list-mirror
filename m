Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC43203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 18:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbdJYStY (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:49:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:56074 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbdJYStS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:49:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id 17so612787pfn.12
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrU2WQ1YEUbYoReGUUyvwRMW9Leyxn205xYxff2It3w=;
        b=RWqGtc92f9WIHsDOGIl4Db+iSrgPSDCzHBfbevoC+eYqYO3n+m9KR8J0DjKsK9awzg
         skdb24X/hoeLse88U0woZYPWIcNK7oa9oKKmWx3Rlrn6yTd7mGj55f52ZPQ05ZXAGZYB
         /6FKB8S5OWMmUoBT3BEKqZ0cSJhixxGLJRb+tFGRThdEAhP2f2YHvustZQxWyesc3bWH
         5426svXCb+pgZSWOL/vrDo/J4X98nuhX+wkoaBkR8Tuy0+2uAFOPlOTA3ZllQTDsYUnj
         POOSKQGgJSX5Wch6XkR2uV+Fvi1ezIVKp4GfQJWrWxdgPTyW1mdfHk2pGQlxa4VLiidq
         6/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrU2WQ1YEUbYoReGUUyvwRMW9Leyxn205xYxff2It3w=;
        b=T8T8AejZOiGiiHyGPwmdkIm1rmXeL4nFoJyh/88YibWIVgq82YqpyNUO3le0CeLez4
         mqFzDNl8xLd1kp9uZjcaGvRZ9SBTsT5f+dJDb3rx8iGkpKz9e38xzNhfse4uVPyE4FJt
         HzsuUytZ9Dnd7Ytxycqb56FM1NE3ZBJlziC5d3yhJMHuUp+uUCNUpDE2+Vvskgdw+Vx5
         y8TRvHPJmtCXE4UpVuDN/GeIjfcZKO3hBNwqPL/dn4wJxbmeeF+34az/bDcVSufq/+FL
         3Z/yuEtpE+Iytcw1Fw7iOk+j+SzyGP7gEao4SMYdAOwVkOqcRNOZtV3PyHt9bFmYSBNp
         p0RA==
X-Gm-Message-State: AMCzsaUweac1mseDuKxa5LEIzX69KxGcVtzbWq1EpC2COxk6IWMnDi1H
        8XAv1xv1ohiY/WOzaDIZHscGuQ==
X-Google-Smtp-Source: ABhQp+TZz0JSy8184A4sPhnZH9Gp0jAW/Jld6E3+g5W2q6+rw0GzkAIp/hsCHp28b601pn6h9w6hag==
X-Received: by 10.98.62.17 with SMTP id l17mr3087082pfa.210.1508957357735;
        Wed, 25 Oct 2017 11:49:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id x11sm6247530pgq.29.2017.10.25.11.49.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:49:17 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        peff@peff.net, sbeller@google.com
Subject: [PATCH 2/2] diff.c: get rid of duplicate implementation
Date:   Wed, 25 Oct 2017 11:49:12 -0700
Message-Id: <20171025184912.21657-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171025184912.21657-1-sbeller@google.com>
References: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
 <20171025184912.21657-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The implementations in diff.c to detect moved lines needs to compare
strings and hash strings, which is implemented in that file, as well
as in the xdiff library.

Remove the rather recent implementation in diff.c and rely on the well
exercised code in the xdiff lib.

With this change the hash used for bucketing the strings for the moved
line detection changes from FNV32 (that is provided via the hashmaps
memhash) to DJB2 (which is used internally in xdiff).  Benchmarks found
on the web[1] do not indicate that these hashes are different in
performance for readable strings.

[1] https://softwareengineering.stackexchange.com/questions/49550/which-hashing-algorithm-is-best-for-uniqueness-and-speed

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

