From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 12/43] refs.c: move resolve_refdup to common
Date: Mon, 28 Sep 2015 18:01:47 -0400
Message-ID: <1443477738-32023-13-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXc-0002mx-0J
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbbI1WDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:10 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33899 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961AbbI1WDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:09 -0400
Received: by qgez77 with SMTP id z77so134278576qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oaYQvhiifsTGMMXjp5BT89q+7tF1/6cXkPTe8Fip9Is=;
        b=mxdanRiN6q4eXngh5w2K6aHyK2ywQuL3UfdXKhrZ76tJO9AYoc4LzLk/h55vqXWEcD
         J9edglYOY7AVAGHp8dw+dyW09MnwFQiprUf+6N0nzNwfbMMclRuth0i1mOXO/veFSMs/
         S6zklnQnflNmKSs9kzx9y7jJmeTfQdJdYuEUlDfepa+J8NDYKg5Q1y09UpxB/sduCz8X
         3lqf2EIcc8OyFJyADoQUGIxQ43NTVz2OW/NA2yct3wf1iEh8ZRpP0J7fUR2u0aQY3yCZ
         WFTAta/Jk2AuKRYuDeLmW+min+5TvylJzrDv5Q1jio1mmCbG35gPUiqK/jZCNjJbVVnr
         6Akg==
X-Gm-Message-State: ALoCoQmKaarrjbZi4g97d27ZEbaqASWzV4ozqLMMViMR6ae37Gk97w0O7fPmgSqEoy57TGf0uQAV
X-Received: by 10.140.41.81 with SMTP id y75mr25482685qgy.5.1443477788607;
        Mon, 28 Sep 2015 15:03:08 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:08 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278795>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 7 -------
 refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index d46474a..e3f7b1d 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1789,13 +1789,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 	return ret;
 }
 
-char *resolve_refdup(const char *refname, int resolve_flags,
-		     unsigned char *sha1, int *flags)
-{
-	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
-						  sha1, flags));
-}
-
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
diff --git a/refs.c b/refs.c
index 242f66d..039e5c0 100644
--- a/refs.c
+++ b/refs.c
@@ -651,3 +651,10 @@ int ref_exists(const char *refname)
 	unsigned char sha1[20];
 	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
+
+char *resolve_refdup(const char *refname, int resolve_flags,
+		     unsigned char *sha1, int *flags)
+{
+	return xstrdup_or_null(resolve_ref_unsafe(refname, resolve_flags,
+						  sha1, flags));
+}
-- 
2.4.2.644.g97b850b-twtrsrc
