Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B4D2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 11:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754479AbcHVLYP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:15 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48022 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752383AbcHVLYM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:12 -0400
X-AuditID: 1207440f-e17ff70000000955-c0-57bae09045bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 27.28.02389.090EAB75; Mon, 22 Aug 2016 07:22:56 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQQ027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:22:54 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/7] xdl_change_compact(): only use heuristic if group can't be matched
Date:   Mon, 22 Aug 2016 13:22:41 +0200
Message-Id: <d2fd0eefdf6e4f2884df3214b32606e5b43e0555.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1471864378.git.mhagger@alum.mit.edu>
References: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsUixO6iqLviwa5wg0dPZCy6rnQzWTT0XmG2
        2L24n9lixdU5zBa3V8xntvjR0sNssXlzO4sDu8ff9x+YPHbOusvusWBTqcez3j2MHhcvKXt8
        3iQXwBbFZZOSmpNZllqkb5fAlXH55m3mgmcCFZv+LGRsYNzE08XIySEhYCKx8s8Dti5GLg4h
        ga2MEgf+HGOFcE4xSZyZ18wCUsUmoCuxqKeZCcQWERCXeHt8JjtIEbNAP5PEj44uRpCEsECU
        xN8t74GKODhYBFQldu+yAwnzAoWfPp/OCLFNTuLSti/MICWcAhYSW1uUQcJCAuYSz3acZJ/A
        yLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5qSukmRkhQ8e9g7Fovc4hRgINR
        iYfX48jOcCHWxLLiytxDjJIcTEqivGatQCG+pPyUyozE4oz4otKc1OJDjBIczEoivMz3d4UL
        8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeB1AGgWLUtNTK9Iyc0oQ
        0kwcnCDDeYCGH7sHMry4IDG3ODMdIn+KUVFKnDcfJCEAksgozYPrhUX9K0ZxoFeEeWNBVvAA
        EwZc9yugwUxAg6//3w4yuCQRISXVwJh7Y4/ZzCXGm+eWRN2qWVoeNlXDukQk7bzeYxlvUwGm
        x0HTizu3LLM1V0zYGco3Ib3oxJXvfyt2Set6RO+Pe7J3e5KO8YsvB3tCr+T1vlhzbr3K0mvF
        ZmGGh92Wtl3b0tzE3jRBJXV2bravIlvIqyyr/f9vhdiKTjmpvfnsWaOc3B875Bcr/VFiKc5I
        NNRiLipOBAB6CuFX1QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the changed group of lines can be matched to a group in the other
file, then that positioning should take precedence over the compaction
heuristic.

The old code tried the heuristic unconditionally, which cost redundant
effort and also was broken if the matching code had already shifted the
group higher than the blank line.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 95b037e..61deed8 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -504,25 +504,25 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			}
 		} while (grpsiz != ix - ixs);
 
-		/*
-		 * Try to move back the possibly merged group of changes, to match
-		 * the recorded position in the other file.
-		 */
-		while (ixref < ix) {
-			rchg[--ixs] = 1;
-			rchg[--ix] = 0;
-			while (rchgo[--ixo]);
-		}
-
-		/*
-		 * If a group can be moved back and forth, see if there is a
-		 * blank line in the moving space. If there is a blank line,
-		 * make sure the last blank line is the end of the group.
-		 *
-		 * As we already shifted the group forward as far as possible
-		 * in the earlier loop, we need to shift it back only if at all.
-		 */
-		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+		if (ixref < ix) {
+			/*
+			 * Try to move back the possibly merged group of changes, to match
+			 * the recorded position in the other file.
+			 */
+			while (ixref < ix) {
+				rchg[--ixs] = 1;
+				rchg[--ix] = 0;
+				while (rchgo[--ixo]);
+			}
+		} else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
+			/*
+			 * The group can be slid up to make its last line a
+			 * blank line. Do so.
+			 *
+			 * As we already shifted the group forward as far as
+			 * possible in the earlier loop, we need to shift it
+			 * back only if at all.
+			 */
 			while (ixs > 0 &&
 			       !is_blank_line(recs, ix - 1, flags) &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
-- 
2.9.3

