From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 40/44] refs.c: call lock_ref_sha1_basic directly from commit
Date: Thu, 15 May 2014 16:15:37 -0700
Message-ID: <1400195741-22996-41-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4tC-0005dx-DH
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbaEOXQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:27 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:37216 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756073AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so388990iec.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P1ksDCIa9dN4o3qRgfGBDwBAjIUNjGiRNbSJlkHCRDM=;
        b=JPuvLsCVa+JqzIEvJ1J/3kJGE1Pp1xCYp+v8j65JTKSFDvq1zP1JJPftBjUcy3LfXT
         Vm6FzxZF96/sR96owBjgLnhQzMU44U7E1W++oqlNcdjJA13OhypgDzYT9gkckPnxd2vo
         T74uGySl0qeblBjTZffK4aXDCSPrvwSAFmjbtE7evwRYeDVCTuJH79kSdaQ0G5NUwBEe
         iksX1OgGysHRtXhcYWxEcIkpEd9Eli1BCzuKaEHtSpJX+Y87oKJRzEX9+hpwb2Z74xH+
         +h2ubOTRyIJA40g53hH/WPozh/9puhmciQ8vT36RmsGObKnBRste83qNlzWndvzSovkC
         P7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P1ksDCIa9dN4o3qRgfGBDwBAjIUNjGiRNbSJlkHCRDM=;
        b=L2QDmeOOjYWYHOpjhtwwI07PhLahCfrOVtf+sz8Mq5hcj7jMiP+pGb+3eJzArILRuj
         B22o77wFu4d6+vS+vwF2D+CimVFiPT2TIYrNN1XQuw4Cj0ML1R9dpjbv6aRmRZfzBEnp
         du97oO8Is9KlcmdFSu2Tv7iUdWb8wbeNr23rVm6RQ9Af2YoGvAkJbG31yuDukuGQ2x3b
         UMK5cKgYLclNTocbCVxDlaa3OB2RrnF6mnMYlGLyChkv4wIgl2+wqCd2BM1HT2nwhtpO
         C78AR5//PlBiqBKq1VTssaMCvlS5ibt7xn32nyUyBNluOSLR3L5cj1yMP7TImoszEH8L
         p2HA==
X-Gm-Message-State: ALoCoQkKiOjX/T6KUosuDdVb9mCmXqqRYtQbK62gsGWLPhumO7fmpgXK+uort+ULnk4dTM6lsYbf
X-Received: by 10.42.50.9 with SMTP id y9mr5477429icf.1.1400195746368;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si244843yhj.5.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3763D31C259;
	Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 13C3EE0B9F; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249234>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index baa620f..87113af 100644
--- a/refs.c
+++ b/refs.c
@@ -3521,12 +3521,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.gffe78a2
