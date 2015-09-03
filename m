From: David Turner <dturner@twopensource.com>
Subject: [PATCH 12/43] refs.c: move resolve_refdup to common
Date: Wed,  2 Sep 2015 21:54:42 -0400
Message-ID: <1441245313-11907-13-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmR-0007Ih-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbbICB5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:32 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33230 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308AbbICBzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:38 -0400
Received: by qkdv1 with SMTP id v1so15671116qkd.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5nkWeXE4pWQUVmsJpikqENd/0ocxaSfUb5CltqFqiI=;
        b=VhFlHAsQ/BNm5Y4ByJ67MycAA2dhn/5hjTtCoixJ9uK1wIXmNO7//vL7A0/3ntM6q8
         6pRjCm+dsTkns9bE2wUrrXLm5pVLmiCUFGmt+G3HKH0VVT5f/syKJkcjw2AfJJGXWD76
         2BbGhVKiwdliFE3L8JPRN5I9/lI3b93YXYm0WvIkQaMWxVmejozAhYfQfrM4jwxkhV3a
         Z/67de9tP/512xidiVWX0RIwEFmBjzsFk9g+rK8geGlHe7x6F/Na31HOB4gwqBPf22PR
         mnVR4OgJQvj7v46Dj4+j2UhlBj0d5e/5Vi+MVMa4fmbtJiMs+r+yUEm/JeesGLTfrHej
         e4bg==
X-Gm-Message-State: ALoCoQkt/ql8KvVEnP3en6bRf3onlj4/wEEX2Gx3+mf7OgD3Y8Gemp8T4InGh9rDLS4p4qo7cqbj
X-Received: by 10.55.195.80 with SMTP id a77mr33342043qkj.2.1441245337832;
        Wed, 02 Sep 2015 18:55:37 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277175>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 7 -------
 refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index f67ff41..6328e75 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1786,13 +1786,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
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
2.0.4.315.gad8727a-twtrsrc
