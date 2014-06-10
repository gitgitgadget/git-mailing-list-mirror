From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Tue, 10 Jun 2014 15:28:52 -0700
Message-ID: <1402439376-25839-5-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:37:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUah-0006wr-5x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbaFJWcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:32:19 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:33792 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbaFJW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:40 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so176626yha.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sr4Gmu8KPdL3tYz/XdISKArqkipDwA9qtgwgRRQYzlA=;
        b=hIf2l92/w/x3gaIxbfeHPIk6pOlB2vRMJoQ/MByjrqb2rqQ5yimUlEnKLQYZ2N7Ltr
         hCPHB+QP9N0VgUzU1hQEj1gGjCYqYTi6IXVwj8y3MSbrOF9fqnPDVGxpFZPwkyFAz++m
         QcvJzg5OUFmciJXOlDSuUsk2+HyZpQXoLbYujujO9MfBLc/i4eoch63DBtnv3k6CRWL9
         ARriwA4H7fHoeG115jeUr/LN1mCuo+XjjdYNvx0ZtcQQ/wLQ5VuwKRUj3Y72REW0EMPX
         BDPQTNCQ9OrMhlWEdyr6B+h/KWFXmJCMnYV/SijPPMHjIB8fqpZnj2sojub+jRc1PKCU
         bjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sr4Gmu8KPdL3tYz/XdISKArqkipDwA9qtgwgRRQYzlA=;
        b=PaItzN1ePTxxXckBvpfFGiPouudpR0PkRaAVp65hSWqqodU7jBDplYMgWypsLf12OB
         yXYFjHC9t8bHgQG+p87WqTt8oiMsKZ/sJUpQAWOatQ10K8KF7DJJj8SPqMPc6HETY+QV
         9ZGtAuJ6YRK0/znJtS1yWQhZ9vLVB63bbPJAxygPHfEXWjHFZsrmPf8S6jPGW35oSNdm
         xOYShmjzwhWWiHPedn7a4m7RdvU0Gw/sFaJOCVk/dHqJbxBD8/LUotMfaTtgMNwg7lKa
         GfVjJOz92yOU6DoHTt0br0EwftN+Vudk3IW2IAizcVIqr+hSlGeR+IXVeKTfZEc7dr4M
         yQkg==
X-Gm-Message-State: ALoCoQnMYrCyfjVULLbYnlcb0EPw7ODg4d+iRSVeb51HIWiGXgnQHfjV30E6ySIvnQ5uO87HaYH2
X-Received: by 10.236.133.201 with SMTP id q49mr5885404yhi.1.1402439380146;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si1396558yhe.1.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 01DC731C746;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9B93DE07FA; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251276>

Allow ref_transaction_free(NULL) as a no-op. This makes ref_transaction_free
easier to use and more similar to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index a767ef6..0faed29 100644
--- a/refs.c
+++ b/refs.c
@@ -3312,6 +3312,9 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.574.g30c2c5e
