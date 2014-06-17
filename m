From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 11/48] refs.c: make remove_empty_directories alwasy set errno to something sane
Date: Tue, 17 Jun 2014 08:53:25 -0700
Message-ID: <1403020442-31049-12-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwvkS-0006Pc-P6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbaFQP43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:29 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:38195 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so1052126yha.4
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J992xH4mNC6DVLIFVWtfMo48bwAucsHuDLb4hmEKKJc=;
        b=hnQd9yxtac6nIyLWiR7o3uc9u3DflR91yuQ6daYtMQL+tSaPepwyDIPpML+kVrfKCQ
         Ze6Z80lUlXbvR5k7iMkQaHPg+3VJ580/KIZyuTkWAVL/ylxHaf+IGGFIPqqE2JFXM/qT
         maONCbFVkZRaIVGj9Zcx11YB0Ii7yiIDpEnrDqVsHEkb+KfaMP/gwHXOTIfTuk5xS7CK
         ix6aDlKyp6Ac6lUmsK1vt9GTPmDzk6Q7y1xkpgVMOnjkbxIyR6cA9cW1Ep+3QJfH40kp
         VJmWjOZBkL/u2jnnSm/e4xpKxKIIaCsY+JWNvao6Syx2OW7GQues1McgNiB9QNIcX5bL
         wQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J992xH4mNC6DVLIFVWtfMo48bwAucsHuDLb4hmEKKJc=;
        b=Bj7Q1PVI1AS3qN/cbvSxeQyuDRf5P/7odIea8ETQZjCzOzXX4R049reqmZopg4gPRw
         Qnk8xfSHBIapgS8393Y4r0oixC5ai3D8kRa0EVFyac6lOO4sShLm7QxiIJiPtYIXmv9S
         FgVzc+DlSMZYovIhytYxaxCC/+4Xcyvw0IBuK4730kFDuEW1ue3KYjtUBkAgKAZ7nyS1
         VnexhWNvIn69nNAz0A7PFx4PcI0t69hMe1fMpoqxeUs4yx6WZj0HDTYnrrqzOMNuTAX7
         Lujsv56yPnwseMICY62uwxoiX7tpLtVO+Jk9//4PSXcTSW+HcwrMpN8UpGQi9tz3koWi
         ACDw==
X-Gm-Message-State: ALoCoQn0HPzQZsTYRSGQrXk4JCwQ+d1CwBycu/RFIatJ1OpMbpgOag2QroA3AIYHxdMzTnzUUxd2
X-Received: by 10.58.182.137 with SMTP id ee9mr2034435vec.37.1403020444743;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id z50si1209153yhb.3.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9318F31C76D;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 32C5EE1797; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251904>

Making errno when returning from remove_empty_directories() more
obviously meaningful, which should provide some peace of mind for
people auditing lock_ref_sha1_basic.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index a48f805..cc69581 100644
--- a/refs.c
+++ b/refs.c
@@ -1960,14 +1960,16 @@ static int remove_empty_directories(const char *file)
 	 * only empty directories), remove them.
 	 */
 	struct strbuf path;
-	int result;
+	int result, save_errno;
 
 	strbuf_init(&path, 20);
 	strbuf_addstr(&path, file);
 
 	result = remove_dir_recursively(&path, REMOVE_DIR_EMPTY_ONLY);
+	save_errno = errno;
 
 	strbuf_release(&path);
+	errno = save_errno;
 
 	return result;
 }
@@ -2056,6 +2058,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
 					    int flags, int *type_p)
-- 
2.0.0.438.gec92e5c
