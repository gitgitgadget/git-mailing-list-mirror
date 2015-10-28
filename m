From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 15/26] refs.c: move prettify_refname to the common code
Date: Tue, 27 Oct 2015 22:14:16 -0400
Message-ID: <1445998467-11511-16-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:16:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGIE-0002aQ-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbbJ1CPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:11 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33993 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247AbbJ1CPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:09 -0400
Received: by iody8 with SMTP id y8so86370257iod.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ULLMvo8hhzppjecUmhl0LxJhZsyUTqhxGHcbXYSfNpQ=;
        b=N+slIqKxkTKBpDXZdgpSnEnWfWguM1xWIBGrtO6mtMP30ccoZNmp5vAZK7Eyq+kxIz
         OB0tE+pOgpJiLFFAthZi8kY8cG8f2wSph2O35jfc+0FUvfRKCOXoPQTEpKf8r3PW5emK
         q2fZMoDJFbo3Xg+PojbIZrTyvBnXrJqzTuxtIlsXyK1jxSkzPmBoqcfcyHUf+FrHO/R1
         wqXId/Oh2tpr6qjcYPfsYUJWL0a/bX/akISFipgE0nPNHisHdcwbxZZZAx76eNEAXG3m
         WJvjroT5f7lb/8I9/K/7mB5YEyC29mqav8W6YyrZ46MY8XsETkSZuwAX5jf4de2aN0CD
         b7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ULLMvo8hhzppjecUmhl0LxJhZsyUTqhxGHcbXYSfNpQ=;
        b=diZ1aDXTraQY51DYLdv4NZMRfLukNXMUfmaF6nhB1ut0oGqny2dzI4R4thsxeiskm9
         WiM3/zhnYfL/9RJCM0y3L+js5qN5xBGxT1s/0bognpmtANgxHhvTHvPZ/cOuhJ5/aTY+
         j3z/VQ/BRlwZyFERpT62FFIFRv7b+4/hs9muXqH+KZYk4ErvPheaz34vlzNwD95Wx2hD
         QjvDScNV+qZ5UvXqMpvgfKOWJXdnHJw5060CEU+LDIzMKUIG4Uk3lrAI3L997jm/uTFA
         /A8Ry2JOkJlBn+1OXBI+ZLIki9xW/BfscS2DliHJsWRWO6HUYHSrmTWG2Sq6oDQRr2GJ
         RxKQ==
X-Gm-Message-State: ALoCoQlW1pD4/FUp4MDlAfbk1J8MavzR1HQSiRcJtHkLyhBP7m7hSZFxq6VmSjK+d7EPDyO9AeoW
X-Received: by 10.107.10.95 with SMTP id u92mr45901997ioi.180.1445998506308;
        Tue, 27 Oct 2015 19:15:06 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:05 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280348>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 8eb4b93..c5cc7e7 100644
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
index 2aae268..d89a8d3 100644
--- a/refs.c
+++ b/refs.c
@@ -736,3 +736,12 @@ int is_branch(const char *refname)
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
2.4.2.658.g6d8523e-twtrsrc
