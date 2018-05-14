Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B3471F406
	for <e@80x24.org>; Mon, 14 May 2018 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeENV4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:43 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:39450 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeENV4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:42 -0400
Received: by mail-vk0-f73.google.com with SMTP id y22-v6so16818399vky.6
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=u3NxWc5HdUpXOiL5dqHNaaIpi0DDzSW75B4u1BWx974=;
        b=XqLzPie4g90BDXHa5c/t7Zyzt6GmpkG3B5vWAvy6pQLDwy/UbNe6bH2WcBpSt1gTs7
         5YUIXpVWxbAG9sS1fGFkyS0ZDJ9D3t29ttfLQ3vYgIE3sHDuCqt4Ss/TjYsU1YlO2Yqj
         5/EL9/+rC/rYqVGs+qimLk42I+IvgAPD9w/mWibmxsC8+NfsPnIViEjyiWj3SREtbkbf
         hBPtjl4oVeyqG60qPAdpBTJu7SkarjQh97YsV6WZQ/6dLOzX+kyYZ3dLt83H8ALexAKp
         oEw39biEkzYo3Lg7zEVL/37+U1HuEug7vCokPTozLxbHBFWg8w1D+QMDIELzJERAfTc8
         qyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=u3NxWc5HdUpXOiL5dqHNaaIpi0DDzSW75B4u1BWx974=;
        b=Orxnm/rxxLbwn8AH6gnnFa8qVbxFfuYE7dio9pR/Ww/OXP2E7GFqIIT8KEFF64e5wA
         XhiDFmphdxTmFwRu4NOq9nJqDyO6jO9CCp0z1rxB1XUVXvV2WmP53LLW5gzSBTtI9mil
         nO1livmWUPGNcjfxFmzYEf92qGWIosR3CTm/jeZYeqR1mU7wJQhS5zt3sAcZqHsON70b
         kWQ4mJWh2QwUVLEZbwse77cSQKwRBNWjkhx/xBXv1HtuRbudHfqeDJhOZL7k6YpneN56
         ds8TuIVWagF+zQ6OL2OwQBrJ7eD6KqgTlacp7Z39fOdS4gYy9vHHzaFE/Z6VOiyds5Pb
         +fSA==
X-Gm-Message-State: ALKqPwdvCxgwrrhUknLglSUeDt/Va4Wsv14G96IQ6SFxQgv6sf6mrrgb
        aLDLbjfiR6mf8nSnT2YQgV8OuOXm+5Ws7ZluycnNfVCEmKMprOvdRVNd4idxYkz5YHv7extTGxl
        NmZgVlJahk9XFcbvp4+DtaYYK001ktDWiZBsIFStIL+mKXhAilgIbYY8GSA==
X-Google-Smtp-Source: AB8JxZqB2qzWSILg1D4DEg4QCWu8WWrd/nYe5h66x0wab/BpqZ2ViW3h6Xu//4bt3ACSvwtlBrqGORrF0Jk=
MIME-Version: 1.0
X-Received: by 2002:ab0:1308:: with SMTP id g8-v6mr12817186uae.59.1526335001638;
 Mon, 14 May 2018 14:56:41 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:53 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-3-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 02/35] refspec: factor out parsing a single refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic which parses a single refspec into its own
function.  This makes it easier to reuse this logic in a future patch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 195 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 104 insertions(+), 91 deletions(-)

diff --git a/refspec.c b/refspec.c
index ecb0bdff3..3cfcbd37d 100644
--- a/refspec.c
+++ b/refspec.c
@@ -14,110 +14,123 @@ static struct refspec s_tag_refspec = {
 /* See TAG_REFSPEC for the string version */
 const struct refspec *tag_refspec = &s_tag_refspec;
 
-static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
+/*
+ * Parses 'refspec' and populates 'rs'.  returns 1 if successful and 0 if the
+ * refspec is invalid.
+ */
+static int parse_refspec(struct refspec *rs, const char *refspec, int fetch)
 {
-	int i;
-	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
+	size_t llen;
+	int is_glob;
+	const char *lhs, *rhs;
+	int flags;
 
-	for (i = 0; i < nr_refspec; i++) {
-		size_t llen;
-		int is_glob;
-		const char *lhs, *rhs;
-		int flags;
+	is_glob = 0;
 
-		is_glob = 0;
+	lhs = refspec;
+	if (*lhs == '+') {
+		rs->force = 1;
+		lhs++;
+	}
 
-		lhs = refspec[i];
-		if (*lhs == '+') {
-			rs[i].force = 1;
-			lhs++;
-		}
+	rhs = strrchr(lhs, ':');
 
-		rhs = strrchr(lhs, ':');
+	/*
+	 * Before going on, special case ":" (or "+:") as a refspec
+	 * for pushing matching refs.
+	 */
+	if (!fetch && rhs == lhs && rhs[1] == '\0') {
+		rs->matching = 1;
+		return 1;
+	}
 
+	if (rhs) {
+		size_t rlen = strlen(++rhs);
+		is_glob = (1 <= rlen && strchr(rhs, '*'));
+		rs->dst = xstrndup(rhs, rlen);
+	}
+
+	llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
+	if (1 <= llen && memchr(lhs, '*', llen)) {
+		if ((rhs && !is_glob) || (!rhs && fetch))
+			return 0;
+		is_glob = 1;
+	} else if (rhs && is_glob) {
+		return 0;
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
+			return 0;
+		/* RHS */
+		if (!rs->dst)
+			; /* missing is ok; it is the same as empty */
+		else if (!*rs->dst)
+			; /* empty is ok; it means "do not store" */
+		else if (!check_refname_format(rs->dst, flags))
+			; /* valid looking ref is ok */
+		else
+			return 0;
+	} else {
 		/*
-		 * Before going on, special case ":" (or "+:") as a refspec
-		 * for pushing matching refs.
+		 * LHS
+		 * - empty is allowed; it means delete.
+		 * - when wildcarded, it must be a valid looking ref.
+		 * - otherwise, it must be an extended SHA-1, but
+		 *   there is no existing way to validate this.
 		 */
-		if (!fetch && rhs == lhs && rhs[1] == '\0') {
-			rs[i].matching = 1;
-			continue;
+		if (!*rs->src)
+			; /* empty is ok */
+		else if (is_glob) {
+			if (check_refname_format(rs->src, flags))
+				return 0;
 		}
-
-		if (rhs) {
-			size_t rlen = strlen(++rhs);
-			is_glob = (1 <= rlen && strchr(rhs, '*'));
-			rs[i].dst = xstrndup(rhs, rlen);
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
+				return 0;
+		} else if (!*rs->dst) {
+			return 0;
+		} else {
+			if (check_refname_format(rs->dst, flags))
+				return 0;
 		}
+	}
 
-		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
-		if (1 <= llen && memchr(lhs, '*', llen)) {
-			if ((rhs && !is_glob) || (!rhs && fetch))
-				goto invalid;
-			is_glob = 1;
-		} else if (rhs && is_glob) {
-			goto invalid;
-		}
+	return 1;
+}
 
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
-		}
+static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
+{
+	int i;
+	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
+
+	for (i = 0; i < nr_refspec; i++) {
+		if (!parse_refspec(&rs[i], refspec[i], fetch))
+			goto invalid;
 	}
+
 	return rs;
 
  invalid:
-- 
2.17.0.441.gb46fe60e1d-goog

