From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 02/44] refs.c: allow passing NULL to ref_transaction_free
Date: Thu, 15 May 2014 16:14:59 -0700
Message-ID: <1400195741-22996-3-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:18:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uh-0000ye-B1
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756378AbaEOXR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:59 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:51090 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so348666pbb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89iWhYSvNifUS1snqB7A2wfCwW0ix+Ku6vmPk3JmXcs=;
        b=ceBmYknx5BXfWBCZsPHt5UZhl5DVEmaU11PQzhQMBab/jn/xitvY9h3KVMqgngK6ZW
         PPxLdOYd8VpN5DZgjNUqTQx+PGCXGS2twC6vV4RDh/niqg9wB4HySheWJbpFtCYiEjw1
         JMJIEX63RQLy7zEuY14iKu/GipHnaEXm5jHOPfl8IxhXz36FxY16y7kYIuUj+sCsm96g
         w6ols15u1f25Q3bDd72WeJDWkc+mREPk3iU+OQwQbz+KhM6bMzqD+QQtvMNLw7DDChkv
         jxAParohARnEXg5Xg7wvpXiJnecPHk2pztX5xeGC4/Ja/CTUZlStzZIkJgMUHm4UaD/W
         qsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=89iWhYSvNifUS1snqB7A2wfCwW0ix+Ku6vmPk3JmXcs=;
        b=Q15uQXbgfVUSmmkTkH0h7awOUXofW30iik64KZq8SeU9OXEuCqpDNrBNiHtYuUrgV0
         3sILs7Uasakc5jFAG5n8zo1zUZk8zcmOR1LSoyIXQgjd8UK/AHtWPSmsMMUVs3GFaY9y
         XfjKg1SX8iTFEFiNcZSP/kNkfOe5VpdBLlw/QiU7oQlPnlgBF5z8nJc0c1swGK6NHd/J
         DssCJwtTqr7NSvI65gyFkU+9Hb1BoXMTYb//avNN5CQgWh2ewSOP5UQb3AKfoenStNVx
         CPeQ8I2L1jyCYYO84+ucRLHnCeQvJSgNPTv6cOqfo1RqodNqx4ZhxOpExI23CZZcJnkp
         AD3w==
X-Gm-Message-State: ALoCoQnRQEQexd8X4IxL9dlj9r+pRhUjfpYdgYE/BJqLufrlVVzKvG+bs/IqaEXIrSc0lIStrJXq
X-Received: by 10.66.157.138 with SMTP id wm10mr4172957pab.23.1400195744605;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si319596yhj.0.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 68E5631C1CD;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0F33EE0D39; Thu, 15 May 2014 16:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249264>

Allow ref_transaction_free(NULL) and hence ref_transaction_rollback(NULL)
as no-ops. This makes ref_transaction_rollback easier to use and more similar
to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

This allows us to write code like
  if ( (!transaction ||
        ref_transaction_update(...))  ||
      (ref_transaction_commit(...) && !(transaction = NULL)) {
          ref_transaction_rollback(transaction);
          ...
  }

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 2114748..88d73c8 100644
--- a/refs.c
+++ b/refs.c
@@ -3312,6 +3312,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.rc3.477.gffe78a2
