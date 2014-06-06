From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 10/40] update-ref: use err argument to get error from ref_transaction_commit
Date: Fri,  6 Jun 2014 15:28:48 -0700
Message-ID: <1402093758-3162-11-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2fk-0003Pw-M4
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbaFFWbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:31:36 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:38580 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbaFFW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:22 -0400
Received: by mail-vc0-f201.google.com with SMTP id hq11so681129vcb.2
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JXDS/2El7fl3r1/Rj53vaJPYWKpbZfA9gNdt3TgoJnY=;
        b=jbqMVLjhJdz1n++GVjkuFutqX/4RIcdtS+kR3T18WggVzNr+zyRIQzHcXBjb2mB32e
         NbqcejR1JyPSxG5eJhUt4h+huADFhMpAjsGRwLBbg0upV93jiSZUlGtHs4+Mgd5W9Fk9
         QU9EUaaxTBifVz1WWxljrf3Vd+f3d7MQdm6VEA7GyWI97d5hKW1X/vYcw/mMDWAwTbxH
         LoEUgFd2H7ZCF8UVd0mYUps1wqkIsP9jyQ1akb8YjXA7LGNome0OV0qIjkVHpwDwkdNk
         W6Eqp+bU7gSI83EWxV5Wtx14I5jD3L/8c36hdJRTTxGK9U2zkgaf/PZPn6b+JnVlMu4z
         IZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JXDS/2El7fl3r1/Rj53vaJPYWKpbZfA9gNdt3TgoJnY=;
        b=U55Wr8NeoKneEHyXvQdR98ABqvqBRLtMMem/CeJZsnb/k2tHvtTYZj7XQ+OgWBbGmq
         Rd0THEKeFuXAgbv1FVEvOuQFOv/igQCiKsMWQM6Fp6sD8/725xuqHaMgGNQe+aROGxPo
         qp7bsEkuWHMSd0emMjd3jMPrYp0TiU+Rj9mOqc7nWch8or3y43pksfSMGIeRPucb2Yuc
         fPbRuVV6f8FWUKcNKhkWul84grvmuE27JH/c0MM/T0znOyDWj/JskzBR7uKv60lmp59Y
         TBevOcIIdJP9Fg9VN/oyguXd/Bco2/KdLtQeaQy2745rga0MA/WCYuZ+ZF2+PR1L1Kkh
         OGZQ==
X-Gm-Message-State: ALoCoQl/0FtNeFNPwdW+D98t+2zrnuq+dVet/YVGpZRCY/J2IO9NK99HQ317XgsNaQqSonDnbULa
X-Received: by 10.58.198.231 with SMTP id jf7mr5285846vec.19.1402093762144;
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id pr8si750950vdb.1.2014.06.06.15.29.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E0FA25A450E;
	Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9B19BE1154; Fri,  6 Jun 2014 15:29:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251005>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.582.ge25c160
