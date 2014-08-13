From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 01/23] refs.c: create a public function for is_refname_available
Date: Wed, 13 Aug 2014 13:14:45 -0700
Message-ID: <1407960907-18189-2-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexu-0000CW-SN
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbaHMUQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:07 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:63442 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-yh0-f73.google.com with SMTP id f73so36036yha.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Oxzmq94n9ci+kiQNqKLrEbeYk8G8/UdOhz6qVPe6xPw=;
        b=C62QBopmeSCZ8TWmBG+8lVYnTNYh+e4dUhplIVl7U7r6vrPO0dm9slgcFtIqdmPLib
         hILQedcm5GLFZ0mX4K+Z/oSbWsytoA9EoeZw2TtPlqYBSf845JP/+TdkRI4za2xC7MzE
         50R9vPY9op/wcAhPlpzQR/WxKI4FpM0je+yCVxGuvpRNVlCzvwYrWLWcaaDNcWK/LS44
         noZzJ7XrbZjfgzFzgmaa1xLnDh50qaVft8njc4p77abBQVtY9LWyAZhnSSEQbZgmsAVO
         xhJTwBzrshgxEfLm6wL+5stlKFEEHPynqhKq6EqBvcaX1zhv69h7REAfaAwsKOForidR
         xAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Oxzmq94n9ci+kiQNqKLrEbeYk8G8/UdOhz6qVPe6xPw=;
        b=lkNbq6JK2gsnRJlrIod51G4NZMxK3mW7daigIYsj+XR+JU4PdiMmJAA+bPxNFRV63f
         iNg7zHSsqp/K4Velv/ktzxJCpEcOm+zk9DpfYBK7IJvuN6+1X073FXDBRO+a0KzmtMWb
         SP4u8MyL92pRu9PBq2RKxp+/cHTJaZ+PJkxBIiqVwviQuQ6PaJJAVAo+K0lOZhVS11Tt
         NU/LJx6Q4QXBYhQCnoc81IbVOs+BdauBdX/SXud9GBuRrypMa06J/veMuC3iv0GroW6D
         t5s3CCmf16sO1RpjAITPMTTgnqRw/gMiVdCsJGX4lrO2HD2HQjObTuvpPNZOq4A2M6pA
         735A==
X-Gm-Message-State: ALoCoQmOzd5A/JgUim4UQJ3iszNWOq40QXyKp+Jm0q39WFbmz+4EH3cNCoxweqx/30FUeO5/ARU2
X-Received: by 10.236.28.226 with SMTP id g62mr217697yha.0.1407960910007;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si207799yhp.6.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C81A75A441C;
	Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 745CAE0C3A; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255244>

Export a generic is_refname_available() function. We will need this
as a public shared function later when we add additional refs backends
since we want to keep using the same rules for ref naming across
all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 29 ++++++++++++++++++-----------
 refs.h |  6 ++++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 7e13c0f..4a22513 100644
--- a/refs.c
+++ b/refs.c
@@ -830,9 +830,9 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * operation). skip contains a list of refs we want to skip checking for
  * conflicts with.
  */
-static int is_refname_available(const char *refname,
-				struct ref_dir *dir,
-				const char **skip, int skipnum)
+static int is_refname_available_dir(const char *refname,
+				    struct ref_dir *dir,
+				    const char **skip, int skipnum)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
@@ -1238,6 +1238,18 @@ static struct ref_dir *get_loose_refs(struct ref_cache *refs)
 	return get_ref_dir(refs->loose);
 }
 
+int is_refname_available(const char *refname, const char **skip, int skipnum)
+{
+	if (!is_refname_available_dir(refname, get_packed_refs(&ref_cache),
+				      skip, skipnum))
+		return 0;
+
+	if (!is_refname_available_dir(refname, get_loose_refs(&ref_cache),
+				      skip, skipnum))
+		return 0;
+	return 1;
+}
+
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 #define MAXREFLEN (1024)
@@ -2168,8 +2180,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * name is a proper prefix of our refname.
 	 */
 	if (missing &&
-	     !is_refname_available(refname, get_packed_refs(&ref_cache),
-				   skip, skipnum)) {
+	     !is_refname_available_dir(refname, get_packed_refs(&ref_cache),
+				       skip, skipnum)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2676,12 +2688,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return 1;
 	}
 
-	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
-				  &oldrefname, 1))
-		return 1;
-
-	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
-				  &oldrefname, 1))
+	if (!is_refname_available(newrefname, &oldrefname, 1))
 		return 1;
 
 	log = reflog_exists(oldrefname);
diff --git a/refs.h b/refs.h
index f44b5c8..d526da0 100644
--- a/refs.h
+++ b/refs.h
@@ -131,6 +131,12 @@ extern int ref_exists(const char *);
 extern int is_branch(const char *refname);
 
 /*
+ * Check that a particular refname is available for creation. skip contains
+ * a list of refnames to exclude from the refname collision tests.
+ */
+int is_refname_available(const char *refname, const char **skip, int skipnum);
+
+/*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
  * store the SHA1 of the referred-to object to sha1 and return 0.  If
-- 
2.0.1.556.g3edca4c
