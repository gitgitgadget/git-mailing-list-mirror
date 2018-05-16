Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93BB91F406
	for <e@80x24.org>; Wed, 16 May 2018 22:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEPW6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:58:49 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:35925 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeEPW6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:58:46 -0400
Received: by mail-it0-f74.google.com with SMTP id c82-v6so5263503itg.1
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=hElQGmaDEzC2YcNbKdYI0GYJN34VABZLWlECaKU31q8=;
        b=iZrD3FUgXSOsSiK30ooz/Q78+BADZdSKZYRdh/GgK3Kc3G7R3GZ5TdUPKqo0j29dz3
         8MoA9F2FwrpiEjRq15GXsr64bYnIOn1Kb9q19b69eIoX1Rzj8kMZVg+mTEm4t48jS+Ey
         b5FCrSYa1yNrVKBe+PvjI7aSY/zFKNBP7pTkZHI5nKpdB8SdTTEDQu0WK7N9B5B12bux
         WemLSkwyPWipmhnHe+gHs8ht8BIBzQ0rh9nRhkBrkb5XfbuYILFR9wlqNxVg6QeihTaX
         mtAB+8IMc+11AQ6/CrTxx+hUDc1Nn0f0cBN28NFtm0syux/CbKdqG/dZBDQPqNpm3Lah
         ClrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=hElQGmaDEzC2YcNbKdYI0GYJN34VABZLWlECaKU31q8=;
        b=LG15+EALf1n8luDIoAdwOO7j6eRXsyR+kqNzKWCE3MqVR0pBnlnZDSWxAbKPLJvpao
         4XeyywzVfGjLnvPq5002xvqX8QP5z8Ikhzq0LjaNjcVxrqd/Zr0byDLPoFQwolJxlIKJ
         QN0Qk7GuAjuA/vCge+bYy/FFo+MkhTqkCePzPFoH1hzWbiKjBoPd32KsEG2KSQi+zfpR
         5bnDRNy9H7spEBifD0pNUviZzMMQqRqxruZpMQX921xJ2q25NZCdyBD4S/lgf/GuKvL4
         JeezpbF7T6y/UmDwstn2ADABYgn3xES0WsHIOW2am+liWH6A/1a7TiGDNSIgxm2CU0tl
         6cZw==
X-Gm-Message-State: ALKqPwcAinNMz+vubsg10OEvYgZawHS3eUTzpxPDORiYpoKqLtVyMmoe
        N3t8RTirEMvMc3OcVA75gPdmY8arYyDpUZukNu4BWZgxHGNX4DMK6ws/tJ30nxIW3h1RTq6rgf8
        vjzE32vlRX52w2SD/mLeEU9C9OgENApces3EtJe9rqdQizi5MOlW8WeG0DQ==
X-Google-Smtp-Source: AB8JxZrRvsnsoKhlORjgajO0L3Psdfq59sSOvoBrWFgh1X641DDG6lxXzgW9kM0D9NwTEOz5iecMZsucK2k=
MIME-Version: 1.0
X-Received: by 2002:a24:7d42:: with SMTP id b63-v6mr187292itc.49.1526511525305;
 Wed, 16 May 2018 15:58:45 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:50 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-4-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 03/36] refspec: factor out parsing a single refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
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
index 22188f010..8bf4ebbd3 100644
--- a/refspec.c
+++ b/refspec.c
@@ -14,110 +14,123 @@ static struct refspec_item s_tag_refspec = {
 /* See TAG_REFSPEC for the string version */
 const struct refspec_item *tag_refspec = &s_tag_refspec;
 
-static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
+/*
+ * Parses the provided refspec 'refspec' and populates the refspec_item 'item'.
+ * Returns 1 if successful and 0 if the refspec is invalid.
+ */
+static int parse_refspec(struct refspec_item *item, const char *refspec, int fetch)
 {
-	int i;
-	struct refspec_item *rs = xcalloc(nr_refspec, sizeof(*rs));
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
+		item->force = 1;
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
+		item->matching = 1;
+		return 1;
+	}
 
+	if (rhs) {
+		size_t rlen = strlen(++rhs);
+		is_glob = (1 <= rlen && strchr(rhs, '*'));
+		item->dst = xstrndup(rhs, rlen);
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
+	item->pattern = is_glob;
+	item->src = xstrndup(lhs, llen);
+	flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
+
+	if (fetch) {
+		struct object_id unused;
+
+		/* LHS */
+		if (!*item->src)
+			; /* empty is ok; it means "HEAD" */
+		else if (llen == GIT_SHA1_HEXSZ && !get_oid_hex(item->src, &unused))
+			item->exact_sha1 = 1; /* ok */
+		else if (!check_refname_format(item->src, flags))
+			; /* valid looking ref is ok */
+		else
+			return 0;
+		/* RHS */
+		if (!item->dst)
+			; /* missing is ok; it is the same as empty */
+		else if (!*item->dst)
+			; /* empty is ok; it means "do not store" */
+		else if (!check_refname_format(item->dst, flags))
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
+		if (!*item->src)
+			; /* empty is ok */
+		else if (is_glob) {
+			if (check_refname_format(item->src, flags))
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
+		if (!item->dst) {
+			if (check_refname_format(item->src, flags))
+				return 0;
+		} else if (!*item->dst) {
+			return 0;
+		} else {
+			if (check_refname_format(item->dst, flags))
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
+static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
+{
+	int i;
+	struct refspec_item *rs = xcalloc(nr_refspec, sizeof(*rs));
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

