From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 29/31] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Wed, 14 May 2014 15:13:28 -0700
Message-ID: <1400105610-21194-30-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhR2-0006WZ-6d
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbaENWNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:49 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:57189 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbaENWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:43 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so47600veb.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9BSqTyGZaHEqwCcqRs3XlaNCLXh4ygeHMBIiJDBbOdQ=;
        b=XCCbnshv9nE+sM/CeQndDwhIjT4I1yVoEnr/ZxAzgYMgj04UqFYYSMlfTcXw8JrNP7
         w87aSEw9ZkSTeWewyQ3Ix6s6SFPXYG2hbW9NGmbiJVjkix+tpL5nF3VvtqgHlXcwJ8vE
         GGbQYBrWYFujcuhZl9dOxiOLIiCBnvCtHBUCOFYn31GvpCV5jQC4PavOjsD9frdThwjP
         DpyYiimrBXvBS2OJpsfcPNpOFuw5qciIFNxSTK1QYZ1NXDsy06wBozrESGYUxvZolP+n
         tHyRBQ/+Pg/LUwnFBKeawDm//xLcSpDDka/HC5x/NBqkBoWJgGr5Cgx05PvfzzE43Shy
         88sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9BSqTyGZaHEqwCcqRs3XlaNCLXh4ygeHMBIiJDBbOdQ=;
        b=dX7Q1ZnBLxK3OAzKR1CynuxjsH8+RfY6QV6cZek1wLtA0QOP1QuxawgZeBSuUZZ1ii
         AtjlrHpju2LNSJIppDRzNEvmvuJnCN8olEekRcvUKkqR/UVhc5NrzRx9ru/JF0luNBGb
         DOX/seIsrdlny9ODPgqeYa9U7QIlhb+kJ7Jd9ruKfVhh54C2uhP3JsmRUuLSL8Rcsn9T
         ad3ueWGBmkSdaZxWA3eed2vjFJBtB3eA4mUrHO6jJmlOFMxKKBBQBmRutiYa/AqorAfq
         jPOFjmZVzCfaIRDtuqRQ2AEoKxMIWJf9IFGirKp/BMlJR5qMV+tIjOvKi2TU7O3e8Olb
         VUpw==
X-Gm-Message-State: ALoCoQkd/zyXa2jXZti2/Ub5L1VIAnz9haWhd1P9PC+8t06Ic1SioitZC4YZzl1xYODGByhkaNUZ
X-Received: by 10.58.46.240 with SMTP id y16mr3197176vem.2.1400105622432;
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si151212yhb.6.2014.05.14.15.13.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 49B905A41E5;
	Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0260CE038E; Wed, 14 May 2014 15:13:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249015>

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
index 8129b20..46a31c1 100644
--- a/refs.c
+++ b/refs.c
@@ -3396,14 +3396,18 @@ int transaction_update_reflog(struct ref_transaction *transaction,
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
index 558a711..933cae7 100644
--- a/refs.h
+++ b/refs.h
@@ -251,6 +251,7 @@ int transaction_delete_sha1(struct ref_transaction *transaction,
 			    struct strbuf *err);
 
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_EMAIL_IS_COMMITTER 0x02
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
-- 
2.0.0.rc3.506.g3739a35
