Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79221F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbcHCWA7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:00:59 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63262 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755796AbcHCWA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:00:58 -0400
X-AuditID: 1207440c-217ff700000008d5-cb-57a26996a3a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 70.28.02261.69962A75; Wed,  3 Aug 2016 18:00:55 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSd023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:53 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/8] xdl_change_compact(): keep track of the earliest end
Date:	Thu,  4 Aug 2016 00:00:34 +0200
Message-Id: <b0413b20e3b8de1dedb91460a9f05534166f6afa.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqDs9c1G4wZS5nBZdV7qZLBp6rzBb
	7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
	b5ILYIvisklJzcksSy3St0vgymhb/p2tYD93xf49rYwNjE2cXYycHBICJhLPp2xl7GLk4hAS
	2Moocf/CKzYI5ziTRE/PLWaQKjYBXYlFPc1MILaIgLjE2+Mz2UGKmAX6mSR+dHQxgiSEBTwl
	uk/+ArNZBFQlDvY/B2vmFYiSuPF0KjPEOjmJy9MfsIHYnAIWElcnzQYbKiRgLvG2YxfrBEae
	BYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCAotnB+O3dTKHGAU4GJV4
	eDdILgoXYk0sK67MPcQoycGkJMqbkwoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJ7LwUox5uS
	WFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4E3OAGoULEpNT61Iy8wpQUgz
	cXCCDOcBGr4nHWR4cUFibnFmOkT+FKOilDivBUhCACSRUZoH1wuL/FeM4kCvCPNuAVnBA0wa
	cN2vgAYzAQ0+YbAAZHBJIkJKqoGRQVDMetmDGxd2JG2wL/HdyLuF/eQP0cysnCg515Maukt3
	nla99/faNeZJJe/US4/scA1M3GYae8y8IyKv5XNU89E0N755U02il/VvrWasvc95PC3/0MNJ
	X6cvtY06myuywORqqm+Okcb0ojB/Q/5n4u0i987qLHNJcDu58LhoWZTdtsUtLn1KLMUZiYZa
	zEXFiQDzjRaK1wIAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This makes it easier to detect whether shifting is possible, and will
also make the next change easier.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 66129db..34f021a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -414,7 +414,8 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 }
 
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
-	long start, end, io, end_matching_other, groupsize, nrec = xdf->nrec;
+	long start, end, earliest_end, end_matching_other;
+	long io, groupsize, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
 	unsigned int blank_lines;
 	xrecord_t **recs = xdf->recs;
@@ -516,6 +517,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 				end_matching_other = -1;
 			}
 
+			earliest_end = end;
+
 			/*
 			 * Now shift the group forward as long as the first line
 			 * of the current change group is equal to the line after
@@ -547,6 +550,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		} while (groupsize != end - start);
 
+		if (end == earliest_end)
+			continue; /* no shifting is possible */
+
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			/*
 			 * Compaction heuristic: if a group can be moved back and
-- 
2.8.1

