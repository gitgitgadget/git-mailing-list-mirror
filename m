From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 02/42] refs.c: allow passing NULL to ref_transaction_free
Date: Thu,  1 May 2014 13:37:02 -0700
Message-ID: <1398976662-6962-3-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxk0-0000bs-3c
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbaEAUht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:37:49 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:51075 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbaEAUhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:45 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so546797qcz.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D4IHeo5ZJFqA50GInvc+IjEImJf4WT0/GVQ8IMsPyfg=;
        b=O0nUP5dtCCXSQ4JRmhD7RgBlvo8rfG5vjmbt7fyukygTqHpQ6UdqK5+gHol7V32Uwr
         tjmhU69LUnA8/rvTIdMeB41bvtmG/zD6QaCtbY7yU/GErYbaAdUbO76wCll0KOKuQdOq
         lun/AXD1Zps5wrBm3mtoIIpNq1rSHle5L7Kf7bQqHhN532pm3Z3UhI+wJV0wc36K9UeV
         Ju6SIJGAffBhzzYsgI2pYUnQ87wZs5Pw0jLfNax2+pK2XBGfC/5rqkihQBMh5ADKV2vs
         bzeuOJ8towaGjQqgy45fHM8pxwAEITVTcUTNtMad9bl5RCTelJy8ju9HBadX5LMJLHKa
         D6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D4IHeo5ZJFqA50GInvc+IjEImJf4WT0/GVQ8IMsPyfg=;
        b=YX2sbHHMKj15h/CE8yay3KvmP1UlHNCKp9rBAeEYyIGvuevoCHrGhXisZ1RlOOxcOz
         6G38ISW9uHdipoGoh4moRDwxwKgqUR68ecZBeVkAA3eMXbsdhDjN5iGdAGJfGOpxkNU7
         peCZ2yTQoZp6u4vvgj9RWK3mEvid3dHTW5gUJh6mhGZnhEgFTrHwTtLktRCl/A6MrpJC
         3B5iTqXVcTaqflMeada0WOjPpIG2qHwTj+2mSVc5GC9rrOidQ777Mrd+ls9ATnsxh4eJ
         SjepTZpuR5tjAjYAQ80lNZ29E/lB+S2D2WXmk8A3NS90o3Id7GFkj3+FRUfCaVMLO9TA
         /uHw==
X-Gm-Message-State: ALoCoQkVuKustG1/5HAX6Lln69BbzSiwpGSYRaBdCDWA9LtHuJAyas2Iaysc7AvuNq7V3Hmqdzh0
X-Received: by 10.224.95.9 with SMTP id b9mr6785138qan.2.1398976665338;
        Thu, 01 May 2014 13:37:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si3537996yhe.3.2014.05.01.13.37.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3443531C1CC;
	Thu,  1 May 2014 13:37:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EA795E097F; Thu,  1 May 2014 13:37:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247838>

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
2.0.0.rc1.351.g4d2c8e4
