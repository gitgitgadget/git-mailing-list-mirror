From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/4] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Thu,  5 Jun 2014 16:17:11 -0700
Message-ID: <1402010234-7628-2-git-send-email-sahlberg@google.com>
References: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WshDr-0001SA-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbaFEXhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:37:23 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:61049 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbaFEXhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:37:22 -0400
Received: by mail-yk0-f201.google.com with SMTP id q9so79658ykb.2
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BKPHt+6MTv2SpLj5jC5za1coP6f7zn7Fvt5lqwEik54=;
        b=BDo8j7N/nwl4iKxfR8l7/pPeDRkkgopuVAoyxNG/oyOuYCe08uFZg8Kuv918L7R5QV
         501nEdrJwJfa2B08yvsFlNLZX9skF8qgjESn5FF8wbQIkQ+sErGxsCeXhrDIBkWDGqcz
         Hj9e1CiQdd+EZY/KG8L9AjyPgjYZdhTDclzUtuePCixmSdr1kGE1qhhd0yRxwkbRkhS6
         gCxno+HCZg4iu4mcsWnAVgSZPapDyaA+WpHLa/VgXcTHRdmpTK+lj1QsIvrY6mrgCcTs
         w6gAgLSG6IgumQb4uhreggA+gQ4/eIT5ryXUI26O64fBS7JpZ4LEQQP7ltGx+0CPOlSs
         js9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BKPHt+6MTv2SpLj5jC5za1coP6f7zn7Fvt5lqwEik54=;
        b=XUDvLTi2rDnq737oabde2pDYiMyEpddnEPtpnFkPpaG9f8senaW1d0nuDi1LifqsdE
         QxSt99pTVUhpwmBlpqcF5vxjlf6Z6Zc+VLGf326RYJgeRQKMqKm53IAxUYGQ3n82f1rq
         Ts5TDX8eM5V/94E8lwOsHkBMg80obzI/FLqgHCdqeq2DQOMqkc1Pq0Fxet1o7E0O8/lJ
         Qi0lOTNYTzxb1CmD2Zp41W4cCL3qnUTtKlJex+6uCstrl7NRXndu79PlHRgHde7WnmWt
         LBoS5D3oOX1QOXxcFiecKLvOohT1AFISHyewyrkh5giljYEv9TXRz4AL/gU4eKaTU/PW
         FdlA==
X-Gm-Message-State: ALoCoQn5Hm+CGzv1IjKJcoCJsatk43gjjJQdnrgO86uFYwGqaPiVgfllxPfrC/mxaHO6QmOsT56j
X-Received: by 10.236.19.7 with SMTP id m7mr236017yhm.35.1402010238167;
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si670078yhg.2.2014.06.05.16.17.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:17:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 02A8B5A4756;
	Thu,  5 Jun 2014 16:17:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A74A7E0440; Thu,  5 Jun 2014 16:17:17 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
In-Reply-To: <1402010234-7628-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250880>

In many places in the code we do not have access to the individual fields
in the committer data. Instead we might only have access to prebaked data
such as what is returned by git_committer_info() containing a string
that consists of email, timestamp, zone etc.

This makes it inconvenient to use transaction_update_reflog since it means you
would have to first parse git_committer_info before you can call update_reflog.

Add a new flag REFLOG_EMAIL_IS_COMMITTER to _update_reflog to tell it
that what we pass in as email is already the fully baked committer string
we can use as-is.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Conflicts:
	refs.c
---
 refs.c | 20 ++++++++++++--------
 refs.h |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 9689592..e3a0383 100644
--- a/refs.c
+++ b/refs.c
@@ -3489,14 +3489,18 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
 	if (email) {
-		struct strbuf buf = STRBUF_INIT;
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
-
-		strbuf_addf(&buf, "%s %lu %c%04d", email, timestamp, sign,
-			    zone);
-		update->committer = xstrdup(buf.buf);
-		strbuf_release(&buf);
+		if (flags & REFLOG_EMAIL_IS_COMMITTER)
+			update->committer = xstrdup(email);
+		else {
+			struct strbuf buf = STRBUF_INIT;
+			char sign = (tz < 0) ? '-' : '+';
+			int zone = (tz < 0) ? (-tz) : tz;
+
+			strbuf_addf(&buf, "%s %lu %c%04d", email, timestamp,
+				    sign, zone);
+			update->committer = xstrdup(buf.buf);
+			strbuf_release(&buf);
+		}
 	}
 	if (msg)
 		update->msg = xstrdup(msg);
diff --git a/refs.h b/refs.h
index 1b6a055..3c99619 100644
--- a/refs.h
+++ b/refs.h
@@ -318,6 +318,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err);
 
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_EMAIL_IS_COMMITTER 0x02
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
-- 
2.0.0.583.g402232d
