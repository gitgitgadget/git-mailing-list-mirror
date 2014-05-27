From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 03/41] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Tue, 27 May 2014 13:25:22 -0700
Message-ID: <1401222360-21175-4-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNz1-0005XW-Br
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbaE0U2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:28:17 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:46388 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752528AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-ie0-f201.google.com with SMTP id tp5so1920258ieb.2
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O9WdxNoinKNDuB5vPbeZz+QByqDWDzpkGxEfKNdq/XA=;
        b=XG9QqjCgCv1rklO/+Z5tEjNDvxlVm/IFBEwFOStlFkmtYn20bglRAfHPkqRpgdBeG8
         eKbpLHpnDyn6Ub77G6pOUiFKiN2TqeiXa0TuN/T0qAUV0mMGxjE+LsZVMu7PgOtf6JOO
         w7oZYRyv6npBy1/0bzP9bpFVkY6KMyonNKNok+EeQQuQJiaJznpNrGCf/YTvruYy3Urr
         uJljgQvIYh8FS3ZZhUVW6CXRvFjGaaKxfjmREq0+DvEQEa5Zl0Q630H06e+VyYhYo2/t
         kikCJfhbAMVA+LVOPE9yJ3XilsWs0YfGTa7oVkeWqK1SynWgapBQt6/dLjDRiM+FXrHn
         2wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O9WdxNoinKNDuB5vPbeZz+QByqDWDzpkGxEfKNdq/XA=;
        b=O37UM5qiHVZXmG2wt0+iLTbFROYA/MUtyx/8/V4WDfKV29mUxjZfujlcWqZA74uO4G
         8ppUfS5EM/DucO8Jn8CP88CmFfnoPrnKSuDMa9g5BG0eAPAxc0j0QdlKhRUyii3COJIi
         b5ythLdPgCIOiKrwhar9Le9il0J+TEKGDJjKt3upV+9b371N/ifb+qTjLFJ/g24wQSJj
         cZOEEKOaN1262mSs6Undl8BP5cy/4WInDpYJ5Xyx2IWSgsd6BvkYVQGzIe6Oez6V/N6U
         OtMWyPekAuTY/r9U9b8gct5j48HG/Hbu8dAlv6/sTNnReqp3hIgitBzqx08tp1QMXJ1Y
         Wq5Q==
X-Gm-Message-State: ALoCoQkCaPL1+SiSpKtJKfveHS53yG5r+R1koTazKqgM4RFSa/gsPlUy3N6BZ8WoHA0DlU0JOYBd
X-Received: by 10.182.33.66 with SMTP id p2mr14683298obi.8.1401222363786;
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1573746yhl.7.2014.05.27.13.26.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9EDE8370512;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4AD7AE0C28; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250236>

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
2.0.0.rc3.474.g0203784
