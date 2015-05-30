From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 2/8] for-each-ref: simplify code
Date: Sat, 30 May 2015 23:23:25 +0530
Message-ID: <1433008411-8550-2-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykxM-0005mu-7m
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbbE3Rx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:53:57 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35541 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756681AbbE3Rx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:53:56 -0400
Received: by pdbnf5 with SMTP id nf5so15114849pdb.2
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=if7oc0RT+FbQpxdOrMhmVX50gmRSay83m2Dq3pYB8/c=;
        b=LPnBFZlV0giXlAZbIQ3a6lxGJCfgr1AbRbURtejX9GMFu9nMKok7wuCkPdtrjso3kj
         Mxhv/pu5f6BHgTf9HZLaVu2WKWGNoLzxDoDg8C1UGma48WVn6WiwsIvg+N5z4pGEbuLD
         3CEUGyJFOQEzpRHgoqhxT/NX97+lPTwaup7jhQWg2lzsgYdyf+bnB4GrtS2nvQvkUySQ
         vlPZgv5fRtRXGJGaIxKPfYcXrG6diwLU2k1vb3vQQ61wivV2Zku75273pRrAQghnGWqm
         RP1R1Cfd2sekKNPh/QVcW4E7+JcltzCzjZAQe5Evm0r7FganlBCL9RjMOdnE2jL2k8fo
         Y3gQ==
X-Received: by 10.70.38.10 with SMTP id c10mr25515430pdk.72.1433008435951;
        Sat, 30 May 2015 10:53:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.53.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:53:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270295>

In 'grab_single_ref()' remove the extra count variable 'cnt' and
use the variable 'grab_cnt' of structure 'grab_ref_cbdata' directly
instead.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b33e2de..919d45e 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -881,7 +881,6 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -893,10 +892,8 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 
 	ref = new_refinfo(refname, sha1, flag);
 
-	cnt = cb->grab_cnt;
-	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-	cb->grab_array[cnt++] = ref;
-	cb->grab_cnt = cnt;
+	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
+	cb->grab_array[cb->grab_cnt++] = ref;
 
 	return 0;
 }
-- 
2.4.2
