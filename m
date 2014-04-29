From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 02/30] refs.c: allow passing NULL to ref_transaction_free
Date: Tue, 29 Apr 2014 15:18:47 -0700
Message-ID: <1398809955-32008-3-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:19:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGN3-0001Yr-42
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbaD2WTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:22 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:51441 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965257AbaD2WTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:19 -0400
Received: by mail-pd0-f201.google.com with SMTP id fp1so162031pdb.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wYR/EM1e93fwoPOQS9quF38NQePlReOmZO8iu5AcWj4=;
        b=Vlo2iHAt7nL6c2vmYXiKb+NUPT5p1p5XFbp72jm8urGzgtlHY+qpLwQ0oNJc6UP7V2
         wXZCvJK0Gkw35mOwmQdJmh4e5uLvmTLa2tfPtwDj/G/6/NYZTh1wPHMpsRCobTekpcFz
         L9Bjo9Hx5KEcJzGDUhToMIAlmLcsZXT46Ua1WtV2OXNaqOK9U5RBPm3PxBuNyu8rOkmm
         EiCZghVCHGyp1hjPvWZRjkEg1xd70V+jhizqzKcWUloo/87KvUsvF1v4aV7dpBALhnjV
         ZQ0YtI2ijo0aTm2oWPdjY5e1oXhlEcydMP2QKZGKDbip4Xs5JXD9lkA6L4SGUCyWZxHi
         4dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wYR/EM1e93fwoPOQS9quF38NQePlReOmZO8iu5AcWj4=;
        b=ehgdcOIkIuVZSf7FmHnI39kEwMclDTods3RvS9RTkWTXai9tPht4Im0cHRvpKRE1lr
         olGddQWF7vQh0/zv2zS8daUFgoFVJMNNiHfi786Eh666Ekso2YMue15vga0Rvx0eI41a
         /strnWyOBYVUv2WebV0mNOiWHEKaFuc0tQCi3tqLQOPKq82E5J8dIxWf3qeN0dujQfcp
         OtO1INBewjOZdeqekvaDSLT6aN+uAbEG16R2DAnXncI7gtGiWpPU8WcWmANgYaCq2Ld4
         P0xre8bHFP8Mdh24TBZ5uqBIwpkIAJxAjpdNuVHf2fgQHuSHkgIAThpFrPQP+jeBYdbq
         c/mA==
X-Gm-Message-State: ALoCoQlaTgMqNXTJR6w9Z9ts5gvPp1YJb9z+gZeAlXzzsmFa+xYEHpgexlc5DV3wMrFMRTqhpGFP2pFLmQmwKgWqSIHk2d3sVcP0GmX38QIba30Y6GSFPN8XPE3m5Kd0OkdXdYIPsOLWbHyaAvNCmTEmcQqI8/ezJh7zX34sEmaSUxNjRqN4pEdn4VvavUkae8jr7iFvSv+K
X-Received: by 10.66.159.36 with SMTP id wz4mr349573pab.14.1398809958294;
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2738464yhb.6.2014.04.29.15.19.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 21ABC31C20C;
	Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 00616E0A5B; Tue, 29 Apr 2014 15:19:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247628>

Allow ref_transaction_free to be called with NULL and in extension allow
ref_transaction_rollback to be called for a NULL transaction.

This allows us to write code that will
  if ( (!transaction ||
        ref_transaction_update(...))  ||
      (ref_transaction_commit(...) && !(transaction = NULL)) {
          ref_transaction_rollback(transaction);
          ...
  }

In this case transaction is reset to NULL IFF ref_transaction_commit() was
invoked and thus the rollback becomes ref_transaction_rollback(NULL) which
is safe. IF the conditional triggered prior to ref_transaction_commit()
then transaction is untouched and then ref_transaction_rollback(transaction)
will rollback the failed transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 138ab70..2d83ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -3303,6 +3303,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
1.9.1.532.gf8485a6
