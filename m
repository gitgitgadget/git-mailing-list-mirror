From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 38/42] refs.c: call lock_ref_sha1_basic directly from commit
Date: Thu,  1 May 2014 13:37:38 -0700
Message-ID: <1398976662-6962-39-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkg-0001Qi-T1
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbaEAUib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:31 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:40996 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbaEAUiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:00 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so671437pab.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLay1iklrOHwTrjD1eCPiP2mAH7+5MnCM2LLoYO2yXE=;
        b=OSQi7uKXMKgjGZvVES7HsHy8GJDIpUj1QYeSKjQMlOBtvA11/DuaFrydZovLjMuElL
         pTW+zvml/EFBrzMYlbul5qHXU7AJqkuO7LLBvOO/8srVXsViz7HQ2Mkyd6pMpzsncAUe
         zYGC3SBrFhQ56KQ/EaiWbDVtBWoanYaNBXifokS373S0ML36lJL9hhICk6ao7IZf7GWP
         kwlv4bkvYld2XWipAxqmR19icHZKnJfGen+CGl95l2VXh/TaXC3UGm8u1dFOeYzLQEeG
         SLFtUx2b2TB+DC/r2qjNBfPVgD8SJN7gsgoOpaDmKtbVqB26D1m8uGymJNHD0A5Hw5ym
         fxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLay1iklrOHwTrjD1eCPiP2mAH7+5MnCM2LLoYO2yXE=;
        b=ZF4tuUvNAGqMC8FcN4slBicEvM4gLS7k22dUheZCHdT30NRAREvWLLJWRDI9DyL2Dv
         uJNtocn0NN2uz9dfc0z2O37N9awUrCHP83F4gm2WmiqJv6eq5Rdpn2xWihSpVwixPjm8
         yK5eJc9mAYvr1dMV5llqqBvNT2u5m/9cUh8eTRNZHpYy508RDPYRSolBIvabD79SKZuR
         9qTjBrq4ycOAzzOX8rq2+Ysv48CrcDDopWSCQjIM8m/pLI+4mIUrNQW8dTb1hbHLmOkq
         R4PCWzSTKPrhY8OMeSX5LFVtgK6gk8PXag3ppUE4LJN8fpa89Yf9DFajni82h1NAzTOU
         Rigw==
X-Gm-Message-State: ALoCoQlFKqaOwTP/W3M66bQViOXMRlNoR9uKyKci+sj1e5bHJobxM5OzV2wup+tvlVyK1u0WAXUB
X-Received: by 10.67.30.197 with SMTP id kg5mr6847217pad.36.1398976680254;
        Thu, 01 May 2014 13:38:00 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si2198400yhh.0.2014.05.01.13.38.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:38:00 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 178E231C1CC;
	Thu,  1 May 2014 13:38:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D0A1AE0A5B; Thu,  1 May 2014 13:37:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247850>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 8d82742..51cd41e 100644
--- a/refs.c
+++ b/refs.c
@@ -3462,12 +3462,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = lock_any_ref_for_update(update->refname,
-						       (update->have_old ?
-							update->old_sha1 :
-							NULL),
-						       update->flags,
-						       &update->type);
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err ,"Cannot lock the ref '%s'.",
-- 
2.0.0.rc1.351.g4d2c8e4
