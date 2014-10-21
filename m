From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 01/15] refs.c make ref_transaction_create a wrapper to ref_transaction_update
Date: Tue, 21 Oct 2014 12:24:08 -0700
Message-ID: <1413919462-3458-2-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:24:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf38-0000PF-SN
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbaJUTYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:24:38 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:38786 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbaJUTYf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:24:35 -0400
Received: by mail-pa0-f73.google.com with SMTP id et14so339647pad.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krFpsuwE32vW+H2K+k791ZfMYlko7hWpUc6aBMHd+Pg=;
        b=DsbZGI3kZYL0JsxvOIUGic0Qv6pq5DPDdZmmpd6k4OUEu0E4J+W28TSc3k+SlJ8JKE
         gdSgDjeXlHX1BX8ja/hEMGMDT5MsC5Qb+VERD1UfUlUrjG2LaRrdNNixnbDktv7DYEOU
         PCZxPGTqyQ6NhrowcmmknYqDZSKrmP7fEP/2O2x5D5iD5ENr7GiBk5kBHhjFVrZli0on
         Yv5cnkJNHu1K7P+73C6fkC0Cj9TPmJCzm8hQQrS6YJSVZ+Pi+aXR+ywnSQQCswfpOWEz
         xgotVer0umvxG7qYqAfbKnjEqG3qOstLV9VvXXmW+A5nuS8zYsaK3Bmj+0S1Pr8/Q/4m
         tnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krFpsuwE32vW+H2K+k791ZfMYlko7hWpUc6aBMHd+Pg=;
        b=ghZTO1ynNDKfcAqlMpE03qxxZRviWE/8tWLeVvUD0yaC8u2SJRHxbKXbDruPO/5D0q
         6zu/NuD7JszGP4XH3E6YeKOCv3fneVVatIC0HJWhS6hLUTD1JVKjGcltgNoqcfW0dwKd
         5N5Jk3p8hQcfEZaueWg6cOjyIUjXkLxVI66GTUWccR62Z1e3ru8JZkBBYV056pp2VRfi
         sW65+drzwsEnlko/M0FQX4X/OgODU2+LXxo1DpCP5xxJzYjgUig37L5xG1gv4VNGSzeP
         TPSmz4oTtNKIpmwJ0fKWeWlV1+P/tlcqbHNp+nfuQkQrZa9mL/kixGmCdx3No612OaLQ
         unAQ==
X-Gm-Message-State: ALoCoQm25MxanwdSVYOTTVujZplDB++BFxaF1YkHnhmlWPlMSwt19X4YXaVZQAfoXEwmyrx4MNNB
X-Received: by 10.66.182.131 with SMTP id ee3mr24310896pac.4.1413919474794;
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si582837yha.6.2014.10.21.12.24.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id nZUQNP4Y.1; Tue, 21 Oct 2014 12:24:34 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 10515E05FA; Tue, 21 Oct 2014 12:24:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 03001144a015f81db5252005841bb78f57d62774 upstream.

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Change-Id: I687dd47cc4f4e06766e8313b4fd1b07cd4a56c1a
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 0368ed4..ed0485e 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
-- 
2.1.0.rc2.206.gedb03e5
