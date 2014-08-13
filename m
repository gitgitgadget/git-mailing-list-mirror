From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 04/23] refs-common.c: move delete_ref to the common code
Date: Wed, 13 Aug 2014 13:14:48 -0700
Message-ID: <1407960907-18189-5-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:15:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexA-0008Fy-FY
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbaHMUPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:15 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:42943 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbaHMUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:10 -0400
Received: by mail-ig0-f201.google.com with SMTP id h3so269262igd.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d91ovSXbGAsBDF9Etkra9eV0szrCWzCTvw+UDWKC6os=;
        b=nIW6dcT7A4wyFjaN/o5R6B62uCKrd14sDxX/k4MWWjOxmiDBMyQLeIB/KBC+y3P5jb
         Tr/PdDPCxLiZlv+KpfWRTfdjil03fXJ225OmhIuCKID1KpsZUiFYlv6hMCxGy9uYELIu
         Ngi1zYi1M+2ROW6Zgnd7y/8fWYJ3E3veloY/cY5HkrVq+q+bF7a8rOWfWY4q9JBYnVD1
         sohD3e99UwtgzSGvIN2uPwn9F/udH1m7J4g93pTh1X9yQd+G1YSY6JlGSxlV2Mr+JQLo
         xjnKn80gX3T0DyAtvCVzkmlSk9490fpkMZdLxkhl1lTZ/4UoGLQet4aIOm+PjKB11O1q
         up3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d91ovSXbGAsBDF9Etkra9eV0szrCWzCTvw+UDWKC6os=;
        b=ROtSssQzOcbn4xDj3L2AdOoKdFvypZaaqT5sR9CDBy7HasB8uHnWuadPoqfCA35ShZ
         1bf6agwq0TpThWNhx1u4Rp+pfpiVbv3whRZxy09Sm29GK9VN6cnkO/skMbilfZ6Tnxse
         illc15dEsEM/vRuCgyyJiGFBYoQkzm/A0MuFBR9Fh8tt1p/mx8/IAt2LfaaH/FaCUjJm
         9djvXsu4wkaXJ5R1M3MieeZuLH4eHrXrW+Ra+QXXQrTjrhkIt9o22C6beS5ZTs1BTmJT
         /tyqx8nZQ5IUDi0agGDTOIMZaaV4+qKJpsk8nvFVZ5gbHyb2U/jtJAIyns6ha8cW4Vwt
         lFZQ==
X-Gm-Message-State: ALoCoQlfyTPEkI3z+995hXEdH4cWHG18qa04ClYqRYOU9S5IA8tOiTu0rk/v83J4yPYR8YeBM7Zx
X-Received: by 10.42.26.12 with SMTP id d12mr3254968icc.24.1407960910069;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j43si208464yhh.5.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E321F31C2A9;
	Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8D692E0AA8; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255230>

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
2.0.1.556.g3edca4c
