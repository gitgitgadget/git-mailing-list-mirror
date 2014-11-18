From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 14/16] refs.c: make add_packed_ref return an error instead of calling die
Date: Mon, 17 Nov 2014 17:44:55 -0800
Message-ID: <1416275097-3616-15-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrV-0003w8-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbaKRBpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:40 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59385 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaKRBpU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:20 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so6415041ier.28
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RIvFn02ldALZOU9Lh/fLE+Hz4sbFkxM0+jqmNEys0HI=;
        b=kAmlh+fRMlFIXV2yYxH8t0DglKl7a/5tmoTm2dFXqJPlzcLOhEPyGFDAY60T9+JfiM
         aJAViGHWhG5LXWIBfEwpeqEkEmgqGLtKCe2UUkTHyMrLXqJOsIx02fvQCMCQFlvyrpQT
         xUKydHiLf14DmZwbjYku85ggWVGSI0hN89/Q9n88yGP+nvn8Yx1IkGBjxrlHDNoCIy5L
         y+lic4bwrYnE0lrBOwL+6PKjSTGTcAvIes/m9mzskP9q8IdbzweNnHoXSsOt8uVPev3O
         IT5irNuhLDQ6HpELJVKgGWtzlGp6P9uyiiUKS1Gp4n/O4XjGTCHie9i0T1fSOxylYZXh
         WoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RIvFn02ldALZOU9Lh/fLE+Hz4sbFkxM0+jqmNEys0HI=;
        b=eiwSNPw/wytrJpqlOhP2gzpE1rQRhhT2p3ST+RUOL29tvjLaC9cYUpDSzJ4nM/97HU
         DngnF7wQCd//yR3/CjqNEsgWz3VE84WzJezyU+mnGehBAMu0fE9wnuWh9n+3WcLOct4d
         CUHsGtcARgR+FG3HBdefxHnRTU/RCzjg72MiVynyL6PHhOMP6L3IbOkeecj6rdxzV3eZ
         m+n9E/mvl5K/+BsY6Xp9ZqxY9gjIkQqwHqh0Wc93Sgfu8Q8JV1j+KF+hkxCQvTlDK+rU
         sfs6mhCo+ZVwpalHx68ohNzR3ZruuqE5PQN9eK+EdKsF7oB1TpZxIcq8/EHMg5VfS0CZ
         CcVg==
X-Gm-Message-State: ALoCoQlU4pKGCo8U3t7PvLQf/tU+XY+appHIgcZzkGnH5bKAash8dzxuGdqmrrKZn3UyR2CqOlQT
X-Received: by 10.42.30.7 with SMTP id t7mr5851697icc.66.1416275119825;
        Mon, 17 Nov 2014 17:45:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id nj17sm6880397igb.5.2014.11.17.17.45.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:19 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 3146288..c59cc3f 100644
--- a/refs.c
+++ b/refs.c
@@ -1229,15 +1229,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static int add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
+		return -1;
 	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+	return 0;
 }
 
 /*
@@ -3827,7 +3828,13 @@ int transaction_commit(struct transaction *transaction,
 					sha1, NULL))
 			continue;
 
-		add_packed_ref(update->refname, sha1);
+		if (add_packed_ref(update->refname, sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 	}
 	if (need_repack) {
@@ -3941,7 +3948,13 @@ int transaction_commit(struct transaction *transaction,
 
 		packed = get_packed_refs(&ref_cache);
 		remove_entry(packed, update->refname);
-		add_packed_ref(update->refname, update->new_sha1);
+		if (add_packed_ref(update->refname, update->new_sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 
 		try_remove_empty_parents((char *)update->refname);
-- 
2.2.0.rc2.5.gf7b9fb2
