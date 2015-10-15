From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 15/26] refs.c: move prettify_refname to the common code
Date: Thu, 15 Oct 2015 15:46:39 -0400
Message-ID: <1444938410-2345-16-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVS-0007RA-K8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbbJOTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:58 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33580 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbJOTrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:23 -0400
Received: by qgeo38 with SMTP id o38so36979395qge.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ZqYDmng2i2BI60rhr6bSUzHpJ4EF5yePvl9ANWwYIU=;
        b=cvKwFp9Hr0YDGnNC71tbrvNDXZBzi5MHa6JlUUCNZvyzoX0Zj2qu8aYv0PP0AO1q3y
         IZ2sD7CL0r+TNYlrnpelfB2hmaX6nRPlJRtHKhOZSDA3atFFwa9VlmpIrqYV0NQ2k+UZ
         ptfbNw7A8XsOqYcoEt2MI6ys7QQrgvzVzlugxrsP+p2i2r+zG2TRpwyHjxXlD1BdJriF
         2J4s5uthIJacHVewXOdEv+kz9+WaA8YJWkXXqG1zpTnzRBnb7TELlzZRbbEI2utN5rcP
         JtMiokJXz0Ztb3f4vfRX4VyVgCfcxGCevuAIfKwSKAS7HW5vKC53PpKf+xAP96REOw+M
         bW2Q==
X-Gm-Message-State: ALoCoQmUmX6HVesOLXUzt58lxfsrBgDUM35EXtVS4/AK+Dbkjzab+4A4TuMKkepWMbh68Kk1kFme
X-Received: by 10.140.107.182 with SMTP id h51mr14059045qgf.86.1444938443019;
        Thu, 15 Oct 2015 12:47:23 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279697>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 5c6c743..c8b44ab 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2052,15 +2052,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
diff --git a/refs.c b/refs.c
index f2f8052..642a2ab 100644
--- a/refs.c
+++ b/refs.c
@@ -737,3 +737,12 @@ int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
+
+const char *prettify_refname(const char *name)
+{
+	return name + (
+		starts_with(name, "refs/heads/") ? 11 :
+		starts_with(name, "refs/tags/") ? 10 :
+		starts_with(name, "refs/remotes/") ? 13 :
+		0);
+}
-- 
2.4.2.644.g97b850b-twtrsrc
