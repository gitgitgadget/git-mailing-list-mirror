From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 15/17] refs.c: make add_packed_ref return an error instead of calling die
Date: Mon,  3 Nov 2014 11:02:17 -0800
Message-ID: <1415041339-18450-16-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMza-0004Lf-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbaKCTIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:08:37 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:60889 "EHLO
	mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbaKCTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:08:36 -0500
Received: by mail-oi0-f74.google.com with SMTP id u20so1380072oif.5
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D8gP/jFitZu6LOgdS0giU4DNMYDxLppTCLLZDTpe+1g=;
        b=mZN4f2U/1h9T3QSidIuaxgLh1iMukIoH1PDD946YOtWxMAaIic7n2b5ynJcyW/88v3
         PO5YoJ9y/CIlusiqnnUnvvT+OYpvHfRCMQrKJXDDdO6zoEoZYy7cQcd/Bgtm8CCI29HH
         h5SCHcK3Xia1VnQbRgKTxsz5pN+a3A7guGpcqtxO2ilMCbzrRZ+RD99i2LGcmYKOzcmi
         mN6pwiKcd1iNOCZSnEsJYF1cN70NKwxrm58BcgQHDvAjHelj6tkS0pXj3PGgYjzNehUq
         p/H5UK+hWt6zRgoKNgsyzt5JG91SGt7dt3hzeeItsc2DGkZKbxEAwT9gcfQrBcz+6Rcj
         7fpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D8gP/jFitZu6LOgdS0giU4DNMYDxLppTCLLZDTpe+1g=;
        b=OKJIBqjJj8lK75d4Rk1XWBu2BN8vDMOohl0kN+qseqdW6fBMPViYePcbiw+TaSYuGC
         N1+Mxlwwxlu51ryC2/xuPrXDWKYy/qoDd80FAv/RKfquJVBnvjO5EmYrOx5N7wXYbNpH
         jwIZyyD4AdPm3pmxM5mN/gmjCOpOPvQNiiMaOhbzCe5lxtuDEU0exdX0kAiQmO8XKsqr
         9GTCinzn+I064yIqSr77kJYxz44wWj9MlIAEbSGe+4crBUftQkIVlPt0pR5narNthLs5
         AGzx7pPs6AeNk7tGA0PAWFwa5KL92ElZ9rTd4BtFNN26pHua7e8Zi/lIj5XdzMTNq5bm
         uc1A==
X-Gm-Message-State: ALoCoQkkQKaj4J0atiOq9ozV/DP8Nm1djPV7+/WpJtl4V7J2UGPIl2+IXy1MHUeGBaPeoAsNd6ir
X-Received: by 10.50.73.201 with SMTP id n9mr14034930igv.8.1415041715853;
        Mon, 03 Nov 2014 11:08:35 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si976011yhe.3.2014.11.03.11.08.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:08:35 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id gV2dqbwG.1; Mon, 03 Nov 2014 11:08:35 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 298FEE1137; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change add_packed_ref to return an error instead of calling die().
Update all callers to check the return value of add_packed_ref.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index aefbce4..0b9cb8d 100644
--- a/refs.c
+++ b/refs.c
@@ -1229,15 +1229,16 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static int add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 
 	if (!packed_ref_cache->lock)
-		die("internal error: packed refs not locked");
+		return -1;
 	add_ref(get_packed_ref_dir(packed_ref_cache),
 		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+	return 0;
 }
 
 /*
@@ -3829,7 +3830,13 @@ int transaction_commit(struct transaction *transaction,
 					sha1, NULL))
 			continue;
 
-		add_packed_ref(update->refname, sha1);
+		if (add_packed_ref(update->refname, sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 	}
 	if (need_repack) {
@@ -3943,7 +3950,13 @@ int transaction_commit(struct transaction *transaction,
 
 		packed = get_packed_refs(&ref_cache);
 		remove_entry(packed, update->refname);
-		add_packed_ref(update->refname, update->new_sha1);
+		if (add_packed_ref(update->refname, update->new_sha1)) {
+			if (err)
+				strbuf_addf(err, "Failed to add %s to packed "
+					    "refs", update->refname);
+			ret = -1;
+			goto cleanup;
+		}
 		need_repack = 1;
 
 		try_remove_empty_parents((char *)update->refname);
-- 
2.1.0.rc2.206.gedb03e5
