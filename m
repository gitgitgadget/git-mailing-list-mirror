From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 23/48] refs.c: make ref_transaction_begin take an err argument
Date: Thu, 12 Jun 2014 10:21:14 -0700
Message-ID: <1402593699-13983-24-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:24:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8jj-0000uD-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933732AbaFLRYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:24:22 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:47877 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so309045oag.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NIpUJlLpNmtr/KEDPvYL1qSiF22sV5e2uyfuZrkJMAg=;
        b=io95fRnE/AAqzY5GDAqAJOTBeN19D91e1FyLZSvaLR0eXk5pBAFJrAkooNpWVgD1mf
         Re6TyX4Gaj9dkRU1H1DnRAOUJRfZuNP/vhsSJjf9PglBEVzs24LCxF4Zc1zaH6Z1vvZr
         Erf4b2NEwoGbCzyvBxR+RNphdCcrlgdye+z68eJOFzMWotZDyFwT21eLgW/+CCHpWNUU
         ksWaWHnXiCOvRyZe9jitoKaJ94wmJRYlw9eW0MRJRkSaEyzANc05ArXJYlDoF11m/zs5
         HVzgfASzfxuQZTHQ2J6Dz79y2dk6zOmhq6kFjT0wFGvg3OLifKIlPhkNAjKpapZudgdm
         CcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NIpUJlLpNmtr/KEDPvYL1qSiF22sV5e2uyfuZrkJMAg=;
        b=b+j8HVg9dMd2IfDRVPy9KOGR1fSGRrvE0doKS3W/5+4u4F7oeDT2iYANXjNPCxR/5M
         soVrAe6PjuQ3O2+oBLvU13t/jmfypZ9tZZOGul2LkcboeyINAx1E+sbzQlN2XAkc7SDR
         70x6AhmJaiBGaBFq7OVG/H+31LLouTFRqlHY7EMi9a7acU0cGfYBpEaetYGIeElrzqeN
         zIl5Gge2vSDYabb3qrhRwZ/9JuAjDkEIaiEQYVJIhNbb9g29+2Qyayrk5/wLNbKoF6kN
         TLPcVDABz5zYTBFm28jmrevvBEQ+J+u3TnI3I8JpjKE0CkAJDCtyWJmHveMtubPAu/6N
         6bkw==
X-Gm-Message-State: ALoCoQk/xecIUQzSD16e9KqKFtUacRMxuYQ8lIb4BYbO4K9p1/RcGCVk45uGCD0QKl1d+Vc+mBte
X-Received: by 10.182.95.100 with SMTP id dj4mr5304234obb.5.1402593703753;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si111185yhl.7.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 937795A47F2;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 71C8EE0CFF; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251457>

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
index 6c2e7e5..8c29af0 100644
--- a/refs.c
+++ b/refs.c
@@ -3394,7 +3394,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 193c818..c27467e 100644
--- a/refs.h
+++ b/refs.h
@@ -265,7 +265,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.599.g83ced0e
