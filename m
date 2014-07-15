From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] refs.c: add a public is_branch function
Date: Tue, 15 Jul 2014 16:02:38 -0700
Message-ID: <1405465358-27054-2-git-send-email-sahlberg@google.com>
References: <1405465358-27054-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BkR-0001VV-JI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759590AbaGOXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:02:45 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:36440 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbaGOXCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:02:41 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so27958oah.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=59qYewlJlHttYfQ8ftpG6Kf5dddemFiTMzKASjsxT+s=;
        b=W7hEINaaF57wCH1DDQxdN3liarpxC1DI5oKnhjrkB8oZP+mOTT8ozMx+TnfU1eC5xt
         ZCjZ6fGQ/tfT5V5OFD4O6kRjtG08UsO5FqOQB2LxgjrBQkAHvpSTsil2lRQ/L+TKEaPk
         AKC0HcLA1CIdDLUswNqsmEMkAe8vtvi0akEPLXQrAXS+e09oelIVPSx9x595uXU7k6mK
         SFJr7HCHwIfP3Ihd4SO8co+IEac7VwW+A7FCaGBfUS6GfsJvY/HYdufwbdhNu93TQEJ9
         qYmAMFBHWni9aWty5l/maP2HVxyD4MZpyAYNhYfqVyoudqb2fBVecrJqRIFeXQnFLjY1
         6cXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=59qYewlJlHttYfQ8ftpG6Kf5dddemFiTMzKASjsxT+s=;
        b=hylaENvMNRFxdSoVnNkTo3T/bMPbsNG3fvoZtWhTpXhMtqBcXExplEcUdmoqnPwIWM
         X8wm8g/x/RA9nyu5b3362N+YpEusjCb97ebsv1Gpv0cC+zVH48hxeDizkh1sxjiT+Dum
         v96f3px41prKox3xQk3jpmXVpPOeWJxhhMzRpZGSW+vL00LBMIHwiQ0phr4zN7jX5NEB
         p3Y+Li38DjWMNb09dklpsSwJG4wBKO7t7RP1pOLHxcMPTSx4MFX1q8zH6xfb0Z/Dw3UR
         tRWnrY4WTnUpxABmdLgms+GXIIY86JCVlyAB9XMkjIjveT4Vtg7hIBhO6MjSJuSgmQbJ
         FewA==
X-Gm-Message-State: ALoCoQmzwwRCT/r3eCmz9/L84g624Up30UK2yvPwuVtmWWJJq/YpS0JU1jHKfJpQ9Bv0BXX+06XI
X-Received: by 10.42.209.140 with SMTP id gg12mr13110199icb.26.1405465361249;
        Tue, 15 Jul 2014 16:02:41 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1053937yhl.7.2014.07.15.16.02.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:02:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1AA275A425F;
	Tue, 15 Jul 2014 16:02:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CEF45E0B27; Tue, 15 Jul 2014 16:02:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.442.g7fe6834.dirty
In-Reply-To: <1405465358-27054-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253617>

Both refs.c and fsck.c have their own private copies of the is_branch function.
Delete the is_branch function from fsck.c and make the version in refs.c
public.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fsck.c | 5 -----
 refs.c         | 2 +-
 refs.h         | 2 ++
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fc150c8..a473622 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -482,11 +482,6 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 	return 0;
 }
 
-static int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
diff --git a/refs.c b/refs.c
index dc45774..dc44802 100644
--- a/refs.c
+++ b/refs.c
@@ -2817,7 +2817,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int is_branch(const char *refname)
+int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
diff --git a/refs.h b/refs.h
index 4e3050d..8b4a3f2 100644
--- a/refs.h
+++ b/refs.h
@@ -125,6 +125,8 @@ extern int repack_without_refs(const char **refnames, int n);
 
 extern int ref_exists(const char *);
 
+extern int is_branch(const char *refname);
+
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
  * and the tag can be (recursively) dereferenced to a non-tag object,
-- 
2.0.1.442.g7fe6834.dirty
