From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 12/20] refs: allow log-only updates
Date: Thu, 14 Jan 2016 11:26:09 -0500
Message-ID: <1452788777-24954-13-git-send-email-dturner@twopensource.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:27:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkk6-0002cO-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbcANQ1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:27:18 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36317 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbcANQ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:45 -0500
Received: by mail-qk0-f177.google.com with SMTP id q19so251873786qke.3
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nZPvce+LjbAao9R+sC8JJP1urbMy3FhRl2es0rrMXDA=;
        b=RP9I6tN5CbVfToMTlHWhogzj//ny7OkbQirABjrObrVpCQyVUZnjKpSe43dinZwhlR
         IKX7B4wJVyGmvNZcRztjz7x93OY1yQMyt2znJt3P2IVeMbRvBmKbj0edIyp0k8D6pOPq
         cgX64J3EAECssdsMZws9sKqE1hRyFV3qEWY5TTFh29SQjHULAQHbQPSQtX8I6zvvO8Hh
         mjwl9iFPrsBNkaconyQ1Pf277LRVOVkU94wxsdOJ8oYOVpBtX+nsHvZsVT4EZFev3smR
         A3DNF834bkt9rYpLOYV0xR9WzLpuF/zxpd99tH9Tc9uH13wDy0ivm7b1BqKhFiIxIRLF
         hkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nZPvce+LjbAao9R+sC8JJP1urbMy3FhRl2es0rrMXDA=;
        b=KMj/8gEnP45wk1XmPuQjbO7FkJ3ilBmJnZovf7Rfx6YVsSlGjSAr43gqZZNsTZoNC9
         y95F12AxkLF2iSm5Cwhb51CL2RQ3kGcxkWgjj+Kg9EiDuds6BILT8NCgFp/q/MQ64RpG
         zbNbMbZQXwWIly74zpX8Va4KZvfRZNjfGnHTfFYEZPv0F+JDCJvk2dGyJfQXTRRTDTfm
         osjabFJlSaM8ArTAPtwdkurmOgbhshWjh0jhYTD7GHCqt9ywQIK7+8UAFxsbW/6uUzEq
         /hGuOxxyuzVvD88KdVsSC2teeaOEfrDbbpjd39+o4NFtL54MfkpwrZXNL3cw3gcz9UPI
         ktzQ==
X-Gm-Message-State: ALoCoQkAQPxJTlmJp8nsSQwMaL6Df9E4fCyavh2dw9cSxj4uqin3cqOVOQSOer6AXjCjE4RmiLnw5vGiWbocvhymUImKBILdMQ==
X-Received: by 10.55.78.75 with SMTP id c72mr6602798qkb.97.1452788804792;
        Thu, 14 Jan 2016 08:26:44 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:43 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284048>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6dc9257..3a61d1e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2827,7 +2827,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3181,7 +3181,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3211,7 +3212,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3228,7 +3231,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3248,7 +3252,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0dbb13d..e8b1865 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -42,6 +42,8 @@
  * value to ref_update::flags
  */
 
+#define REF_LOG_ONLY 0x80
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
-- 
2.4.2.749.g730654d-twtrsrc
