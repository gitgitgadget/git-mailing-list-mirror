From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 15/16] refs.c: make lock_packed_refs take an err argument
Date: Mon, 17 Nov 2014 17:44:56 -0800
Message-ID: <1416275097-3616-16-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrj-00040h-3M
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbaKRBpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:39 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49402 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbaKRBpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:21 -0500
Received: by mail-ie0-f176.google.com with SMTP id ar1so1104883iec.7
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RyGx1PBe2ntad4h7QoxbBbYyoQnV4OGEUvLXkuXBJcM=;
        b=FXJx8g2rYDhtQoItM2R21DzFmXUWml36ymO/S1kAZTl9ogmI0LdeIY1Bj2ElnC3bpG
         1HXWSCg9Q+dv5EpimMWq6NM7IYaC2IBvsDlG9MyH2IxsX3Hp2fQk63G70L0Wy9JFCgwU
         UTw0g7vkVjqjK1EkHFDDamzK0jNDWvVmCVJ+r1wpEIMpPIqs7qeVf/KNPTa/rdTfBW2b
         w+G9bZCAkMvmzQ/8pysA4+/GJlKpdxWPQ+gQmz1PFCWGT3Lc+avuEsfkVfZHgOfi8nqU
         IW1cJDo7R9Ngca8UfIV5dujmZUh2BXbm2CvKxcXRql7Fw3fGKj8/sRJGMEMUxht3XItK
         aoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RyGx1PBe2ntad4h7QoxbBbYyoQnV4OGEUvLXkuXBJcM=;
        b=lxNyLMsDlpGrHFWdv9eibZFHLhA9UVOV94jxI+MIBCsw9xrLEG6ZasW0gSDlI2ImND
         O2SoLi+A9UiBHGP1oUPjrfSIsovCQ9nFlYl3gYPsTWN6kO/Wa4SoRzJY9hw2zHnX/FYe
         9ZkE9cbMRLjLySpnmXNV2Y1E1iPbOh0Ss9NgfCpbRn4AxEwqR4XHmkJQBfIbp5Z0UFIE
         XKikpir7F0ViWetZvonokSv3z2K9qTIrbKWDag+KRafQ0QLuEXYDeZoEljwvA5sGDJTa
         7YGkVpiMOSD2r4A3K/aOT2IcL0Kde7PDNUHYPE7j5xWKnJPhL3RV6ztJqCpWmdAjRV0L
         jn0Q==
X-Gm-Message-State: ALoCoQmHRqrxqYoMjU4/Wp2tuDE4XWVT5a89tR/Nc/tf0GEqup+ZhXgbCXDjOPJTLgiyDEOxW1UT
X-Received: by 10.50.88.69 with SMTP id be5mr1786147igb.21.1416275121040;
        Mon, 17 Nov 2014 17:45:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id am5sm132751igc.12.2014.11.17.17.45.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:20 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index c59cc3f..725945e 100644
--- a/refs.c
+++ b/refs.c
@@ -2398,13 +2398,17 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-/* This should return a meaningful errno on failure */
-static int lock_packed_refs(int flags)
+static int lock_packed_refs(struct strbuf *err)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
-	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"), flags) < 0)
+	if (hold_lock_file_for_update(&packlock, git_path("packed-refs"),
+				      0) < 0) {
+		if (err)
+			unable_to_lock_message(git_path("packed-refs"),
+					       errno, err);
 		return -1;
+	}
 	/*
 	 * Get the current packed-refs while holding the lock.  If the
 	 * packed-refs file has been modified since we last read it,
@@ -2592,11 +2596,14 @@ static void prune_refs(struct ref_to_prune *r)
 int pack_refs(unsigned int flags)
 {
 	struct pack_refs_cb_data cbdata;
+	struct strbuf err = STRBUF_INIT;
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	lock_packed_refs(LOCK_DIE_ON_ERROR);
+	if (lock_packed_refs(&err))
+		die("%s", err.buf);
+
 	cbdata.packed_refs = get_packed_refs(&ref_cache);
 
 	do_for_each_entry_in_dir(get_loose_refs(&ref_cache), 0,
@@ -3789,10 +3796,7 @@ int transaction_commit(struct transaction *transaction,
 	}
 
 	/* Lock packed refs during commit */
-	if (lock_packed_refs(0)) {
-		if (err)
-			unable_to_lock_message(git_path("packed-refs"),
-					       errno, err);
+	if (lock_packed_refs(err)) {
 		ret = -1;
 		goto cleanup;
 	}
@@ -3847,10 +3851,7 @@ int transaction_commit(struct transaction *transaction,
 			goto cleanup;
 		}
 		/* lock the packed refs again so no one can change it */
-		if (lock_packed_refs(0)) {
-			if (err)
-				unable_to_lock_message(git_path("packed-refs"),
-						       errno, err);
+		if (lock_packed_refs(err)) {
 			ret = -1;
 			goto cleanup;
 		}
-- 
2.2.0.rc2.5.gf7b9fb2
