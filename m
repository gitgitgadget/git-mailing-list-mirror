X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Increase length of function name buffer
Date: Thu, 23 Nov 2006 10:05:17 +0000
Message-ID: <200611231005.17859.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 10:05:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: fbff283e1a6eac90
X-UID: 168
X-Length: 1237
Content-Disposition: inline
X-OriginalArrivalTime: 23 Nov 2006 10:06:52.0997 (UTC) FILETIME=[196A2750:01C70EE7]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32131>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBSP-00034V-RS for gcvg-git@gmane.org; Thu, 23 Nov
 2006 11:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757321AbWKWKFX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 05:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbWKWKFX
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 05:05:23 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:60769 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1757321AbWKWKFW
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 05:05:22 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 23 Nov 2006 10:06:52 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GnBSJ-0003nP-00 for <git@vger.kernel.org>; Thu, 23 Nov
 2006 10:05:19 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

In xemit.c:xdl_emit_diff() a buffer for showing the function name as
commentary is allocated; this buffer was 40 characters.  This is a bit
small; particularly for C++ function names where there is often an
identical prefix (like void LongNamespace::LongClassName) on multiple
functions, which makes the context the same everywhere.  In other words
the context is useless.  This patch increases that buffer to 80
characters - which may still not be enough, but is better

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 xdiff/xemit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 07995ec..e291dc7 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -118,7 +118,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
 	xdchange_t *xch, *xche;
-	char funcbuf[40];
+	char funcbuf[80];
 	long funclen = 0;
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
-- 
1.4.3.GIT-dirty
