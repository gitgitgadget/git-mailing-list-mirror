From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 12/26] refs.c: move resolve_refdup to common
Date: Tue, 27 Oct 2015 22:14:13 -0400
Message-ID: <1445998467-11511-13-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:17:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGIM-0002hX-JB
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbbJ1CQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:16:55 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36352 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbbJ1CPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:01 -0400
Received: by igdg1 with SMTP id g1so97171633igd.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wgHltIPkDNcQJug0mN11D/R3AmVBuSTbUb5r/m+sQA8=;
        b=y3rC/PC7/SxgF5ipGh4kppf0+a/cdIdixj/CmCyL/VGz6UcVsA0GJa7u+BY+QQWRsW
         UQ5PR4MUhkUiNZ7BtnaxW1RaXa56HpjA1rGLyED2ywYg0YYxEZ/5RRhCWKq0mfZdE5og
         A9Omp9eTVKE+sVDT87jt2CQ4mGOtwmpyU4GqjvG9tJISyKll/JCPLufIRTefWNHrAxZH
         C+rpqTdfzRyS3FZ3HhieuQCtchEafSwY8w0meqZjlD/O7N9n8bUM0iik/GVrBMwKs2IJ
         LGEZhg7nTHyVZ3Q/gTyu3LWKxYvj6zqIKSu/uu1SrEbwiBSbnmBAQ8g1VwadFzK4JQ77
         O5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wgHltIPkDNcQJug0mN11D/R3AmVBuSTbUb5r/m+sQA8=;
        b=CuaOCs/NByMzrEKuhdfc8E4wgEBoTUF05GW5lKLjro6SbTU1Gt71lVL7wq7mvjoti9
         z8Lk523iZ7NE4e/ickaChW9la6piYuER7PNGc3rKnwkHVQb/qAnF0nyZFnZgRfEndNUW
         VBa1n5EW4v1HwMNX9hbc0vHTECJDBXUHkgAIwL1WJr7GqPxU2wsUKBQxtfp2kER94Yuu
         Ihzo4cQo7M+wlZkl5TJUG8RhLWUjbvQ9FBkBWYEKjFYgj4c5/ubOMptQCud0Hk8+GglG
         shgOb5bJVHFQYQMmeEOEW0dE7KsxpOvKEZvKjjBvvjj5ySI/qtfsmxjrzH2hCYuJPdQL
         uaOA==
X-Gm-Message-State: ALoCoQkXoQaDLIU/EYFFYTLKsKE29htOS1rveP4JkxNffvRvGXPBQy2KEbQjPkfdzkWsjr6ZUWeV
X-Received: by 10.50.62.148 with SMTP id y20mr324852igr.80.1445998501085;
        Tue, 27 Oct 2015 19:15:01 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280349>

From: Ronnie Sahlberg <sahlberg@google.com>

This function can be shared across all refs backends so move it
to the common code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 7 -------
 refs.c          | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 7f341bd..dcb6394 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1777,13 +1777,6 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
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
index f3241e4..b605460 100644
--- a/refs.c
+++ b/refs.c
@@ -615,3 +615,10 @@ int ref_exists(const char *refname)
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
2.4.2.658.g6d8523e-twtrsrc
