From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 1/5] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Wed, 18 Jun 2014 10:24:27 -0700
Message-ID: <1403112271-21331-2-git-send-email-sahlberg@google.com>
References: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:24:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJbO-0007cJ-Jb
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaFRRYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:24:43 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:48455 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbaFRRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:24:35 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so126720pdi.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqb0uh4knb6RRONR3fEUxrnf9hPDMKNE9YN25+UW5lA=;
        b=mxtp7Ac526VoQeMuoed/ESMu68jWXBbevLp+MqWPt6A07dMY+wF2f68PCfaZPyna+N
         aPzXpB5bEUA/JYSWdq9Z0RBW4MIaNX0PyStG0lX0K2JnRRLbn4oV6NKs5JoomX3Y76x/
         z6jG3JWEAGmbz+LLOueWsHKLG6PgQqdn/t0XL7YtvWbRqKxZQqOOn8ikeuAM2BXqs80j
         jy5muBEBT7Cn984CchmyTr/gUZx66aEhwhzRLoM9iHz6izGHBu7NafpEsxS3TegVugxw
         7YmqYAJuflRRf+F0mkJ61gK0s+NjZZi6cBTn/XPRD5zHy5PNxMbLr/oUCndFyMODElbd
         Vemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yqb0uh4knb6RRONR3fEUxrnf9hPDMKNE9YN25+UW5lA=;
        b=fJzCl/rcTDac2koBZM3bhmLcvhY0yY/EC9azRVIv+O6TQwbf3HB3BHD/OZSpjdgIoR
         OuPzV8dWNUieR9SZYhoCWMaEuX4NZDyM32Z7E0KcirLIbMezcTHgSntWDmRRQSf+EhB7
         MX6EZK9eVFtWFXzwx+SfpDa9p7hhUhT7D72RFGUZVd2ujR0fiKWbAm9Jb3AT2n0EJ5xU
         Qj1taeqQqGK0RNMCJyL+FzXu76obK5nHyoPte9Gj2YsjYmm+yT3EXL4mZicJgK06Rm0N
         1zJAio+8L/2Ubm6Nx1ant/xFgh6PGSDcY7Xti5Pw+tLa++Lib467Gvha2d5VeTq2sb3v
         ITdw==
X-Gm-Message-State: ALoCoQnYc2X37s/wdTPBysai97etBUl5LHcBua4DYIGPWP9jZ19OCNw0V2rJ1xIkGgFR5o+J+u+Y
X-Received: by 10.66.102.9 with SMTP id fk9mr1356269pab.2.1403112275011;
        Wed, 18 Jun 2014 10:24:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si176303yhk.4.2014.06.18.10.24.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CE06B5A48AF;
	Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C8C1E0A43; Wed, 18 Jun 2014 10:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403112271-21331-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252010>

In many places in the code we do not have access to the individual fields
in the committer data. Instead we might only have access to prebaked data
such as what is returned by git_committer_info() containing a string
that consists of email, timestamp, zone etc.

This makes it inconvenient to use transaction_update_reflog since it means
you would have to first parse git_committer_info before you can call
update_reflog.

Add a new flag REFLOG_EMAIL_IS_COMMITTER to _update_reflog to tell it
that what we pass in as email is already the fully baked committer string
we can use as-is.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 20 ++++++++++++--------
 refs.h |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 95c3eb8..11dcb07 100644
--- a/refs.c
+++ b/refs.c
@@ -3521,14 +3521,18 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
index b674c20..469d27f 100644
--- a/refs.h
+++ b/refs.h
@@ -315,6 +315,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_EMAIL_IS_COMMITTER 0x02
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
-- 
2.0.0.467.g08c0633
