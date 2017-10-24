Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04F21FAED
	for <e@80x24.org>; Tue, 24 Oct 2017 23:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdJXXmv (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 19:42:51 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:57237 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdJXXms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 19:42:48 -0400
Received: by mail-io0-f196.google.com with SMTP id m81so25686895ioi.13
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qrU2WQ1YEUbYoReGUUyvwRMW9Leyxn205xYxff2It3w=;
        b=Tkd1/GSEGl/HDl4XTWi059Rz/iDSGTF+dCLhIrGR2YUyYkQLHi4Ivi4+L3+YLgxrJ9
         +eJI9RSv/9O2Jc2o8Bu/R/MW7U5NkL8f+cQ1BvfFdXgx7OAEQIk+HEVVDUJJHCQw0+7k
         oqdHWfJtEsZOkfkfJCws5dtT6XNVJaD4UnusjhqK8Y9Jt/4BnMommW8vO6L08mldSOL6
         C8SIh48m67zsWj6XTA/+CMmRzgrccetryLMrkpTKbR7gfJFLP3YO5sEVLNIEmCA6R37M
         CfyfcwhzQj/eh9npyOKuI6XJ3YaO2xzNhmgLRHLBYorgP9IYfifRPw40ZwhZuJP0iWvS
         1pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qrU2WQ1YEUbYoReGUUyvwRMW9Leyxn205xYxff2It3w=;
        b=R+piG0M3hB9qhJDSmpyHpi12PKOC+YtTTUmEw67KHTdKlulGDQGtZ7C9ynEVpH1cBS
         7RSevraaQ2BqkyXcsQtkPpx8eLOMV5qa170EUUM2bonmrBDAAe7M3pRCz9buR6qAWJZZ
         05GvLb0zzjxtfc9DFeY/0sGL0nMb3+PAC0UERrZzcXDVhK7VOY5dFRtW7beLR3CMUGyd
         Pd8jUkn6wrUuuQzV4xx8jzKcXxH8w8LBILvKyoK9ydp5LSzjTAY3CSReflK2ZdCpSYhH
         C+eOGiHTsJlsSh4tcmkaPkl3UEshI2Vcc/j70jeRTGFY1K6ABPfCw0d0keck3yHBUE4R
         MSEQ==
X-Gm-Message-State: AMCzsaVV5Bsmz1sw0WS6/b9p1fKqUxjreBwYWtg5IROsC4SgcwikEo/y
        PCCZEegIEIhHn+tj1Q1oI/rbEQ==
X-Google-Smtp-Source: ABhQp+TEjgLWUjVEWhZ+rPzkP5lSJL+DRl7AXQrTf0CRwTwPgQWZeaVQZFKXNrl4mBIs+P49V6dgdA==
X-Received: by 10.107.85.8 with SMTP id j8mr22338672iob.54.1508888567827;
        Tue, 24 Oct 2017 16:42:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:24db:446:6fc5:b25b])
        by smtp.gmail.com with ESMTPSA id w63sm625319iof.7.2017.10.24.16.42.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Oct 2017 16:42:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        l.s.r@web.de
Subject: [PATCH 2/2] diff.c: get rid of duplicate implementation
Date:   Tue, 24 Oct 2017 16:42:34 -0700
Message-Id: <20171024234234.10944-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171024234234.10944-1-sbeller@google.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
 <20171024234234.10944-1-sbeller@google.com>
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

