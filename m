From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Thu, 12 Jun 2014 10:21:35 -0700
Message-ID: <1402593699-13983-45-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:23:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8iK-0007rj-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbaFLRWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:19 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:40629 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so142746vcb.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtMSgd1MVFFRwFzroJvuFch/H5pzbNIHIdl4aRbSgbc=;
        b=f35FmSyx0fKOBVQQ5JL+WJVR//lmGHpr9gby7Hfd4yExP75n6hVVPV+a20k/BnGnoQ
         0qSaucpHuXOz0TpkELBeBmth5Be09FxFUiMAHss4bQTtZeJrB2tKxgMfvHBvS716AncD
         GuI5/XQQUFOcuR6bvGwE31MMTv1kN5HiUb+dsZTpxfefZ3jE5xQO+2ovsdmyhJ9V97SB
         FegLpFm+o6Q3snmi1SblFOUdjcLFCikuSihPQI1TYoGDmhEbHGsLaxIa59Ktzf9N9vvQ
         K0/DR0DrtS77jKNCWPCcGVt1aAymoTy0Dzin5Btt2YwmIjmHKWx2jWMFPsZ20Nr8dXaA
         TLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtMSgd1MVFFRwFzroJvuFch/H5pzbNIHIdl4aRbSgbc=;
        b=EG84pPG9Y1dHYDR01XQBij6BLblrNR5WVLqajlkBJOr0c6vcKGYvBeGYI+ZB17GMdn
         WwhB+nQkc07URCN6Y8VvOLwRKKcfE8F8ScTYD654HQldfXj6vLrQr8kgCd5LXNdQ4jeG
         QwTarh3MwX6oMXx8MkcJdnq+PkoVe2A6LT7E17pu4x5F1ukKZ7Q6c6+kCgIJB0/qhqO9
         K91bkcmJyRIWsrtHg+Yc1N6BIwQ7NO1Q6ENOjbmwVo5oDuzk+ypOTQnin6PaVz8pBxIp
         +wO/6JzVFDOvTIUSYSzNhOPE8DDr+wFDJKQeao6uxbrDlX6N6ocvVoxMLsysi1oD2u4N
         lV1Q==
X-Gm-Message-State: ALoCoQk/fURNZeZtJmyu86/r0V0ntypl/ObqBNKC6EBaJXQjY6MM7Fu1oTYzaDFf6SDFA57qLSzG
X-Received: by 10.58.164.226 with SMTP id yt2mr4139228veb.7.1402593704929;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si113147yhg.2.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C362E5A4749;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A2228E09AC; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251435>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index be618e8..6d367db 100644
--- a/refs.c
+++ b/refs.c
@@ -3571,12 +3571,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.599.g83ced0e
