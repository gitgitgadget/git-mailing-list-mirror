From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v14 36/40] refs.c: call lock_ref_sha1_basic directly from commit
Date: Fri,  6 Jun 2014 15:29:14 -0700
Message-ID: <1402093758-3162-37-git-send-email-sahlberg@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 00:30:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wt2eQ-0002dJ-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 00:30:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbaFFWaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 18:30:00 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:47139 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbaFFW3X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 18:29:23 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so140664pbb.3
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HeLiQ86VVdmTWtbDcSTRdASEHsnqnJh8SwZzRcsR1Po=;
        b=Jn/msFnWgcAOlij8T6A6Mtivj5aRhMZd7qeDwsxQ5GipyKEKPNI8LiW/vBb1sIQJt4
         5GxCAfIQfCUEnDU+dsn1MuIRDKA9UYnZ2wbS1ewbB32HIg1bIxGQjJKwyd5Ce+Vy1DTo
         Z0ndl9VC1lfU43pkdrg/3qctFRPNxPmggdE+xp+FL10WMe/t+9HPLzPBxc0BS35eGm9z
         oktckAodvT56TegswjY+5cfyVdeUDg8HzcSRkzbOIJdrKsIspfEHFPqsLBuk2NbrE9LT
         07BARBSF0BUcUJg4o1oizpVcOlSjTvTFDcEc9XY0/MWagXbz0f+aUeX40Zv4Jt0j6oN+
         2j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HeLiQ86VVdmTWtbDcSTRdASEHsnqnJh8SwZzRcsR1Po=;
        b=ce5x4xm+E8xStJhKK4ca7mmivKsFfJppE3z3DQUhp0Kjlgq4GTQpM1xzEAyyfsLtuI
         uP4zK3yEX07H6OlmOUplQq8l2v7aRmrEso5Osx9uKcftl3XcbtsaT303e/3doSj/uP3M
         L3TE5B3PkhK2zMEEEwNLR5EN+fMoB96dmcFWgsQpFdMhio5XvhxC6UYnreNM/lFJcWDK
         Z650ct6L7VCRF58NJWObajPNjjejDzoayxNqxqpBp9FnH8/45p0OV2pLNPfG9g9yGfsY
         Zo/HJAXCN4xvmmYq4BkAsUcBC+k2PwwR0VUdcl/zMqUjy9H6nZqWPgeee3cQdRZqa4Kb
         a6FQ==
X-Gm-Message-State: ALoCoQnt+mCOF/SsmbDeyyAr67yCyuv83A9/BKy/aLQqYDsH+IA139dBvDYKwJG3WKnUDGAiQjWD
X-Received: by 10.68.216.230 with SMTP id ot6mr1987173pbc.3.1402093763274;
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id xn6si751081vdc.2.2014.06.06.15.29.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jun 2014 15:29:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 04A145A44F9;
	Fri,  6 Jun 2014 15:29:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D4F1EE109D; Fri,  6 Jun 2014 15:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.582.ge25c160
In-Reply-To: <1402093758-3162-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250989>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 7da5357..66427f0 100644
--- a/refs.c
+++ b/refs.c
@@ -3564,12 +3564,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.582.ge25c160
