From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Fri, 20 Jun 2014 07:42:56 -0700
Message-ID: <1403275409-28173-16-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02w-0001No-8b
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbaFTOnk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:40 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:52879 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-yh0-f74.google.com with SMTP id b6so505572yha.3
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZE3tzLyNLEg3dQBht0zNWdZpevNqqEoqQitxeB0Rws=;
        b=Cc5iN8YLyNQita3NW1K6PZh2zxEI3hP9rE1xmh7au7W2EY1UC8gr2AFR7afgB/lmML
         8bjXa1vP/SIu0DzXDz29Oj1slpycPugGSGYgJ0vJbPJ3BRIZWqPlPc868bdzzoegkYAE
         LmvnzP6Dhobrdf89f6d3WvqSosNL1Stx0ZkivI4EZDmtqA7V6nA4u8Q759L8StCES33U
         h3AGCY3kfoQuYgE+Dk+T5P+SQ53mzlXbmVc0u3FJSG4J1HhEAhbLc2NoxBhhrWLsugC+
         0f47bBRGyZusUJ4Utm76I+MhqrsrtVe+yLz1TbkhOK7JLBqGCXaIHkI6Lf31+mc2mLaM
         k0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZE3tzLyNLEg3dQBht0zNWdZpevNqqEoqQitxeB0Rws=;
        b=cjFSbadUUMNV0/LHp5+N8ujVMasF9H161xor66+gTelb0X8dy6mAWqox75urnHpRmF
         pK9O/OcjMOq7R4bUUEA9LDkh/pXeHcaXN9vrA1NCHpkRGRK7Uf1/czem+Oo1HqYY2vhg
         /Rg1r6uHzs5BkRoEkGt+uuB0E4cpVLOVfo9/+3b+9bhCeWN8VQkfmty8eJU5rA0smIdf
         h0fetQt6GaFGWkxUrJNanV5mdJERY5FE7ZWR1wK9ge0+YFau3E+hytK0GyBu+KriofD1
         PgthAvvmx30TBGhsJN4wpi4Gb/lakhxii7awl6AIYG6VlBsBuST0vVVwq6hKFRU/QX09
         Ll8A==
X-Gm-Message-State: ALoCoQlq743WCzjXEr6zPfXndZXxuhC6YEogHOHfU1qpvb+6D3cf4XfFfbl9l9Z1G7hBnNASGkkW
X-Received: by 10.58.67.193 with SMTP id p1mr1537431vet.36.1403275412542;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id b39si187832yhj.0.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 62E3531C6B1;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 32814E163C; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252234>

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
index 61570c9..115f143 100644
--- a/refs.c
+++ b/refs.c
@@ -3488,6 +3488,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3495,6 +3496,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3525,7 +3529,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.420.g181e020.dirty
