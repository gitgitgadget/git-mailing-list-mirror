From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 11/44] refs.c: change ref_transaction_create to do error checking and return status
Date: Thu, 15 May 2014 16:15:08 -0700
Message-ID: <1400195741-22996-12-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4sl-0004YP-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbaEOXP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:15:56 -0400
Received: from mail-yk0-f201.google.com ([209.85.160.201]:33191 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-yk0-f201.google.com with SMTP id 19so108391ykq.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ghj+7xcAyHbfzGJbT31cfnuDp+Dl6Tp+O9/YaJ3ddPQ=;
        b=bqz4mmc4I7hh745OO9AAR2j7xFE1Xr0oqgvePgepkhlc21esJTDPvITh0ZL/izaZpC
         j/DtT/j3FJCA1t0HBGBJPOtQI0IVG/vmeBLmWHuCACFTb3wYPGZLp4/pzm5JWeC70ymb
         rHgjKkHhRqzt4WrbyNj/PshLT4fsrklJ930hnYzpaj0frBQLgYDmWYy+NSQBhd+H76yC
         6jVTrQa5SN2Hp+LYPOkZlLSJFyQrqTGYWNQDJM0GBVVNxAq6iMi/80+v+xFWWZ9U3I7E
         n6JmWFJyKHeqb+z/F67FrzyVUzmn/LVKHS/YLnTWssz0UnoYjeHHQf7fcJwcVcpWnmqS
         C4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ghj+7xcAyHbfzGJbT31cfnuDp+Dl6Tp+O9/YaJ3ddPQ=;
        b=G4840JuwoDTmWrTwM4ZFif0cYezc/47MssJc0eJxekNxNXYSNVJ7WtpQKTi6GuQUqT
         +ASlOLUPIoxRHuq8qMN52bjkHiuz9CzXp9l+/imakBofBZpipJHlSKiKevKOWBPlCd2g
         CL+si/kEffBKfDGSwvTzknBi+vSfLAbYTxZr6iojUx7q9lNeKEuilSzV5OXvR972rrrl
         ZHobDbLyv2K+IM7MbHJzXxJZcPuQjh2DN6q1bCC6ydlXw/wEjIdTF9o1/+abE3JgaeSd
         4Pqc3TAEJ8LtBEzr3Pe5MQiMALKHqY+7CMv4yRc+Dvtf9dOwA5OReeinAFC3fI1JB8RA
         lptA==
X-Gm-Message-State: ALoCoQnP6a1Ph2rdXjm/AElaSQ9hofStl8xlGj35R+5QkhFeK43b/W++6dIcrwOqGjZOed8lUCLH
X-Received: by 10.58.38.199 with SMTP id i7mr4841388vek.6.1400195744888;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id k43si318880yhq.3.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B953231C1ED;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6A17FE0F39; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249227>

Do basic error checking in ref_transaction_create() and make it return
non-zero on error. Update all callers to check the result of
ref_transaction_create(). There are currently no conditions in _create that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 18 ++++++++++++------
 refs.h               | 12 ++++++++----
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 9f328b2..e9c216e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags, NULL))
+		die("cannot create ref '%s'", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 3c9b981..344e27a 100644
--- a/refs.c
+++ b/refs.c
@@ -3402,18 +3402,24 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("BUG: create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 11d07ee..0af5ba7 100644
--- a/refs.h
+++ b/refs.h
@@ -258,11 +258,15 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * that the reference should have after the update; it must not be the
  * null SHA-1.  It is verified that the reference does not exist
  * already.
+ * Function returns 0 on success and non-zero on failure. A failure to create
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags,
+			   struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
2.0.0.rc3.477.gffe78a2
