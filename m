From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 12/21] refs: allow log-only updates
Date: Mon, 11 Jan 2016 20:22:11 -0500
Message-ID: <1452561740-8668-13-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngK-0003hc-W8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761629AbcALBXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:23:30 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33949 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760548AbcALBWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:44 -0500
Received: by mail-qk0-f179.google.com with SMTP id t64so492716qke.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yr1CbD6VJr2R8/fKvmbi/mFsAxo4AZ3ViOOKwYgNLWU=;
        b=g1SFqnbBd7Ip9bZZCpzrgLLb1Pf+ISHmtTw39F5f1zcpx3H+C5FBOAXvdd/u3+8jwx
         VTf5mAGnqSjUN+ljz4Tx4nqejXRZDurS8JKbaMRK470BdcUaWhX+h3Fmvh/SyRoRi6I6
         tiWBNBNxYPDMDLtntnb5dSKXLmBowmbwRgN/giztKch/L15ZWYgxttwdRhbzDB2rxuQ7
         mohbMRXyAfmAE/+sEMp/xpc8PFRcsZQ77V3QzX9riJn6hn5RUb4vl9fdfP0f94xp8ube
         7aHtdQjnYuwDcHK6n2yAu/jDBPVucqNFMI87AGZRzkW/lg6LxLOtqhcdDW43dDm7b3L3
         uHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yr1CbD6VJr2R8/fKvmbi/mFsAxo4AZ3ViOOKwYgNLWU=;
        b=K/U0RHWTrH5Ha92BEIWY9gVgiCFVGRP43VAvBWYd9VWRDGqnNFL/lPfNCjQJpjkPAN
         lF2YAu4yLbNYJ4dYES0zm1kV4C2iIhMS0eCj/7LYBEqtIVNg10uAv7yJ7PaQSWVh0TSs
         XP6wvNp28L1khQWf92w6o2N/VzzY+vnMrGJMh7CmzOEWlQi6pqVlBpIYy5BioGf73fiM
         MXoHem0ORXg6RWrprK57HH4QcB78n2MD2OczKOFgsQxH46RPmani7Qa8Tky1s4jHEQ0Y
         ekfn3Yrpf69DXhWTlT98tpNMoylGW4W3aaACF2fNh2U3+K1Y1VDDRpKJN1P9j8BnblYx
         6QAQ==
X-Gm-Message-State: ALoCoQndzm/2WlzAu5ECDQTsfsBF2D7Mi3e5HGQunYHDJUgX9aW1fNHngp80pTLF0kP2GxwAcFD1OVaJkaHodthRf6aJRT2AcQ==
X-Received: by 10.55.78.75 with SMTP id c72mr165367924qkb.97.1452561764359;
        Mon, 11 Jan 2016 17:22:44 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283758>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 98a9958..37c26d9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2821,7 +2821,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3175,7 +3175,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3205,7 +3206,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags |= REF_NEEDS_COMMIT;
 			}
 		}
-		if (!(update->flags & REF_NEEDS_COMMIT)) {
+
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_NEEDS_COMMIT)) {
 			/*
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
@@ -3222,7 +3225,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3242,7 +3246,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8f5b412..82e44ef 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -42,6 +42,8 @@
  * value to ref_update::flags
  */
 
+#define REF_LOG_ONLY 0x80
+
 /* Include broken references in a do_for_each_ref*() iteration */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
-- 
2.4.2.749.g730654d-twtrsrc
