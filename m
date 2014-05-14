From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/31] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Wed, 14 May 2014 15:13:00 -0700
Message-ID: <1400105610-21194-2-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQg-0005uL-0C
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbaENWNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:34 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:60512 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbaENWNd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:33 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so51161pbc.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PxtWRLHxtJiZPef4hSTLD8MeqOIV01hHkmMAAOj2V60=;
        b=Om7Sl4B2l1dvXyuI0ZS0Rk9i1xLgX/BXFeO8J7la8l3BCxbBSoHo6YSIttI31fKH0J
         WZR33Hw6rEtc2blHB8m80CfmgUJi9xt1AI637rEx4R2PT+fl3b35GojjRnf/uwCnKucR
         R7GOcwwlLbTAHJcD2zgnGj3w1X9hXZ/7yqJag5ZvIONbLhNSn24S8GHQmcEH2J/SN4vN
         pZS7RjjWISvCqjYY47swULRoDH82v4E2WTNC75tDaDxtIg7E6UaBnJkK5M2E9+suP4zU
         8IwswJx/z55Bsj3EjUBc6zTG764W+MN5vpDYaGsYcU6hC5AGWSsJuJSSYaBtanCkHzL2
         WwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PxtWRLHxtJiZPef4hSTLD8MeqOIV01hHkmMAAOj2V60=;
        b=L1z07mCyX9wxPRUQyh8UTr016bx8C8Gqx/eJsPO9+/DVE/l9PFFKAztbeGYTW3UKCn
         6aQ2qcuHycCTGy0DQTp6Nm90xW599MuefI0Zc7rsCrHlM769CNbI/EahKEAL25GgqbJa
         jSj2YIwlz88yg/ugm4uJ12QbT/ZxEhZiykuD4OrhpKT0/Yf0RL/4sf6MpSL6pKdn0hiW
         152fSBHlT63RyM+j/GNW5HuEg8Dj7qWpR/2d6HGbE/X7HplLhGeYF9T2tDi7CYpNnsSn
         aQk7MHsf2PBC3v6gPUx8Zk0ZD7ctr4+sNZte3fsI4r9XTm2ebf9VXM3lKZaz9NahtrlY
         xMUw==
X-Gm-Message-State: ALoCoQnITAlm7TzEydjtXL0GrKgA5+NENkCbeGbJtrmrpEgDG2IPAeUKO6gbBtEgYSpnbgGP9kFN
X-Received: by 10.66.149.67 with SMTP id ty3mr519427pab.27.1400105612628;
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si78032yhj.5.2014.05.14.15.13.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 714B45A41E5;
	Wed, 14 May 2014 15:13:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 246C9E0973; Wed, 14 May 2014 15:13:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249008>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 13 +++----------
 refs.h |  7 ++++---
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index aed700b..fe195dd 100644
--- a/refs.c
+++ b/refs.c
@@ -3354,17 +3354,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		die("BUG: create on transaction that is not open");
 
 	if (flags & REF_ISPACKONLY)
-		die("BUG: REF_ISPACKONLY can not be used with creates");
+		die("BUG: REF_ISPACKONLY can not be used with create");
 
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 2d2362c..d615871 100644
--- a/refs.h
+++ b/refs.h
@@ -233,9 +233,10 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or zeros if it should
- * be deleted.  If have_old is true, then old_sha1 holds the value
- * that the reference should have had before the update, or zeros if
- * it must not have existed beforehand.
+ * be deleted.  If have_old is true and old_sha is not the null_sha1
+ * then the previous value of the ref must match or the update will fail.
+ * If have_old is true and old_sha1 is the null_sha1 then the ref must not
+ * already exist and a new ref will be created with new_sha1.
  * Function returns 0 on success and non-zero on failure.
  */
 int ref_transaction_update(struct ref_transaction *transaction,
-- 
2.0.0.rc3.506.g3739a35
