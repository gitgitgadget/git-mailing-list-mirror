From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 40/44] refs.c: call lock_ref_sha1_basic directly from commit
Date: Fri, 16 May 2014 10:37:28 -0700
Message-ID: <1400261852-31303-41-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5R-0007x5-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115AbaEPRiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:13 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:39834 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so521741pbb.1
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=boVFoW9cN2QpGB/822KSCBtcOUR+ia8li/l8Mm/rNvo=;
        b=DSn4GCMCTv6IYtimmRNqnurzrJAkStD5CERbJf+CaMMXi/OmMgtpymzNlCxNJDEc0H
         +ejZfq2g6M893tHmMxN+Z1nGElvDKDLWmiSNf7UzMTM3BwY17wLr1/6XxnHRQE3DA/Ig
         4jtqGUj+fJfcjwmYHmb3vXoyiwfxHaaQ1tjLdsK4jDX2psYyXt3WXqAkQhzIXwGvxcRm
         c3Wl8o204kmqY6Zok5s8AW86bd1dtrMlSg1Bc7bz2ZYhXIqteXP3I+1tNpuqG/MwQS5B
         EZ7Pg7qKYwemdV2PvDqhZlhtmI9FsEiBCb0Gi5sE/ulm9N983X9UkN8bnK/H0YE2C2Qf
         h8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=boVFoW9cN2QpGB/822KSCBtcOUR+ia8li/l8Mm/rNvo=;
        b=bfGqOKFkZnKT/41tVnitbExRMudtzex0F+2tSywmFwqoYJaX+JrV13zfnsxBhmMtDd
         1uztLJhUnxVr8I8QXVHivONtqvQxXBEREMflF9Et6ZkGz4ZC5qbSSnh/ildQb+x00E0L
         LWhbJtFbU88VgCx32fgUphzuRl1rVx94LlqBfQoUWnKvpnTwIQEdpZXNXij3i5F1bGbq
         BPiZ4+CczT725mjFflog3bKJPUuXWNjM+EGaxtmJDm975YDh0lyGtHMBeOML34AeDNZw
         QxUrLhl09GYaT3xGmXy+GyONGdT74hqo0lGrMsjwRKwRrYubXutQ9muI/LDS1BkDIjbQ
         nnEw==
X-Gm-Message-State: ALoCoQnU2Hi0H/U3W/A6qcJph2chadyHyudI8Z5S7J82g/ILTlX784hFlGxjFven287rj9+xVy2q
X-Received: by 10.66.197.131 with SMTP id iu3mr6112200pac.15.1400261858803;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si442309yhk.4.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9D2FC5A427A;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7946BE115F; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249366>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index f63a356..564feb6 100644
--- a/refs.c
+++ b/refs.c
@@ -3511,12 +3511,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = lock_any_ref_for_update(update->refname,
-						       (update->have_old ?
-							update->old_sha1 :
-							NULL),
-						       update->flags,
-						       &update->type);
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.rc3.510.g20c254b
