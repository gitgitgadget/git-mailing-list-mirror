From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 01/14] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Mon, 17 Nov 2014 17:35:37 -0800
Message-ID: <1416274550-2827-2-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXir-0000Vh-OX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbaKRBf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:35:57 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:34856 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaKRBfz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:35:55 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so196449igb.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+9FheLhvKFdiCaBo28Qdyp+jiX6HpcT8KN02+n3uLWU=;
        b=ndgA/x+LCRxzLptDJqZBGwr9j82DKWtqLwTZSrM17tCZefq3l7srLaNunbr5u8lpU4
         Vn3MLlernpAwf2rQAobBhzUNe0DlpF9/Lv6djNxZsysz5Ju++bGZuQxCmOD2c8bb32V0
         EkkFPkrQt2ntPXc5ntvlP9EcqZt5s4bZcjVojVD7wYFqLHUy82HXFlFNI+OhOJHByoyP
         ELPMjGTZ9c+yjjIoorcJGsUFZ88iyLzyYghBXtpl6PzLda/C0u9ZOxW1p/KI66gKpZJU
         2QSs17O4zCIpWRVIB47wtuRf26LnbNhzKbRcfujHEVedNtP6fPxGXC4bIDVM5GGKleXy
         4D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+9FheLhvKFdiCaBo28Qdyp+jiX6HpcT8KN02+n3uLWU=;
        b=lpsjWJB6O7XiW3uorvVTqU2652oFAnB/dR7A0HSsmDUqiHyaFQ8P82LK/dvORctWG1
         PujclBSDiGOkp1idDgsWDyAlXpLGmxeJI4gCqOtp5CDpTQF2cPsPPuTkFHyaVL9tCmGp
         fqnG53nDdZxRxvEdi20jpWOz6c9Ouhs8Epjvbexqc/B+I9LcW9IgBHWosuhXxrdjm665
         e0wnBTo8d5yH/A2zLk22eY2zF+a0sDOr1dv00UIbrelRiWImmQ3wONY6zAslruLvp0zu
         mzPtb+0/+uHfKoADOrw9W7YVVLNTIPiPy9EGrYVIE1qVCnC020B+e7nq5594kL1O9Kp3
         rwQA==
X-Gm-Message-State: ALoCoQlSOFJ5EAV+nxDbBhrru+VFoGimrw3vHYL9LCV7SwgNK73Y9vxKXbsEcvw4F6pOSaGDZWW+
X-Received: by 10.107.128.87 with SMTP id b84mr30855013iod.42.1416274555029;
        Mon, 17 Nov 2014 17:35:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id l14sm4709424ioi.31.2014.11.17.17.35.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:35:54 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

The ref_transaction_update function can already be used to create refs by
passing null_sha1 as the old_sha1 parameter. Simplify by replacing
transaction_create with a thin wrapper.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/refs.c b/refs.c
index 5ff457e..005eb18 100644
--- a/refs.c
+++ b/refs.c
@@ -3623,31 +3623,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	struct ref_update *update;
-
-	assert(err);
-
-	if (transaction->state != REF_TRANSACTION_OPEN)
-		die("BUG: create called for transaction that is not open");
-
-	if (!new_sha1 || is_null_sha1(new_sha1))
-		die("BUG: create ref with null new_sha1");
-
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to create ref with bad name %s",
-			    refname);
-		return -1;
-	}
-
-	update = add_update(transaction, refname);
-
-	hashcpy(update->new_sha1, new_sha1);
-	hashclr(update->old_sha1);
-	update->flags = flags;
-	update->have_old = 1;
-	if (msg)
-		update->msg = xstrdup(msg);
-	return 0;
+	return ref_transaction_update(transaction, refname, new_sha1,
+				      null_sha1, flags, 1, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
-- 
2.2.0.rc2.5.gf7b9fb2
