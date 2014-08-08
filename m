From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 04/22] refs-common.c: move delete_ref to the common code
Date: Fri,  8 Aug 2014 09:44:51 -0700
Message-ID: <1407516309-27989-5-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJi-0000s3-GJ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757105AbaHHQqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:46:34 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51013 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so1040995oif.4
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=moyO7g/pWZ6lGzzANMhSR7fZwymEn9hd/AFfRBUPCU4=;
        b=nQa/XDuLijCK57ZMlhPY64N/f2cCDaNwqILmRepfJpeNEdlATVLkzEHkscUqo1wCDD
         MWrBX5T0Vv2JVVVdmTf6zQW19hhT9h+PpuVL1Q8Rqi686EJeUxSx2DhAkwinJIE0HCZb
         JkmVmb8e2ulWgLII3Hmbl5O6RptAoG6iszdDQecXCTz/rWaR+6BBkBLfIKnuBP+CofVL
         cvorUzvrdS8iF8BXrwtnCob0cVHmFVtdm4ZBxKbN10ozSmfD6s805/8iP3oqV9pu3b1V
         W7/T3l6Vj5Pi13a9u23vByvMfAIYT04P1OE2johOYJoWWb3DpluTTQNoSv8ze19H62TQ
         jisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=moyO7g/pWZ6lGzzANMhSR7fZwymEn9hd/AFfRBUPCU4=;
        b=duFAaxiFryEgIPx1gesQCKXq1yplS12CrJMOmfXLG3psxGnusAn7uQE5vk7Eg9XJBy
         9g18rthcZZm0iopcQL6GHnTZRn18ONj/ICP2qrZdiMIXJGBAEk5N8lBFz+iXTy0FoRpQ
         jYLTyASe+Pz1sNRyzIjtredZlZWM7aEIXf9udxDtI7rJ6RxztAFRLymGEGrklZzpV3nu
         YUW5+5QypcF2qLisi1lkeV3PUAKaK9jcGdfdTzvdCbJRt/R5nyeTZcglAZCCKE0C0eYB
         Sq6uT7+VNMJs6s+9uoClVtbFP9Jef3hp7sZdpiu18ATRV7HhyN+tJmnbAkWUjlnZOgMg
         o2nQ==
X-Gm-Message-State: ALoCoQl9rZEg9WPB2TF2vCMjAv8yjw+B2tKK6QJcCTXYHaDhwdqS3SbyFDcrG6MviE9WdHqBydCC
X-Received: by 10.42.177.5 with SMTP id bg5mr5059538icb.27.1407516315486;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si504804yhb.3.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5339531C5BB;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E8FD5E064D; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255046>

This change moves delete_ref() to the refs-common.c file since this function
does not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 18 ++++++++++++++++++
 refs.c        | 19 -------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index cb884b2..71ad358 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -25,3 +25,21 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
+int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+{
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	transaction = transaction_begin(&err);
+	if (!transaction ||
+	    transaction_delete_sha1(transaction, refname, sha1, delopt,
+				    sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		transaction_free(transaction);
+		strbuf_release(&err);
+		return 1;
+	}
+	transaction_free(transaction);
+	return 0;
+}
diff --git a/refs.c b/refs.c
index eb66cf7..faf794c 100644
--- a/refs.c
+++ b/refs.c
@@ -2622,25 +2622,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
-{
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
-
-	transaction = transaction_begin(&err);
-	if (!transaction ||
-	    transaction_delete_sha1(transaction, refname, sha1, delopt,
-				    sha1 && !is_null_sha1(sha1), NULL, &err) ||
-	    transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		transaction_free(transaction);
-		strbuf_release(&err);
-		return 1;
-	}
-	transaction_free(transaction);
-	return 0;
-}
-
 struct rename_reflog_cb {
 	struct ref_transaction *transaction;
 	const char *refname;
-- 
2.0.1.553.geee1b3e
