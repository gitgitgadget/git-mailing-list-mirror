Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F319D1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbdFPT3C (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:29:02 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33341 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752147AbdFPT27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:28:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id x23so7481396wrb.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qGWgrLGP5ZdfTJYnEHw0oWy+8D1mLJ+fZACsFrHVQc8=;
        b=BpLIW+cfBiqG+nfrZScfn1FuWuqVbm65Bar2eUYYU0crZpGM92ggzVRSdPosm2XuEV
         p3RaVM36aOAektoISIxbqa6i1wIK4de8WvKRUN0uVo/rHM98rHC8g29iCb1iebnPLrfH
         9ovLKsrbnYyVdQdu5ORqhBhLaumFieCeSnCujGcYgx5JcZRZA5aau1gDmUxx6ln45sKU
         0yNcL0B/ELHdZ7KZJkIg236/X2PNnB0OaWp0W6bPQLUgOVqOuoLEjKTvPxKH/4ayn+J5
         ybrYYBh8yfemSsUBcPkQ5O3+EK3Oum3nZwd5jfkTxfE5VGghvqyTNLtHCEYr2iDBb+n3
         s+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qGWgrLGP5ZdfTJYnEHw0oWy+8D1mLJ+fZACsFrHVQc8=;
        b=TRKRSz7nw8qR5BeM8NGRMv82tciTUS2/s1peQrsESMK7fxey1y/qVohiFjUzJ8qz67
         Dsabe/EnJ+2QVYRVFIN5497rgUoU/t+Qmw6MoaF57jMDmI0Hh+mrW9ob6dfK4qy329qE
         XCyjc7KkZfSfGqB+Z/vEFlC2Xs1kOeX+wW2/Uw3me33APrQkqMvmfbmujDq91xKdATVB
         0LA/wXOtwa1VTdc8uvfhmgAw/RMvQrUei7Q7FYo8GnVCon2dMLIrK2v+QAXgvAn5HupQ
         SW96uwiLSSCwv052NTMZFddJBS+PIGBNt6JD8b0bGhOyr+YmkQqqAqFBLUICFANYHpNz
         THTQ==
X-Gm-Message-State: AKS2vOwCUb53Xj062TTCxoJYIoVna/9rSxEKws3GRBmo8YUcxnD6b1zm
        iGHOTHMf4w6KIrIL
X-Received: by 10.223.136.216 with SMTP id g24mr9534339wrg.162.1497641333198;
        Fri, 16 Jun 2017 12:28:53 -0700 (PDT)
Received: from localhost.localdomain (x4db0ef0e.dyn.telefonica.de. [77.176.239.14])
        by smtp.gmail.com with ESMTPSA id c71sm2658026wmh.21.2017.06.16.12.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:28:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/5] remote.c: extract a helper function to parse a single refspec
Date:   Fri, 16 Jun 2017 21:28:35 +0200
Message-Id: <20170616192837.11035-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.501.g45ae33cbf
In-Reply-To: <20170616192837.11035-1-szeder.dev@gmail.com>
References: <20170616192837.11035-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fetch refspecs read from the configuration are currently parsed
lazily: they are collected into a string array for each remote while
reading the configuration and then refspecs of a particular remote are
parsed together later when the remote is accessed by remote_get() or
for_each_remote().

We are about to parse refspecs _while_ reading them from the
configuration, one by one, and a function parsing a single refspec
into a memory location provided by the caller will be quite useful
then.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 remote.c | 231 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 122 insertions(+), 109 deletions(-)

diff --git a/remote.c b/remote.c
index d23518afd..fc1d3cf7a 100644
--- a/remote.c
+++ b/remote.c
@@ -484,123 +484,136 @@ static void read_config(void)
 	alias_all_urls();
 }
 
