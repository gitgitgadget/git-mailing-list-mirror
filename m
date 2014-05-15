From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 02/44] refs.c: allow passing NULL to ref_transaction_free
Date: Thu, 15 May 2014 10:29:17 -0700
Message-ID: <1400174999-26786-3-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:35:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzYb-0006NE-9w
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbaEORcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:22 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:36212 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so240873qcv.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5+qe/MKpGsJh5F4EWbYx560xYId0B2yXDKQfd2EhZY=;
        b=AmLfJkXae1+7FnTn4QR7vt5YQVxh1azfreR5Qze2/xtbCOG51p7kLX+bvbe9Skl8OP
         6JV/O6SDMJPG62Efv4mV8GZXWVooS83RUJ4D2xvQBeorS3+UyhedUmIs+0gxzcccUxGa
         2g1mfSa2cKt9A552vSwC20oLaPLo+WJLanPXrjuzUChhswYuXACPAbEB2Exyl6ZPyxWw
         qSN4Tc2Mqj5ufBpRZ5dCjnoCV2tljQ5P3BRJB5jHyJ6IDEiBsnfg6aN1/dt6QAeBODRc
         qXnQfaJmj2Zu/ZitgaqA1w+OPd2P0gyEjI6SSM7WkU9paZ5JMb8rvVi8CAN6ehm5dnDp
         ozOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J5+qe/MKpGsJh5F4EWbYx560xYId0B2yXDKQfd2EhZY=;
        b=W9SG1/F8yFTRmluzRf54DbskfkpS+FG6xQZZflII5r3B1JUmq7LRDyimSJONTvkp6L
         U3gbe/hO9wwlf95ycea6lpAyA8j52rh3TbfGYjnZUEIJq9zXDYv2QuxynZ7ouMn7q1UE
         Mys8fjR2NFor7OAZ3tlMplSzEgiZsGNLHVc9FprwE6rBDpGP0UNveVUHgM48Lr1sbxNg
         4UwYmPH+2StV+V+JlSxPJ7OHl9uy/svk3FeVCDQ6WuyDBb+5rSgNYefCkIykrXmoVWfo
         BpGd5MX6slvNK6FZ8s+SKy7jDutvKLjel5K5X9CcV3GjNUtuZHbTVS3PspuZKArojPbh
         XMWg==
X-Gm-Message-State: ALoCoQmpOEaw+HAy6fIoIZusUxzPAjA5A/bvqcbaaVgn/vjQmiiR4RHgOFk2MSPpsVP4cvFAEkAh
X-Received: by 10.58.30.78 with SMTP id q14mr5474220veh.10.1400175005921;
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si273662yhj.2.2014.05.15.10.30.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C0CA131C239;
	Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6FD9AE0B2F; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249166>

Allow ref_transaction_free to be called with NULL and as a result allow
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
2.0.0.rc3.477.g0f8edf7
