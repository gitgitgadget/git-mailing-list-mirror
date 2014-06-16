From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 15/48] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Mon, 16 Jun 2014 11:03:46 -0700
Message-ID: <1402941859-29354-16-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKq-0007ty-QA
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbaFPSIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:24 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44992 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1128839oac.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l8vuKEm/xqICG+m5NBNLXwdKJxhgTZcrCmgtrAkj14c=;
        b=Jrt6aZQhwsg0s3TuRNvlHRtD34oFoLzzvDqMdBzEebB8fUGlQbQr0TF9aKcH30WjVx
         6FOfw5egzCPuRCGiWtOaCbjFrM21LUU/1J8haXjSdXoL1rj9P+zfp/Z7lxmCluzx0geV
         Nyz7SeCEYCkFa/m4COJyDrwEStqEEewYQabpBUiZ+w394XHmv4U/7Ue/zpgVSQSEiPUq
         CmzZ/YXsS7C///84Ylr6zpJxyM1VVBUXwfviMoPbQT0QhA2PzqX4wCXHV3h2LXCLZmms
         bL4EySOTPxxtO+aqelKKqvfDhTrGEJRG74/1ux+E2i1VvUgUe09Y61aMxDNwaqwxi9D3
         sWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l8vuKEm/xqICG+m5NBNLXwdKJxhgTZcrCmgtrAkj14c=;
        b=nJly7YQkmDyF4lKGiNT55UfVYJMHgeUGVh4BdIG6pbhQS7vWyFp0KFJfDDm45PaFSo
         bQ6gJZpKYceALGmU905Dcq3DuP+bnnlRuOIfAnNiLLxu+M4Qw2xWRkfxwWjMvwQCAm0z
         xGP3NS9rHcGjr2i6I+UwfikQipXWRn9vI6R0lz7T+PLz/5Elgr19a1gwe5IDIDJ6iTu1
         bmllpnUYnbKY4yR0sKMIbNdOleQe65d+FIhbw5I+XQBqiOgR+ZC7zoCPUNi5T1ToJeTA
         qltfSSOUyOGJHFl8emIFfgPZiq2p973hHLKb4L4CN071FOB+Foq4AhC7uKF26VG4liK6
         TU9g==
X-Gm-Message-State: ALoCoQlNcXQcz1DKX9Xo98p0wPU8Z+H28MoW2o/oDJgezMB5oLrNX54bQGuHKOAssSTtQVg/Hjpu
X-Received: by 10.42.19.73 with SMTP id a9mr431596icb.31.1402941862825;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si996129yhl.7.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A800F5A490D;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 78DA5E179B; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251786>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument. This means that when a transaction commit fails in
this function we will now be able to pass a helpful error message back to the
caller.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 31ae63e..81d3605 100644
--- a/refs.c
+++ b/refs.c
@@ -3463,6 +3463,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3470,6 +3471,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3500,7 +3504,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
2.0.0.282.g3799eda.dirty
