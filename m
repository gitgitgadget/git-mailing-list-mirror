From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 13/22] refs-common.c: move is_branch to the common code
Date: Fri,  8 Aug 2014 09:45:00 -0700
Message-ID: <1407516309-27989-14-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:46:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIr-00085S-5E
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993AbaHHQpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:38 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:55101 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-yk0-f202.google.com with SMTP id q9so765454ykb.5
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XqgGi9xOW0dr4zLZMB/DKXGJUO43Og/qVY0TJuiPz3E=;
        b=dnHovdx1FmhEowaspNYxRKLI2YAx5gaZWFNhuE+r9nxlP663dkSoO3Ps2GBwFXvTTO
         7ZUyVkoRXq9VxGMiyvUFvvSOzy2Xch9ppchjJLLQuxynL8NPmojYraBYV2i2L64vR/HR
         ORTZLOULtJRAzOxFZrSbqSc/C5Rbfy3mm5GhI+yEi/mcuTEUwJnEPxc4ugmo2rHJbv9t
         SdIdC5LhG3BPQkXPxVzHbgzXs717UPa1STVJiMO2mev7nf+EcwOMn4dleETm2KZ+IeyP
         vwqaoxLbxgTc4ujOv2BIjo34w9Lez+wE9oQoXSsIyKPo+IECS1YftmBu8Uyru5H/Up0K
         uXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XqgGi9xOW0dr4zLZMB/DKXGJUO43Og/qVY0TJuiPz3E=;
        b=JQjMEKwlpLbBCQSyvlOGo15heX1S73xCCh4/8Llpu9uDz8Ohq37q1oXnAn9/KUdkv/
         KdOCikqcjAyN/xjLLbkc4+BVKbkB580MW4ItmaJqNrh329yKIFd+2q9tQaw5fwIHiDhr
         scOvT6GOfhnjA1tk7KYrMzJs/T+1umrN4BbaDNde/V8hkoFZr5mOVQnsyGduMo1JXUjg
         ZA0aApx3/DE446/MiTq8wkh9ajKmy0S36je8dQ66KtZhNVTXpymtLVHorLC+CVt8+uL/
         5Ngz2bd3/DNbCojjzPxiQ3MproNfH5/pCKeKMZ4fD9jotgEyhqbmb6CC00WI6y9K90cT
         CbAQ==
X-Gm-Message-State: ALoCoQkc99qezr2U4DDOg3qAjNgmVxqW6ORDPsOdQTmfrzwOz9twvsgCPM+aGSKmhvDx8TN3OkZD
X-Received: by 10.236.69.138 with SMTP id n10mr5247166yhd.49.1407516315986;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si505697yhg.1.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D396931C5BA;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7B79FE11CC; Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255035>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 5 +++++
 refs.c        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index f8b79e0..5f83d7e 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -3,6 +3,11 @@
 #include "refs.h"
 #include "string-list.h"
 
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
+
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, struct strbuf *e)
diff --git a/refs.c b/refs.c
index 55bced9..70c034c 100644
--- a/refs.c
+++ b/refs.c
@@ -2483,11 +2483,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 static int write_sha1_update_reflog(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
-- 
2.0.1.553.geee1b3e
