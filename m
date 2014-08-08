From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 15/22] refs-common.c: move prettify_refname to the common code
Date: Fri,  8 Aug 2014 09:45:02 -0700
Message-ID: <1407516309-27989-16-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnJj-0000s3-0Y
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757107AbaHHQqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:46:35 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:50154 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so1475422pab.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jw6GF0nB6+dktdh2LbInHbmylcYy/JHOEddLPWIC0f0=;
        b=gyhR3M2r97lq9dTbXAc1Lp/9qNx0vHgFjWILMBspLj7Hp2D1uHPVe5G9BP+F58gjlO
         N76Bq/nPc/5iOFeIIoqSNaZPwvhfd+aWTeWzsnycFtixQyYf+GEYD8T/LPWYivCx7l+Z
         5BfVXg+/jyOXiVVmVzol6WAaPIy6vYrGaptcDq2kSLfhOCJDJJLcVX7ZlT/kDKaU7Ngr
         /H6olka6BtdYum9q1DIfvk+0DGpqGCaSWg4M6cxXa/T+m8T+YF7f/dGQM804OorrArrl
         1ieOYL95S/NW4smD0ekgMaX6GTmYDRl72pA5Nmjyo9Ea5DdTz6GlY6sDhuv371zoo/6g
         dGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jw6GF0nB6+dktdh2LbInHbmylcYy/JHOEddLPWIC0f0=;
        b=GhlbaqyXrDnumqIOX9H1NLqZ1Rcc79pW2ANHdklxDiYxy5EJmMTm2E7E9DJoa0L/3U
         aDGB9wqHPVdL9BJUb9qfL1b/sZUuPLCDX+mEsqZzjSlvaZNf5JGZyQ5QIJV1tIbDv2YB
         IpEfCssBXAdOSGu7HEN240H26rGGSC0hM5rnleq9b0LQN8AJXG7pFK/3i5iwCrN84C+f
         jrsaok0Un0+tqnPVuNB9x2OhC2HuYt869GbQ43o9LuFJfJLHwE9DR8mjtw5eIrRp3MEu
         nY3z5eTGfiem1JoJrc/IRLPy3/U8BGDqlmsMTs8IQjk6j3sOcSxdJeaAv1tMy3c5l0IA
         CHsw==
X-Gm-Message-State: ALoCoQnE3bVrvF3a5rFsJqYSREfP6wlrGWK1/xC7XRH6+ULhfglP8lG4z1mxu0FQjjjbQuT3OrRA
X-Received: by 10.70.44.230 with SMTP id h6mr11527118pdm.7.1407516315897;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si504381yhk.4.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B3A5631C40F;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 625C4E1163; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255045>

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
2.0.1.553.geee1b3e
