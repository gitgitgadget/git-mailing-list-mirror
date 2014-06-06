From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 07/40] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Fri,  6 Jun 2014 15:28:45 -0700
Message-ID: <1402093758-3162-8-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fl-0003Pw-MD
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbaFFWbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:37 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:43027 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-ig0-f201.google.com with SMTP id uq10so128710igb.4
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vB9bFwkclGSQRlXaoDOSSgQDt8TjfDpuybbcXH9tBOk=;
        b=S2R52PtjifxQgfmdXUUU3onjhLAm9KDJLxCVgEKwasRt2l2HfLtJytUpSVa7w5v1rh
         6NM6Zzit5GIT8y8zYxIao4Y2bIGQcKgjWPCpIpPkJgXpCBZ3SW65YjEOsMZepH6vribV
         ZRYXLh+0yzXhBkBAJeBekX4MJIfUFBK61b2nAFPZyy2pqCE4Fo5Fr1fOcjLMYBK74NdQ
         PE0Skflok7JteCXHMUrHPoAAsTBaz0T+kcfnydNl9zJT2f7Zdu2+kaCXp42SBAcu3Htt
         2cY4wC9Hwv3/hU0l//HHKX9ZiKuwuTx9m4NCIGIeBYDYd5rRw7PI7SlY2YTxEmIH/kyH
         rGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vB9bFwkclGSQRlXaoDOSSgQDt8TjfDpuybbcXH9tBOk=;
        b=moN8ce2rYMHH435yXualbMuA4vNrZ9ypKoZnnmMehvygNozVxtWsxLxFu1ZTDUWQ2d
         jDHrm4HTppdgUeu9izfTy415XLurOVbMJb3cNsO7CAK3n4rnf9rj9lvQ26bkL1XZbIjX
         PHd5rZsCockn/tC96K4f0LiDuv1s0OdokbmCZJjGAw/m9rnC+dm2dNkfZjlKznD8kPR2
         sm/6h+PjRC19YEeM4U5zGGH4K7VVYoXpjVn5/8eIamWrlh9/+U9WD1ZlxkvVYuXpNDz+
         AEbTohU+7EZWxRc6dijq5+7rissn0hO3T9+0+yYhmRE40h20lxdPjn4s+tJum3Ttk4DF
         UBCw==
X-Gm-Message-State: ALoCoQlRPPCNP4fB+cl5qvdzWDeABYs9BdKw1draUT04WHtDPQ4g0ELXf+IPBaBJoq0Fq9iJIpll
X-Received: by 10.182.227.131 with SMTP id sa3mr4512667obc.38.1402093761995;
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id ds6si750428vdb.0.2014.06.06.15.29.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id BA01E31C62A;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4A8E0E081F; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251007>

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
2.0.0.582.ge25c160
