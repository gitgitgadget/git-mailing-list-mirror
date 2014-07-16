From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/12] refs.c: call lock_ref_sha1_basic directly from commit
Date: Wed, 16 Jul 2014 15:23:07 -0700
Message-ID: <1405549392-27306-8-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Xbn-0004EI-Ux
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbaGPWX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:23:27 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:39539 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so221895yhl.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GV5ooENdMAGq1fCZeBH6hJxVqekluT8wF2XGq9byEw=;
        b=ahNrJzfrRkQ6ByG/B0+u2Io9u8xoRtQT1fiWiEZ0c3a8JpmWXumsn9ozrqEhh+ROfN
         FDzoOKR/O9GHI3oETcNVpKEYt59PaEjTKoVi6wm1n2/wWAGcgRBlzngsHtnDBRujV7Gs
         QWdeHNcbA2oV0ZethJ1LTz3J1x6oAKpYw4HPbu5tXa/2WvZwrYIRNxU+N6cfV7BJnmsk
         InPXHHJxEm8vt99ZrCy5cl6AVwS/0fQqga9762bD88a1e7cqcB0gcXZDrmg3AYUilSmC
         9cc8qwgn0bdWNq0rbSxCCiv8MUf6xbwUgvsjHioKg2tNzBRnS9YRrGneWOLN70miHCKJ
         qBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GV5ooENdMAGq1fCZeBH6hJxVqekluT8wF2XGq9byEw=;
        b=a8/CI7Dnuxhht3LOCfcWbkN9Iy5rKQOLhcjjxLrse6kkz+GPsORyseBcFg1dPBaIRW
         ThFNfiJZW0buVHt4+B34CelX3a7aEjqhO1WbM1AUyNE6gl0Yqc/VTjlbB2Ro2ULvXMr/
         bvlZesQQ4+43FtaRdJhjOljpYdYvyEbvcrjao1RDDAW2MxHnr7EyDBrcmG8s1bTndxA7
         7wMW5jgUc9df2TQ9/BLfl5fD4tSx03Q3u4DiqmCAl9MNk4b6328SS8UreimK8S41ZLvg
         pc1YAmfsRsBbwjwjksX7iQouYj5b+/tREiURfA3GtXIPO1bTR1OEPtdLRt5YeI9pP+ai
         afVw==
X-Gm-Message-State: ALoCoQnYnnuNhlulqy/QHTRS6qm+62ufG0cuGBMIIKcUgdwQyzrbJx8byuDAwrvYzYtRrVeo3sD8
X-Received: by 10.236.101.148 with SMTP id b20mr14060939yhg.46.1405549396122;
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si73902yhk.4.2014.07.16.15.23.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F3DD35A4065;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A2199E0B27; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253704>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index f29f18a..d3fedbb 100644
--- a/refs.c
+++ b/refs.c
@@ -3575,12 +3575,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.1.527.gc6b782e
