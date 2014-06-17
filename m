From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Tue, 17 Jun 2014 08:53:29 -0700
Message-ID: <1403020442-31049-16-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvkT-0006Pc-PP
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbaFQP4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:30 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:41806 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so1051929yha.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2862IeVOXR954TV0mGh3lmmMlHdeOWXWJAQCGRPL0+E=;
        b=bAjcEhZgVmhrqWo8NThUneyFDRDog0O/pPT8paE/CaQDfHvqNy6jRV8HaIpIb4B1dp
         uF5yT5sa7PoqA1+dDvE3soGP0hL53MOZybCoC15KuGss82aquK/TnbuEEB9IbZHy8rfc
         yTJ08Vkr2YBW7RU6fyeJ2gXV5KY1Pl9ucvJJCZRdrCqIYjTrJ0NbyghPt+g1S5izfxTK
         KKXFXk+ZJrnRQTyFo84xEy/1rQTnTONbJgTJTt6KAR3Qbx/66+3V+TXhzBSOSPHpbIAq
         f56IxsSGGzPR7htMwGXv86bM0cFcJ7xGyIi40hVchGoarP3aNHd2ZWOBAQnV0cTY8Lbf
         wb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2862IeVOXR954TV0mGh3lmmMlHdeOWXWJAQCGRPL0+E=;
        b=E70zgxJQ1QHh1Cj2ALCIDPjMWtnjHVprRDTwK5FSyA58grvZxy8B9fDviAR0UroqZz
         MJZRhQTNcyhQnN1t59j54BIefK/imOyCTHBu3L/ZRvTcpSxK2WMj6Jx879ZsOK2xYvCM
         IhynSEHeSZvfvQSOyVNgvfA3aAVRS+rjYEm8WANRRlECYDsGCLe64gnB4wHRfTZ07SPZ
         UAAMnSpd/FPuA2m9hHKP20EGziFsybQJRKKSWVDuJaUWCiwSbbqRqqEj+8CflNzYMzWx
         kRMHUf13QkZTGcgKEUfGyCfCu9eYoJLn0PQSXUWCCIkmx8N28zfCx5N0S+70dMl5cvtl
         CsOg==
X-Gm-Message-State: ALoCoQluD3fsewec63KYB2eZKQS6imZstDTzhz8LzNmpI/KkW0535jbBuwAKoobKu/9pGrU3EiEq
X-Received: by 10.58.209.227 with SMTP id mp3mr1412400vec.29.1403020444846;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1209461yhg.2.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A690931C770;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 55E3CE1648; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251906>

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
index 1f2eb24..4c1612a 100644
--- a/refs.c
+++ b/refs.c
@@ -3489,6 +3489,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3496,6 +3497,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3526,7 +3530,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.438.gec92e5c