+static int parse_one_refspec(struct refspec *rs, const char *refspec,
+			     int fetch, int gently)
+{
+	size_t llen;
+	int is_glob;
+	const char *lhs, *rhs;
+	int flags;
+
+	memset(rs, 0, sizeof(*rs));
+
+	is_glob = 0;
+
+	lhs = refspec;
+	if (*lhs == '+') {
+		rs->force = 1;
+		lhs++;
+	}
+
+	rhs = strrchr(lhs, ':');
+
+	/*
+	 * Before going on, special case ":" (or "+:") as a refspec
+	 * for pushing matching refs.
+	 */
+	if (!fetch && rhs == lhs && rhs[1] == '\0') {
+		rs->matching = 1;
+		return 0;
+	}
+
+	if (rhs) {
+		size_t rlen = strlen(++rhs);
+		is_glob = (1 <= rlen && strchr(rhs, '*'));
+		rs->dst = xstrndup(rhs, rlen);
+	}
+
+	llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
+	if (1 <= llen && memchr(lhs, '*', llen)) {
+		if ((rhs && !is_glob) || (!rhs && fetch))
+			goto invalid;
+		is_glob = 1;
+	} else if (rhs && is_glob) {
+		goto invalid;
+	}
+
+	rs->pattern = is_glob;
+	rs->src = xstrndup(lhs, llen);
+	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
+
+	if (fetch) {
+		struct object_id unused;
+
+		/* LHS */
+		if (!*rs->src)
+			; /* empty is ok; it means "HEAD" */
+		else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(rs->src, &unused))
+			rs->exact_sha1 = 1; /* ok */
+		else if (!check_refname_format(rs->src, flags))
+			; /* valid looking ref is ok */
+		else
+			goto invalid;
+		/* RHS */
+		if (!rs->dst)
+			; /* missing is ok; it is the same as empty */
+		else if (!*rs->dst)
+			; /* empty is ok; it means "do not store" */
+		else if (!check_refname_format(rs->dst, flags))
+			; /* valid looking ref is ok */
+		else
+			goto invalid;
+	} else {
+		/*
+		 * LHS
+		 * - empty is allowed; it means delete.
+		 * - when wildcarded, it must be a valid looking ref.
+		 * - otherwise, it must be an extended SHA-1, but
+		 *   there is no existing way to validate this.
+		 */
+		if (!*rs->src)
+			; /* empty is ok */
+		else if (is_glob) {
+			if (check_refname_format(rs->src, flags))
+				goto invalid;
+		}
+		else
+			; /* anything goes, for now */
+		/*
+		 * RHS
+		 * - missing is allowed, but LHS then must be a
+		 *   valid looking ref.
+		 * - empty is not allowed.
+		 * - otherwise it must be a valid looking ref.
+		 */
+		if (!rs->dst) {
+			if (check_refname_format(rs->src, flags))
+				goto invalid;
+		} else if (!*rs->dst) {
+			goto invalid;
+		} else {
+			if (check_refname_format(rs->dst, flags))
+				goto invalid;
+		}
+	}
+
+	return 0;
+
+ invalid:
+	if (gently) {
+		free(rs->src);
+		free(rs->dst);
+		return -1;
+	}
+	die("Invalid refspec '%s'", refspec);
+}
+
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
-	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
+	struct refspec *rs;
+
+	ALLOC_ARRAY(rs, nr_refspec);
 
 	for (i = 0; i < nr_refspec; i++) {
-		size_t llen;
-		int is_glob;
-		const char *lhs, *rhs;
-		int flags;
-
-		is_glob = 0;
-
-		lhs = refspec[i];
-		if (*lhs == '+') {
-			rs[i].force = 1;
-			lhs++;
-		}
-
-		rhs = strrchr(lhs, ':');
-
-		/*
-		 * Before going on, special case ":" (or "+:") as a refspec
-		 * for pushing matching refs.
-		 */
-		if (!fetch && rhs == lhs && rhs[1] == '\0') {
-			rs[i].matching = 1;
-			continue;
-		}
-
-		if (rhs) {
-			size_t rlen = strlen(++rhs);
-			is_glob = (1 <= rlen && strchr(rhs, '*'));
-			rs[i].dst = xstrndup(rhs, rlen);
-		}
-
-		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
-		if (1 <= llen && memchr(lhs, '*', llen)) {
-			if ((rhs && !is_glob) || (!rhs && fetch))
-				goto invalid;
-			is_glob = 1;
-		} else if (rhs && is_glob) {
-			goto invalid;
-		}
-
-		rs[i].pattern = is_glob;
-		rs[i].src = xstrndup(lhs, llen);
-		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
-
-		if (fetch) {
-			struct object_id unused;
-
-			/* LHS */
-			if (!*rs[i].src)
-				; /* empty is ok; it means "HEAD" */
-			else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(rs[i].src, &unused))
-				rs[i].exact_sha1 = 1; /* ok */
-			else if (!check_refname_format(rs[i].src, flags))
-				; /* valid looking ref is ok */
-			else
-				goto invalid;
-			/* RHS */
-			if (!rs[i].dst)
-				; /* missing is ok; it is the same as empty */
-			else if (!*rs[i].dst)
-				; /* empty is ok; it means "do not store" */
-			else if (!check_refname_format(rs[i].dst, flags))
-				; /* valid looking ref is ok */
-			else
-				goto invalid;
-		} else {
-			/*
-			 * LHS
-			 * - empty is allowed; it means delete.
-			 * - when wildcarded, it must be a valid looking ref.
-			 * - otherwise, it must be an extended SHA-1, but
-			 *   there is no existing way to validate this.
-			 */
-			if (!*rs[i].src)
-				; /* empty is ok */
-			else if (is_glob) {
-				if (check_refname_format(rs[i].src, flags))
-					goto invalid;
-			}
-			else
-				; /* anything goes, for now */
-			/*
-			 * RHS
-			 * - missing is allowed, but LHS then must be a
-			 *   valid looking ref.
-			 * - empty is not allowed.
-			 * - otherwise it must be a valid looking ref.
-			 */
-			if (!rs[i].dst) {
-				if (check_refname_format(rs[i].src, flags))
-					goto invalid;
-			} else if (!*rs[i].dst) {
-				goto invalid;
-			} else {
-				if (check_refname_format(rs[i].dst, flags))
-					goto invalid;
-			}
+		if (parse_one_refspec(&rs[i], refspec[i], fetch, verify) < 0) {
+			/* verify != 0 here, because parse_one_refspec()
+			 * would have already die()d otherwise. */
+			free_refspec(i, rs);
+			return NULL;
 		}
 	}
 	return rs;
-
- invalid:
-	if (verify) {
-		/*
-		 * nr_refspec must be greater than zero and i must be valid
-		 * since it is only possible to reach this point from within
-		 * the for loop above.
-		 */
-		free_refspec(i+1, rs);
-		return NULL;
-	}
-	die("Invalid refspec '%s'", refspec[i]);
 }
 
 int valid_fetch_refspec(const char *fetch_refspec_str)
-- 
2.13.1.505.g7cc9fcafb

