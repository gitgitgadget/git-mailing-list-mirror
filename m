From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Mon, 16 Jun 2014 11:04:15 -0700
Message-ID: <1402941859-29354-45-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbHZ-0004CC-BO
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbaFPSFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:19 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:48442 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-ve0-f202.google.com with SMTP id oy12so475300veb.5
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWQKsRyKvTBQfAXQyM1Qt9/E1Q9r5KKy/YsGyHztBPU=;
        b=QstB3+u4mzQ6kswonx/92sLqD85MUvwbJnndFTAzr65aAwxXjt47tLxu6NxwPnjOL+
         32khmfATPAKtE1WjntcNVxOiq6hKUoJHqY/wkyMk7pAEcuwUFj4f9mi8le+Sao82SeIj
         0uDYoJqpApFo9O1eZStVeA/xM8JG2XUM8MYv2iNajJFau7rqyYXdWTIxI+JOxAa7hNeE
         FnD0KnpnNk0J4utj3mZzYhaRNSbJikQcyiXZ8QplqYEY0GMDLpmwiyGeQjvFtG/Sq/lk
         3lLFjj0ur588xdp9mJ379USHLsR/MLqTg+JFMhZXPaMvFT4YdxyUcp/TicCLs6UT8vi6
         NqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWQKsRyKvTBQfAXQyM1Qt9/E1Q9r5KKy/YsGyHztBPU=;
        b=POFpEUCwZVJdf788bcbrul0ZOol/isePMfjTZCGyb3a9dWoWy+LY/YJH0m8nbKLJez
         b43x4FE2xx4N81MGsHxPGW9R4iFwdxPtz8NL81L9NgWqL7mKtsug81j6AnwyxCJ5ItHS
         EQS2vXoK1aqHjY3yX2v28IFFVRIju2PapZPE/MNa8T2qS/X2R7hatBS7d6CrHRZu0/Nq
         V5lRK3GVrgt4j+Tj7USOHTGqNklVoWwYnAiZEWkNSrUN7CpUNu+HzazO6Tg7ZfZUQlst
         QFiOoCjajDcof/43BRXKIWmfxXpWaaRFpftUS8XlPiELm71Qlff2hTftziJ42C3ZRFj2
         hLNQ==
X-Gm-Message-State: ALoCoQlE5T4Z0BgMGgqg/syK5tcwCQmllM0eyyzF4SUwyMIvS3pea00ViPVF25GvC85OhnodDufD
X-Received: by 10.236.124.100 with SMTP id w64mr450552yhh.57.1402941864112;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996138yhl.7.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E82F031C8AD;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4A93E0E22; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251748>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 69815d9..d67479e 100644
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
2.0.0.282.g3799eda.dirty
