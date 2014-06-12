From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Thu, 12 Jun 2014 10:21:06 -0700
Message-ID: <1402593699-13983-16-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hR-0006vy-3T
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbaFLRV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:59 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:37829 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbaFLRVo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:44 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so311011oag.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kZBLm0qvzNmDOiSUoG6+DJAFpYgZqls2F7XtI/XpHkg=;
        b=HvjKtP+2PdyjCOkcB5LDlDUQnw/tK2akFT/cQT33z3p4ASu66M2veHnnR4LpI42zYq
         YGxo10+iy5sci11drrQbv+ISb1ji068vBRojaX0erCXbuWL3ZsB2ryBZjRFBlIBrlnw9
         2y2ZTYDL7b/p+VnHTNbGRd1JK4+GUzrvPykqom645GYmgxKhpqoRN3l8Mf6Ia/F33eEK
         p5qYIossxBcjswc8Yujl5sa6KSUbfr8/oYaU10ZsXa2SgNvnGeHgVUKuMgWE2ESRfyQa
         nLUhZ4uCNN8ec9SkkxRwKiP4krqGHglCj8ZvZSNv9ibHlUrg8Zk4fmDa+ccABS679k0y
         T34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZBLm0qvzNmDOiSUoG6+DJAFpYgZqls2F7XtI/XpHkg=;
        b=HxNnRvPbzCqr7tmi12tc7t/pKoNm7WWykt6BlFt7Db3JYTATCy06oDIx13Rf3/sIp1
         kDncdjiagzLV6pvoMSa+AC6Nz4WJVOA0rYEe0nWWzEoH8IPtaLJ9/4QN5ZipNNTSaQpJ
         oXA8sURvmBIqfxy8KHcV5I/DFgA/e5PINr8Mrqwjj3i01lwdZOCP3a3HjmiULKFziV9C
         E7H/yM9t+1vxzqPMQc7+0neDOcxwkNCzYfSGRh+tNXItxn/kF4L6a64BTZ+YZOBt+3r3
         j2f9jDJCCociAYIcXFEhvP5OWOzeTx4X6yhVKz74nP5A9a5kCh4gprnNb58hoD+BTP4q
         CHYA==
X-Gm-Message-State: ALoCoQl+MycSlZQBFaW5g70dHpFMbQlcGQNNkYmY0sXnhgMtNLa5NExRmR3O+qAQo6SxacFoM4VH
X-Received: by 10.42.26.77 with SMTP id e13mr20427608icc.7.1402593703443;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si113011yhb.3.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 371035A4743;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 01780E0CFF; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251419>

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
2.0.0.599.g83ced0e
