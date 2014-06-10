From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Tue, 10 Jun 2014 15:29:03 -0700
Message-ID: <1402439376-25839-16-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUaK-0006ZG-B5
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbaFJWbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:43 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:38329 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so206657iec.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVm1Uo0xagQRfrtdhu4pVVTk6FysFMFgsVP/ZGyb7yM=;
        b=GiMuKR+Y9GmWOL1Dms+IP5aWK+J+1idZZ2/SUcPWxXtcpfssDpagASt+edA8vmrW1B
         xN7fWHHNk9AIfwBVuXmwscXcMXYU5m7YhWuk37+e5dAbp4YnWX+PZgO9QVRjsfSCkwV9
         NFKVhRlTqrbjuhnX15gsObSJTLynGUgZcyCM/P6RSgY5TXpVQ43L2xCbwIctkq0g+D+x
         EbgYm9vRcbpPdbH21ZeMD8PQ6Gg2rxJURuOlE/n8By4QcPOw1jEQtQSV0UK3QZeSZOX0
         mtQf1Uquh7X9/SqlUVA3PBXjdQwmbsOuki3AYhzT1bMKx011tSfldKor949hWU6UxOLo
         HUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVm1Uo0xagQRfrtdhu4pVVTk6FysFMFgsVP/ZGyb7yM=;
        b=cGoE99bFBs8x3bY2dm3rg5G5LYGZEl11RQprySzpUtRkB+gG+TyADv98Ofn+5KlPC/
         tOXYaGzZUa/jvMznxp3b183Yiv2wYzMQ1Xx09rf0ufEkQ3+1C6OwV8SeNF2RDBkqgtaC
         xokXWz9WLIfqqQOZSRbDs5xudRjrH1PzaEIi0Vcl+F7AVk2c2GoeHMFVN4JSnZQ5zKMP
         Zjtn8l/+kBS0GhWL/n2ANGbyjVygNu4bhAVDAFwDUKTTje3hsFec+dU6liiXKgadGqVe
         olo8pBECpz2x3X1BZVbVZuxZC2N3Or+jsnkZy8yPhDzgR8Zv/Hcn3pR70Jf3/8WxDOBs
         Hswg==
X-Gm-Message-State: ALoCoQkRJVUR5yu44lzfe01L3bFiVZFKw0L9wAzOo141+PdEr+B29WILLQCTRxjBpE6cJ3D4ivjy
X-Received: by 10.182.73.200 with SMTP id n8mr1994820obv.33.1402439380614;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1394550yhl.7.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 71E9A5A4828;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1FCE3E07FA; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251274>

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
index 31ae63e..81d3605 100644
--- a/refs.c
+++ b/refs.c
@@ -3463,6 +3463,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3470,6 +3471,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3500,7 +3504,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.574.g30c2c5e
