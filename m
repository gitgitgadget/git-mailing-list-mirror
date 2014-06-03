From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 04/41] refs.c: allow passing NULL to ref_transaction_free
Date: Tue,  3 Jun 2014 14:37:22 -0700
Message-ID: <1401831479-3388-5-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT9-0007ro-8j
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbaFCVmC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:42:02 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:33683 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934062AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1408465yhl.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mSPnj1gi0qe5xugiHIDYW1yglBFxtIw1kLdo/OcZ158=;
        b=XSAE5+nPYe6/CKCH6uhPsat9ib8yQRuPoySqZBlM3U2NVVmE5zIWG68DprXPvIaT73
         Vf6GV/YoZjoGuERqkeM7vu/Ot/y2dHXBx1CVSHQkoTRYD3WeURq2qPp/A5JgTE3uldH0
         RcB1ga65ibKOpD09g0R5RhWXMWOZmYQEyNPu6znJCtSf2Ha58pVFb9UbavsXft+ZV79q
         ZJpTbRY7LM/MZA/H/MEAhyOwp5+/FP45f51IrcmqV0Q+x26xYGJEfba+BQYG1+wDElMF
         t6CBVeRrLRWzhd1LUuIfD9L8tghOsqG6AJBk5HXaMwXFuW2plbqibYmFgwSSLXHozeIV
         WQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mSPnj1gi0qe5xugiHIDYW1yglBFxtIw1kLdo/OcZ158=;
        b=Fb+EjM4A+EVaTcQ22F9jsNgayF8Z6+4t30SfxcRAuLGt4jIWAPbb7WMo+nNnr7Qrer
         lHglUQOTeLjO1W5FXMYt947Yc0bqqCQGGsJmLE1cJ+vktTl+BEYKMoy4BiLZS4G17Tzt
         M1ek0ng5/Xl/yIt2i5PRBvwtoVeAIEfSfjzvElRm0xwRRQq6YIrGrvyk4X9l9eWL9VLE
         eY5D2QSE3s7Qt1xDtWDsC3RI8JnQJM3+Y3Y8YSrt548aNPsmb7DcNx3qJaMz0kby2AsG
         K0aHfszu9zf5iH7XNPeT9cIBzixycULHN7QRhrWHf6ZJ0FEnbVq971scZK9N3IS5zTlf
         T6Ww==
X-Gm-Message-State: ALoCoQkhjWDKCoto0Ohjm4hULK1kHtUZ535J7K2cEkKqFhG7F8Pr6JUzyRM9jequYL6hMIu4HaA1
X-Received: by 10.236.75.66 with SMTP id y42mr5512824yhd.20.1401831487018;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si29578yhk.4.2014.06.03.14.38.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CC9225A43C6;
	Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 79F5CE07FA; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250680>

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
2.0.0.567.g64a7adf
