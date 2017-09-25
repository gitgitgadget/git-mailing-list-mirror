Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C90420281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934032AbdIYIAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:43 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:49299 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933835AbdIYIAl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:41 -0400
X-AuditID: 1207440f-a43ff70000007960-07-59c8b7a7a071
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.59.31072.8A7B8C95; Mon, 25 Sep 2017 04:00:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6Q027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/21] read_packed_refs(): only check for a header at the top of the file
Date:   Mon, 25 Sep 2017 10:00:03 +0200
Message-Id: <c8e8df259b99e26a49a7bc03c4dc657c2b36d61d.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqLti+4lIg8tdOhZrn91hsni+/gS7
        RdeVbiaLht4rzBb9y7vYLG6vmM9s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8PH+M8
        Fmwq9XjWu4fR4+IlZY/Pm+QC2KO4bFJSczLLUov07RK4Mq6+u8BUcEOwYuXSp8wNjO94uxg5
        OCQETCQOTtHqYuTiEBLYwSRx9v1MFgjnFJPEi0dHgRxODjYBXYlFPc1MILaIgJrExLZDYEXM
        AiuZJSZtvcIKkhAWiJF43nqfDcRmEVCVWH10EzOIzSsQJfF/9iywQRIC8hLnHtwGi3MKWEi8
        OXMErF5IwFzi/I1brBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXRy80s0UtNKd3E
        CAk5/h2MXetlDjEKcDAq8fBG/DseKcSaWFZcmXuIUZKDSUmU9y7fiUghvqT8lMqMxOKM+KLS
        nNTiQ4wSHMxKIrzHVgPleFMSK6tSi/JhUtIcLErivOpL1P2EBNITS1KzU1MLUotgsjIcHEoS
        vK7bgBoFi1LTUyvSMnNKENJMHJwgw3mAhi8HqeEtLkjMLc5Mh8ifYtTl6Lh59w+TEEtefl6q
        lDjvBpAiAZCijNI8uDmwVPGKURzoLWHeNJAqHmCagZv0CmgJE9CS3qlgS0oSEVJSDYwVvEF/
        +d97PnR9ca76zrJPqkvCp9u6GepYbu3b7yudH3r15oszluFb7I3CdFj7s+y/qfTxSclv4jla
        qlkeo1zBnPfz4dpwoS5PK1mLSWtfnJzEG+RuduDaLrvLizdPfZNtdEbvstsX29IfBQ1F+gpF
        SWwL3+S8a9kW07ozRrdtS+DZsCkaekosxRmJhlrMRcWJABnlLHzwAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tightens up the parsing a bit; previously, stray header-looking
lines would have been processed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 154abbd83a..141f02b9c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -255,11 +255,34 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	pos = buf;
 	eof = buf + size;
 
+	/* If the file has a header line, process it: */
+	if (pos < eof && *pos == '#') {
+		const char *traits;
+
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			die_unterminated_line(refs->path, pos, eof - pos);
+
+		strbuf_add(&line, pos, eol + 1 - pos);
+
+		if (!skip_prefix(line.buf, "# pack-refs with:", &traits))
+			die_invalid_line(refs->path, pos, eof - pos);
+
+		if (strstr(traits, " fully-peeled "))
+			peeled = PEELED_FULLY;
+		else if (strstr(traits, " peeled "))
+			peeled = PEELED_TAGS;
+		/* perhaps other traits later as well */
+
+		/* The "+ 1" is for the LF character. */
+		pos = eol + 1;
+		strbuf_reset(&line);
+	}
+
 	dir = get_ref_dir(packed_refs->cache->root);
 	while (pos < eof) {
 		struct object_id oid;
 		const char *refname;
-		const char *traits;
 
 		eol = memchr(pos, '\n', eof - pos);
 		if (!eol)
@@ -267,15 +290,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 
 		strbuf_add(&line, pos, eol + 1 - pos);
 
-		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
-			if (strstr(traits, " fully-peeled "))
-				peeled = PEELED_FULLY;
-			else if (strstr(traits, " peeled "))
-				peeled = PEELED_TAGS;
-			/* perhaps other traits later as well */
-			goto next_line;
-		}
-
 		refname = parse_ref_line(&line, &oid);
 		if (refname) {
 			int flag = REF_ISPACKED;
@@ -307,7 +321,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			die_invalid_line(refs->path, line.buf, line.len);
 		}
 
-	next_line:
 		/* The "+ 1" is for the LF character. */
 		pos = eol + 1;
 		strbuf_reset(&line);
-- 
2.14.1

