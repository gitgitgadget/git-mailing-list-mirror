From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 22/44] fetch.c: clear errno before calling functions that might set it
Date: Thu, 15 May 2014 16:15:19 -0700
Message-ID: <1400195741-22996-23-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sa-0003xd-SW
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbaEOXPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:55 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:45037 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so347931pbc.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y2C7rUyRHoG4cJIooIc/vo34uqhnOMQ1YAgSZYiRdao=;
        b=cAhZjDm0mkmpLz9ek8Q1IOxjTrlJUxLE0I3tJratFttLbshq5j12UV8DhQuDjQseVS
         dnYSyAdBSaekgcDj+9qa6+5WD+IaZRV6MNvRYbWEsQHE3veRmJIBcSdZb6wlsM6nGdut
         RgxySu/J2m+/GWhSyxeYdtoA9FR9Kbkz0FD+zIX88cuQ+UggWyyU4S4AMNM9nVzYxbAU
         pbS2UlcLLRAHukVRy4nLAvMUWPt3ECjs1yHg0yaV5ppN5RhBHD1Up9aZKS4S6lc7q+ZZ
         OdFtzebGlY66ypqKg9v6JxneMSZAoU4c/2/xvDy8TPW6IvnjjyUBPIZAuRgQVdlJS9I1
         klhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y2C7rUyRHoG4cJIooIc/vo34uqhnOMQ1YAgSZYiRdao=;
        b=WtFJxRtKlOfcrtGRcSlnILvFE9ki/OuJfsPKL7VMQJSNLITyldH0JRrtNSn5IpfRnK
         OTXVGLltMJpp+QlnOFPPZYl89RFJ6vEdHIc87kUxJ38hBJWVNBekYmR/2xzDM0mQJS5I
         xTBChycUPJr8K2YqJ4VxNLN1QG5QhGZYEmfDsPxMO9B+yuep+fLq7mb9wu7rP8oSX6ky
         PO1t42Y393Jm/CCkRoAIgnKwkYPVIredZlyWUWhgPlAz8tp0HByaBeY52E8gRwm9oTAW
         xTpSOy0Cl7npxXWsQeeXDVw+3gLAIMcczdbRkXWIxnnLGwnYGXDBv2Fu/d5N5Nqdsqj8
         b2jA==
X-Gm-Message-State: ALoCoQlviAMrFXCyfs5GChyOcNwSKMX67niPRIp+CZUpWdpSIp+Yx3sLeL4hLm/sP4Te9+sEEbt+
X-Received: by 10.66.157.35 with SMTP id wj3mr4256450pab.11.1400195745402;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si67810yhe.1.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3B19D31C25B;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1765DE0528; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249224>

In s_update_ref there are two calls that when they fail we return an error
based on the errno value. In particular we want to return a specific error
if ENOTDIR happened. Both these functions do have failure modes where they
may return an error without updating errno, in which case a previous and
unrelated ENOTDIR may cause us to return the wrong error. Clear errno before
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
2.0.0.rc3.477.gffe78a2
