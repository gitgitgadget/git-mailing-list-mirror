From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 25/26] commit_ref_transaction(): Also free the ref_transaction
Date: Mon, 10 Mar 2014 13:46:42 +0100
Message-ID: <1394455603-2968-26-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcX-00082d-UQ
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbaCJMrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63700 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752786AbaCJMrj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:39 -0400
X-AuditID: 12074414-f79d96d000002d2b-f1-531db46acc0b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 77.CF.11563.A64BD135; Mon, 10 Mar 2014 08:47:38 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwn025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:36 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqJu1RTbYoOmtmsXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+Pvlo/sBX1CFevPGzQw7ubrYuTgkBAwkbj0VKiL
	kRPIFJO4cG89WxcjF4eQwGVGiW23+9lAEkICJ5gkJn+uBbHZBHQlFvU0M4HYIgJqEhPbDrGA
	NDALXGGU+Pz1FztIQljAT2L7znlsIAtYBFQlJk8IADF5BVwkGk9yQuySk5jyewFYNSdQePqV
	B+wQq5wlXu5pZp3AyLuAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRkjI
	iexgPHJS7hCjAAejEg9vxmuZYCHWxLLiytxDjJIcTEqivBPXygYL8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuHNXAyU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4K3f
	DNQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qJ+GJgVICkeID2bgNp5y0uSMwF
	ikK0nmJUlBLnnQOSEABJZJTmwY2FJZJXjOJAXwrztoJU8QCTEFz3K6DBTECDm49LgQwuSURI
	STUwmpe+qRD/W2KluFzDM0s37rJCyqqoqAjLn3YacdkiE84FLfzneO7Fl2+11fOFD8fkv/TL
	uDTnXc/U5dpSHH/X/D6cmj3TwOPmkrL1qraxxm0WV21ufLxhqP962YJPwQdu+bAw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243744>

Change commit_ref_transaction() to also free the associated data, to
absolve the caller from having to do it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c |  1 -
 refs.c               |  1 +
 refs.h               | 11 ++++++-----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index ffed061..b33288c 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -346,7 +346,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = commit_ref_transaction(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
-		free_ref_transaction(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 1fd38b0..d83fc7b 100644
--- a/refs.c
+++ b/refs.c
@@ -3471,6 +3471,7 @@ cleanup:
 			unlock_ref(updates[i]->lock);
 	free(updates);
 	free(delnames);
+	free_ref_transaction(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index cc24213..754894b 100644
--- a/refs.h
+++ b/refs.h
@@ -210,14 +210,15 @@ enum action_on_err {
 
 /*
  * Allocate and initialize a ref_transaction object.  The object must
- * be freed by calling free_ref_transaction().
+ * be freed by calling commit_ref_transaction() or
+ * free_ref_transaction().
  */
 struct ref_transaction *create_ref_transaction(void);
 
 /*
- * Free a ref_transaction and all associated data.  This function does
- * not commit the transaction; that must be done first (if desired) by
- * calling commit_ref_transaction().
+ * Free a ref_transaction and all associated data.  This function
+ * should be called to free a ref_transaction that will not be
+ * committed.
  */
 void free_ref_transaction(struct ref_transaction *transaction);
 
@@ -264,7 +265,7 @@ void queue_delete_ref(struct ref_transaction *transaction, const char *refname,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The transaction is unmodified by this function.
+ * problem.  The transaction is freed by this function.
  */
 int commit_ref_transaction(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
1.9.0
