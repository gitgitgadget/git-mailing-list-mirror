From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 17/31] refs.c: make _update_reflog take an error argument
Date: Wed, 14 May 2014 15:13:16 -0700
Message-ID: <1400105610-21194-18-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:14:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhRZ-0007Zp-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbaENWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:14:12 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:55461 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbaENWNi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:38 -0400
Received: by mail-ve0-f201.google.com with SMTP id db11so47522veb.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hyAAWpOtDI/7qV1W/4ZSqvq9/8Q6scHdu7unULUJXSo=;
        b=OFFlcwvmcJ/fYIAxGEzoIdio4vlYBdtq8K0tMIflwpE1+OuJkA5fEm8E55o8JucbvA
         aY6Zhgr5Fndak3EIq3eN8NlntWLM5AbHqQY2OKk/qpiM5tiFl6sb+/oczIRQjHd0d65M
         pSGZZcObgLwSpmlhC3RuGBfSHy3sOHxHCpjcHdbGldYWMmdi9teLYdVjKtw/e9uHo2gM
         hrOzI8laSwd8bFT/zY3DSNbR3gZQo4spso7GTxULi72YvHWw0+Ua5Wj90OPcM/uaLxJn
         H+8uloJUNK31wQGRnjoMqPPh2KDyxEfapvSqyPkD0BYHjNTqZ6O4cuo62idqXKxQ8RdV
         LYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hyAAWpOtDI/7qV1W/4ZSqvq9/8Q6scHdu7unULUJXSo=;
        b=GCD28Y121RrZOHyJPfkcPIiA+8AGlq7e1vcFHr4wxN3/2r25YSj1UqIe6fJv5aHdcb
         8CUhMfelnk0tX9UZBpGH6bL+956vvDIFYiaCQVm5056iSqt/FaFtLb5NnR+VYQh2Roqq
         Lw8FcGum3NBrAgk+amqECNS8u/Q+/BnSFLInu9yVDiHlsF+QR5MxtawB34+hafCNiySa
         SvalksmxZmsJp742nRT4UlxvUULRNFmTKnQcvNP0kzFZKUldfMeAcEL60B+cvHvifzBD
         owPfrdN+BEZnX9BUZf59oCz7PHuuIrbLL7s0m6or6rvP38fERwL0mLu4bGYXwtxUKlTF
         Fjfw==
X-Gm-Message-State: ALoCoQmthEmUsa/r3TM7y3m8vKz7vW9+m8mAq3ppnwC1jFF8e09ttlT/PoVdFU7hH5qx84YK9aw1
X-Received: by 10.236.162.9 with SMTP id x9mr2731585yhk.17.1400105618243;
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si152500yhj.2.2014.05.14.15.13.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1A3955A41E5;
	Wed, 14 May 2014 15:13:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D34CAE038E; Wed, 14 May 2014 15:13:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249024>

Add a strbug argument to the update reflog transaction call so we can return
an error string back to the caller on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/reflog.c | 6 ++++--
 refs.c           | 3 ++-
 refs.h           | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 5f07647..2239249 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -319,7 +319,8 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if (cb->t) {
 		transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
-					  email, timestamp, tz, message, 0);
+					  email, timestamp, tz, message, 0,
+					  NULL);
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
 	if (cb->cmd->verbose)
@@ -372,7 +373,8 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		transaction_update_reflog(cb.t, cb.refname,
 					  null_sha1, null_sha1, NULL,
 					  0, 0, NULL,
-					  REFLOG_TRUNCATE);
+					  REFLOG_TRUNCATE,
+					  NULL);
 	}
 
 	cb.cmd = cmd;
diff --git a/refs.c b/refs.c
index 59f1ca1..8b09258 100644
--- a/refs.c
+++ b/refs.c
@@ -3367,7 +3367,8 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const unsigned char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg,
-			      int flags)
+			      int flags,
+			      struct strbuf *err)
 {
 	struct ref_update *update;
 	int i;
diff --git a/refs.h b/refs.h
index ebe7368..6c628bb 100644
--- a/refs.h
+++ b/refs.h
@@ -285,7 +285,8 @@ int transaction_update_reflog(struct ref_transaction *transaction,
 			      const unsigned char *email,
 			      unsigned long timestamp, int tz,
 			      const char *msg,
-			      int flags);
+			      int flags,
+			      struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.rc3.506.g3739a35
