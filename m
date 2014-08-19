From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 16/23] refs.c: move prettify_refname to the common code
Date: Tue, 19 Aug 2014 09:30:40 -0700
Message-ID: <1408465847-30384-17-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKW-0002zZ-69
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbaHSQa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:30:59 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:61616 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbaHSQay (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:54 -0400
Received: by mail-ob0-f201.google.com with SMTP id va2so916521obc.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qzebuCoH+oLcDO8tpvftf915fxyOMGUjEDLeifRLQ+U=;
        b=TslLfuecST84+6VlGhAS+6BEQuKH5JnC0zCzncbtW6s/U5KPeZUKzpP3YfTWhRk4x5
         HqfbukFZnaBbwKx/e9vScTQs7cTuY8LMh8w9KffNW6VTFWo7h3G/a5jiIOulvraSOeF7
         /rj1Dr2b/Fn6P8l7XqVoPNCzpHWnkHSVnE01X4MpNB8f1jr/OPqkHkoVKGfPHAyDPJyu
         Mdj8izoxbA8ngMpnkAkFgu0yQwUj6hvx+tRausvexY4JlgXNgYUCDS/J6KEzYn8oHIuZ
         dJD2iOhog6Xo1c51qXmPz+XL9SFqz68gzA+QaXpQY3C11w2K3hTsufPNJPeotVwfMc2r
         Wu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qzebuCoH+oLcDO8tpvftf915fxyOMGUjEDLeifRLQ+U=;
        b=FyGz7VoC3QXLc3BR/4o8nL7wfNG+WegZc0paKPbpS5xrpbAri5Jdf5Js31gfuCPSl4
         dNWtsiAtU51fvIBFIyolFrI/ss+5TlAmF0qrcbFi/6JXula+irFnOSuX64dPlqiPEXNk
         aiv9PznIC2/Uo7kXPMtgy/GU4iYr6KyWP1BwcKWK7rooEJP8tGooxRXVPifqBX4rD9m/
         pDDwbKhNxeyjRpjFgVoskMAnDrZcxC0agL0OSFfVG9G7rQG2Rxe+ezlJQio1Eui0SIoC
         QJEk5Oh1I5XAwFZ+aJoSBnIDECCNPjzVZr1QApbLj8lhHpqM7TpglR9jiRA02IWDfEr4
         XUqQ==
X-Gm-Message-State: ALoCoQmlbJl7KGj4vq/cEJ67zzYZ3wx/kCjmVIfliAppc56wyGwIL0LZI0bXue3C1IWEf3P0jahv
X-Received: by 10.182.111.170 with SMTP id ij10mr20966399obb.6.1408465853486;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h42si332680yhj.3.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4E8F55A441C;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 11C18E0F01; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255483>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 9 ---------
 refs.c          | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 6542969..fb9c614 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -1747,15 +1747,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
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
index 177bed6..d163e61 100644
--- a/refs.c
+++ b/refs.c
@@ -696,3 +696,12 @@ int names_conflict(const char *refname1, const char *refname2)
 	return (*refname1 == '\0' && *refname2 == '/')
 		|| (*refname1 == '/' && *refname2 == '\0');
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
2.0.1.552.g1af257a
