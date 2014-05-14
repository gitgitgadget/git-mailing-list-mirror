From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 02/42] refs.c: allow passing NULL to ref_transaction_free
Date: Wed, 14 May 2014 14:16:36 -0700
Message-ID: <1400102236-30082-3-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgbg-0000M0-44
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbaENVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:24 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:64002 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbaENVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:20 -0400
Received: by mail-qg0-f73.google.com with SMTP id q108so11389qgd.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BxtEJB1GUdNQ7vI+yQZhKs3kk6YtYvWfZXLrOE9X2w=;
        b=IYikBt5YkebCNtutpP4Ur7bbZ8zrHF0keN7QPw7StHa3PPDtc5qfidzq9UYSEip48Z
         ES08d/BMYq41R0WUwcZg2H7lqAoZ0FLVbP70ftE0t95nVLy7at4FGhMZKDAbY8qgrunR
         Y2OfMtg/Mumpq6orq3bmwUSvQKikA9zYGleXitjbMn3udSK4UGxbD3jzuc5sxvm0UKcT
         tm0ELw877/5pfW3nU3E55vbdH/zxKTfLGISsnEVXOKEQm1ayCw/UFHRN1CUyQbrqsLZ8
         YEvqYBn9dKPk2fgHg9NxwgthWf8gxUX2uuT3hbLbeZcwtTE3plH9Kyzj+1T5GDDlvLyG
         a9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BxtEJB1GUdNQ7vI+yQZhKs3kk6YtYvWfZXLrOE9X2w=;
        b=GnLuGV/smHZlsBqaTZzFme3z3/7XU0CJlCe9BfVyKVTy8m2YxJ74qE5yPr9+xgQpMb
         gywPbUsMCgnC4z/sCWTNIbw9ByGcbE0xrBZ3EOwtDcYPSRnn9AMPs1dvGmerbFKOtcqm
         5DVem3uGwp0TpPfka60bUrQ6eK+L+pnJ/gUYx56ykWdMWour05Lwe2O/MFWTj0bOzKDF
         EShq35j2M6G3XfsaM5dYtG6KyQuQcnkNThhVXSWDJfz6PFoALUDiVK3fFE9XZehG9B9o
         mccrKMq8hw2mnJsKRH2j2ZpHtjI84KC8b0Q7dcLyeQC+m5wDWIPHbT0gjelLWWC4RoWv
         e02A==
X-Gm-Message-State: ALoCoQmAHjvVgkOdUOP8JQMfNbHMhKq7kvrBbZYvSnEkp9MmY83AUYpPuY/8REcMV928h9yQe0j0
X-Received: by 10.58.95.98 with SMTP id dj2mr2834397veb.30.1400102239832;
        Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si145893yhj.2.2014.05.14.14.17.19
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id AC42431C1F8;
	Wed, 14 May 2014 14:17:19 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 69929E0973; Wed, 14 May 2014 14:17:19 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248983>

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
2.0.0.rc3.471.g2055d11.dirty
