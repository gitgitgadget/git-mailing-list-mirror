From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 38/42] refs.c: call lock_ref_sha1_basic directly from commit
Date: Wed, 14 May 2014 14:17:12 -0700
Message-ID: <1400102236-30082-39-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYY-0002V2-2o
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbaENVRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:38 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:51429 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbaENVRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:33 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so40789obc.5
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rAXQTXaquxsbGhT+4+r+JVZbyIigszCN7rXiswWsGYs=;
        b=QAQr7qR1nU91HaECuErB7i89J4SJvm7N0E5JY48e0GEjbC5Fc+kgPa1+bOxYBZUr6J
         J0IAnXL1CVgRrGcq5SyUtPiCPQEuSqtxdbpy7Tacl+OzrpS8V0zDRzvWXynAbOFlbIv7
         XEEF4pdOoyEN62QqFzvsuxJxGUAOoP+NxcIk4j56pxwexN22s4xhSDqs9WoVZ9f/vAK8
         KYXdPBEzq2LDoF0qPrJO19kitmUWr7c8aCsdeZ+lnxLnlxMR0A7h0CExAM0FevGayZKg
         OcbBMvlLRHg4m5KXIDjNwHHAFAoNfDx7S/Q1cUzPUsUD7WWRPMSBCojBEG+mXWggf2lN
         U6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rAXQTXaquxsbGhT+4+r+JVZbyIigszCN7rXiswWsGYs=;
        b=KFJkqkEnIIsleYb8icnXEgv1awvpyw762/SkTnIbDOkrh0267JhbUhKAKg797iOtkv
         1Pwec7/KjeY5WMV4o8ywspdVjNB0jWe93FqG2nLJdOxEDTqu/HUMZFQpvLIsOSUOdsAG
         kvPUsy2hdAVppvJ3SL6cxa+Dcdw4TiuYQF8E3aTbUKlBUhTfwqWtHJHMxsULq9yeTAUV
         H3OTLaRQHjnpzQSC8LfIp68EsUQEMchHFv8nALaveVjtMi5WDRbM9yiWRb/INZ6KtPjZ
         hOAJpFtriHWjn6IvJVpT97M+j7zoRfYt+1ev1u+XHPO4yD+4PSRUo6DaSZwR4P1mcARd
         szLQ==
X-Gm-Message-State: ALoCoQm2gxdzVpJ5BkJMJUsOfQQCE+CSD/ERBDnpUSNGDN5OnMGqXrHTCFVZCeAd2qDQ1YeCq8r2
X-Received: by 10.43.173.71 with SMTP id ob7mr2681596icc.19.1400102252769;
        Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si146200yho.1.2014.05.14.14.17.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 98C2F31C1F8;
	Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5A965E0CB6; Wed, 14 May 2014 14:17:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248958>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 6556417..a376dd6 100644
--- a/refs.c
+++ b/refs.c
@@ -3476,12 +3476,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.471.g2055d11.dirty
