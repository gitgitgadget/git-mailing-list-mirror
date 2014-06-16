From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 23/48] refs.c: make ref_transaction_begin take an err argument
Date: Mon, 16 Jun 2014 11:03:54 -0700
Message-ID: <1402941859-29354-24-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKI-0007JM-IB
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbaFPSHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:13 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:53994 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932646AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1154419iec.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5nVgRxnb1H+POCipt31S4hMSfbbLMRjLiAElSzUBjs=;
        b=jzTl08oXwg5mXVbHt5x5GYQXZ4Z+UtmV93DlEshTZTOPkfGwY3nVF4x2LEe8zjLZ3J
         CTjls1/hmHITiA5EvnR8c039oSC2h/R6x/t0ilpiq86Retyr1vpgni/BYXn/NCGDVPFA
         AfxEIExVY45UDK8HeI4CKmYwfOmrgrPa+XCK7gH0XLR7Hg231SW7+RgleTW7NH8W/W73
         1v1ZzXbOKVa8+tpu0XgqXzM1ypLD713ybYqu6OHEO2wUN4IDh6Fs+8+aTBjKtzy7x7oN
         szVioEgx2MdeCJ9xwy0PNfriWuWuUuIf3Z6fRLC08iHtjWR3RmrXu81hk6YY5scuL0kx
         cXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5nVgRxnb1H+POCipt31S4hMSfbbLMRjLiAElSzUBjs=;
        b=PJ65JaEIdmEfiq3R1qAf/0a2PkMI2SU5Sz1Zthpdw5bEnuPMZ3RZ1sjfRlF2ND4gPK
         ts7B34IPpuWwshlrMBeeN1No8vigbmPxo7iviuqK50S0zCtJUpQko0gxF1NiasFCnvoz
         Dc7FEKUUrqUmdj1KPqrxlQ39rpWHtMJkC+ajBjGEMTBUN6K+NufieX5jnun1Qg+5siMT
         1achOrHiki0c4TS+16N4nIFB3dUsrcGQec3dLUXMYTbiFNBk59ylroRhzOFaVP0UNHKp
         qcNpy18fjlFoa+YF5d4ANr1ZC11xVIbcdmtvIqQCbagX2d2NnG2TjV/ZhV04h6ariuVn
         HVyg==
X-Gm-Message-State: ALoCoQkfxZ4meNMa381jV+7B7tmedN2SkpEdbOerTSHKvNqGHPeiO2+2sNmZEGUw+OdscfLukEME
X-Received: by 10.182.128.234 with SMTP id nr10mr695567obb.0.1402941863197;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si997134yhj.5.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 1048B5A4911;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E0D15E0CFF; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251775>

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
index e544b35..4937754 100644
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
2.0.0.282.g3799eda.dirty
