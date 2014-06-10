From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 08/48] refs.c: add an err argument to repack_without_refs
Date: Tue, 10 Jun 2014 15:28:56 -0700
Message-ID: <1402439376-25839-9-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:40:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUa6-0006OG-Vs
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbaFJWbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:44 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:33502 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ve0-f202.google.com with SMTP id oz11so493677veb.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hnplNiJD/35F+E/i9j1wYoC+VLpugTS1Z4vRpVRsI+g=;
        b=LdX0ALKMZJQiO3LSht0lUG0K9pJh4fSbwJhvSQMmien2n6LNwtHvU1Fp/1pRD8pu3h
         1xQuQyWtjACFj+UTBAY4CbfrIfjssa/5pyda54zmK4+ILVvSWGrkgjfbGXl3t78CIS/6
         cu62l1A2k2Mg9vazV4Wg/Kf35XQOJmbqAyMBJU+3WClYn5Th1l/2G5SSPdmOE8+W9j3P
         +8WoegL2pD8UN2RiHNncYERg3Ke/Rs4ptGtKiWbpevSSLtraQ2O6aX8moFvbvfDUpDyD
         Figwe9r8s8Q9CiuI03oCXD2h3KzSBJ6IY1iUvrIVdKEd5KVjnSnKpREw051mDfWRijLD
         Sr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hnplNiJD/35F+E/i9j1wYoC+VLpugTS1Z4vRpVRsI+g=;
        b=cHK0+x65mVduIiE2gZjiPIKYWpuAC4bECfGIC6HMXxpahWR4nmrUGxpJYowXPugtbY
         51o4wKVGsjSPRZG0C04U0vLnmVsF+NGB3i/OftraF46pmqHd/5GwCPJ5KgTbx0n2Om0N
         jDljGHEskMifhrgip3rbLp+BkFrMo3MW8qArzUlYVC//YKUpFxa5Iq5diyYUQrBR486P
         4SMD4PDDQE+kvkej1JtYMTM7SD9uOwOoun4vOv4pwjNlvKHWW+P0melMKn0Zo1jbz2hg
         3z9qQkcWMGWZVqzfS1x6T+zrUVKlQPobTsH9/LKgGBOZrJz+uvIZsPXIdJGN3V0EGx5A
         0ljA==
X-Gm-Message-State: ALoCoQnmv4ocvku3YeITb40/LFkc4+qtBser8ccUGEzj3qZXamGR8GUqFLSGAiSl1lE3VPBQbVYM
X-Received: by 10.236.165.230 with SMTP id e66mr9932955yhl.6.1402439380443;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si1395063yhp.6.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 46D425A472D;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CD30EE0DEE; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251315>

Update repack_without_refs to take an err argument and update it if there
is a failure. Pass the err variable from ref_transaction_commit to this
function so that callers can print a meaningful error message if _commit
fails due to this function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 1e8f293..b4b05bd 100644
--- a/refs.c
+++ b/refs.c
@@ -2428,12 +2428,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 	return 0;
 }
 
-static int repack_without_refs(const char **refnames, int n)
+static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
 	struct string_list_item *ref_to_delete;
-	int i, removed = 0;
+	int i, ret, removed = 0;
 
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
@@ -2445,6 +2445,11 @@ static int repack_without_refs(const char **refnames, int n)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
+		if (err) {
+			unable_to_lock_message(git_path("packed-refs"), errno,
+					       err);
+			return -1;
+		}
 		unable_to_lock_error(git_path("packed-refs"), errno);
 		return error("cannot delete '%s' from packed refs", refnames[i]);
 	}
@@ -2471,12 +2476,16 @@ static int repack_without_refs(const char **refnames, int n)
 	}
 
 	/* Write what remains */
-	return commit_packed_refs();
+	ret = commit_packed_refs();
+	if (ret && err)
+		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
+			    strerror(errno));
+	return ret;
 }
 
 static int repack_without_ref(const char *refname)
 {
-	return repack_without_refs(&refname, 1);
+	return repack_without_refs(&refname, 1, NULL);
 }
 
 static int delete_ref_loose(struct ref_lock *lock, int flag)
@@ -3482,7 +3491,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		}
 	}
 
-	ret |= repack_without_refs(delnames, delnum);
+	ret |= repack_without_refs(delnames, delnum, err);
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
-- 
2.0.0.574.g30c2c5e
