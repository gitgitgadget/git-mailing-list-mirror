From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 07/14] refs.c: add a flag to allow reflog updates to truncate the log
Date: Mon, 17 Nov 2014 17:35:43 -0800
Message-ID: <1416274550-2827-8-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXiS-0000KX-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753481AbaKRBgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:13 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34702 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbaKRBgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:03 -0500
Received: by mail-ig0-f171.google.com with SMTP id uq10so190812igb.16
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZxUQ1sagDK+7JQrD0TjbNixxMs05BRArYVOsRcUdc8=;
        b=CYuzL2wdKRqtr3UFudFheGjEQkNXmOIiEFr02+oo6DEZgMs+bWbf0w70tl1y5lZiW+
         r4ByXPWSRSuu0H+UijdpbO6snr7BPFJgwuvelJZdVdD7d8cGMHBi8czZTFQos/3IJh5t
         UdvbPKucXOhPCdo8UAjVa7be7VGDjfeioESpq3CwnFyepeReKJMfRGPfNVXJZTPhtJB2
         FCgv8sneVb+TX6nCW88tQRDqLp5rTFX/vlemZeaISNzV1408Lpo9Vz3zbJZjKf3hyUog
         XhUB8rNr9AFg9VSOfV/UHv1e14duf0Oq+PxwKRBAIw1xUWn+1FhRakA4z1DU6l/gx8sB
         zHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pZxUQ1sagDK+7JQrD0TjbNixxMs05BRArYVOsRcUdc8=;
        b=ipN0UjJnUMdauBA27YO8IjrMPY7yNvhBZ23oKihggWNQCyATn7IEobXIC/zJYxoFA8
         3AmefS4HkTlBhkWobTUme7Jx8vztb52nF/IBq75PP4Ebfkk/cgJi5qZci8cDC2NkaBeP
         bAOQJQYCe5gZx7EvpTjgkDeO1d1f8s+ek0+5rmjo5AGIcf6LMig+d1mhkow57dhMazVJ
         wdYD955Ol2ThU8fzf/nrgNAVUasrYVHHTzIxQh8U5CXiwhH59BKZTYnlf8d0jnDRNUJQ
         s3TSEQyZLe0FLHd91/wKjfRGHWn+BJROcr6v7sGZQ7Obs2R3cXBOg7tRBkUfzItDQDtv
         rqLQ==
X-Gm-Message-State: ALoCoQkpb8nKnBd4WR3S2pREqVHKkVKUsTCYWbeXykhcfVvnxUhXNBLAzx1m91vMhjcpGau9jHdD
X-Received: by 10.50.117.71 with SMTP id kc7mr29787768igb.35.1416274562984;
        Mon, 17 Nov 2014 17:36:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id qk10sm6861032igc.12.2014.11.17.17.36.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:02 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add a flag that allows us to truncate the reflog before we write the
update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 17 +++++++++++++++--
 refs.h | 10 +++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9a46e1c..d21ecb9 100644
--- a/refs.c
+++ b/refs.c
@@ -3873,7 +3873,12 @@ int transaction_commit(struct transaction *transaction,
 		}
 	}
 
-	/* Update all reflog files */
+	/*
+	 * Update all reflog files
+	 * We have already done all ref updates and deletes.
+	 * There is not much we can do here if there are any reflog
+	 * update errors other than complain.
+	 */
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
@@ -3881,7 +3886,15 @@ int transaction_commit(struct transaction *transaction,
 			continue;
 		if (update->reflog_fd == -1)
 			continue;
-
+		if (update->flags & REFLOG_TRUNCATE)
+			if (lseek(update->reflog_fd, 0, SEEK_SET) < 0 ||
+				ftruncate(update->reflog_fd, 0)) {
+				error("Could not truncate reflog: %s. %s",
+				      update->refname, strerror(errno));
+				rollback_lock_file(&update->reflog_lock);
+				update->reflog_fd = -1;
+				continue;
+			}
 		if (log_ref_write_fd(update->reflog_fd, update->old_sha1,
 				     update->new_sha1,
 				     update->committer, update->msg)) {
diff --git a/refs.h b/refs.h
index 8220d18..5075073 100644
--- a/refs.h
+++ b/refs.h
@@ -328,7 +328,15 @@ int transaction_delete_ref(struct transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Append a reflog entry for refname.
+ * Flags controlling transaction_update_reflog().
+ * REFLOG_TRUNCATE: Truncate the reflog.
+ *
+ * Flags >= 0x100 are reserved for internal use.
+ */
+#define REFLOG_TRUNCATE 0x01
+/*
+ * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
+ * this update will first truncate the reflog before writing the entry.
  */
 int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
-- 
2.2.0.rc2.5.gf7b9fb2
