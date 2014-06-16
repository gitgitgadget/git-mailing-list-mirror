From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Mon, 16 Jun 2014 11:03:34 -0700
Message-ID: <1402941859-29354-4-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbL4-00089r-4x
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbaFPSIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:52 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:54651 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so829926qcz.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gTdrlIOE6Bbblfq5YOo3a5PXZmnbQzSXBmw7+yCCVE=;
        b=D9XYHEplSgMeQosrioOCRGt76GQcq1zWRX/gqFt5nzLMj0SH5rVSnllUmtM976NxgY
         1e8p0CTRSVqZxKIJEgnchmGOUNK5QJSfz+hhjzMtzXx3MH6QvfoqpwqxIiNGmMTBuiwJ
         q9s+2etF5Xs+uywYOy4aAhVxmlNvaO++bwIdvI56wqCbdl3ZYfRgIBkcAVxeA7orFpXR
         3ym5ZmhPFLNZZ88fEev4qdTY/MSA/24bhlNYp6e98ziL3UMPSdEZupMKJoGenpOz63rO
         OKd4yIFXbhKg5AH2yR+iWNdNpwsl+sBUcB54B4OdQPHIe++VHTM39n3ORdj/tUVjKbtC
         wz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9gTdrlIOE6Bbblfq5YOo3a5PXZmnbQzSXBmw7+yCCVE=;
        b=P/JY2PQCJLyjO0z2TjteZAKfT2jeT/n+cp+tOxGe7wwQC0KlNeqEAWxHXZ1Mm/YNtx
         5k4c2veet7QYy665dGiwlLvwrsIdrH16RfoF418sA/be9YsUmaVujZiZfJKuJmx4Bn+Q
         lx7j8GlazSxQBj+RqqZagmysrjyjyPD6m3M7XQWToKhnc8LWY4h4Ny6ZZcT0YfyMmbdL
         uDV4ZmwSRzSdc2m9UG9ddAGibVVAzxpPXYkNpsd5wNYM7m6hA7vqok3K0wPA6zL9mvb6
         9HUpB/AjmtfOvM8UQYOb7UhIYnjdm26TCh6dSeX/NenQmhpbdTD4qosnsr0k5znpmzvl
         7Cqw==
X-Gm-Message-State: ALoCoQkAaWk8qgT0ZYVGLXZjjMq9a1msYIuyN/2SNgRTXyPoNReTyBufAFsrb+cvFqPLc82bp9xP
X-Received: by 10.236.67.103 with SMTP id i67mr1301165yhd.56.1402941862364;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996127yhl.7.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3AE7231C8AC;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E01BBE05EA; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251791>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 33541f4..a767ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -3333,7 +3333,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3347,7 +3348,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3361,7 +3362,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 306d833..b893838 100644
--- a/refs.h
+++ b/refs.h
@@ -237,7 +237,8 @@ struct ref_transaction *ref_transaction_begin(void);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -248,7 +249,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -258,7 +259,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
2.0.0.282.g3799eda.dirty
