Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB84203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757006AbcGZQGZ (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:56280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756782AbcGZQGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:22 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWgND-1bpYrI2Tjn-00XpnE; Tue, 26 Jul 2016 18:06:11
 +0200
Date:	Tue, 26 Jul 2016 18:05:57 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 04/16] merge-recursive: clarify code in was_tracked()
In-Reply-To: <cover.1469547160.git.johannes.schindelin@gmx.de>
Message-ID: <b8e122f0c27453171334a59fa6f0c8675350e9f1.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CapXaNaMbppa+X3aTTEVf+IGaKlDEcmtU+YDkYIhPrWbcnRPBxl
 MM3hdYPM/WXOaehJSRz3aOl8HYNmJCvxxZypk46j/AVylDfMdcKY1Q8ApcgLfa/kfsbW9zv
 Y/ojGA8pQmwzs2U1zN/SLdWL+1cH9KHOSCee8TSX985/RULRdXodZZAT2YQYHLIXzj3fmq9
 i5jEzHVQvTt01NcFXTaww==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:J+vKYfUoUOo=:8pwqKhd0MgwtgNvmUa7ObX
 kuXibgihz5Y6P+BUn7/5fihzosyLvd1IYCJvlsZdWX8phGK7EOJcjuVTU708hA0pfzhsqYRwu
 24FGQ7KQWZolX3EQE1mXPWuD2GDSy782mCD6i6HNaOMmuBYQ1bHHevdwyp9j2ip1wr2kvzX+4
 tawY7KkUJquiwDm2qaeyGoOUjb1KssyJkJ5REdMXFBRW2M+FvPUZ3nONgIMTWyKN3V9idUHii
 XOKx5h36wQ08u3OLSW7i9AcIsLzB4yk8NGvRNR2XA8w7hzbkI4chLyzHWO+sNWc0snbIlBUgb
 H/cQj4PGz5rnWRcdalIHrfWeeLlPsIQl6Dwy6DFhhF7BceGG/IN6e3zkRK3HH+KWp0EDIF2Q3
 AjYErP0qlAGP1taytBBV/naOAEeapa+VZn89+/MWzSjPwgDUf1wt/OkFgAeLoBWqA1D0wn3uy
 Ds7hWjigVAQaLwyRi9a13wiv2RgUlk2u5uSB1j5HifGM5e/CmgPQtcsjhwr2SN1OAHR6V3mDA
 QGERk0I92//OXBBao/X33CaKWEaOtMGAw5Y2V4LmavIA6OzFrZWXBjPtgdQLquROT9gt1rnVp
 eL5nECLtsCAZLdaIS17OkWD33Hy8K5pPy9qVusmGQmMdizfcCc1roy8fpAED/XfAM9aWCDXxc
 /HgJRP6K7OY9dqw7BEjSSK6n+P5mTY8A78KZA3fczEFl/Zqbrl76QOpgi5SZ25lD5N+CBd4NU
 Ua3F5x9ryr44rFlkrjJinHPaqV5fePydvSkTsE6btls+VgrtKZxF183XHS7fB/MRRN6hnrx0i
 bbEF/Rw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

It can be puzzling to see that was_tracked() asks to get an index entry
by name, but does not take a negative return value for an answer.

The reason we have to do this is that cache_name_pos() only looks for
entries in stage 0, even if nobody asked for any stage in particular.

Let's rewrite the logic a little bit, to handle the easy case early: if
cache_name_pos() returned a non-negative position, we know it is a match,
and we do not even have to compare the name again (cache_name_pos() did
that for us already). We can say right away: yes, this file was tracked.

Only if there was no exact match do we need to look harder for any
matching entry in stage 2.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1b6db87..3a652b7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -667,23 +667,21 @@ static int was_tracked(const char *path)
 {
 	int pos = cache_name_pos(path, strlen(path));
 
-	if (pos < 0)
-		pos = -1 - pos;
-	while (pos < active_nr &&
-	       !strcmp(path, active_cache[pos]->name)) {
-		/*
-		 * If stage #0, it is definitely tracked.
-		 * If it has stage #2 then it was tracked
-		 * before this merge started.  All other
-		 * cases the path was not tracked.
-		 */
-		switch (ce_stage(active_cache[pos])) {
-		case 0:
-		case 2:
+	if (0 <= pos)
+		/* we have been tracking this path */
+		return 1;
+
+	/*
+	 * Look for an unmerged entry for the path,
+	 * specifically stage #2, which would indicate
+	 * that "our" side before the merge started
+	 * had the path tracked (and resulted in a conflict).
+	 */
+	for (pos = -1 - pos;
+	     pos < active_nr && !strcmp(path, active_cache[pos]->name);
+	     pos++)
+		if (ce_stage(active_cache[pos]) == 2)
 			return 1;
-		}
-		pos++;
-	}
 	return 0;
 }
 
-- 
2.9.0.281.g286a8d9


