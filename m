From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] xdiff: add recs_match helper function
Date: Mon, 18 Apr 2016 14:12:29 -0700
Message-ID: <1461013950-12503-2-git-send-email-sbeller@google.com>
References: <1461013950-12503-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 18 23:13:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asGTa-0001ds-Rc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 23:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbcDRVMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 17:12:42 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36548 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcDRVMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 17:12:40 -0400
Received: by mail-pa0-f49.google.com with SMTP id er2so53983583pad.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JjaMM5zzTk2Z685D7ZIF3j9yaQCRt2ZR3Mt82/EZfE4=;
        b=PKaMVQ7oai6pOJZm3VEm57Ow8787F2DtLsHG2i5FU6npaqdTiYfHy8nSz2Zq9jUJvP
         2Lwti/bzKS20Polb1dAYhF4K3YelkubpKBlnwoM/6xvslhg2p0eRN7x0td/Xp9mWahZ7
         /MDHFJUvng8MLJg2msxVxHjEvBUkR3PnOClI2Gane1ZAfphyc1jfxksbysCgXtAwAXPm
         bhM6TXoiLlhXI1hvY1watasvt8nppnVk4IUERXCM6NgMrYF3KUs0saFyZRQE/y5N3eKW
         /r4IxnN0gmcbWLOpCbwxROmC/6SFEuIMikLNikYXe4I4G14La/kOlaz+nqym2QFbeKgN
         RwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JjaMM5zzTk2Z685D7ZIF3j9yaQCRt2ZR3Mt82/EZfE4=;
        b=haTB3Vh7d6RQS6ETCdnHL/1x25cwaUIFBoGsFcb5a1GGYDUxdLSPwwgCUYLipMeR4J
         ju7O9BxJcyPYecifBvo7KrcSL6I6v/75F3SRWUgxVXP/bLLiTDD9FofAs6hkOX/4wn+B
         GHdTWU87/UKn0/BCVccxuXMoXlqP1yzoFQk5Y3zuAt76OJ61CB+gfCcXxCi5E7WOkNQC
         zzn0AwNDqw+MMpNWyJI7XHctMLgdc7iCmCtvcPk/YpAzNbWaV3P1Zs1+hepjC0zWzmMS
         8Kuv0VYuMfJzYSt1qpPNqfOA2l15tQS+n+/KMTtue5Am1D7TuLX1VaWUw0+bhjWSnSSg
         KxZg==
X-Gm-Message-State: AOPr4FWaBRE/oPhT4Xeq81KL4huVtNYeGVYV5k2Re4ALCUycZHatvF+nIdwQpScz1jd9KUXs
X-Received: by 10.66.148.35 with SMTP id tp3mr12971148pab.159.1461013959543;
        Mon, 18 Apr 2016 14:12:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6869:43f:e72f:2f19])
        by smtp.gmail.com with ESMTPSA id 26sm41371420pft.41.2016.04.18.14.12.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 14:12:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.212.gdf84f39
In-Reply-To: <1461013950-12503-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291826>

From: Jacob Keller <jacob.keller@gmail.com>

It is a common pattern in xdl_change_compact to check that hashes and
strings match. The resulting code to perform this change causes very
long lines and makes it hard to follow the intention. Introduce a helper
function recs_match which performs both checks to increase
code readability.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.8.0.26.gba39a1b.dirty
