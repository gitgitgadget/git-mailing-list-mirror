Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E690201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbdEQMGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:46 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58689 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753775AbdEQMGj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:39 -0400
X-AuditID: 1207440f-701ff700000004e5-2a-591c3ccde33a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 49.78.01253.DCC3C195; Wed, 17 May 2017 08:06:37 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pgD000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/23] ref-filter: limit traversal to prefix
Date:   Wed, 17 May 2017 14:05:45 +0200
Message-Id: <1f50142ccbb84a4e5d7a1cd67e6f9d30edc1d73a.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsUixO6iqHvWRibS4MwRNYu1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGl+mn2QvWyVU8nrSFqYFxlUQXIweHhICJ
        xMv5BV2MXBxCAjuYJNoP72WDcE4wSTy9/oWxi5GTg01AV2JRTzMTiC0ioCYxse0QC0gRs8Bj
        Jom/y7pZQBLCAjYS+z9dYgexWQRUJa7d+AXWzCsQJbG46wiYLSEgL7Gr7SIriM0pYCFx//0j
        dpArhATMJbZfr5zAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkig
        8e9g7Fovc4hRgINRiYd3Apd0pBBrYllxZe4hRkkOJiVR3v0PgEJ8SfkplRmJxRnxRaU5qcWH
        GCU4mJVEeG+aykQK8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKdY
        AzUKFqWmp1akZeaUIKSZODhBhvMADecCqeEtLkjMLc5Mh8ifYlSUEuc9AJIQAElklObB9cIS
        wStGcaBXhHn1gGlBiAeYROC6XwENZgIa3AzyEW9xSSJCSqqBsfdgetvzY3XhE57l7XtpL/KK
        NbKGweNK6VaTrsdPlH6KK0m+eXrOhE84SNKgtFrtoM6l65zM05MY2eIn+solr5q+g2f+u/9V
        km8lri9a0y/lvn1CR3/6sp9vSk4ce5ZpvOLBtFf8Z3NfMjbwsl9gqa30l77vVB/Y9HnZIXGm
        kmqn5cH341VLlFiKMxINtZiLihMBVQaA5t8CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When we are matching refnames "as path" against a pattern, then we
know that the beginning of any refname that can match the pattern has
to match the part of the pattern up to the first glob character. For
example, if the pattern is `refs/heads/foo*bar`, then it can only
match a reference that has the prefix `refs/heads/foo`.

So pass that prefix to `for_each_fullref_in()`. This lets the ref code
avoid passing us the full set of refs, and in some cases avoid reading
them in the first place.

This could be generalized to the case of multiple patterns, but (a) it
probably doesn't come up that often, and (b) it is more awkward to
deal with multiple patterns (e.g., the patterns might not be
disjoint). So, since this is just an optimization, punt on the case of
multiple patterns.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 ref-filter.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1fc5e9970d..54cc6bcc13 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1665,6 +1665,66 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter, refname);
 }
 
+/*
+ * Find the longest prefix of pattern we can pass to
+ * for_each_fullref_in(), namely the part of pattern preceding the
+ * first glob character.
+ */
+static void find_longest_prefix(struct strbuf *out, const char *pattern)
+{
+	const char *p;
+
+	for (p = pattern; *p && !is_glob_special(*p); p++)
+		;
+
+	strbuf_add(out, pattern, p - pattern);
+}
+
+/*
+ * This is the same as for_each_fullref_in(), but it tries to iterate
+ * only over the patterns we'll care about. Note that it _doesn't_ do a full
+ * pattern match, so the callback still has to match each ref individually.
+ */
+static int for_each_fullref_in_pattern(struct ref_filter *filter,
+				       each_ref_fn cb,
+				       void *cb_data,
+				       int broken)
+{
+	struct strbuf prefix = STRBUF_INIT;
+	int ret;
+
+	if (!filter->match_as_path) {
+		/*
+		 * in this case, the patterns are applied after
+		 * prefixes like "refs/heads/" etc. are stripped off,
+		 * so we have to look at everything:
+		 */
+		return for_each_fullref_in("", cb, cb_data, broken);
+	}
+
+	if (!filter->name_patterns[0]) {
+		/* no patterns; we have to look at everything */
+		return for_each_fullref_in("", cb, cb_data, broken);
+	}
+
+	if (filter->name_patterns[1]) {
+		/*
+		 * multiple patterns; in theory this could still work as long
+		 * as the patterns are disjoint. We'd just make multiple calls
+		 * to for_each_ref(). But if they're not disjoint, we'd end up
+		 * reporting the same ref multiple times. So let's punt on that
+		 * for now.
+		 */
+		return for_each_fullref_in("", cb, cb_data, broken);
+	}
+
+	find_longest_prefix(&prefix, filter->name_patterns[0]);
+
+	ret = for_each_fullref_in(prefix.buf, cb, cb_data, broken);
+	strbuf_release(&prefix);
+	return ret;
+}
+
 /*
  * Given a ref (sha1, refname), check if the ref belongs to the array
  * of sha1s. If the given ref is a tag, check if the given tag points
@@ -1911,7 +1971,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", ref_filter_handler, &ref_cbdata, broken);
 		else if (filter->kind & FILTER_REFS_ALL)
-			ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata, broken);
+			ret = for_each_fullref_in_pattern(filter, ref_filter_handler, &ref_cbdata, broken);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(ref_filter_handler, &ref_cbdata);
 	}
-- 
2.11.0

