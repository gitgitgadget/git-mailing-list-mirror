From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 02/27] refs.c: allow passing NULL to ref_transaction_free
Date: Mon, 28 Apr 2014 15:54:17 -0700
Message-ID: <1398725682-30782-3-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:54:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuRp-0005VH-TX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbaD1Wys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:54:48 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:64066 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaD1Wyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:46 -0400
Received: by mail-pd0-f202.google.com with SMTP id w10so280972pde.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LIlYYGjOkthYdEjMGgM00drNZ1xYCEYicUIsgFv7+8I=;
        b=KZvXG0nAhCVYOlbQhyWb0nUP9cnMxd+NzQRMolat1xcwuI2J9URal/MrtVVDczlmcg
         Yuf46kNk5ZkrgjXsS+XFfpH25qn2X95PF3yMzMMnkaPbiGKlspktRrf5p3gi76BmoiZu
         FluXAidF0ofAzabKtmEwVUMLakS1VwzT5WkguFPO+CQG7pMpA412eNSwgRMFCP9saoSd
         8z/1ur808BXG8HxEP4aifbcMX1lFCgYEDjNlwhhuaIojh8XOyjpcQRQvPzUxh+3J0jEI
         WLOZg1fh7y19EWrPuaxwJixCEt3K2T+g5PTcGn9u86zJJ+Fze+Oq3gY7H/Wwa5T9QStl
         lVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LIlYYGjOkthYdEjMGgM00drNZ1xYCEYicUIsgFv7+8I=;
        b=jfwmdXELiJ0m6BSsw9KHt/cF0OAcgtnKUoQuMZjk6a87BWXoy0WDNMwJNxH+TzhB15
         zXD76YLVbmTXHBuWdg3LJWRanNa2B30GHq0EMgS7+BvyCqCzDSlgNAwpY2buy/Yi/Ssc
         l42WxN5aAtYPtrXVnrvWBQ8L5r9m54hEPbg71H03+QWMnbSgoIfOyAxsuALQAOUzj838
         xoEw11Z/eu8DZ4m/imL6V4qH24bCg2FyNz2MmX9JlhPPOytiS4QRjdJ4XD0hphjT9DGI
         wu8F7nA6LH7mdV7mVbgAOL8/zTsFrtlUWyfjWC5+pL2THNeSQ/GPunUjrpM0B2aNh9+W
         7NBA==
X-Gm-Message-State: ALoCoQnizNjABtZQ58CIauTJX84ou4QedI72eFHIahkpLtmalTIwU4PjT2Bmot8LZSkyBiDnzmTivmtvQpsFH7iE/bGA0XucogBePQ4KO4vEm/r+AgcKxYiahg7sHtB43/jxyuyXLjohQx52l4ySEfpgYPUO0cCFT+1ZWyDJD4BETBg6WNSqaOxeDuU0FoxWxEQTRe3mI55K
X-Received: by 10.68.202.99 with SMTP id kh3mr14374991pbc.8.1398725685848;
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si2350721yhk.4.2014.04.28.15.54.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A570D31C20B;
	Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 67805E080D; Mon, 28 Apr 2014 15:54:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247463>

Allow ref_transaction_free to be called with NULL and in extension allow
ref_transaction_rollback to be called for a NULL transaction.

This allows us to write code that will
  if ( (!transaction ||
        ref_transaction_update(...))  ||
      (ref_transaction_commit(...) && !(transaction = NULL)) {
          ref_transaction_rollback(transaction);
          ...
  }

In this case transaction is reset to NULL IFF ref_transaction_commit() was
invoked and thus the rollback becomes ref_transaction_rollback(NULL) which
is safe. IF the conditional triggered prior to ref_transaction_commit()
then transaction is untouched and then ref_transaction_rollback(transaction)
will rollback the failed transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 138ab70..2d83ef6 100644
--- a/refs.c
+++ b/refs.c
@@ -3303,6 +3303,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
+	if (!transaction)
+		return;
+
 	for (i = 0; i < transaction->nr; i++)
 		free(transaction->updates[i]);
 
-- 
1.9.1.528.g98b8868.dirty
