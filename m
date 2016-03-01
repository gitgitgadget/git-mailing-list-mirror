From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 02/33] refs: move head_ref{,_submodule} to the common code
Date: Mon, 29 Feb 2016 19:52:35 -0500
Message-ID: <1456793586-22082-3-git-send-email-dturner@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 01:53:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaYZI-0006xI-50
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 01:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcCAAx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 19:53:29 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36021 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcCAAx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 19:53:27 -0500
Received: by mail-qg0-f51.google.com with SMTP id u110so1408874qge.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 16:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VpdGo9EcNXDsJg0asYtK261Hbnc6OQAvmlkPyA1iWk=;
        b=pnUb90N2QOawUVnrIDQ3G3vgCmaTos68hItF76WD80yMWZZ2as4jtOVSjEnr9QwK01
         iaZvDJ+NFDzI92d9TZrCHZAq+DtPd4220yiQ7kyFZy6FldmUff5Cnhf3OUkLc+l/XgDw
         IJypGE5JaMQwsJX4w8f3XgCBPOiYmLo/x1IddkmetaQIDwWM1a6Ug28ZWksXi/9SXwyI
         tmwWtSfduLzJb7bI/qqG+3xKm4PWhvVYzwlO0OpDfIpmMMr0ROsxTgerXbSfNA75e8p6
         YMHLd3gczx72d31eatm1C7cKsgbLEjsxUXU4ApgCd/rCfbvHeqzn7v8HmMbQ43QFCvfm
         PDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3VpdGo9EcNXDsJg0asYtK261Hbnc6OQAvmlkPyA1iWk=;
        b=Vo+fMs5NISQ/BXNRXqpw4aTLkL+Gd3Pn8dKlxxnQsxw9Fx0Q4J1oS7LysRf+SFHjcB
         /Uej0PC89s5t1+UqPtw1mw9LZ4aazg9uCNeDLLT6IdhwYynZUFrt2SMmMlHe6RvmU3O+
         R5Q/cYZW0LL6L8q7IR4By0OtisBPrTaKQJInk/J9OsVGtpOK8hr+xzqvTSjdBd+kI1gf
         FLVeEr9auq9PEVcTmJI7pyRtTLBAmi8RVCJUCHstkfLSWRTzbJ4LCMCHFjUk6tAdJfLv
         pPQCt0MW9KR0MW5AL4Ek7ajLAIFk1wSDvFl/BD4EdCNAJTns99v/TFchL47lyOqTRrSq
         pzpw==
X-Gm-Message-State: AD7BkJK7hhNWbkCwHB6CAzpQwDxMlau7hq6420pz7EkVrpdcyIBne5M9Ul4d7+noyjHnhw==
X-Received: by 10.140.98.71 with SMTP id n65mr7260019qge.22.1456793606893;
        Mon, 29 Feb 2016 16:53:26 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z62sm12094715qka.26.2016.02.29.16.53.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 16:53:26 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287951>

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
index 0dadfea..beac899 100644
--- a/refs.c
+++ b/refs.c
@@ -1086,3 +1086,26 @@ int rename_ref_available(const char *oldname, const char *newname)
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
