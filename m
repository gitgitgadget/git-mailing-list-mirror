From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 15/43] refs.c: move prettify_refname to the common code
Date: Mon, 28 Sep 2015 18:01:50 -0400
Message-ID: <1443477738-32023-16-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXM-0002OE-2P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbbI1WDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:14 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33727 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbI1WDM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:12 -0400
Received: by qgev79 with SMTP id v79so133375286qge.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=190n8IeTlsE673ijpAGcHEadnW68krBr+/ceGD7dqQU=;
        b=LfKQUQZ6OYZY4ogP51NDLrgaa6GWCNRzwuK4Dt85xVWiGEUOqwhjlQm2pgtyrFw0qQ
         WB4lDvwDBePodbT5Ztm5VMz916Br4ha5c7hgIjtntRFNBJjoPBnGKgoxes5kzdPBXqdq
         6RD2ft0ajqVef54scomkQIPcI+97GXdJ3H3m1E1/5Jq1oqhMvQSc7qzVf3ejcD5+UNGj
         Bz1wkDMP6iDUKBsfVgRFQKYzcLnSrJAzOgegsnNu4/NLW9i7jDE0k64Zn33GV3CeAPdx
         yOgW11OcQ/A9DRw8fuqhMoaLPb3JbCld0MwMZ2/rsOGbLbZfUOqu9YKp5JWKFeg7ayIK
         X2oA==
X-Gm-Message-State: ALoCoQnJlLYA7hJ22dmgLQpa8ra+MwAO96tnfXcDb0v65SampHrA6AHlWx+8/hEVIF+J+ebEYtZe
X-Received: by 10.140.133.71 with SMTP id 68mr26560328qhf.85.1443477791922;
        Mon, 28 Sep 2015 15:03:11 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278787>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 58ff453..9c27851 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2064,15 +2064,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-const char *prettify_refname(const char *name)
-{
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
diff --git a/refs.c b/refs.c
index bc8750c..44ee4f4 100644
--- a/refs.c
+++ b/refs.c
@@ -772,3 +772,12 @@ int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
+
+const char *prettify_refname(const char *name)
+{
+	return name + (
+		starts_with(name, "refs/heads/") ? 11 :
+		starts_with(name, "refs/tags/") ? 10 :
+		starts_with(name, "refs/remotes/") ? 13 :
+		0);
+}
-- 
2.4.2.644.g97b850b-twtrsrc
