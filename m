From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 23/48] refs.c: make ref_transaction_begin take an err argument
Date: Tue, 17 Jun 2014 08:53:37 -0700
Message-ID: <1403020442-31049-24-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviM-0003eu-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbaFQPyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:19 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:45642 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so1049906qac.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2rkYgXA96jWfDj6DPq9yFfFpiNzM9JfNW0uuCee07yU=;
        b=gCLDV2CzwPbNItE6WIVEdAhBtlqyH8PEeVD5AWYM2qzGsyFSTCW9Rxo0AKsFRI4Mq+
         JFihTe9q2PgK7Qbgid0DeEzkLOw3g+Mr8Yuyew8i2llClJUV4t6FxL6vq5yJXitc88Nm
         vtZRmkolvo/8J7f8YU4wHgRN5K66QiHdyRi1C8z5uJa1MCCVQEEFyi1E4q1AAwdKu523
         ZszZYLT9HFIx+ymis9e7a5Bssdrt4gWJjXhBaI5zxsR6+Z3r+Dq3kM+W87G4k6fHCHif
         EwYWQGy+n89MCIkk4SVQfRRzgmYYJQhT0xeP3UyaRyWyLpPRcdhybJQSBHmfjW+04RFU
         ptNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2rkYgXA96jWfDj6DPq9yFfFpiNzM9JfNW0uuCee07yU=;
        b=kyF3FCwMF3L5tkSvnwFeUmH45r3wEFBmahg0snNzonS0znuWFSb9CJDassjGA2gowL
         UN0Hf9pmf4CRXtiG+u7j6zDck7hefsWcePmmgR1LpTMknak8bfs+9JNwVVjPJuMYbavx
         Iq3G5sOAXuyuWms7GvSkndzZrkmbCh5z86/tp4BXSMUMLz3wIbcqHpC0vVcY7Po09+wE
         66CGn1gxKAog/7PWpho4b7fLZrWN4o6n7pl/KUxcCmnjtQRR6SqjXc5UD3ECG1xmlKHt
         NH5mfDO49BODUDxd9RXoH31jUKKxeBarp9KYd76PR+XxGeajx/OtewYe5IOdDF4Ygwjl
         WF/A==
X-Gm-Message-State: ALoCoQlxs9pWX48yU3H1wmzEhGjpvgrC6GbhatAhklKPUPGlcOxx39nW3K7tGksoJ5Ih6cp4zJm2
X-Received: by 10.58.72.135 with SMTP id d7mr479876vev.10.1403020444994;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si1209969yhm.0.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D384E5A45BA;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF6BEE0F10; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251874>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
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
index 93edb69..e2a035b 100644
--- a/refs.c
+++ b/refs.c
@@ -3420,7 +3420,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 3bc58a6..e94cc27 100644
--- a/refs.h
+++ b/refs.h
@@ -269,7 +269,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.438.gec92e5c
