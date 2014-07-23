From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/15] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Wed, 23 Jul 2014 10:03:42 -0700
Message-ID: <1406135035-26441-3-git-send-email-sahlberg@google.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 19:04:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9zxx-0004WJ-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbaGWREL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 13:04:11 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:38549 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbaGWRD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 13:03:59 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so404348pab.5
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hXWE3saRA4IWdf/ksLF0Wn+YF8RU1UbSzrNG1Kar2M=;
        b=KZGV/dIjtU/SWriLmiQEXZOBXbhyJ8xTwjBrw3uQA86jo24+oTX+TdWGbp3lZeqvIO
         eeyEWbZhUstMnbcqeF8iAxIpNZ/3mycj+jNMDyzA35wT87JGzCtsE7tpx6JGrOTqduJR
         3KiCn97jh2faU0OmY66kS9STRxpiC7HfcXex5d9AnEXDy+l01RdFn7/g6juLX0DjasBF
         aeMNZXYDEmHoMlYjH9oHHhzTAR1xc9az62191cAHgG53ZSE6c4boHo2lvjCmOVhzBGzL
         7hJTNODjcH2DDNy18G94b4OaQpxU4sfqFni2q+HRrLD+6TTREzjYJw8f5I7Z7Kl8CCii
         jEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hXWE3saRA4IWdf/ksLF0Wn+YF8RU1UbSzrNG1Kar2M=;
        b=KoV6WHCW2LcU7smfJsdYZ79ZABTbo8Cj0CgdmiTtIHl8ucdGMDpkJRxEAiR2wNzo77
         1YELmMbuYecOpTUsOxuKtKHAPYRyJGTs9CkmbHDcUZh6x/XaRlAzromc/Il6hNfoVGog
         W+dhqMkC+R5hAzHxL21XXgID4e6h+z+i+7xniUNfeI4Lbv6LNEb1VStPwQ0ZrqPW3SOk
         rJvDiXkBNmIdhDd1NOPVHDIzWD45BRtqpzBkE0IAWaCjRdHw9AB0huNn2A0UQ3AqxkPg
         i9+vIr75j9ZYdaRZWftpxD0xnNCgvMlKRjSuT11hi0nuqvP+SJkyA/j7gNEGa2qCqxD6
         Ta3g==
X-Gm-Message-State: ALoCoQmyhQBQVwcqriOjkgmv6tfKXwADOrwCxudC7ACnfpNzr0t4WR/6o7XLArUsmosqbqezEKsy
X-Received: by 10.66.102.68 with SMTP id fm4mr1218135pab.27.1406135038572;
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si486786yhp.6.2014.07.23.10.03.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6455A31C34D;
	Wed, 23 Jul 2014 10:03:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id F0EE5E0AF7; Wed, 23 Jul 2014 10:03:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406135035-26441-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254086>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 17 +++++------------
 refs.h |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 8f2aa3a..74fb797 100644
--- a/refs.c
+++ b/refs.c
@@ -3506,24 +3506,17 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
 	if (have_old && !old_sha1)
 		die("BUG: have_old is true but old_sha1 is NULL");
 
-	update = add_update(transaction, refname);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old) {
-		assert(!is_null_sha1(old_sha1));
-		hashcpy(update->old_sha1, old_sha1);
-	}
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	if (have_old && is_null_sha1(old_sha1))
+		die("BUG: have_old is true but old_sha1 is null_sha1");
+
+	return ref_transaction_update(transaction, refname, null_sha1,
+				      old_sha1, flags, have_old, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 1c08cfd..f680b19 100644
--- a/refs.h
+++ b/refs.h
@@ -275,7 +275,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true and old_sha is not the null_sha1
  * then the previous value of the ref must match or the update will fail.
  * If have_old is true and old_sha1 is the null_sha1 then the ref must not
-- 
2.0.1.508.g763ab16
