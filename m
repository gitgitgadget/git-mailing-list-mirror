From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Tue, 17 Jun 2014 08:53:18 -0700
Message-ID: <1403020442-31049-5-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvi9-0003O5-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368AbaFQPyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:10 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:62243 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065AbaFQPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:05 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so1049878qac.3
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q9vxIJYWLOlnASdZhvaa3J7BTLJfAgTvZuKwlb+LwsQ=;
        b=UyPslnypLNMX+/4+m+A7ERa14J/s097NT9MGTnTAlHmCJFIIgDLsVSL25zW5MVQ4Yr
         YJeuxDhWYWhTl8MTSHi+oVTyWe3SOWVVrQCCDAK6iOZUWu0DliM1RULeTNPn/XcInZPg
         D6FM1vKiI5XzKODxtKrBLU67fixY7voA6RT9tKz/aOUrAtIIFxIIGCLiYrCogL+6UVFw
         lzLKPWqqpUpg7u6sDtSucLRS8hnGPv8shHsW05Bk4+cbbOFQY8WNZcXoNbkzTMwr8zY1
         lDXnKNU/GZwljykttYlpOvj+wjE8gU1NkCkYzifHNe2p1MHi+VjPFuvYm3v/2nv6u/CW
         lneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q9vxIJYWLOlnASdZhvaa3J7BTLJfAgTvZuKwlb+LwsQ=;
        b=Gs2zSiVf+vLWW43BwC7W7Z+Oxf3rEa/qLsDvP3zXu0tAduIRUmJOG8AZCG9CJwVQAm
         /LndoGdIfttriX9/zmS0mQpr/rITLMA59AX5nQuWmrLQP4+nz2xJP5bz0Zl37HRVfzq/
         +7q11lDjXwf71IqupM8FARqnwwT66QfCtkHhQCOOK4AdNxfydxyaWES8JNHL/vrIlhK8
         LAdJazErRBSy1S+TLSkGuvL4U8wtEtmS9bxZQ/jkKLkreYWm/pzQgDfzakk51QZkWe7U
         I/bNadm0/gWhkDex5J63yYDrbSVEH/4kfjr9ohVIYNTL+XWGOaISM4aZTHj93lA5/gga
         V3Rw==
X-Gm-Message-State: ALoCoQlf6CZp66MWHmXlr6wF5N4ZRY6O2knresBpCV62ND/Z53x/16tVfMkTDG4SvLmPOHnMV2kD
X-Received: by 10.236.144.136 with SMTP id n8mr247875yhj.22.1403020444413;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si1207999yhp.6.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3FFBE31C76E;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1D7BE0F10; Tue, 17 Jun 2014 08:54:03 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251870>

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
index 21ed465..1d6dece 100644
--- a/refs.c
+++ b/refs.c
@@ -3338,6 +3338,9 @@ void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
2.0.0.438.gec92e5c
