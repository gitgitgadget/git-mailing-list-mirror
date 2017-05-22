Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4002023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934629AbdEVOTQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934694AbdEVOTN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:19:13 -0400
X-AuditID: 1207440d-dcfff70000000e33-1c-5922f3596e83
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.B8.03635.953F2295; Mon, 22 May 2017 10:19:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24X023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:19:03 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/25] ref-filter: limit traversal to prefix
Date:   Mon, 22 May 2017 16:17:54 +0200
Message-Id: <e6eab70183ce8016efd9763d6dfe0892b91dc53b.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqBv5WSnS4PJMa4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXRtf9eUwFLxQq
        jqw8wdzAuFaqi5GTQ0LAROLK83nMXYxcHEICO5gkHrw6zgLhnGKSWHXrFhNIFZuArsSinmYw
        W0RATWJi2yGwImaBDcwSb6avBksIC9hLfP3ymhnEZhFQlZjRso0RxOYViJLoWPyWDWKdvMSu
        tousIDangIXE71kHwHqFBMwlev+tZpnAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6R
        Xm5miV5qSukmRkgo8u5g/L9O5hCjAAejEg+vxmOlSCHWxLLiytxDjJIcTEqivEffAIX4kvJT
        KjMSizPii0pzUosPMUpwMCuJ8GrfBcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphak
        FsFkZTg4lCR4J38CahQsSk1PrUjLzClBSDNxcIIM5wEavuYDyPDigsTc4sx0iPwpRkUpcV4D
        kGYBkERGaR5cLyxVvGIUB3pFmLcQpIoHmGbgul8BDWYCGmz9TB5kcEkiQkqqgVGvo//91rUO
        b2oa6mI/cevsvmeXVbrxzR8PluiXGgd/9tzt3/r64an9x0p4P17keO9yeXL8m5TfHor+O3o8
        bH0Wb77QmLWueUpMcpzpo/z6vrppElrK7a3lDxOPdnPzatrKWAVMyTXTWm6tLqQ7ZeEtYauC
        txmb1jP8LfIQuNHr8+zIol3105RYijMSDbWYi4oTAZS2+xXwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

When we are matching refnames against a pattern, then we know that the
beginning of any refname that can match the pattern has to match the
part of the pattern up to the first glob character. For example, if
the pattern is `refs/heads/foo*bar`, then it can only match a
reference that has the prefix `refs/heads/foo`.

So pass that prefix to `for_each_fullref_in()`. This lets the ref code
avoid passing us the full set of refs, and in some cases avoid reading
them in the first place.

Note that this applies only when the `match_as_path` flag is set
(i.e., when `for-each-ref` is the caller), as the matching rules for
git-branch and git-tag are subtly different.

This could be generalized to the case of multiple patterns, but (a) it
probably doesn't come up that often, and (b) it is more awkward to
deal with multiple patterns (e.g., the patterns might not be
disjoint). So, since this is just an optimization, punt on the case of
multiple patterns.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 ref-filter.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6cc93dcd9f..25ca56d62f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1665,6 +1665,68 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	return match_pattern(filter, refname);
 }
 
+/*
+ * Find the longest prefix of pattern we can pass to
+ * `for_each_fullref_in()`, namely the part of pattern preceding the
+ * first glob character. (Note that `for_each_fullref_in()` is
+ * perfectly happy working with a prefix that doesn't end at a
+ * pathname component boundary.)
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
@@ -1911,7 +1973,7 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
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

