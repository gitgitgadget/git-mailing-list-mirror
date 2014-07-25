From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/5] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Fri, 25 Jul 2014 09:58:37 -0700
Message-ID: <1406307521-10339-2-git-send-email-sahlberg@google.com>
References: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 18:58:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAipb-0005al-T9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934656AbaGYQ6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:58:53 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:62838 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934604AbaGYQ6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:58:49 -0400
Received: by mail-qa0-f74.google.com with SMTP id j15so769642qaq.5
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37VdBckZ4Tsr8upMgHPguXub9EHqnOgyn8yJ9FszFl8=;
        b=UUc6aFM2bszRMdW4b4T2aaVbLIuS+SakdU11H06ifiKk3H/fFNvIWbJY0G9RC6MQRR
         SjmPLlpvgX7pHf0fod+YpWg3hTNSYB7oAufsmWWeqCF/mQX1qSGCyAo65J7r3ATD7jv6
         BoXQIrnYfkUjORaiQT3vZZ352iUAm6ntyGfFyhytXABhuWOzH3ln2yk32I+qOaLceBh9
         rCOz03x2fEobH1SxHM7YiTT4OdWomARIGxtB6rfgTCO9XZ25P6ol48RVztFOoSMTN3ra
         Zna7dTyLhvGKLxSb6kU3IANB9Ufw9M1cybE882EbW+qGgqcgxBW7braattdfPDqZHgV3
         Fegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37VdBckZ4Tsr8upMgHPguXub9EHqnOgyn8yJ9FszFl8=;
        b=N5UWGk6dZ6zn90wqm0e9J5tSikGIqgtVStkgqjn3Hr0RUxkUEVM/QZ/3xHpDn79v8t
         lQQC9POSIqUCBt9VRdHkWTVM4bC5KiitzKyabcEWviBWwHcni4p8NIRevfrUtpuJnqaJ
         WXP1XANrMmStT0t5D+1Fi6HNZbrmZ9Y0VO0DVqjgE6Pni/xU9lxmaZjH3iIsQs2vZ8V5
         8nnCqs6H1YgUkxV7e8Hj/XSQTQZB7zimEtBDKkrw9CQlQxyfBGvPlMBpYZK1isLBf/aJ
         D+68npp8Q90M+VTRYcr8mCIb4TIhyQwWEWYA6dVP7zd/FL50xtnUj5oNstfIj2r+17hH
         NViw==
X-Gm-Message-State: ALoCoQnLXIS2gr+pl41xNCf/SbkKCHgbVbs/aqJqVsszhUVzL+q1qaIttIW7YtT/81P7szaMZT01
X-Received: by 10.236.102.239 with SMTP id d75mr6290513yhg.21.1406307528463;
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id p3si1291707yho.7.2014.07.25.09.58.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 536215A42F2;
	Fri, 25 Jul 2014 09:58:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E888AE0CED; Fri, 25 Jul 2014 09:58:47 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.508.g763ab16
In-Reply-To: <1406307521-10339-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254232>

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
index 2662ef6..6c55032 100644
--- a/refs.c
+++ b/refs.c
@@ -3522,14 +3522,18 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
index 0172f48..eb918a0 100644
--- a/refs.h
+++ b/refs.h
@@ -309,6 +309,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_EMAIL_IS_COMMITTER 0x02
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
-- 
2.0.1.508.g763ab16
