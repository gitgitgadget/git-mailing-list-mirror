From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 20/44] refs.c: free the transaction before returning when number of updates is 0
Date: Thu, 15 May 2014 10:29:35 -0700
Message-ID: <1400174999-26786-21-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUR-0007Vr-QO
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747AbaEORae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:34 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:35726 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426AbaEORaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so637291yhl.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MaqvRR/5OKkLbY6J6cvdmPyO2/tdbvowT9FcVh7KqYQ=;
        b=dvBXsvo/HjwoAKjEK3qIrg8VkPyJaSYL8Xp8C54cZAh8jST6RJuXFyyPivqtfeThDR
         DVWPTdWkkKap9Pe6tuoCTcWUmCVLXrZVZ47B37zEC8h0GmM/wKoVD6os+OpJYFJf5Wb3
         GwppsQhwcFbh6Ch2OQ1HO3QRzslzqhlL2+d5ajEhfrYPnyBxm+oV1DRjWgwV8r3i/JEt
         S0TXhOHkWfA6n9fuIMqvDMnioWls6jY76JhwD/h1ymcDM7EN1H9fz55PLTES7cuEt/+h
         IfntUw3JgOsVoYd4TXbd+OsP25eWzwr13piWe220AWjHfbm7Cf1Zd2T4aKBqbHXGAHi8
         4prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MaqvRR/5OKkLbY6J6cvdmPyO2/tdbvowT9FcVh7KqYQ=;
        b=RZXdujYpd5c29qhXPAqgeUa/jyx1Wwj+b1WK3/juYIVKfg+wWAk1qdEj9Pt06TfTff
         GXyrBb6g+tJlpy0wl7Ji0NZbLpSP2EDO2K2kVnG2D475+3VdNsM7JPICEAa8zwVMuqnV
         FDJ/H6LcIsnHhNOcBKC+fy+P1exa84FUv/NF6g3ym6dro+mqdBKXj6ujpzEMB67EBAxR
         /V1cHfjSjSPz6MJE+k8PQcDAbTewjBPQYBpD6iV+CzNoskNTYN7G8XYWHKiANxYg9/Of
         STezUfmV5XSfBPlDhxb2ibqotX0s+S/AXTspXn80IEdxfQQzDgyQ8e+mdl57BpeHO1jM
         m5zA==
X-Gm-Message-State: ALoCoQmJb5Hp+BRYTpEUy1sP1eoB/jUlknxyYAMJjZPUCZVFLAsOCU9FzpmqOJcHa9pWCB60aIFY
X-Received: by 10.224.72.66 with SMTP id l2mr4894274qaj.8.1400175006620;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si273664yhj.2.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 79A3E5A427D;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59C74E1084; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249127>

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
index 0476892..4a37f87 100644
--- a/refs.c
+++ b/refs.c
@@ -3471,8 +3471,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.g0f8edf7
