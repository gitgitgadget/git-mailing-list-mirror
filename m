From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 31/42] refs.c: remove lock_ref_sha1
Date: Wed, 14 May 2014 14:17:05 -0700
Message-ID: <1400102236-30082-32-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgZX-0003iM-VX
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbaENVSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:18:30 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:37987 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaENVRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:31 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so427894yhl.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xUlSSsldlxQq0OlDx+ts2PQjeQkjMRF9ULcGF1d530o=;
        b=lkF9yrT8SvpS6MLC0CxcN98DGKj83Nfk6uP85mM9i2RvP38Is6vEucqrOhtVk8bc7d
         j1LPwBcSIoBNS5AKN4ARjAymm8vjF2rMKgjKC/KuxVKO/O5VXpXmqz79IsSntjFD3xYz
         3Di2FKOmA6Fc21rC9uAT+0UN3zpoiEQtK6lcYxWrJB2iWFjdyACJrBovjw+gkLs4qlOa
         ujVU3AC8rMRE3iIJdT2aVUCA0VTHDGEWh7JLJs9roTsY9jfsX6C67EStsSu0yMcBgYnO
         GECZPvd77G601yYv2tGCXLaP/Z+z/XPJQ2vc7ycoWBYPXxpYFJG/qr9048rg49LH5veB
         WnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xUlSSsldlxQq0OlDx+ts2PQjeQkjMRF9ULcGF1d530o=;
        b=ZROy1K6ypdwSTGMMkPx+LmpALHbHIUekM7hJRd4B6TInBPDfRRXj4JvsqLXrkzTxCO
         Y0n9hZACht4g+kDXdIfeLTy4U3jS8K9D4jRW2VBVKuD0vFWS/cf9FaqHuPUTSBqtKo2a
         d9r99MUWNvkLxe4eES3qBbbN5O/TxpC4IMV/04IfKdsm0oq1CBBK6RQqXYnJBVtjdNLH
         B6RPfLxpaIPq0D4/8FceY+Ed1EKAFGGEpXx0wyhe6r8eLE+NRLnAO1PM8mnuGGUxFaqI
         I7frpX8LGDenBYu0GobKVz/J9PcQoG4VRRgVoaCCQmvnQTiQ4gbJMXtvXo+DR7Ue8ZL5
         2Szw==
X-Gm-Message-State: ALoCoQneq/hVK7hUiDFIrki4xDP9rH5G4kPrLFEU0tYR2lNE4Va4ElZzzV0gUoCfEpljP4RS687R
X-Received: by 10.58.77.204 with SMTP id u12mr2864387vew.24.1400102250537;
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si145913yhj.2.2014.05.14.14.17.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 64F2731C1F8;
	Wed, 14 May 2014 14:17:30 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 28EFAE0973; Wed, 14 May 2014 14:17:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248966>

lock_ref_sha1 was only called from one place in refc.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index aa598ef..cc7556f 100644
--- a/refs.c
+++ b/refs.c
@@ -2126,15 +2126,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
-{
-	char refpath[PATH_MAX];
-	if (check_refname_format(refname, 0))
-		return NULL;
-	strcpy(refpath, mkpath("refs/%s", refname));
-	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
-}
-
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
@@ -2335,8 +2326,12 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock;
+
+	if (check_refname_format(r->name + 5, 0))
+		return;
 
+	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-- 
2.0.0.rc3.471.g2055d11.dirty
