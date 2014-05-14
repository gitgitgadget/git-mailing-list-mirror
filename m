From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 18/42] refs.c: free the transaction before returning when number of updates is 0
Date: Wed, 14 May 2014 14:16:52 -0700
Message-ID: <1400102236-30082-19-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgbf-0000M0-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbaENVUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:20:50 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:64261 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbaENVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:26 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so33854qcv.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZrP3H5n5EEJ6da7tXxCAyVaYfr2fmP+t7J6buZidHHc=;
        b=DPMzcnzCoR9LhHIaXNFbmf3Y3qRNHl9v0JykrWUW8JGBJefWkQMzsA7E67xdztZVZj
         VnFuZjUJDvrdJOLcPSOd+0KQTkTNuVgVnBAUwFYRP1hRNPQ1HDd2w5Nb/PMCiHgf+ZwO
         clA8Twk1KOQsIkCkcl3seCyyU0OQ9ZDxR1vgPhII/JFx0dIlQGhP/lwi/dywu5EgIOo9
         3DrLHNog4EiqxwO4C2hOvGV+9rkYEUvQTlgKyPmHZsm/Xead8NETJQrI3LY0/653hDij
         wXD4GQrb7/ojLkekOH3Qsbvhu+vOYOIgSxwQlZaJkURR1D76uISZxfcwrDFOePIavjaD
         GLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZrP3H5n5EEJ6da7tXxCAyVaYfr2fmP+t7J6buZidHHc=;
        b=N1cd5dPSPg989ZcyE8EII+q/AuG2SRbSeYZj4H24GNBL3lmu3wBULvxfLP8Ywjzlsg
         7qMWZudFG6QpcjW5KYBdib855rSdslR76SF6pDbJbnEetf8J0QEORVmL9TMTpCYMG7q0
         U4l1AJXgKo/f1gAeqqEb7/JFbFFMLHYzSRUOdaV1z+5eHTCSQ0EnRjMzVcZ5G6iWGLTy
         zC6X1SjWWQ1WNXCha1gbl3MxCDGejQEgdsUdd9LQnGi9iHSUawDPy6n3NF3hPioYJcAR
         zyNwierKFDhMChIXKWAlcft4+58juiLMjXQTUqKr2duZZ8KkCyl1VJqR92Wpn9EgD5if
         crPg==
X-Gm-Message-State: ALoCoQlaxN0VSeBZ0z1nMRWzss89URvaMMzLG6StVCUxnGR9JVRnSVMRuZW3JYCu2fblnVplY+eB
X-Received: by 10.52.146.45 with SMTP id sz13mr2544623vdb.6.1400102246080;
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si144562yhb.6.2014.05.14.14.17.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:26 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E9DCD5A42DA;
	Wed, 14 May 2014 14:17:25 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF030E0973; Wed, 14 May 2014 14:17:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248984>

We have to free the transaction before returning in the early check for
'return early if number of updates == 0' or else the following code would
create a memory leak with the transaction never being freed :
   t = ref_transaction_begin()
   ref_transaction_commit(t)

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 55aa5a9..a48873c 100644
--- a/refs.c
+++ b/refs.c
@@ -3460,8 +3460,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n)
+	if (!n) {
+		ref_transaction_free(transaction);
 		return 0;
+	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
-- 
2.0.0.rc3.471.g2055d11.dirty
