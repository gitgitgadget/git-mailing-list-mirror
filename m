From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Thu, 19 Jun 2014 08:53:26 -0700
Message-ID: <1403193210-6028-45-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxef7-0006a7-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbaFSPxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:53:53 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:40443 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757376AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so693200ieb.1
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MXR6TRqIPNb2rPbBFCSNk9EI/s4OqW7mn50kVf6Ic/M=;
        b=Tcu5lMr+SAgIjW3VjRf3mB4QI//F3w/LPpfYtmzl4/EXVx94Cf8EwRwRuF3YxA31mp
         pT1BdQ+j9Br/nOVglC3KShuHJ04MLx0Sio6HXlhyrqdEQqFdXNRg6eJmAe/VUhndGKUI
         lL8jTSk2F43BQnTV7ZwdzlN09i/6tJ1rChu1f1BzbML7Fgg8TyCxGM6VeUwpuNW1dGGK
         8OmAXwLtqk7BTARPtcdz5IMnWWSU9ttWxJrABkSxEYvbGJo+zZcoF9A5vLmlEK4XdDe5
         A0aW/tOvnB1Qo8X0wwLk1ngzKOAcyi595vm0SgQy3n4oP358E3ztUOi5CsmI60pqBhI3
         Jd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MXR6TRqIPNb2rPbBFCSNk9EI/s4OqW7mn50kVf6Ic/M=;
        b=OiMrXIFOsV6EAHZUmWxiYmwfDswGjJWMmKrBkb9+C3G4jGlMRRQ9fclKvlF0wuCpZM
         Ri/INbdMtO3wnwlooYR0u/XYdMjrio4mRpXo3T4ilIAOCLexk9Oba4Xic88fu80TvUBr
         C9jIrw2g5GQut6sc881wEMDUTAv9d+w2AMzZNcLgeeVZadfeMmkbYcfV8bzoNkPjw8oI
         Y425LlHy2XuJX5Rsl3ZC0hB6plNW5TPdGqyuZxloFqO8Jy/94nGonwBOlS6KAcmES34v
         Ke2T2bjAO6qSw110N3p+tCUtpHiJjNNXfMM8HL9LyuitAgZHCaacK9XrWSxaB6bUYoer
         vPUQ==
X-Gm-Message-State: ALoCoQkXGlQLDKEpr4Cwra6F6qf1XGEy07/Y67R0dJ94AlUKsWpEC0g3tNpydopVhqz4U8ryTPxF
X-Received: by 10.182.27.40 with SMTP id q8mr2739595obg.22.1403193214537;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si347094yhe.2.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 62CF231C2E6;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 412A4E0734; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252124>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 5a7fb34..2cc662c 100644
--- a/refs.c
+++ b/refs.c
@@ -3595,12 +3595,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
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
2.0.0.438.g337c581
