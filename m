Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8051F6BF
	for <e@80x24.org>; Mon,  5 Sep 2016 09:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbcIEJpo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 05:45:44 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50176 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932346AbcIEJpb (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 05:45:31 -0400
X-AuditID: 1207440c-217ff700000008d5-d3-57cd3ea2ea89
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 53.69.02261.2AE3DC75; Mon,  5 Sep 2016 05:45:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p57907BC3.dip0.t-ipconnect.de [87.144.123.195])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u859iwtP008788
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 5 Sep 2016 05:45:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/8] xdl_change_compact(): only use heuristic if group can't be matched
Date:   Mon,  5 Sep 2016 11:44:47 +0200
Message-Id: <d2fd0eefdf6e4f2884df3214b32606e5b43e0555.1473068229.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473068229.git.mhagger@alum.mit.edu>
References: <cover.1473068229.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqLvI7my4wcltghZdV7qZLBp6rzBb
        7F7cz2yx4uocZoszW4Gs2yvmM1v8aOlhtph51dpi8+Z2FgdOj7/vPzB57Jx1l91jwaZSj2e9
        exg9Ll5S9ti/dBubx+dNch63n21jCeCI4rJJSc3JLEst0rdL4Mq4fPM2c8EzgYpNfxYyNjBu
        4uli5OSQEDCR+NHQx9bFyMUhJLCVUaL96wEo5ySTxPcbrYwgVWwCuhKLepqZQGwRAXGJt8dn
        soMUMQv8ZZJY/OguG0hCWCBKovPvdGYQm0VAVWLqxj1gDbxA8WVN51kh1slJXNr2BayGU8BC
        YsmXPnYQW0jAXGLevGbmCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaU
        bmKEhB/PDsZv62QOMQpwMCrx8FponwkXYk0sK67MPcQoycGkJMpboHo2XIgvKT+lMiOxOCO+
        qDQntfgQowQHs5IIb44tUI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JMGrBtIoWJSanlqRlplTgpBm4uAEGc4DNNzZBmR4cUFibnFmOkT+FKOilDhvCkhCACSRUZoH
        1wtLD68YxYFeEeadD7KCB5ha4LpfAQ1mAhq8bvdpkMEliQgpqQbGWRnf2p7/iVHacmnPr7IL
        e9s/yE24MOcqV/bB66veufO8essTqSHYySTYKeF+VY+598vKkFWpG5gPXt2SdNHuum+3bI/w
        Z+2rMUUX9nprPHdIdTvd8zPqdKON8K4Ht/3+zN7cwpow+aZ11oHbdcXcz7dlMD9M2liwxz42
        N8N/U8bB43+c2VX1lFiKMxINtZiLihMBIB2nUeoCAAA=
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

