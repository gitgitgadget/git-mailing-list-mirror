From: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
Subject: [PATCH 08/10] xdiff: add XDL_EMIT_MOREHUNKHEADS
Date: Thu, 27 Mar 2014 14:50:54 -0400
Message-ID: <2c07e06fbb17bfb6d9d51733df0ce5755bbe97f5.1395942768.git.davidad@alum.mit.edu>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
Cc: peff@peff.net, l.s.r@web.de,
	"Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 19:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTFOy-0004xo-3k
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757229AbaC0Svg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:51:36 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50653 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757211AbaC0Svd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 14:51:33 -0400
X-AuditID: 12074413-f79076d000002d17-a3-533473342a5a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.C7.11543.43374335; Thu, 27 Mar 2014 14:51:32 -0400 (EDT)
Received: from zayin.local.com ([74.212.183.186])
	(authenticated bits=0)
        (User authenticated as davidad@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2RIp9TQ013586
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 27 Mar 2014 14:51:32 -0400
X-Mailer: git-send-email 1.7.12.4 (Apple Git-37)
In-Reply-To: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu>
In-Reply-To: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
References: <a833f392bebae7a2441d0a6e81a1c6dc52fa682e.1395942768.git.davidad@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsUixO6iqGtSbBJscOqjpcXclU1MFl/O3WKz
	6LrSzWRxZms/s8WPlh5mB1aPv+8/MHk0nTnK7PGsdw+jx+dNch63n21jCWCN4rJJSc3JLEst
	0rdL4MpY+tm8YKpxxYFXzawNjO80uhg5OSQETCTuHHvNDmGLSVy4t56ti5GLQ0jgMqPEry1P
	mSCclUwSMxeuZAOpYhNwltj0az8TiC0iIC7x9vhMdpAiZoGFjBJv90xmBkkIC1hI7Fy8ihXE
	ZhFQlZj0uBMszisQJfGs8T0rxDoDiU/PzoDFOQUcJCbP3whkcwBts5f4uNQWIhwt8XrrYrC9
	QkCtr7eeZJnAyL+AkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkgICu9g
	3HVS7hCjAAejEg/vDCuTYCHWxLLiytxDjBIczEoivHMLgEK8KYmVValF+fFFpTmpxYcYpTlY
	lMR51Zao+wkJpCeWpGanphakFsFkmTg4pRoYt0yyfpjqy24bU3grq1i6WlHwT+qL/h2lv0we
	vHZwn5imN6fAnoup99aT+5VX//Ae/srzunHXjEAH9UjuDVyvNW9/ktpaIVC3XPfUh9sTOde8
	PcFjqLZTtCJtHRe/tqPKUf1rf+Ur5fj3brKL/r6jseK9L0fThRmVD5/xnTO8WzI1n6Vx4ekI
	JZbijERDLeai4kQAolwPDT0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245312>

From: "Bhushan G. Lodha & David A. Dalrymple" <dad-bgl@mit.edu>

For filtering by function names, it's useful to split hunks whenever a
function line is encountered, so that each function name being deleted
or inserted gets its own hunk header (which then can be easily detected
by the filter).

This adds a flag, XDL_EMIT_MOREHUNKHEADS, which triggers this
nonstandard behavior, and enables it only in case the --function-name
option is being used.

Signed-off-by: David Dalrymple (on zayin) <davidad@alum.mit.edu>
---
 diff.c             |  3 ++-
 diffcore-pickaxe.c |  3 ++-
 xdiff/xdiff.h      |  1 +
 xdiff/xdiffi.c     |  2 +-
 xdiff/xemit.c      | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 xdiff/xemit.h      |  4 +++-
 6 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 914b4a2..a86206c 100644
--- a/diff.c
+++ b/diff.c
@@ -2381,7 +2381,8 @@ static void builtin_diff(const char *name_a,
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (o->funcname)
-			xecfg.flags |= XDL_EMIT_MOREFUNCNAMES;
+			xecfg.flags |= XDL_EMIT_MOREFUNCNAMES
+				    | XDL_EMIT_MOREHUNKHEADS;
 		if (DIFF_OPT_TST(o, FUNCCONTEXT))
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index ab31c18..d9f4c30 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -164,7 +164,8 @@ static int diff_funcname_filter(mmfile_t *one, mmfile_t *two,
 	xecfg.interhunkctxlen = o->interhunkcontext;
 	if (!(one && two))
 		xecfg.flags = XDL_EMIT_FUNCCONTEXT;
-	xecfg.flags |= XDL_EMIT_FUNCNAMES | XDL_EMIT_MOREFUNCNAMES;
+	xecfg.flags |= XDL_EMIT_FUNCNAMES | XDL_EMIT_MOREFUNCNAMES
+		    | XDL_EMIT_MOREHUNKHEADS;
 	xdi_diff_outf(one, two, match_funcname, &ecbdata, &xpp, &xecfg);
 	return ecbdata.hit;
 }
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 469bded..787c376 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -45,6 +45,7 @@
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 #define XDL_EMIT_MOREFUNCNAMES (1 << 3)
+#define XDL_EMIT_MOREHUNKHEADS (1 << 4)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 2358a2d..c29804e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -545,7 +545,7 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	xdchange_t *xch, *xche;
 
 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(&xch, xecfg);
+		xche = xdl_get_hunk(xe, &xch, xecfg);
 		if (!xch)
 			break;
 		if (xecfg->hunk_func(xch->i1, xche->i1 + xche->chg1 - xch->i1,
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 0ddb094..f49eaaf 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -29,6 +29,9 @@ struct func_line {
 };
 
 
+static long get_func_line(xdfile_t *xdf, xdemitconf_t const *xecfg,
+			  struct func_line *func_line, long start, long limit);
+
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec);
 static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *ecb);
 
@@ -62,7 +65,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
  * inside the differential hunk according to the specified configuration.
  * Also advance xscr if the first changes must be discarded.
  */
-xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
+xdchange_t *xdl_get_hunk(xdfenv_t *xe, xdchange_t **xscr, xdemitconf_t const *xecfg)
 {
 	xdchange_t *xch, *xchp, *lxch;
 	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
@@ -83,6 +86,59 @@ xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
 
 	lxch = *xscr;
 
+	if (xecfg->flags & XDL_EMIT_MOREHUNKHEADS)
+		for (xch = *xscr; xch; xch=xch->next) {
+			/*
+			 * If a current change contains a func_line, end this
+			 * hunk immediately before and create a new hunk
+			 * starting from that line.
+			 */
+			long fl_in_xch1 = get_func_line(&xe->xdf1, xecfg, NULL,
+						xch->i1, xch->i1+xch->chg1);
+			long fl_in_xch2 = get_func_line(&xe->xdf2, xecfg, NULL,
+						xch->i2, xch->i2+xch->chg2);
+			if (fl_in_xch1 >= xch->i1 && fl_in_xch2 >= xch->i2) {
+				xdchange_t *new_next =
+					(xdchange_t *)xdl_malloc(sizeof(xdchange_t));
+				new_next->i1 = xch->i1+xch->chg1;
+				new_next->chg1 = 0;
+				new_next->i2 = xch->i2;
+				new_next->chg2 = xch->chg2;
+				new_next->ignore = xch->ignore;
+				new_next->next = xch->next;
+				xch->next = new_next;
+				xch->chg2 = 0;
+				return xch;
+			}
+			if (fl_in_xch1 > xch->i1) {
+				xdchange_t *new_next =
+					(xdchange_t *)xdl_malloc(sizeof(xdchange_t));
+				new_next->i1 = fl_in_xch1;
+				new_next->chg1 = (xch->i1+xch->chg1)-fl_in_xch1;
+				new_next->i2 = xch->i2;
+				new_next->chg2 = xch->chg2;
+				new_next->ignore = xch->ignore;
+				new_next->next = xch->next;
+				xch->next = new_next;
+				xch->chg1 = fl_in_xch1 - xch->i1;
+				xch->chg2 = 0;
+				return xch;
+			}
+			if (fl_in_xch2 > xch->i2) {
+				xdchange_t *new_next =
+					(xdchange_t *)xdl_malloc(sizeof(xdchange_t));
+				new_next->i2 = fl_in_xch2;
+				new_next->chg2 = (xch->i2+xch->chg2)-fl_in_xch2;
+				new_next->i1 = xch->i1+xch->chg1;
+				new_next->chg1 = 0;
+				new_next->ignore = xch->ignore;
+				new_next->next = xch->next;
+				xch->next = new_next;
+				xch->chg2 = fl_in_xch2 - xch->i2;
+				return xch;
+			}
+		}
+
 	for (xchp = *xscr, xch = xchp->next; xch; xchp = xch, xch = xch->next) {
 		long distance = xch->i1 - (xchp->i1 + xchp->chg1);
 		if (distance > max_common)
@@ -173,7 +229,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		return xdl_emit_common(xe, xscr, ecb, xecfg);
 
 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(&xch, xecfg);
+		xche = xdl_get_hunk(xe, &xch, xecfg);
 		if (!xch)
 			break;
 
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index d297107..4d584f5 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -27,7 +27,9 @@
 typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			   xdemitconf_t const *xecfg);
 
-xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg);
+xdchange_t *xdl_get_hunk(xdfenv_t *xe, xdchange_t **xscr,
+			 xdemitconf_t const *xecfg);
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);
 
-- 
1.7.12.4 (Apple Git-37)
