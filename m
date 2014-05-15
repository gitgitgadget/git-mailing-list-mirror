From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 05/44] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Thu, 15 May 2014 10:29:20 -0700
Message-ID: <1400174999-26786-6-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWQ-00039P-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbaEORc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:29 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:65361 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so99747igb.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1qS1XldyOtBVpN8HDQnHMj91ByoNGGJnnETiL/iWh4E=;
        b=fBSTPbh8Z4LgURTdSygLKgk9p/vlbHSuUt5llAqWBse4sQ1Qke8eOQK+/3vF9BtT47
         83QXdk90uQoAYfVvurniOXorauYobYVm3Yco2RGWBOqjXXr4ElTRqxM2uZqxq1bjBi6y
         6Joru/iIZuo1n/vQXRHrWxhbAQLJgqqPjKqysY7KieA5vV79jJudWUqRpFGGiTKe7Bxj
         wIDeMU3sa3ijt8hA+j2xD5iVMJtm5Y8nis9WIOctobwUVUzlq0ozXCkaeL0laEnFdfQZ
         c2jepMj2GNIYDjuOVGRzCg9lMwIVB1qSKh2G9CP8yyZ25af5rX2HwT+xMnVqYF9h8Y8j
         OQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1qS1XldyOtBVpN8HDQnHMj91ByoNGGJnnETiL/iWh4E=;
        b=Q/Q8Y0RRuQMTPCyeyyxD2ymixGTFxYOKbFq7ckXlCpEK/7dbdMbsU9je+i6CUISEkx
         y32Def+AQEg9FS8QSphbl3eMtfBWN8UlQZ3z2Q7zf0TzIYuav9EicY1aUsfNV46Yhesb
         MAjhahJ9ZtSglvUqA+4CClppeLCRAKysFYk2nU29HaeNAG9Jc7FmImM3wA9eOYqO0gKl
         D7PtQBqN8iEIUgZdytJwszMHWJHaRBTqtnoxO2qi71Imtuo+sHj7CkV/9imman5Bb+E3
         rkhnVxJTbRNCH2Gqre1n2txMFyspp39PDo4FyWYpdEmbCiDTLe/FnkuPYcy/nK/w5ErL
         OXEA==
X-Gm-Message-State: ALoCoQniUDXgKnsGJIl9gmZc4K48q+4dpIQAHw2ac/g/Z6lrsUEvjNsglXUgK9AZRfz4fkMOV6ig
X-Received: by 10.182.87.2 with SMTP id t2mr5695259obz.2.1400175006156;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si273444yhq.3.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 05A395A4263;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 99197E16A3; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249162>

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
index c2b720e..072e3e9 100644
--- a/refs.c
+++ b/refs.c
@@ -3408,6 +3408,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3415,6 +3416,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3445,7 +3449,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc3.477.g0f8edf7
