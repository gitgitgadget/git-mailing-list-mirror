From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 14/23] refs-common.c: move names_conflict to the common code
Date: Wed, 13 Aug 2014 13:14:58 -0700
Message-ID: <1407960907-18189-15-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHeyJ-0000PC-0s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbaHMUP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:57 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:47693 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so35643qap.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JXSmbS5ZfGtJSHvhdSTLueDQNfRHyst0mtfPApiqMTc=;
        b=HamIFjCmOR/qcnd6ZQeGIpUtA83OwC0jb4B+hAA1NUOtstTspGSK2uAl6Z7H2d3M5J
         acR7O3LAaOpHffme5rC9M8f2axLRIN+1nu5CxBf7jsGjdqa/9PlxlHKR9zikm0C4ZHKo
         e4G8HKT2CRMf7vX8mMhoEFE77XJ15LwTRvic/+h5ssX5eN7RldjaAb3gBImvQLLhOW1U
         JFEaqmWp0ShrpOKOOYP8Ags/PTS/QDRnP+Fp8NDkxBlb4bF4opx8M5Beqg6ukmGR5AuU
         QMrycU7zJ349HK6PXZLjTVG7joEP0dZ0pL/vygHPQiwyOmeI/yBjMldT9sXndbmw6rDx
         toPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JXSmbS5ZfGtJSHvhdSTLueDQNfRHyst0mtfPApiqMTc=;
        b=GT2PV32xK4MJVhhToGdnrJzbiaIlCUrdfNLo9NaGawjDCX+O9DQry7WmeIP0OTBic7
         BKrToTbTqElroYLL/YlUPqyY8LxWRGCdVHpD0zXYKwUwE5aMU7kecB34IC9TbkSZLnmJ
         hjPBgfHjP4nQHPz/90jcEYxKYMPnghu/zRtjOjrf/5vmd+neHM2wDAjlSOg6WxCnD9T5
         Kt5O7KlJFMnU/K6m2Pi7PeBzo+Z2hkoFc458TlTNvrMfTljZOoCEcBF1aGvAwk03I0eO
         jndej5sMOvBuugs1KpK9cbkp2fI88qAFQFXSlyRaQMHAbD2EvX/rlv+0b4ozA47UklIi
         87xQ==
X-Gm-Message-State: ALoCoQnC1gV828/JvlOR5P2WbX2W5GyARqibVcweYuQyxVyf2hgLdMFc+5SE5dn99ABb5jPodTZj
X-Received: by 10.52.1.233 with SMTP id 9mr1834566vdp.5.1407960910543;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x19si210824yhg.0.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 65A5A31C2D5;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 10B6FE08FA; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255250>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c |  8 ++++++++
 refs.c        | 14 --------------
 refs.h        |  9 +++++++++
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 5f83d7e..6eef80b 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -3,6 +3,14 @@
 #include "refs.h"
 #include "string-list.h"
 
+int names_conflict(const char *refname1, const char *refname2)
+{
+	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
+		;
+	return (*refname1 == '\0' && *refname2 == '/')
+		|| (*refname1 == '/' && *refname2 == '\0');
+}
+
 int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
diff --git a/refs.c b/refs.c
index 70c034c..6542969 100644
--- a/refs.c
+++ b/refs.c
@@ -676,20 +676,6 @@ static void prime_ref_dir(struct ref_dir *dir)
 			prime_ref_dir(get_ref_dir(entry));
 	}
 }
-/*
- * Return true iff refname1 and refname2 conflict with each other.
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "foo/bar" conflicts with
- * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
- * "foo/barbados".
- */
-static int names_conflict(const char *refname1, const char *refname2)
-{
-	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
-		;
-	return (*refname1 == '\0' && *refname2 == '/')
-		|| (*refname1 == '/' && *refname2 == '\0');
-}
 
 struct name_conflict_cb {
 	const char *refname;
diff --git a/refs.h b/refs.h
index d526da0..a14fc5d 100644
--- a/refs.h
+++ b/refs.h
@@ -128,6 +128,15 @@ int pack_refs(unsigned int flags, struct strbuf *err);
 
 extern int ref_exists(const char *);
 
+/*
+ * Return true iff refname1 and refname2 conflict with each other.
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ */
+int names_conflict(const char *refname1, const char *refname2);
+
 extern int is_branch(const char *refname);
 
 /*
-- 
2.0.1.556.g3edca4c
