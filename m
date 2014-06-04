From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/11] refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
Date: Wed,  4 Jun 2014 11:57:43 -0700
Message-ID: <1401908272-7600-3-git-send-email-sahlberg@google.com>
References: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 20:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsGO8-0007zq-61
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbaFDS6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:58:11 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:51697 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaFDS6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:58:07 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so1108603qaq.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ppB/AUF4W9i5RIScRNpaBti89bYDX8+3GKfmec9GuHw=;
        b=kV60XjDJoxJuRKLaXgcT6CYaOhZjavnAgx6B9IoSX+6TJrOeckO1SVuWr3qk1cavow
         7nrK6r6/u30EuGl5+Y+uN3S37qy0yN3cYx4bL2LdgYa5M6NgqMFr4xvgRWyZEbdt5xD5
         grS6dGArN9WFoIN+2fhqDSrZb7oPnXOLen8FxH34vjqq1rFEYBrGAIbFQt1Uo6bG1M5e
         zJlDV1ok7FzPDEuLPJAoo8QL/Eh55hjpNZWb7+r7eVkBopb14m36iMC6vARZ8I3Ltjpi
         DjgEalRRPQ7aKNLyTDJi0G3MqJLn7nnVtf77Y02h7fvPXcgn4QSTpgeOFiAjY/R+WpR6
         ZpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ppB/AUF4W9i5RIScRNpaBti89bYDX8+3GKfmec9GuHw=;
        b=VFRxLF40nXLc8IKXxvlz6UZ8DAPLgvZH62ImoxyvSSNKmii+exz1MhkqMMnAOzQ6no
         rnOOMXBHCSSQqVKYrzABAo7n0vH9zZbCWMyNTQ6/W187q/FsFGMnFYu9VuxNQM3qKLow
         /xYXAoiyaY9gdw4oPWCm81d+fRjd1COpabE+p4QhBqZmDzifMHX4OyDFyKUvV2MWyJIF
         JCHaGIc3mMvUR85cJ67Ad4erhn81EMVNwpUvPSarTT9YKfihA0iMNWrOaIq6cJlFHuL5
         UKIjxlHpNYXzmFkHMb9ZQ+RkiFhsyttQuWnCqaY0ZdlO9dPo77c0WybSGSahzwOWWI23
         5eVA==
X-Gm-Message-State: ALoCoQmv9Wrgo3SMSr0pe44r7e/yBJSg7TBDOK1EAbTvxgPpHoSVvpbOs3p5IMNXcR5Wo1X1/Z7l
X-Received: by 10.236.133.43 with SMTP id p31mr19124192yhi.43.1401908286672;
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si332814yhe.1.2014.06.04.11.58.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jun 2014 11:58:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 86AD931DBF7;
	Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3714CE072B; Wed,  4 Jun 2014 11:58:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.578.gb9e379f
In-Reply-To: <1401908272-7600-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250760>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 refs.h |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 2dfedf4..0c382f3 100644
--- a/refs.c
+++ b/refs.c
@@ -3482,16 +3482,11 @@ int ref_transaction_delete(struct ref_transaction *transaction,
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
index eedddbf..02bbc21 100644
--- a/refs.h
+++ b/refs.h
@@ -272,7 +272,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
- * the reference should have after the update, or zeros if it should
+ * the reference should have after the update, or null_sha1 if it should
  * be deleted.  If have_old is true and old_sha is not the null_sha1
  * then the previous value of the ref must match or the update will fail.
  * If have_old is true and old_sha1 is the null_sha1 then the ref must not
-- 
2.0.0.578.gb9e379f
