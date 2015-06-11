From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 02/12] for-each-ref: clean up code
Date: Thu, 11 Jun 2015 21:39:53 +0530
Message-ID: <1434039003-10928-2-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:28:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z35Lb-0000dP-6F
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbbFKQ2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:28:50 -0400
Received: from mail-pd0-f196.google.com ([209.85.192.196]:35983 "EHLO
	mail-pd0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbbFKQ2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:28:49 -0400
Received: by pdev10 with SMTP id v10so2258836pde.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nagjmFpy9WL+g9mn9q/lpu6se4cWeH1r8xiuZy0fJxQ=;
        b=nIG++5bonYU7MIf3z9rhHb940jO9BAFWgHnE41xZ3Yl2s/hp00D+PP79yaFPCRoQzm
         8wygeX84V02B/H/zjH/+8k9dqSUc+B4rpIif1mgqUwARei8BumIz94UpcSdt+LgPSjfQ
         Wd4X6NqpLjMlRY+1/bAmxm66ka9/XjPKNG7tqvd9PQfBKlU77VN2ABnb+Uy19FOoBOWR
         AZ3oF1xlUBJpckOwYzpzlsF+EaNuJ+OCu1QbrbKJ9I86u82TvExEPzHQ3A2BszFhdj5H
         OkL8CKPYvv8b3zTHpX+M7stEmeLGRSRlSegsiuQcJP+QgRu/EgFacQSPK8alcOwd+7ji
         +TAw==
X-Received: by 10.66.65.134 with SMTP id x6mr15534187pas.129.1434039015749;
        Thu, 11 Jun 2015 09:10:15 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:15 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271437>

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
index 67c8b62..0dd2df2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -897,7 +897,6 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
-	int cnt;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -914,10 +913,8 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	 */
 	ref = new_refinfo(refname, oid->hash, flag);
 
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
