From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/33] ref_transaction_commit(): correctly report close_ref() failure
Date: Fri,  6 May 2016 18:14:01 +0200
Message-ID: <f5bb5bf956f86d78f321b49ff444469bf274bc4c.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:22:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiW1-0005NY-47
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbcEFQWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:22:03 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55621 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755067AbcEFQWB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:22:01 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 May 2016 12:22:01 EDT
X-AuditID: 1207440e-ef3ff700000008c5-9b-572cc300098f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2C.0E.02245.003CC275; Fri,  6 May 2016 12:14:56 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV2031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:55 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqMtwWCfcYNNnU4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd0bnscWMBetZKs7u/MXWwHiQuYuRk0NCwETi1paV
	jF2MXBxCAlsZJXZd3sAK4Rxnknh75AkbSBWbgK7Eop5mJhBbRCBCouFVC1AHBwezwGdGiZXc
	IGFhoPC6e58YQWwWAVWJLY87WEBsXoEoiZfL7jFBLJOTuDz9AdhITgELiUO9x8HiQgLmEh1r
	b7BPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXWC83s0QvNaV0EyMkwPh2MLavlznE
	KMDBqMTDm3FSO1yINbGsuDL3EKMkB5OSKO/3Ap1wIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
	V/YB5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKEryHDgI1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiIL4YGAMgKR6gvXyHQPYWFyTmAkUhWk8xGnMs
	+HF7LRPHkf331jIJseTl56VKifPOBdkkAFKaUZoHtwiWWl4xigP9Lcx7GaSKB5iW4Oa9AlrF
	BLTq/VxNkFUliQgpqQZGv48ivmdXcu29qtvkaRx8LvPO/TvVya81Gmuk6hp3Tfu6Z9NMocWh
	bkHL4/IVfpglNvhraa87H7sqQ//6jJAbVRmTVQqfHP3qMp9rjdYWKU/GZ9Eq2yQ2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293827>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7cc680a..f4f7953 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3139,6 +3139,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			if (close_ref(update->lock)) {
 				strbuf_addf(err, "couldn't close '%s.lock'",
 					    update->refname);
+				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
 			}
 		}
-- 
2.8.1
