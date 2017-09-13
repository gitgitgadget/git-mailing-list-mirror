Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FB320286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbdIMRQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:44 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62784 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdIMRQh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:37 -0400
X-AuditID: 1207440e-bf9ff70000007085-da-59b967f46d78
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.8E.28805.4F769B95; Wed, 13 Sep 2017 13:16:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiV001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:35 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/20] read_packed_refs(): make parsing of the header line more robust
Date:   Wed, 13 Sep 2017 19:16:01 +0200
Message-Id: <0cc2a9af0eeeb2ffbf1942d19fbcceb0c0cf6d5c.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqPslfWekwcVmW4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEr4+LbH6wFM8UrTk/9yNjAeEKoi5GTQ0LARKJ/+TE2
        EFtIYAeTxP0O1y5GLiD7JJNEz+4WRpAEm4CuxKKeZiYQW0RATWJi2yEWkCJmgadMEjtP3mUF
        SQgLhElsfH+fBcRmEVCVuH/9DVgzr0CUxJuGHkaIbfIS5x7cZgaxOQUsJDbueMIIsdlconHO
        TsYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRuYoQEGN8Oxvb1MocY
        BTgYlXh4LWx2RgqxJpYVV+YeYpTkYFIS5d2rCxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwhsU
        BZTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwOgEjSUiwKDU9tSIt
        M6cEIc3EwQkynAdouCBIDW9xQWJucWY6RP4Uoy5Hx827f5iEWPLy81KlxHn/pgIVCYAUZZTm
        wc2BJYZXjOJAbwnz2oOM4gEmFbhJr4CWMAEtOXN6B8iSkkSElFQDo7tF2RbzNh7dmoM3VpbO
        UHLbNnHygzs6K8Ii3wR82fzw14tVK1q+trx5uOSx84JHWxyEAz7mbPmeer7jWVpmVaLKh0Dv
        AtW5/+67RdWrn2l0j9zd9euooa+4zEezB+smP0gLDFtYsXvNS77alralrR7hey8qaBhUza/N
        9PjcZrTAqTz1eNjdjUosxRmJhlrMRcWJABKfoZTnAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code parsed the traits in the `packed-refs` header by looking
for the string " trait " (i.e., the name of the trait with a space on
either side) in the header line. This is fragile, because if any other
implementation of Git forgets to write the trailing space, the last
trait would silently be ignored (and the error might never be
noticed).

So instead, use `string_list_split_in_place()` to split the traits
into tokens then use `unsorted_string_list_has_string()` to look for
the tokens we are interested in. This means that we can read the
traits correctly even if the header line is missing a trailing
space (or indeed, if it is missing the space after the colon, or if it
has multiple spaces somewhere).

However, older Git clients (and perhaps other Git implementations)
still require the surrounding spaces, so we still have to output the
header with a trailing space.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 141f02b9c8..a45e3ff92f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -257,25 +257,30 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 
 	/* If the file has a header line, process it: */
 	if (pos < eof && *pos == '#') {
-		const char *traits;
+		char *p;
+		struct string_list traits = STRING_LIST_INIT_NODUP;
 
 		eol = memchr(pos, '\n', eof - pos);
 		if (!eol)
 			die_unterminated_line(refs->path, pos, eof - pos);
 
-		strbuf_add(&line, pos, eol + 1 - pos);
+		strbuf_add(&line, pos, eol - pos);
 
-		if (!skip_prefix(line.buf, "# pack-refs with:", &traits))
+		if (!skip_prefix(line.buf, "# pack-refs with:", (const char **)&p))
 			die_invalid_line(refs->path, pos, eof - pos);
 
-		if (strstr(traits, " fully-peeled "))
+		string_list_split_in_place(&traits, p, ' ', -1);
+
+		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
 			peeled = PEELED_FULLY;
-		else if (strstr(traits, " peeled "))
+		else if (unsorted_string_list_has_string(&traits, "peeled"))
 			peeled = PEELED_TAGS;
 		/* perhaps other traits later as well */
 
 		/* The "+ 1" is for the LF character. */
 		pos = eol + 1;
+
+		string_list_clear(&traits, 0);
 		strbuf_reset(&line);
 	}
 
@@ -610,7 +615,11 @@ int packed_refs_is_locked(struct ref_store *ref_store)
 
 /*
  * The packed-refs header line that we write out.  Perhaps other
- * traits will be added later.  The trailing space is required.
+ * traits will be added later.
+ *
+ * Note that earlier versions of Git used to parse these traits by
+ * looking for " trait " in the line. For this reason, the space after
+ * the colon and the trailing space are required.
  */
 static const char PACKED_REFS_HEADER[] =
 	"# pack-refs with: peeled fully-peeled \n";
-- 
2.14.1

