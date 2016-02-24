From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 01/32] refs: move head_ref{,_submodule} to the common code
Date: Wed, 24 Feb 2016 17:58:33 -0500
Message-ID: <1456354744-8022-2-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiR3-00052b-LY
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbcBXXBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:01:23 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34822 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759060AbcBXW7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:19 -0500
Received: by mail-qg0-f48.google.com with SMTP id y89so26976822qge.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UpGDHe2g6rP7J3fTyReG7T2DpwNbl8MHwXC38Uow7WQ=;
        b=yJTQOj8K1vYF+Epdbgnfbqj+8hgYlvcoF0fdHVg7FLePWIWPgTldzdqfrLfwteo8eI
         53k06lZ1Yw4vgcgxUO69qvpk5JzXKUP93lskcoEevj92d9KU8OEE6/8qvZfcIy+CS6R9
         E3aMw93pdXzX49EtoXfvKdGuZwmhALg8WJ9YfseMGBrDBu52ywXorxPBkaefe7ZnFxzJ
         o50xt6ZvtTJGX3d+tdiKjPVw3H/smbvpFWA6/pAFayp0s5Z357eAuiAenizrXTgJNitB
         Qpx0J7qPVw6MEV90Vi26X4hYwfQG1tpqu+7r/D7o7TQ/y7Yuk+Ee8YYm4G6aoPmBUaE9
         FD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UpGDHe2g6rP7J3fTyReG7T2DpwNbl8MHwXC38Uow7WQ=;
        b=BrMDbuH19uNVeMoHx4qNV8/lMi9pKm5h/5Ua6HfYKD5F8lusoD/J6QB/ki7B2goL4X
         JDgbLkhau6BsJuie2dc+MfDdBE8r2L287ZUSM5ns/zUz6HWymk+B9f4bL8PlSfxkMT6B
         x98lyvMsd3wophETNbg3cltN+uJG+V29aOCDHCzxW4Bkbwae/GNdPCf0RdOnG+Qg98gf
         U2VKgWxjTkLdYrfQoSSd58nnbl3pfpfxg/eYjBZ2pQBB48lvwBJzwVxRCC4K4IbJSlBa
         sU9x5XJh7neD6PhdIox6kgBqu51m66EDH1P1g2eNX1f8n6uKCtsf4Z78KqV54yrSev0S
         5jgw==
X-Gm-Message-State: AG10YOQh6KawMFGYEtuX3/4njFmSYYkoK7CAjgYZupsHqep3GUFbbAXwZEkOl2HLvWvyKA==
X-Received: by 10.140.216.212 with SMTP id m203mr55065439qhb.37.1456354753244;
        Wed, 24 Feb 2016 14:59:13 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:12 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287274>

These don't use any backend-specific functions.  These were previously
defined in terms of the do_head_ref helper function, but since they
are otherwise identical, we don't need that function.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 23 +++++++++++++++++++++++
 refs/files-backend.c | 28 ----------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index e2d34b2..4367c14 100644
--- a/refs.c
+++ b/refs.c
@@ -1082,3 +1082,26 @@ int rename_ref_available(const char *oldname, const char *newname)
 	strbuf_release(&err);
 	return ret;
 }
+
+int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
+{
+	struct object_id oid;
+	int flag;
+
+	if (submodule) {
+		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
+			return fn("HEAD", &oid, 0, cb_data);
+
+		return 0;
+	}
+
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
+		return fn("HEAD", &oid, flag, cb_data);
+
+	return 0;
+}
+
+int head_ref(each_ref_fn fn, void *cb_data)
+{
+	return head_ref_submodule(NULL, fn, cb_data);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b569762..2e2a6d9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1753,34 +1753,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
 	return do_for_each_entry(refs, base, do_one_ref, &data);
 }
 
-static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	struct object_id oid;
-	int flag;
-
-	if (submodule) {
-		if (resolve_gitlink_ref(submodule, "HEAD", oid.hash) == 0)
-			return fn("HEAD", &oid, 0, cb_data);
-
-		return 0;
-	}
-
-	if (!read_ref_full("HEAD", RESOLVE_REF_READING, oid.hash, &flag))
-		return fn("HEAD", &oid, flag, cb_data);
-
-	return 0;
-}
-
-int head_ref(each_ref_fn fn, void *cb_data)
-{
-	return do_head_ref(NULL, fn, cb_data);
-}
-
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return do_head_ref(submodule, fn, cb_data);
-}
-
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(&ref_cache, "", fn, 0, 0, cb_data);
-- 
2.4.2.767.g62658d5-twtrsrc
