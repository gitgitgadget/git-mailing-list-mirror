From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 40/44] refs.c: call lock_ref_sha1_basic directly from commit
Date: Thu, 15 May 2014 10:29:55 -0700
Message-ID: <1400174999-26786-41-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:31:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVC-000195-P7
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbaEORbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:31:16 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:42889 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbaEORaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:10 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so257168pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnFyquH2T7eMWVPABvqXhPVDftDX/IoyT0wWrv2C0/M=;
        b=C2smfsAI1GlhH2TiF9RU9VBf1/bSfogdwaoZ1NapzWGc0lGzNOSg7HTydp6W6yiOU0
         b6MSITOXEZcudw3/ZWcsNf3YWW31dRicqsLdIUFftn6O9KUmE+SDbmmJnurOog13DjYx
         07w20uHC2RyRbbPO+ZQt5B+9LraXq+t5XtpllS4bxG+Xje6Bks4BXcvECpVO3StGHns9
         anChaZ8DVyzLbqKpYUBgNMwaBWMvwMlz4SRI4fhu9kSM13X4f07F/qaikB3n4uRHp3Tp
         gZaYgWbWl/Dl3ExpCU17wtHF2SbnYxruExWmGJfYGEZ4f4hJEd5xJ8xJ79Xk7diKejaa
         QumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pnFyquH2T7eMWVPABvqXhPVDftDX/IoyT0wWrv2C0/M=;
        b=H3L4TBcRFbFdOuC8PJniRWeyfEcxhRtQy64DA9jVLS/cWhE48T4bR2tqvsaNA8cs9t
         YR8opgFN3z0S72GC2uYdtfRxktnLjyw5e3fiqeSi3BQgraridcuv5lXXI0+MR2D4NEAY
         tV+PMyYx0pPQgPhSG3DLjM2g2f8KZ2+7GG8JB8cWJUJPnDMpbNzZDm5H7aoz6+lEV5De
         OitPcy3Gj7IxNlY8EVFpABOjNRTrOpnnhLNY660/Wjf2xmMymG1P6l7a4MHTk3uYC0ft
         YtnOPw1cTQmiWdntBfRmOlHZxVOK7zrRI6xFpjr4XzzNHRLheC72Gi3pEyhB2CQPtN53
         cL9A==
X-Gm-Message-State: ALoCoQnj+acdi90cKALGpCb0H42EVov1LYaPjvOBHyH9wnDRnEaxvIn91qZXM2askwlAKX3F7aV6
X-Received: by 10.68.133.75 with SMTP id pa11mr5530890pbb.2.1400175007758;
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n43si22358yhe.1.2014.05.15.10.30.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 922425A428A;
	Thu, 15 May 2014 10:30:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 60E25E1207; Thu, 15 May 2014 10:30:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249141>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 53fdbd1..69ad51d 100644
--- a/refs.c
+++ b/refs.c
@@ -3487,12 +3487,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.rc3.477.g0f8edf7
