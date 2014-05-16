From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 05/44] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Fri, 16 May 2014 10:36:53 -0700
Message-ID: <1400261852-31303-6-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM7U-0004gK-45
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153AbaEPRkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:40:19 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:57645 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbaEPRhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:37 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so522342pab.4
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtqjY58VsCT6K38XEvPQTfH/QlCJC8PYeBCU+o/ylLU=;
        b=a7Bwf2hMHxMj+fTAQ1jMPIIisga05clCGWFp2VBrS3pmSvuTiY6xlJRKcLbO/AJqIw
         57YEEmVz1niKVu2KLCdGpZJ1KzX7b+7M1G8e8r6dG89cgMZXj67cfRUZiUReERwJihFa
         geLVdhHgNe+gh24+bjKj74vB69+QsvK0xDA4SVLiqz2y7IbEzeVbZS4e81CVwOfQ/aKs
         hXPWJTSscd0hStzmfkGMK0BTvSq+LM4Pk0mJUk/hT0DF/3esL/lModi6Ru13Z8HxttRJ
         9QmPbl6B3Atz9nekHWmkAnmft1kLveloyD+Tp97Doyx+CcSIWGT9tQWJ7fTVKnNwsr/T
         LnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtqjY58VsCT6K38XEvPQTfH/QlCJC8PYeBCU+o/ylLU=;
        b=VSuocyylNDbfVDb0ti1vsLv0yuBZZUlAx27h5noY/UtOm9VJ86gkTII4LjzTrJmBj0
         5VvQV6nUq9h/NUOOhI8T2t1EHn6SbDaFYVx0bPht2Vvi1iK9DSmsVrv8kxReQBx1dyAE
         bhQa3yqQlzhcPyCol5+rC0OpPMoyAVJKKpwmqD0B7Fq8uVkeNlbdhYMfOdbmzWvGY3KB
         98hxHEQOLVCC2Ow0lOxCouYkTpRxf2yTxeFhcnPqU8sUEXdVQXDdTkfQ3lrrdkn1Wy48
         23hBqZ85sQhbgBxvgWYZBwawXoC/TFCMVI8uJJP2Zm1efQDwSh0pY74n+zgZi0iGOhf0
         XsJA==
X-Gm-Message-State: ALoCoQkTTIa2QE4nwZSyEgLqYJTVvAUhNqfAJ2BP6tx/Av0de365OHA9wygPA03LIUilaCMg3yzX
X-Received: by 10.66.222.129 with SMTP id qm1mr8645089pac.6.1400261856999;
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si442526yhq.3.2014.05.16.10.37.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CCB7E31C211;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8114BE0EC6; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249400>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a470e51..57ec72a 100644
--- a/refs.c
+++ b/refs.c
@@ -3410,6 +3410,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3417,6 +3418,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3447,7 +3451,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc3.510.g20c254b
