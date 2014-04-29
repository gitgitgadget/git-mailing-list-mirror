From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 01/30] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Tue, 29 Apr 2014 15:18:46 -0700
Message-ID: <1398809955-32008-2-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:19:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGN2-0001Yr-In
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbaD2WTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:21 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:58388 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965256AbaD2WTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:19 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so201959iec.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vZDRsmqCtLEs4Z9voFnJHC/28qdnsh5tMa4aPBvNVh8=;
        b=YkaEWgBtFtRbYOuBjNS0alhJ3wDuhNS4EVjnt0Qt7VtqOY+vthjMMVCKCMzFiJlz6f
         pItuMurCJUddb+oA17PQ0Gx6Ugurp0fWkmR9ezA9GEeF2G7fo/98wIRKKEm339NLb9SN
         ioEoJW4qe/nw0ixB6tXHJxyUq7ITYxOtC37Yt2VM4A0KcsWQH/FAMtEdsOjZQp+Urj6K
         LkfndPaOJnGOra0xNdEwBeWCAxO8sze7Wvfxzchcj1J/zLhvfuTEAIhwC3lV8KNb7lg5
         g0ANevdB8ruaS1tBgNQdQb+21ZOPJnXioXJRD+qHdrYsygcrLD48U5uBHFag+28ZMj5H
         lNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vZDRsmqCtLEs4Z9voFnJHC/28qdnsh5tMa4aPBvNVh8=;
        b=Lrf4GCQmG4Fsxc7kyBuwv21JgVovbf8/Qq3iwcxeOZ+mrfz29/PMSOLbL4EaJIsDBb
         XNTePVJHMSbXIIzrLGm/DT2I3X2IuAClzO+Ojf5R+3ASd0ac3REvdIcxHjfrmudmE4Ts
         un5xx1CKQ9E09W3kProqkMynXdsDg9h5TSv0JZ1tJBN0+wrJqUF4y1jRtVEC1Xd7y0EB
         iwOeDj1eduadmJh9SmZ/X/2PYjJv+dgp5pMfoLfV0WavdDNJKljGv2TnYYxDtRNBWuCz
         RH9mYToqvahPpe8jarCh/QyaTCaLGzA8RZ5uc+rjIQqWA/O7s19Nk+ilO6wBLzCcL7bD
         YJoQ==
X-Gm-Message-State: ALoCoQl+jAHTWpLLUYwCq86JU3IzAD4XYtiN8X/csqwsGTCbrQF9ImJi76BESL37i/u4mcNDCtWMGJzvRSFVVaIOIPH0FAkDKvk16Igtb5Zhfcd651X9ixuEB4o5YOM0X3PloY3T+gOPDex4WKb+s5mbJ9TK1/DW0BwBtXyNGYxkwpfIi9qNx1If56kyuwWORe3EcmWZ43io
X-Received: by 10.182.125.4 with SMTP id mm4mr246887obb.49.1398809958309;
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2739341yhk.4.2014.04.29.15.19.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DA02F31C1D2;
	Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 86601E0B2F; Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247627>

ref_transaction_create|delete|update has no need to modify the sha1
arguments passed to it so it should use const unsigned char* instead
of unsigned char*.

Some functions, such as fast_forward_to(), already have its old/new
sha1 arguments as consts. This function will at some point need to
use ref_transaction_update() in which case this change is required.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 ++++---
 refs.h | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 728a761..138ab70 100644
--- a/refs.c
+++ b/refs.c
@@ -3329,7 +3329,8 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3343,7 +3344,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
 
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags)
 {
 	struct ref_update *update = add_update(transaction, refname);
@@ -3357,7 +3358,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
 
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
 	struct ref_update *update = add_update(transaction, refname);
diff --git a/refs.h b/refs.h
index 0f08def..892c5b6 100644
--- a/refs.h
+++ b/refs.h
@@ -239,7 +239,8 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  */
 void ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1, unsigned char *old_sha1,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
@@ -250,7 +251,7 @@ void ref_transaction_update(struct ref_transaction *transaction,
  */
 void ref_transaction_create(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *new_sha1,
+			    const unsigned char *new_sha1,
 			    int flags);
 
 /*
@@ -260,7 +261,7 @@ void ref_transaction_create(struct ref_transaction *transaction,
  */
 void ref_transaction_delete(struct ref_transaction *transaction,
 			    const char *refname,
-			    unsigned char *old_sha1,
+			    const unsigned char *old_sha1,
 			    int flags, int have_old);
 
 /*
-- 
1.9.1.532.gf8485a6
