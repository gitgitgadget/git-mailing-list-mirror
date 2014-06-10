From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 03/48] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Tue, 10 Jun 2014 15:28:51 -0700
Message-ID: <1402439376-25839-4-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUah-0006wr-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870AbaFJWcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:16 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:61838 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so428494qcz.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Leprsv9ArDl3DDwWOHKQZeev4x5/J9nIOSEYIsRafbE=;
        b=hIJGA0ZOtqW18L1b+WVDBjYUXozdxsV8b3L7VBCOKLS2T7c4pNoiDiSqK1FtWy3Ipt
         vXkGYNcmvmqtBlW4mtszp2uTDZbRY/HCDBGhVepwI/sn6uM4uq11A1xAmjzNp10dbYge
         Zp+AC74QviebSwJ0zXpOoRjIxTQC88YYkqnlw81frIAFpEEv8NTj2VmxPcusJexi5vB+
         cLCBbzqlHrhxG1mz0EXoFSMmimJKWaouREsYmipfypRcgmOniJx/FmF/dqyjta92V9/a
         h9n40Wd19pKpBxHjsGOI3yHVcYx6K8o2i1aMdJlJ78YcmiR5dn94M8GUbN/fF7dxmLjV
         EPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Leprsv9ArDl3DDwWOHKQZeev4x5/J9nIOSEYIsRafbE=;
        b=fc08dvfAN/FK24RJfNcjNLEq/NZVNeJLrDzf4EpzdKwEUNILpuJ6SXSY3vPXsE8ffQ
         n8RNoWPtNlj7nCPR4U47vU6/Ue9xZXtieCLBaJpBYk24HyfahwzpiZE/W2/QVhJlEX5W
         9M6haWn58GKLyuUi1WvPETCujg6O0GvA0yLRhChbUB9wZV/jowrLSeW7QpwI/CAItthL
         XoPvesO+k9E7/CegMP/jhljKfchpnlovzeG7d5zccS+o29SxCUffPd3ZEVriPFtw5Fby
         M8XknEHvOYIbzGwYPHPZkK0bYce9coYa7gdSvqKbxKIQ7ti9sNMOdrJUSuVywT8PRT7k
         t7Fg==
X-Gm-Message-State: ALoCoQk+tI7b+8XoSogJGWQ4CeWjWagq89vkUB8Asmf6knI6HepN4cH2yBH/NUuug4cJTyEW8Wbd
X-Received: by 10.58.227.10 with SMTP id rw10mr16609343vec.39.1402439380189;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1396410yhg.2.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 0EBEB5A473D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A8337E0B27; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251297>

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
2.0.0.574.g30c2c5e
