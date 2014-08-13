From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 15/23] refs-common.c: move prettify_refname to the common code
Date: Wed, 13 Aug 2014 13:14:59 -0700
Message-ID: <1407960907-18189-16-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHey1-0000Gh-OD
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894AbaHMUQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:16:06 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:38811 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-pd0-f201.google.com with SMTP id g10so83773pdj.4
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tB0NucpD2s2PbXvlLeZ+Hdq2N7eGhE4D9ocg8P7IaN0=;
        b=dE+gY9Jf1qAFMA4z/J+uum4cbwjXV7C4AtuXz88Ym76uMiJ8gi863OHCS5UB27PgNv
         TD4/cvXi7LD5c4Nlmas9Kdp7DiMF0IrUvCBQh+opUm39bT5ifKJT5x8tEN4Mvo9q9lxZ
         3E53iKeEWPW1Vu72X4q6GgxFIDJdPZMG9OD2+qP6XCV7eEeDYrksWT0PnZ+2l2/Rm96J
         o5Cm5pyvc6UX9ULI6ZrjnmoQe53gelIupyF1IbZAn+WjcLfqPOgFMG+ZYPTS7RRWL4Fi
         68s+xlzSZhbsmcNZwFEM9Jp5mAamXRHz+fqU/e67kdZ5S7lDV6qC7LOwPg/M3mGG0pHU
         La7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tB0NucpD2s2PbXvlLeZ+Hdq2N7eGhE4D9ocg8P7IaN0=;
        b=XIcXhi+ykBRW/u6yEb0csLZTrK8yzdP/Q0nCmrYSucy/Cjss4su3hlwFxLKM46HACX
         gi7X95e3igeoHJdqjBk1BK1CWohdNeiLBb914i9ZXLcM53cCJAxEGLnxAlLlRjiXaNCe
         qaFhwfkmx3RGHEgYGwByn5A7f9FsJQ781U6XC2If14DdmzYsMQ2XsKp5MMFlDaM0gYeM
         Biy3gpEmGgR90+8hUXRWs4lh4mF11Q3QkCUDkMh1hIP1agfFUiaL0AkxrOf50ernkBfz
         EGErl8pKzg7l46ciGkvpcb9mMzzrSsrDDDb9XRUu8+8ow7h9vrs5CEWrKdlpU8u26135
         PrJA==
X-Gm-Message-State: ALoCoQn7JCLMoZ6ZqrvEuzsfIKouVZmrTnK4ySFkfzmi0c8wIj6j6NeKo8ipYEEluuV3w4XeKaeG
X-Received: by 10.66.90.193 with SMTP id by1mr3522766pab.30.1407960910446;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si210823yhg.0.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4629C31C2A9;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E03E0E104B; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255246>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 9 +++++++++
 refs.c        | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 6eef80b..d8a295c 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -3,6 +3,15 @@
 #include "refs.h"
 #include "string-list.h"
 
+const char *prettify_refname(const char *name)
+{
+	return name + (
+		starts_with(name, "refs/heads/") ? 11 :
+		starts_with(name, "refs/tags/") ? 10 :
+		starts_with(name, "refs/remotes/") ? 13 :
+		0);
+}
+
 int names_conflict(const char *refname1, const char *refname2)
 {
 	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
diff --git a/refs.c b/refs.c
index 6542969..fb9c614 100644
--- a/refs.c
+++ b/refs.c
@@ -1747,15 +1747,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-const char *prettify_refname(const char *name)
-{
-	return name + (
-		starts_with(name, "refs/heads/") ? 11 :
-		starts_with(name, "refs/tags/") ? 10 :
-		starts_with(name, "refs/remotes/") ? 13 :
-		0);
-}
-
 static void unlock_ref(struct ref_lock *lock)
 {
 	/* Do not free lock->lk -- atexit() still looks at them */
-- 
2.0.1.556.g3edca4c
