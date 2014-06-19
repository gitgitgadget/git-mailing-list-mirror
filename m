From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 04/48] refs.c: allow passing NULL to ref_transaction_free
Date: Thu, 19 Jun 2014 08:52:46 -0700
Message-ID: <1403193210-6028-5-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxefs-0007Qx-Kn
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbaFSPyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:14 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:44660 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbaFSPxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:39 -0400
Received: by mail-pd0-f202.google.com with SMTP id r10so289881pdi.3
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/WvH4416qqneO0/ouaBvbN8RCK/KWJqGe9JhwJVc3EI=;
        b=hOjVOdDWn20HG78ZEprHXU3byKvQ0WykDVWqabefhjnXngsXs2dpjivqfzUhIKs5W9
         XQEax/xZYoJJzNQiX6noWk5szMpfx24PV5XuVCiGOxAX/YS++aO9ETlh247N4wsRggHh
         rpJ08wFA3ZzzTlGYu9PPO1JQ27M3TsFljdEGSGhpj8mBjVM10OnSu5l6JCqADFyWEM00
         F+/S8EkCs6X0j3zoYlJxIih3HL17z1tY4wPgrXoaMCzN67Vnu8dY5pWFFER3Fk9Yl2TT
         1L7TmuVuZrm5g9TN8I765UMEgd65R3lYXBYmrUyrk2qaIG6chH6HMUpzB3rSODFCKoBD
         KlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/WvH4416qqneO0/ouaBvbN8RCK/KWJqGe9JhwJVc3EI=;
        b=aKSGaZfsXMC5A4ZnQiryfpfw/qaXaZSgoQX5iTnYxVrNM7aZg8Nqbkb0SSNhpAU26J
         F/QJj/Ejvr7UxshLy/qWoZQc7Swk83Ef4VZ4RZPMzm6lzN39h5BsIJd9i4EnAMGXokeV
         bEDj7x21F6p7CHFpOcPfLR2wLnG358tR9v7lttZL/n3kkQitdCYUvODvr5ivzYPwYmOZ
         c9OlioU7pqJ3k/bcUa8VhADtnObNsxy+Q5EPKJ41O5a39gCCXaRmSfZvOctPcqpj4PaZ
         HWUTzdzdhdD835eD0ILm3Y28pwzkYG23slOxfh9Wh/bdvc3Ez7LYqQGCmVycDw7OlTvV
         YEhg==
X-Gm-Message-State: ALoCoQmeUb1xzBRaS8Kbi3eti+U/uO5eymnzh9ngMqkyWtboAm8SliI3L4wvABx8zQPptjeyNImi
X-Received: by 10.66.249.68 with SMTP id ys4mr2570023pac.31.1403193218305;
        Thu, 19 Jun 2014 08:53:38 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si418798yhp.6.2014.06.19.08.53.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2411431C2E6;
	Thu, 19 Jun 2014 08:53:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5F198E0B1A; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252133>

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
2.0.0.438.g337c581
