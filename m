From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 10/23] refs-common.c: move read_ref, read_ref_full and ref_exists to common
Date: Wed, 13 Aug 2014 13:14:54 -0700
Message-ID: <1407960907-18189-11-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeyD-0000NJ-2v
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859AbaHMUQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:00 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:62143 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so268925igi.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OKnTuKHrXBRa8aW7X1zdtv6Z1tp2a5UaowujddvnF/U=;
        b=P1Ud+Eo5AgWX9KlGZF73lFH51TI+VQP/mhrKU8srON5G3PAepRBSz6Wdm44hYF3ASh
         wGqy7teyHgw4BKxB9saaM8YRUo0TYGkN6+RHVpSfw++6ZVTHpru5suQhSljw3hME4EF/
         /LeJgaLkNpqo7y+MJxck/AD9cDUenUOonGQinT+berihgv3YE1gP0YY4sgbM6GUGFh9d
         Q/WqzdZ1JNXWrwldd5akoxvzklCK3h98ot6dkAovuqSo98bld/Paz6IrdmhFYJHrCb3e
         0JS4OxWgI1N6Cn0bHYCO6xWhMwy+iin21yzsJW/0ZQr80z5LLYfdAlU3BFauqlI9blTb
         14zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OKnTuKHrXBRa8aW7X1zdtv6Z1tp2a5UaowujddvnF/U=;
        b=J44ZtF6YWEE/OebMw4ngVByCVGOWCotAZYSTWwJxrJqR46jYtMi4+SEv/RgYOnYYUg
         T51uqgc61shUnkeQLX5oWHlDBYR9um8xCEjtukIsE4Ieiv+RoEhVOjxZQFmD8Vyq90oq
         ulkhYVyn2IT6k8zbnLwNOG/tamrzcRSt7y/FL6+1r9SRyOXyYnUmyafQTJiwRjIS9H4R
         sMNTSlLX/X16BiHRaL6kJ1sd9nkUWDUM/N1tMM0eOq46o61HGvOIbY18RP2oLulwq19W
         igY9ZuFMu/PpZOtUC09AFNulgoytOvJguhmepa875kZ8+RoAlcN5+LkuESJO1c0aZd5L
         ISnA==
X-Gm-Message-State: ALoCoQlEtubKErmCyAiHRoCYqe4P/vInJNza4abf7J+OwlHFMyFDD2AOwkeP0lrrC1wKTcTHEBBK
X-Received: by 10.182.24.8 with SMTP id q8mr3477300obf.25.1407960910209;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v20si209967yhe.2.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1316A31C3D9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A6332E09F4; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255249>

These functions do not depend on the backend implementation so we
can move them to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 18 ++++++++++++++++++
 refs.c        | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index ab3a118..37d3d14 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -547,3 +547,21 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	data.msg_fmt = msg_fmt;
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
+
+int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+{
+	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
+		return 0;
+	return -1;
+}
+
+int read_ref(const char *refname, unsigned char *sha1)
+{
+	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
+}
+
+int ref_exists(const char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
+}
diff --git a/refs.c b/refs.c
index 40c329b..a94378e 100644
--- a/refs.c
+++ b/refs.c
@@ -1514,24 +1514,6 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
-{
-	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
-		return 0;
-	return -1;
-}
-
-int read_ref(const char *refname, unsigned char *sha1)
-{
-	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
-}
-
-int ref_exists(const char *refname)
-{
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
-}
-
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
 		       void *data)
 {
-- 
2.0.1.556.g3edca4c
