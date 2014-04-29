From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 20/30] fetch.c: clear errno before calling functions that might set it
Date: Tue, 29 Apr 2014 15:19:05 -0700
Message-ID: <1398809955-32008-21-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGNG-0001oQ-AU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965303AbaD2WTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:34 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:40380 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965285AbaD2WT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:26 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so159818pab.5
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BngyZw/KSuXlnPRTHs9clBAMFikYc8rLSMsn5nrg6OA=;
        b=BGi5Jkgmv5dRIOVAmA+OssDubrUtZnfMlLwLlZ/05jcyEH2/8613IQa7+bw9LyKDB6
         1r5PV4vtPSTgq3B+Qwnn3YM2Nf5X4IRQjwq1mw66iuDq3E2rrClkpO9Nq78GcYkosrvd
         s9qW4kng5ica8Z+HZnMHGhpKCwZ2dyryDPzV4ABEodvJ+IfeoAlkJ0RUqQRXzzIWgVSv
         h7Yp71l2PXUG27ETnjvHdFebqKXTxvpxuKJTyFz9f3dKyc53BZRj05uGaYIP7hRigvZz
         DFntcJ6LFT2k/2RX1+W33iTM9KKfUzP66IDxsRYEi2LJAZ4oU9Uxciu1oFT+59VPcoY9
         2IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BngyZw/KSuXlnPRTHs9clBAMFikYc8rLSMsn5nrg6OA=;
        b=a/VKs/dW9bksnhAlY7uYg+SZYa9D0pqoulaD7LiuACkAu5Pwk44QXkAF7GrALmePMY
         CS//wad4/xE8yosx2hiEc8DHj5E3DEUMmhqxhGU+2vJMzEjMr8BsUIFIpzF7/OqgP7ZP
         7+/RnnxHiAPuaMW3mrLkydjTA2s0N1HEIqN3sUBRfKLXds4/EujrV+LvCXnljWJO+0M3
         5xc1tuRxDDFnD4grON/Oq1Gko3rFqKnd5wrg3cv9yQWPTO8Eqr3pmrtk1fWeYvQKRqMD
         AjZhvO2EWBKMGQ06J6SygZbfsTotwhnkykMPmgfScPKrd2JECjWXkHmMXCVLKojrAVcI
         oglA==
X-Gm-Message-State: ALoCoQmRFZ6TYtICxhws+mAaOiRp6fGW05KxekggAM0Yy/QR6Nhwr22Q7Yh2a+PQbm3Rv81oSxeS+vuZxwxGojN07TgWvwO4mQG31fyVL/IWxi4bIabsGWwJyfCsSXvAPmFnf3yLz58v8FLGFnGCbbE84vPNvY5zkveJN70H1jWU0jc5qQc1xSGQhe/93XJQ+Tp9JLdWvdtg
X-Received: by 10.66.124.168 with SMTP id mj8mr271108pab.29.1398809965841;
        Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si2738502yhb.6.2014.04.29.15.19.25
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A020B31C1D2;
	Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 645B6E0B2F; Tue, 29 Apr 2014 15:19:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247630>

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
1.9.1.532.gf8485a6
