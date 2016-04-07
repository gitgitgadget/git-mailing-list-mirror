From: David Turner <dturner@twopensource.com>
Subject: [PATCH 01/24] refs: move head_ref{,_submodule} to the common code
Date: Thu,  7 Apr 2016 15:02:48 -0400
Message-ID: <1460055791-23313-2-git-send-email-dturner@twopensource.com>
References: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFDD-0006ye-W2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbcDGTDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:03:24 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34833 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbcDGTDW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:03:22 -0400
Received: by mail-qg0-f48.google.com with SMTP id f105so47939198qge.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1LzKPXPO3v6DB0J+h9Dbe1wdSZH0u/QtewEiecaJEPY=;
        b=ZbylHu28yWgb5iLafQQyna9ft5unE8uURxdR/jmIOmq1KnqnasywFw9HZN4jVpvyWe
         DGLu8akjd5gi/0C7coTzqpTYVTCHWRoPTTCjyBk0yG0ezZ6FVaZ7IKHXCz+sgtsMguJL
         4AVVvlpbEzZr6VHPqb/H5SEYe1hN9rK+3YOvcvBmPwVPvd3m3OMQMX9A/yXGOh5QzfZF
         yanQ62ntXWraji67b21UJyMSJrg7wt6kewjBov5pvpecA8Ql7jaCrwXEue9nJFiR5hpL
         izUGNKRM2VLsKdx71D7kVicU614r3bANvzFk4/AsdtUVf1EL5II0qMoQwVBhO0CwP47J
         edtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1LzKPXPO3v6DB0J+h9Dbe1wdSZH0u/QtewEiecaJEPY=;
        b=N953zhCqbRtTtHtx4R75gbYWDqgVkm1Hm547lcDAVedAYYE74v9z5xYSdzcOwC3PLq
         gUFde1PwnIGRJFoGKq9Dv2gJ3IMOkDtfPVGKPekNZ+/2zLEQ+BFMe/y/l1r1mRdE9JvO
         ld68HLAOuBBYeHvi1/uxkUeXXyMIKQkVuV4apG1mwS97LKmBa5Ab9hz/vTMMjmPY+sIG
         tfjOEt1Cl/kF1D9W5LqYxM6F5lXhT6IgYd1/rAkKK9CLxclmmflsssj1YVWrguUdYyyT
         uX5hKlVT5QBTapf7EDPFJnJe8grwfEfD3fV/Xmoosm34SHABUhOZEvmgp33F23pk4e/I
         aTgw==
X-Gm-Message-State: AD7BkJIiXIQseUN3KdiQY4eb1v4nno8lD+SH4dqJGf6TgqNgfe/zEYMxVkDYfNVMeuhGAg==
X-Received: by 10.140.18.226 with SMTP id 89mr6116671qgf.89.1460055801510;
        Thu, 07 Apr 2016 12:03:21 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e11sm3959273qkb.39.2016.04.07.12.03.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 12:03:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460055791-23313-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290952>

These don't use any backend-specific functions.  These were previously
defined in terms of the do_head_ref helper function, but since they
are otherwise identical, we don't need that function.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 23 +++++++++++++++++++++++
 refs/files-backend.c | 28 ----------------------------
 2 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/refs.c b/refs.c
index b0e6ece..6b8c16c 100644
--- a/refs.c
+++ b/refs.c
@@ -1080,3 +1080,26 @@ int rename_ref_available(const char *oldname, const char *newname)
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
index 81f68f8..c07dc41 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1745,34 +1745,6 @@ static int do_for_each_ref(struct ref_cache *refs, const char *base,
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
