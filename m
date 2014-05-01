From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 20/42] fetch.c: clear errno before calling functions that might set it
Date: Thu,  1 May 2014 13:37:20 -0700
Message-ID: <1398976662-6962-21-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxkK-00011h-55
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbaEAUiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:02 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:46368 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaEAUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:54 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so674154pab.4
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fv5EPf9YGbmGBBo4L23rClkhgHrriQYUDt2/KB2IE0g=;
        b=Boh7wO7nf+f4g8aFZTNevYfx5ecaufq68dmAwEKBTiwOmO4OMQ7Rqxa8unK6dU2Ota
         hvQMm5LJf1AX+6baYXGJl+cIQQvON4V9FGW6VBFHv1XT1afM8ZU/YJdE4myjwqfO1CR7
         AUxAO6qOwIwP0DPNWzHiLBGhjgpQy09p8NrXdzdiYoVpOLbG/1glj6IEjhQf5eW3Lmla
         Eo7Ky81b9zNMKwBVnTA0zi7XC8hqWgCRc/2JzJ1Seoi0k+B/c2lPWBOunGnU9PfBivCj
         r2BEl0jbXIZI0tHD1xwlry30v9GTJ9Sb1bThigWptwSTV/bR6sy7zGN2laWESYfARiW6
         dezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fv5EPf9YGbmGBBo4L23rClkhgHrriQYUDt2/KB2IE0g=;
        b=Bf+Q/D4rDccLO3OnThGv1/OsyFKqm1AnUUrkyXV6OllLZgEU6QAYWCpoPB3//Xk+bH
         k2Mv2SQGKHPO6huO6NXUtPo+5K+lUGVcEI93NkgqS18mzRDSbLqnMPq4KCRpeLmct/ES
         abncLD3Mv45XSuAbIKffW8YZ6rSjpQuDZb2yzq1Q5V71wYeaFmva6rXqz0P/Sei92ooa
         sStTANPPj94P6CXz7s/hwohxeTdbQBenGhkvPNtB47w1pP62Qt5jZxZS+NctLFTP9pi9
         GujXFCTzwg8K3V1R4GGquDWtnHT6N1z0iB7k3FudVAXmQnImxahW4h38/jR29qK7OwAA
         judg==
X-Gm-Message-State: ALoCoQl3DNOlSvwinMfLPrJnAREkKTAHFEIEQjOIvw7Wzh2OiiEUKeuiOUut1hYMFRiEpU2EfQoR
X-Received: by 10.66.66.35 with SMTP id c3mr6828348pat.7.1398976673636;
        Thu, 01 May 2014 13:37:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si3104400yhj.2.2014.05.01.13.37.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 6576031C1CC;
	Thu,  1 May 2014 13:37:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 04E48E097F; Thu,  1 May 2014 13:37:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247840>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIT may cause us to return the wrong error. Clear errno before
calling any functions if we check errno afterwards.

Also skip initializing a static variable to 0. Statics live in .bss and
are all automatically initialized to 0.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..a93c893 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -44,7 +44,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static const char *recurse_submodules_default;
-static int shown_url = 0;
+static int shown_url;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
 	if (!rla)
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
+
+	errno = 0;
 	lock = lock_any_ref_for_update(ref->name,
 				       check_old ? ref->old_sha1 : NULL,
 				       0, NULL);
-- 
2.0.0.rc1.351.g4d2c8e4
