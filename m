From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Thu, 12 Jun 2014 10:20:53 -0700
Message-ID: <1402593699-13983-3-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8kD-0001QS-5W
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbaFLRYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:52 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:37143 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-qa0-f73.google.com with SMTP id m5so245557qaj.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y3S+khPisqyDkHjjwpqSBRHH313MDjuRU52ZNMIIwkk=;
        b=owo6W7UwGjalDIAJOMk8ybqV9tVpkmuxbLNxCf8K9YVLT4C3XRQBoHQd/b8ye4rGt5
         ggUejyeEy2HzWn7tyxU2ytZRyQn+c/6xzcjnQplZMRCzCzReqOdZxrNpJBYLjQV2rAc/
         +gw/SrgykxcPst0HPao4uYMZyfYhceoV3+lWf4n4/rNGxsVrY/Ibu+W29/Xz2Xf9BazP
         mGwwJaCsZQ4V7PJVU8qbhec7E/0G7gfvpsONMReiUySRt3+Ep0+MaU86TZgj7G3+QEc0
         kPz8VzCfLdA2EjlvwnxwbUi2Kx/vY5xsZxYNCgWkZXX/T0v8yGdgr1oco1c/JooSB+0S
         i2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y3S+khPisqyDkHjjwpqSBRHH313MDjuRU52ZNMIIwkk=;
        b=QM5WhuIBj4uz82WC3knRK6OC167b4jw8IUS0uqu+VLgKah0t5V5YWXYr9NTypAPx3V
         mNIPksrM+T77c4M2R3ACGQGmyws/nAXx4fVJcG2g+Fjzvuqht+tIeQ+9oEfJ2mR6C6h5
         9xJgwSIdLDMiaUkl/jByxtu+cmVPYaswAqNt1O9C1m86EBAmKYLrCxaBWk+lUPzPR+bK
         JEfNF/S+CcZtPHoFZ9XHYzr/aFhvwnmS+CrGzb0k4scjMXnoxdoSmQ27PjXHmHAU4P+X
         HFBEnayGc/r6KyLl06/jab3OoStEQ3ZT/wtBpxX+2urB85fyeGTMhbj8JexuKydaFpAT
         cZDg==
X-Gm-Message-State: ALoCoQm+QZoQaHFhB0Rpw3ZUrgQ6C++7tvE82LPRoEQuvK1fUEbFLN5S4NR9DJMrHvD6b+GtVJVF
X-Received: by 10.236.229.161 with SMTP id h31mr148616yhq.21.1402593702799;
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si113009yhb.3.2014.06.12.10.21.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9A24D31C66C;
	Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 47B5FE01A0; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251462>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 48573e3..33541f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3483,7 +3483,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a07a5d0..306d833 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -265,7 +264,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.599.g83ced0e
