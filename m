From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 07/41] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Tue,  3 Jun 2014 14:37:25 -0700
Message-ID: <1401831479-3388-8-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwTM-000847-4t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934130AbaFCVmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:42:01 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:48045 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934101AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so1534149obc.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BYn7AyF/P4RSR13eGQRHVkDPB88AEUfBnSrcCixh/x0=;
        b=YzVuClRmQsdqQIGEj2yXVgHA079/P1lFkOhLBA40oOwm5sr10Bq4jTCBr/2oJK+oik
         PdzG15zYYwTKWOWNR5RCGkF/pb6q/GZuEvj0okJC8YkgPGPKXXj+HCrOs8I+7bVowNhh
         iWCfygo16lcoDiCW5gANArxVvaI77x96JIuWob9hnPWcvWGovlNSnUx+xrMb6L789LZr
         zT1CF85afdO0wVHbeAf7QqTpQiEZmyBT/kG74BuuIP40yoycWPi4REdq0doq/UVoUspR
         CUsobCISfJXZK9c1i2ZFK5mdjbw5TeR+tJwapk0JL4xXwdLKUhR3NuaYVGYW4mQ9bop3
         zp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BYn7AyF/P4RSR13eGQRHVkDPB88AEUfBnSrcCixh/x0=;
        b=RKn9Jp/TD2G1UBIOww4EKiQ0lV4ckMb5jj1y7XA3lctR1Rb3If3o6FMUTjptvd6s+C
         7V2iD0RpaxwUbFnZuJrzT+SoK8753W+sU1FDX/Rq+1rK0Grb5tEiFJdxBrtHo4tfPXZR
         0ROlfC87Ngzyn25kjuBw72cG1Eti3ZSprPNXwztEuZv891vPK1ym1FlWugu6uMbfsxq+
         ma8RqSTval71u1h9+o+QRR9KLlscmTDYG9fR2CNPVhZHxKyoq0Iv7AhscdmV9ycqY3z3
         fRxon/R9c6TbJPcaLRzAojdZUGCTGMu+L9gHNEiFUAkKbyymzeBPsreZ2QwyvGZpdvr1
         qc8A==
X-Gm-Message-State: ALoCoQmT4FRUQH3ot11W6n6EcLBM4S1f6fFu/4wzH3m2JUo28y3EHlA95ZyM5up1oxpjncXIP5Rf
X-Received: by 10.182.121.232 with SMTP id ln8mr19762294obb.11.1401831487276;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si29243yhj.5.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1EBDF31C425;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B1BB7E0CC8; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250686>

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
index 7ec1f32..2d6941b 100644
--- a/refs.c
+++ b/refs.c
@@ -3456,6 +3456,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3463,6 +3464,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3493,7 +3497,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.567.g64a7adf
