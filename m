From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] shorten_unambiguous_ref(): introduce a new local variable
Date: Wed,  8 Jan 2014 15:43:38 +0100
Message-ID: <1389192220-13913-2-git-send-email-mhagger@alum.mit.edu>
References: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 08 15:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0uMx-0005cR-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 15:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbaAHOoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 09:44:19 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42571 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756542AbaAHOoQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jan 2014 09:44:16 -0500
X-AuditID: 1207440d-b7f4c6d000004a16-00-52cd644024e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 49.B3.18966.0446DC25; Wed,  8 Jan 2014 09:44:16 -0500 (EST)
Received: from michael.fritz.box (p4FDD47EC.dip0.t-ipconnect.de [79.221.71.236])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s08EhhdH022001
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jan 2014 09:44:14 -0500
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1389192220-13913-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqOuQcjbIYO0dZouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M44cKCVtaCFq+Lric+MDYz/
	2LsYOTkkBEwk9u98xgZhi0lcuLceyObiEBK4zCgxddczVgjnOJPE81VNLCBVbAK6Eot6mplA
	bBEBNYmJbYfA4swCDhKbPzcygtjCAn4SnS96wWpYBFQlLr9Ywwpi8wq4SNy8/ZC5i5EDaJuC
	xOrrQiBhTgFXiYuHl4MdIQRUMvfDVdYJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka
	6eVmluilppRuYoSECu8Oxv/rZA4xCnAwKvHwNqicCRJiTSwrrsw9xCjJwaQkyqsffTZIiC8p
	P6UyI7E4I76oNCe1+BCjBAezkgjvpTigHG9KYmVValE+TEqag0VJnFdtibqfkEB6Yklqdmpq
	QWoRTFaGg0NJgtcgGahRsCg1PbUiLTOnBCHNxMEJIrhANvAAbRAAKeQtLkjMLc5Mhyg6xago
	Jc7LB5IQAElklObBDYBF9StGcaB/hHnjQKp4gAkBrvsV0GAmoMGhcadABpckIqSkGhiNlFc6
	mlqs2hjncLnCOH/DPWO2tVYVek6r/rGYr/h5fUqOH/M31dfa22aoT3RlP8rAJLjnZ0D95MiZ
	z1o4ztf8Mpmxw2POnA3/llTdP7UkcVp57inpHKO+0o2ll1gk1ifPqSznKTu8vCRXXrtLfI2F
	bKpmxemi1Q5/7QVitq6wfdv+enWuUYASS3FGoqEWc1FxIgDmWRRyxQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240215>

When filling the scanf_fmts array, use a separate variable to keep
track of the offset to avoid clobbering total_len (which we will need
in the next commit).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 3926136..9530480 100644
--- a/refs.c
+++ b/refs.c
@@ -3367,6 +3367,7 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	/* pre generate scanf formats from ref_rev_parse_rules[] */
 	if (!nr_rules) {
 		size_t total_len = 0;
+		size_t offset = 0;
 
 		/* the rule list is NULL terminated, count them first */
 		for (nr_rules = 0; ref_rev_parse_rules[nr_rules]; nr_rules++)
@@ -3375,12 +3376,11 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 
 		scanf_fmts = xmalloc(nr_rules * sizeof(char *) + total_len);
 
-		total_len = 0;
+		offset = 0;
 		for (i = 0; i < nr_rules; i++) {
-			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules]
-					+ total_len;
+			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
 			gen_scanf_fmt(scanf_fmts[i], ref_rev_parse_rules[i]);
-			total_len += strlen(ref_rev_parse_rules[i]);
+			offset += strlen(ref_rev_parse_rules[i]);
 		}
 	}
 
-- 
1.8.5.2
