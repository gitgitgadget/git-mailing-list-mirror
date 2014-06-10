From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 23/48] refs.c: make ref_transaction_begin take an err argument
Date: Tue, 10 Jun 2014 15:29:11 -0700
Message-ID: <1402439376-25839-24-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:39:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYW-0004uB-9c
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbaFJWaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:06 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:60727 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so178421pab.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WnwYbZfw7NGqSTMhhjIxrKdkd9SbF225LsB6s8EGrCg=;
        b=Wx+wUkA7whQT7nbT9cKehmf2Zvf1c65DVYQfIXQ5PH/0/NcNMM+4I22TUhn6z2Ty8d
         V4gOlD9YyoLEekSh0NbR6IvRBsR+ZbIAvsweQBuo3RzUR32lKJT2NAMFUHcDQqcDbAkd
         hkKd0dbAcTfv81xQxPBtc9tFB6IDyPmyuO4m/rH5RTkUWiqyNcjkvMJkgJ+z7Q3h0gYW
         gGW6v8slwf0aTFkgOqSHsWls2QeuyOxRpYQW1hvIX4UiSEJzj2J+jxnS/yLqguBqSwA/
         D4WmnLqh2mS72V1Ogi4Uj3K/mpjQtN3z1cbIHp/yKwU8UlwKFYvQDvlsZx0FW1vq88e9
         cYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WnwYbZfw7NGqSTMhhjIxrKdkd9SbF225LsB6s8EGrCg=;
        b=eUg5h6guhe+sjU1JTQzWlnxSt+gagm0Q6ttSfbxFzhr7vzwrRB1OYK0U8LJU64OFbi
         Z6uzEt6M3cmy42CGWVkvWEqv4VQr/S+TK0/wCgA7YndLw63d9kKwML5Hf+sgISmZrwGM
         /Wceu5THjiWiHdl7xJx1c6QUYCmzUuOgcMJ1rlP7Zr8mP7pD9V5tW8AtXDoo15Q/KKdr
         D/7PYRELBs4BDUasgGlFTvCizGy315IkiOo3bv4FCRI0DnAlOv15XinAsCIRTqcXzqQ4
         dhYzNSRiNWanA907791aE+4qZ8qYib5Ib6eqkQoet91QV7/xBCao/bZlJWHZd2THJHDb
         R9fQ==
X-Gm-Message-State: ALoCoQkRH+PN/bEPqL6wEguwpim6Q+IUxPoyXhoicOPNwLZHGdQUECMqOqrd3C6iTelVEGlOoB6m
X-Received: by 10.66.137.105 with SMTP id qh9mr3835416pab.30.1402439381046;
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1396413yhg.2.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D836D5A46F1;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A29F6E0FEC; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251296>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index 115fc4e..e120b39 100644
--- a/refs.c
+++ b/refs.c
@@ -3394,7 +3394,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 193c818..c27467e 100644
--- a/refs.h
+++ b/refs.h
@@ -265,7 +265,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.574.g30c2c5e
