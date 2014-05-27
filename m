From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 07/41] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Tue, 27 May 2014 13:25:26 -0700
Message-ID: <1401222360-21175-8-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:28:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNzJ-00063w-2v
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbaE0U2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:28:16 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:45622 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbaE0U0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:04 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so1510002pab.3
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=50yG6Tpk0C9IgxDFKNVcUATWEyxpVfkZSLp7PnoXjDU=;
        b=Tzd9V11WM/NvfAtW3/3Rnt8t/xoAHhNsbIWWgs8CpJyz2Rzd339rGCDKBy7WLMw+sj
         TnjxRARnQ7xEzfBEDWKlsiLhRuAQjW5fa6MJS6qtbTp65J0Mkr0rnGlX/+Rfj+ro9Zjw
         GkAm/5NKKd6UsadNurrT+DJGvUrjDhCyCGZ64T9ke9NnhwjC7MHqPQqI95ByRvYS11Hc
         RKFC97ISG8sAy7WUnO0MjzBaoGjed0XMfMYu9YSPpxOvc2gaTv67z8Hjjx1nWqg1rn7I
         05MlIjXbctWl1UkFBMYWWjYC7XH0wGNKxz+e6lu4BiQLNKTp4786kcU5myuvWGSWHclC
         yGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=50yG6Tpk0C9IgxDFKNVcUATWEyxpVfkZSLp7PnoXjDU=;
        b=U8LytdgMeycpyemMf0Z91mmvLXvwt/tY4ayP7eQ3y7srUk2JcESdae8B4qXWQ3LP/u
         GA/kk2n8v+C/xAjIYlKPw9JWCHkAAPvMj+WPYtNPFOGHX+2dmUUEEFg/UB8fyKbCoHyb
         yg2DdG7bU8u2SiLQhizKq56qx+BHDXLpKt/lnvww9i4CEAQxzlJCuWp5uboxj8V5bTXn
         LME/3ZTV/ciUNDAa7bTWoZYvKIsQp2vnoKHt4QNwAWxiokfWVsKHHn6LJdL7GYFc0uEP
         G7kgn/+DwOBXg1wG13Y/5/UeE2+Esrv8KBYQaBhHp8Z+se6w6rhV1+SNOnf3vdNT81Vr
         RlHQ==
X-Gm-Message-State: ALoCoQnXOb27dvooIEPhFAslw4iJjw73uaSGRqoYdaUywJaEnKxWCCnDOFc63ZiRxyS9vVZ/C2bt
X-Received: by 10.68.137.99 with SMTP id qh3mr12535355pbb.2.1401222364135;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n59si1574265yhi.6.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id EC7542F4AD1;
	Tue, 27 May 2014 13:26:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7C01AE1170; Tue, 27 May 2014 13:26:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250237>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2da62ac..4c7f4f7 100644
--- a/refs.c
+++ b/refs.c
@@ -3410,6 +3410,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3417,6 +3418,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3447,7 +3451,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.rc3.474.g0203784
