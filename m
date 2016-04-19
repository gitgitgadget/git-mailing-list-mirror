From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] xdiff: add recs_match helper function
Date: Tue, 19 Apr 2016 08:21:29 -0700
Message-ID: <1461079290-6523-2-git-send-email-sbeller@google.com>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com,
	peff@peff.net
X-From: git-owner@vger.kernel.org Tue Apr 19 17:21:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXTA-0005DR-KG
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbcDSPVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 11:21:37 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33752 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106AbcDSPVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:21:36 -0400
Received: by mail-pf0-f169.google.com with SMTP id 184so7882630pff.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vIL9/VhJWDOcOkqAIzbNEIHwlDIpLaiKyYlTQ8Ro/dA=;
        b=Fj8ITsq1+Sg9IFtOBwfOk/WK0X7dhT2HETv/SQeluAlQg0RsYNGkNaFisEhrBSWYmR
         +Ur8i0sO8sWJjYTzA+r5K/hcALFQc6hREub2rnoE9MbrRw14wX9JKbEm662Nrx+HZQxn
         I5208pJK6xY6xthRn23G++QQyIiTNGzqu7lM9miNKBPtoY+WpIje3KAf570dR+gVRFyF
         dyoc6/czXOIAnDvji3iuLXiatznqCwPpeYJNa5mOaaf7JrQ1LJ4IVBDTxnxwaGfL3PW9
         MpHrf8/zi9aWp5d+HleKXbZxP0uby1Lq1RWh38mn9NQAeSgOklHA8Zkf9CeLWFN9Fo3E
         eHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vIL9/VhJWDOcOkqAIzbNEIHwlDIpLaiKyYlTQ8Ro/dA=;
        b=fZdtrPGDvRf4oswjVNtkTFIjITjfDQQnQEyGBqq+RC9WnfaUgFtUwHfbgwEQgyFCro
         +5jPQBvagNRq9SD23SWYN3yjYG4L9RSszbM8UnduAdjE8SkOYkpl+IPpq6PuVxA2ZxT/
         ePGYMnAmsTzQ3dbPitIzuR0vJ9tjL6b1GlDRBqBf10m2qi507uBF8ubqcbKpcsqfCP+o
         ryRLEguMkK0Ypnt4oUU5vlHRkMGWggyR0GxL78sJTro7BGyOgnza42uOdRAz0Y78tuv4
         OpSU+ItKwdWSu+I9LxnzZ+XB4YAohFbCfESQD8qr+Oys23ERbB0yxwV/oUmxTSl0/qA0
         pF2w==
X-Gm-Message-State: AOPr4FUhg2N80Gooo+wYV3eiUjWwQqtAWTYiJvpB1cAP7UZsw72yYK9tPkKworfG3YTmmykk
X-Received: by 10.98.16.88 with SMTP id y85mr4741891pfi.77.1461079294887;
        Tue, 19 Apr 2016 08:21:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7418:717f:4b27:128f])
        by smtp.gmail.com with ESMTPSA id 85sm91744832pfl.18.2016.04.19.08.21.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:21:34 -0700 (PDT)
X-Mailer: git-send-email 2.4.11.2.g96ed4e5.dirty
In-Reply-To: <1461079290-6523-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291875>

From: Jacob Keller <jacob.keller@gmail.com>

It is a common pattern in xdl_change_compact to check that hashes and
strings match. The resulting code to perform this change causes very
long lines and makes it hard to follow the intention. Introduce a helper
function recs_match which performs both checks to increase
code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xdiffi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 2358a2d..748eeb9 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -400,6 +400,14 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 }
 
 
+static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
+{
+	return (recs[ixs]->ha == recs[ix]->ha &&
+		xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size,
+			     recs[ix]->ptr, recs[ix]->size,
+			     flags));
+}
+
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
@@ -442,8 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the last line of the current change group, shift backward
 			 * the group.
 			 */
-			while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
-			       xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags)) {
+			while (ixs > 0 && recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
 
@@ -470,8 +477,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the line next of the current change group, shift forward
 			 * the group.
 			 */
-			while (ix < nrec && recs[ixs]->ha == recs[ix]->ha &&
-			       xdl_recmatch(recs[ixs]->ptr, recs[ixs]->size, recs[ix]->ptr, recs[ix]->size, flags)) {
+			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
 
-- 
2.4.11.2.g96ed4e5.dirty
