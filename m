From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/12] wrapper.c: add a new function unlink_or_msg
Date: Wed, 16 Jul 2014 15:23:02 -0700
Message-ID: <1405549392-27306-3-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:24:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XcU-0004X5-Au
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbaGPWYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:24:03 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:41232 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-ie0-f202.google.com with SMTP id rl12so476326iec.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IwkZn7jZ/hsDB1L/t+9XZR4QNVNDsQf0kuq/jcLBgtc=;
        b=Y94eKE0F3BklO/NlKEjXfCfUvqsNoKnyQ5JgaignfqTNn8pxs+Xqe6VWIUUA8zD8Vl
         fU+fD2OcCvtxbDV7ubA6mG0QsGncsC6wvP8MA1Pl91SD5kxqDjZ44ijiDDQb25dX3SkX
         UtqD8SZD5jTt5fV001zIo7r/cmF9ZaWS7B80okchGv2I4IY2Bkps9aM+RQ4R2KToZJvC
         bKj0ai8yLasDCoqBaRzYRGbs06LyUyUjsL0TUI3iytc++duGkfCavOB5wpm9+oumafNI
         JtHwQAFzOup6/7mXzkZrrcOkxy4N49dQ0xJ3pC6MH3TiZURcgmqgbBmsrUHssUM8iqiE
         AcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IwkZn7jZ/hsDB1L/t+9XZR4QNVNDsQf0kuq/jcLBgtc=;
        b=DPJ4yZGRoJ+wOVOF0veVXXUIRxbsQdLA6vVzIHmEy99NnSqXF3EWTihn+Yx+ezulN3
         wB7q+0YHbWakM0DKLgAd/WUgmO9f8/Sg+QfzAnSY5BiReTmUrEADbSlE2MfU8rGQbmUN
         WzRnUYEFmVUO+05by0MkS1cDtZ9uszc6IK/ix+uQLLdK0/vq2CPHGdDsUr8SBaz4r2Gq
         KQAJm52hxupBrTrecBRQ4pDyor5Td6upxSPP6akH7NURvzgK8eNAOGUfVF/i9wxVMNap
         X7nMLoUlqqs6UHK9DJkU2Ey5iZqmZeeOd66tG9oUL8e03WzE1BPhDF7uw0l8b3Qb5TxO
         iv8A==
X-Gm-Message-State: ALoCoQlDjmQVAAsOk62a6e9VzCKJ/DZxawQvgkEtgEQ8l0RTEXnHm15M3daP3GypGQfhR5YpJLMw
X-Received: by 10.182.130.169 with SMTP id of9mr17160438obb.27.1405549395893;
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id v12si75149yhe.2.2014.07.16.15.23.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B00D85A4065;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59F9AE0A71; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253711>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 git-compat-util.h |  6 ++++++
 wrapper.c         | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..426bc98 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -704,12 +704,18 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
+#include "strbuf.h"
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Always returns the return value of unlink(2).
  */
 int unlink_or_warn(const char *path);
 /*
+ * Like unlink_or_warn but populates a strbuf
+ */
+int unlink_or_msg(const char *file, struct strbuf *err);
+/*
  * Likewise for rmdir(2).
  */
 int rmdir_or_warn(const char *path);
diff --git a/wrapper.c b/wrapper.c
index 740e193..74a0cc0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -438,6 +438,24 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 	return rc;
 }
 
+int unlink_or_msg(const char *file, struct strbuf *err)
+{
+	if (err) {
+		int rc = unlink(file);
+		int save_errno = errno;
+
+		if (rc < 0 && errno != ENOENT) {
+			strbuf_addf(err, "unable to unlink %s: %s",
+				    file, strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
+		return 0;
+	}
+
+	return unlink_or_warn(file);
+}
+
 int unlink_or_warn(const char *file)
 {
 	return warn_if_unremovable("unlink", file, unlink(file));
-- 
2.0.1.527.gc6b782e
