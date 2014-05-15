From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 05/44] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Thu, 15 May 2014 16:15:02 -0700
Message-ID: <1400195741-22996-6-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uV-0000Xk-FR
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367AbaEOXRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:55 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:64879 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755645AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so389716obc.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=arJfHtgoUOT5KQ9DQMRkuToTW0nczb1rMlDshKfyhvo=;
        b=Bl1kZ1o4GzCB0RudlqwJqBquezpGv+tmi0DoigK+pjp52T47YNjE9LbqnlygTHAoE3
         qVwllOyZlHGhZ1fVB2Vgo64y3R9JGsq9Su1ynb3GOF4rpq2TxzcGPvyjaO1mFPiDDj6+
         yCJbkSrwM+7f/qbX8ZqUe6SJ2vX7OTuVBeL08J/BLHPk//D7AD48bjldKQNfYRg72Y3T
         GC4W3O7D+Ju9g1DfJZMEIGVDSX8dkQnbR6d7mwHG0QAFuKbTYQO8AgEi1xHr4Ju5B/F/
         0U6odhPeWe1o6ZGzQh45EzramSmYTFVTHQyyf5qj0YbmtKR17ureL2DJC0oIl2IQA71j
         WOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=arJfHtgoUOT5KQ9DQMRkuToTW0nczb1rMlDshKfyhvo=;
        b=fhX4XFXT1H9faXSsnozfR8iNpqIWTgn3m/Woiify5h5vpCJnZTjKWmDn5nrDdtrLFF
         +c3nZrfRBjr6dyAfLYDY1AWmBvzE3ulsvibK6pIGXaTGoTA3b8ByCJ4GfXvIya8qNyWb
         jzqcKkJ6L/42mm8NrOMVaL1nS8EmVPDznVAuu24oB+rnG0mwHKO7xNQQhPqKEJ5Wvj+/
         K9304KgzflYwJouZTK9uXTJxZUOKhTXsgdpaaPaZjAMvQPJ2iU6rB38keARayrX8IcpH
         SkapWUqtW24w+Ex5DA7COYUi8BDZJjO7WbbUqeqnlWjVds6sQFDVJKYiUl4/ugQR40UY
         3cpQ==
X-Gm-Message-State: ALoCoQlpF03d+ZeKC6hMcxwxlycLxMWLBohOHR93fhLtWbJTuxCzc55Q0gKJw4W7QRn0UPl+khrh
X-Received: by 10.42.236.68 with SMTP id kj4mr5750532icb.6.1400195744862;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si318879yhq.3.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AF39231C1CD;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 61A50E0B9F; Thu, 15 May 2014 16:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249262>

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
index 66938d7..4ebf130 100644
--- a/refs.c
+++ b/refs.c
@@ -3415,6 +3415,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3422,6 +3423,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3452,7 +3456,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc3.477.gffe78a2
