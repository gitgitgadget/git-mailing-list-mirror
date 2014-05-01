From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 04/42] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Thu,  1 May 2014 13:37:04 -0700
Message-ID: <1398976662-6962-5-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmh-0003xB-DZ
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbaEAUko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:44 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:62529 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbaEAUhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:47 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so549086vcb.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hKT3e9ATT1980j6sIzwEbieAe+h33EVqRYeTquJSoc=;
        b=pK8l6JXcyGfQa1HeFNu6TkECR3xA1fczJHxp2VebVo6zKBNQnQO0vbRGWzWKNJ9Vg8
         ypxQ3G8kzZHc/ySDO4Mofua6VsO9Hx/k3Nb6uRYIPDb8nPUdLBm6gXrQbIoih9GK9Dg8
         lnrnhxjKINTL1K1Vyxvk15J9ZKK1WSUNqZtEJ8lnrRwZWcWU1EqpWap6F+19sTCk79hE
         cL2PgkCXy/dFD/ttFk2v1EZ4EG0Etaxnqi0qXYO7CDzZtGNJNoRjYgbf3GWHmD0sKwTh
         e6uMrR+eFCAiQxF54XDUE/aZpiHswkiXBIUDwS3VrugFMMmdxqh1TxiztgxCNqQIDyIq
         kYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0hKT3e9ATT1980j6sIzwEbieAe+h33EVqRYeTquJSoc=;
        b=SC/vpgl3+kZ7WTRQE91xIHU2Cy7ObCGHsJHMpFc6Xyml8DY4c00ScyDLrBzlyNH1Ud
         +dlYSQJcIlJlOsm340JyoZgsfnFCbWGk0s6modCjFdGqTj2e6WcoHKu6HPkkzSXO31NT
         dh0ZwQZL3MJGDxdmUPePf2NM2DBmF3Y2QxgbaT5EdZCZtN88ccQgBp2EhUEu/N11LRlW
         VWL0XeWLPKtpFiHkjhCGDCaZMapdLOgDdKCfqjuF5P61Agwk8BZUwZHzTAlD2b53dzK7
         tUflG6LiJUkgHZg+ATyBMB0htEGBEgocRewoMPLsNKLagQtWPW3tH3Ej7RVyvmHCkncE
         fWrg==
X-Gm-Message-State: ALoCoQkPla9kyWeiFBosbIvKLddO/2vgVNGizo+cpAteSCcFfWYHk4gOF8NqMHaRg5wcU0VRnrzr
X-Received: by 10.58.18.200 with SMTP id y8mr6561907ved.20.1398976666271;
        Thu, 01 May 2014 13:37:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3538006yhe.3.2014.05.01.13.37.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1DA7531C1CC;
	Thu,  1 May 2014 13:37:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D69A0E097F; Thu,  1 May 2014 13:37:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247877>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 64e8feb..21a147b 100644
--- a/refs.c
+++ b/refs.c
@@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3400,6 +3401,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3430,7 +3434,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc1.351.g4d2c8e4
