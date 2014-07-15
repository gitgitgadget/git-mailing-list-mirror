From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 03/20] refs.c: make ref_transaction_begin take an err argument
Date: Tue, 15 Jul 2014 16:34:01 -0700
Message-ID: <1405467258-24102-4-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFO-0003Pj-6L
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbaGOXej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:39 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:41077 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934067AbaGOXeX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:23 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so40180pab.0
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GaB9aWnjex9q4PVWPCdKMNLw5+UM8GyvYZbolwAAOP0=;
        b=DOfVMifSBp8Z5pDpKM1Pz5kvmo33BbJ1YnsQoSeUyuqaUyvb/s6cMOhBnMTMykq9HD
         XqLNWo0gxx7Ds7J1RvVET0qwyGG3PFy7MJulq3UuewOki1/gLhjMmuciYpSRy9YlDBku
         xgr36Evik3w06fe2xmIn9ht3JltUTWLdKRxnituZgEvCHWpap2tp55hIZ31TXfAZdPxz
         yZstBdY2HXIj5dmlsJCVds8BYnAzeJ6NCwOyHc5KUXEQYFMmc/011tpzoOu/LNgK3H8h
         VibO1+4mT5QbRqfcAzxLYlB50xgTCkEb2krR/njb240IVTSDSDZvKgwK91H/zQgMFbga
         a5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GaB9aWnjex9q4PVWPCdKMNLw5+UM8GyvYZbolwAAOP0=;
        b=UsYskQvjKqdTiy+uzRVEc680v6RcANtFaNX1rIoliBXqgdhhVZL9YnnsHHHeDsB23V
         vG1Xp33ruXwHfB0gntM6jw2oqJzHKpHerc7/iHBl5Hczc6Mt2MSnTcJKMQ3u6nzH02oK
         bbT/wtm+R9xEyr3oTQRlhx+krwVlDhXE15URkj4JHEAtcDuOZwObPxu0L/0djJ90o/wN
         AIvWEKDQSrA91alBcRuk4XugQgLAyFQcE3iaQWmHHXvF+CwiDKbwG82K2hmBx1nDPA6O
         9dFujyHSvvb77luBxMWbJaSjS0C1SHW1MKr/JdLMYXUGmEr55DbhiLfS2w+y5jJfpqwF
         MVxQ==
X-Gm-Message-State: ALoCoQmKwzyGHvK0PcesVAB878srAaSK1njS47OKLxLrVXJtuFvR4ikWcYb8/Wo+dxxxoQo/XMAE
X-Received: by 10.66.124.199 with SMTP id mk7mr70907pab.15.1405467263085;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si1060882yhe.2.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id DD2AB31C2D7;
	Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 68AB5E0C21; Tue, 15 Jul 2014 16:34:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253628>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _begin with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index 40f04f4..9cb7908 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,7 +3397,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 71389a1..3f37c65 100644
--- a/refs.h
+++ b/refs.h
@@ -262,7 +262,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.1.442.g7fe6834.dirty
