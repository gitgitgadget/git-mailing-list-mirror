From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 02/44] refs.c: allow passing NULL to ref_transaction_free
Date: Fri, 16 May 2014 10:36:50 -0700
Message-ID: <1400261852-31303-3-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:40:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM7P-0004ZN-AI
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156AbaEPRkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:40:20 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:52783 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949AbaEPRhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:37 -0400
Received: by mail-qc0-f201.google.com with SMTP id l6so491075qcy.0
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tM/M8TxgqUPpPQMVBIULh7QXQFAfmWK+MjO0eucmWeg=;
        b=PB9aCHi93XnZer9x2xAagLQI02Wlt3bmnlTGHfigl8mUAVi6CfBdqN58WJjXFvwkxX
         i/FbXEUQKXoQz9MxtxoObZNN8SnwH6gPFU/ag6KZKS2Luj6CtHijXvDX26GSbundOAQZ
         M10dHBYULuxfrifO85DzQWOwKmqAupJ//9Gus31zMbt0lRf/T9ZYzZcXNcPpZ5ZiKKR9
         VefV5B1lCXqI+C/5tHRnE4/qMcwBASu2fRDw+MbjD/mDHcEUhJ6JTT4Z6ptTdnHO2WN2
         N6IClJZPXIP/6m+H3TJDbyubr+NPRN+vj/tN124rpyJkaPjW0JLdoF+clLBkw+16mI5c
         tB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tM/M8TxgqUPpPQMVBIULh7QXQFAfmWK+MjO0eucmWeg=;
        b=evLEMxmr9f52nrsvBLDvdDGJWMAaXok994ovOswGSyPL7R3Y2HXkDDheWH05dtiT62
         oGT+5ASx6gy58dZ63hFQpztjaHSjndwZMW/VHE8zz2AMHh8pXImraF2EbhriwiJ2zwEm
         IgFUzYmLSWKYKNcSzacR/+mR9Dt4JJq9aa6TMdUOQYyRzlXtr9z90XHFvSusjA+Dmz0S
         6UX/qrk18EK27RDCYlTKDdmzxORKspbHR2TjYUY0aKxNo4sPpPN8tGLDZKOXFgp3AxJW
         tkgIS6dQlYz8ga0Q+UjwI8LjU5BoAbFwnd1EKZnVZ2wjf94TAKFNf5VocWmHw6YY3Nmh
         h0qw==
X-Gm-Message-State: ALoCoQmqObZUfai2U5uSZY6IBeWCqCKbgmu1ar7WNWDi9jaNViZoF1mo/pFY8twG1f2Vak98qYCT
X-Received: by 10.52.2.129 with SMTP id 1mr7505578vdu.4.1400261856713;
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si441213yhl.7.2014.05.16.10.37.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 8CFA75A427A;
	Fri, 16 May 2014 10:37:36 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 35393E0D39; Fri, 16 May 2014 10:37:36 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249399>

Allow ref_transaction_free(NULL) and hence ref_transaction_rollback(NULL)
as no-ops. This makes ref_transaction_rollback easier to use and more similar
to plain 'free'.

In particular, it lets us rollback unconditionally as part of cleanup code
after setting 'transaction = NULL' if a transaction has been committed or
rolled back already.

This allows us to write code like
  if ( (!transaction ||
        ref_transaction_update(...))  ||
      (ref_transaction_commit(...) && !(transaction = NULL)) {
          ref_transaction_rollback(transaction);
          ...
  }

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/refs.c b/refs.c
index 3b7e604..6357089 100644
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
2.0.0.rc3.510.g20c254b
