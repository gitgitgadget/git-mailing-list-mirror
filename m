From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 02/19] refs.c: allow passing NULL to ref_transaction_free
Date: Fri, 25 Apr 2014 09:14:37 -0700
Message-ID: <1398442494-23438-3-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdims-00076U-VK
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbaDYQPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:03 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:33734 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbaDYQO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:14:59 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so70649vcb.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nDcWGBP80roD42DCt7kY4DMBkyNw5bAlX+ZQK17phgI=;
        b=C4mHVYqyadurwUsyK2CJvWSqP22yITSpUzroUv5Q8wzA8wd1MuNzxJAhzcu1qnCAYs
         35nUBOgLobJhXgmJQjIStTCpmVKe0EPCg2DSdRogBVqWhp6adpcAapmFszMTZwjbxdYO
         nYiSu59OANYMIp5EJWWKYbufRWO0lxnxYtFwMgwA+uxjM4vSNKIUz66RKH09j1AU7pXu
         MqqCT2RXHDdPlopVqYpuYZoQ4yAeRV0tMvELJN70GLacubV/okxBW0ExI/HyEibHkAXW
         QPhtaCG3cbU/bruJVyJnIpwO2KkqPlZsiaiE1EoZRAYewMrGCkuTFLvtxMnBAt4s22Ef
         tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nDcWGBP80roD42DCt7kY4DMBkyNw5bAlX+ZQK17phgI=;
        b=RukMGhoJwc7n5Nj6Otcohp8wJA1wv5PucHa0VQSyZTYxSJCbl5Wl/SBIKyOtwQjNX/
         hQHc2ZJR+l1FNS8riH5nDpNsm2tnZMWSM6Mt6WV2G6YtuIFE6Cg6k1XCcM0afPuLfhq0
         55w5twGDTbjwSJq1aIkHVKQmd8aWuF1ZUG3IxvZo1vxr/ZFJI2m4L5kDhM+GWlCZEtNm
         PMGRlFbZ3MkBOM2wIk+0bNWnkoerSJOMo7OzNLbIMRRxb7v56Py+2MAAYKl0IYva5RX2
         +U+5UYRaAeXjQHP3WrZj1yqbCcT0wCsjWc7beYftkyxHDuoxJur0wM1oXex2vk+TrXHK
         LiiQ==
X-Gm-Message-State: ALoCoQnokJQyNxSzGojSfDBZi8dOr7MR3CJDg0qdbjdDt9Qr+rNiTgg3Oued5MlG7ZORRTEkWvXP9gcbRjcotvyVSXjhWnykWq/uPTMeC1byq5AXeG3QiPBVRs76Xz695rl/0S4qDjgPiuEpgNCQ+udeWmQK5WFxceqK6sGUl7+N2f5oFquCHPgDnF26w9Y7zFBuyWR1meaU
X-Received: by 10.236.134.98 with SMTP id r62mr4017843yhi.14.1398442499051;
        Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si1050127yhd.5.2014.04.25.09.14.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:14:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E1A7731C028;
	Fri, 25 Apr 2014 09:14:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8F578E0855; Fri, 25 Apr 2014 09:14:58 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247051>

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
1.9.1.521.g5dc89fa
