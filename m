From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 37/41] refs.c: call lock_ref_sha1_basic directly from commit
Date: Tue,  3 Jun 2014 14:37:55 -0700
Message-ID: <1401831479-3388-38-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:39:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwQo-0006Kv-HT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbaFCVjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:39:16 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:55694 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934326AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so807894qab.2
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tzv6zR8ojmAzJzgyvsmKMiw+5HTikDmEBxR/rtoLSV0=;
        b=cCNAsAUqg1+TN1TMlU7bMHF8Y682solF6Jb/Hjy8jRTaio2Uyf7idPP4z3C3xVfpC9
         xpKWA6pdYZ4dA7jlXurU8nU/FwSmaiX25mI58SQutzWP/t7E+AXtQvqDpNzy4IJ4ShwH
         hbAOqawyD1xDmJl3PzNVk/8hRo3/4UgI6/5nExQhlR4Bc9C5CtEUo6UqRuM8tNhgJbPu
         A4Gqzk0tmoy8YD/hDhzLzDA6sdeyGnrx3Hx2IqBc4CJEVgCcqmNKCNPu9bA8A16tgpjQ
         YQ2Zz6NcI4ioZm6Hte6urHfBlRdoSNTgGfEt0EGqgRnUmBg9CiOkibH0rbZqwfrEKfz5
         vLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tzv6zR8ojmAzJzgyvsmKMiw+5HTikDmEBxR/rtoLSV0=;
        b=Ex0oU+4cI5+tbbkUPOSsJdfwebj9hi8J1NEAd2UEPMUOhn+ZpKIbg0TeY7oJmOLg3s
         ieX7acPjk9X6inAyB+WxJhSWJAy73ZoF2p4ZxGfjtlp98XWv1gqxg7JPuanwaQsig3on
         NuLFbv719EqVygm6PTxwv4mVl7OGcyv71OqwDQ9oJJkcps6DdoWkcrugdXpgxIms4kPw
         8kj6k3ph021HNW7Nx8xjKSrslVDOCVdq9wEOp22BLUPOvecO8Vl6JiUiFYGfku4hfGIm
         LpM3Ff8F2NIiR1PHN+Ure66v34tk2gmHCm71PAw+W+d8AwUZzCK02lqsK2o2YgY4SmVo
         vgMw==
X-Gm-Message-State: ALoCoQm85yOmNLzd4QQQ8/3qnqA28BUuPFPbDtyAFIU0o1+UMAmsLwN16EVB2zddDTR4XeAhiF02
X-Received: by 10.224.26.76 with SMTP id d12mr9877824qac.3.1401831488647;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si28353yhl.7.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7F5ED31C462;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 61BDBE0CC8; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250661>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 22fb166..f13c0be 100644
--- a/refs.c
+++ b/refs.c
@@ -3567,12 +3567,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.567.g64a7adf
