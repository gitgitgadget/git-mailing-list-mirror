From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 04/27] refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
Date: Mon, 28 Apr 2014 15:54:19 -0700
Message-ID: <1398725682-30782-5-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTT-0007Zc-QD
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756354AbaD1W4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:31 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:41730 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaD1Wyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:47 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so1131107veb.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H48YDLJPvJheX7o3TJc29n236jRWxTSnLWDSNUhYn7A=;
        b=ZDrbkktDbJ+v7E0hCrzPwiRei0pJxwmdt6lBDbLLICJAi99qvH3oUGpTZRwWBc1PkJ
         4PR4BBPrtfcS6rmQCjO1ojCLXgZMPN9XNLbMRZ62r+dee5Ot1QiM9Ah8cHEn4XUmYKqM
         RE2us9HUitoeUSEVNrzxeO5u/ThIwjO2ClgqOGPud3HeDUEN4NVyiUT8mHPh/kLIH3gl
         2d3T7xmWCc1Ks6xWhGFivsgLwprBhk/H5F7xTL7RAR+MM5HomTNICbMzK6xRQJ5m2Jy/
         yeb8pVWW8LBJQ2eAvsBQei+VPh7iK/7D+iqBXRRBpYjUb6+aAmba722gN3+fzJyu3pdT
         ZRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H48YDLJPvJheX7o3TJc29n236jRWxTSnLWDSNUhYn7A=;
        b=Tla/7PjvzjSFVVu5sfOfnNBi55+AwAxz/1IHvQkxGAR/k4Dsyk+HWdjqE+eeUapG/c
         wevLZ4Dmvt+32zcBnEl8kbeEZChX0KV4hgNoKEdKL+GGpXdnuLGC6j07X5FT1lujpUHC
         NLi/4gYlOzL6D1azGXLbeNt35/nkhfMPwNJqLeZiVyia97Uf+1e/sYMWIRREca6einQJ
         xWrusXiiyvFuyp+TOTU8IGg8XP84zYmY/C7MuAUPiVyuBo6Z2gXQIV7cGaVYB3aalaZ7
         2FaqWv+eiuaI3N4/W/NBKCE6GAPZdI1dBJkXdLHguFjA2Hq18FnPbVKC15t2tNq3opxw
         z+kA==
X-Gm-Message-State: ALoCoQnTbK5uIXBrq5TR06+M3sb+wZVcDX9KGbPwpEjp72mX6fACHV3ZC+c+ZYWmoMPyGQDSAHTg7yVZPnsAVUfpYc8/wU1a9/JBOTCe8ajxQ2b0ZsFfDAbJQgJYu0H+J8q8PdnH0yTGt1DO8q1sMJYFlW7WrZayKfzZ1T+KFuUjph22nkwbihBl08+Z8tQGHZmJWAE2RKXI
X-Received: by 10.236.130.101 with SMTP id j65mr10640365yhi.29.1398725687110;
        Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id l7si939366yho.1.2014.04.28.15.54.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:47 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E74FC5A41EE;
	Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 666D1E08C1; Mon, 28 Apr 2014 15:54:46 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247484>

Make ref_update_reject_duplicates return any error that occurs through a
new strbuf argument.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 64e8feb..21a147b 100644
--- a/refs.c
+++ b/refs.c
@@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
 }
 
 static int ref_update_reject_duplicates(struct ref_update **updates, int n,
+					struct strbuf *err,
 					enum action_on_err onerr)
 {
 	int i;
@@ -3400,6 +3401,9 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
 			const char *str =
 				"Multiple updates for ref '%s' not allowed.";
+			if (err)
+				strbuf_addf(err, str, updates[i]->refname);
+
 			switch (onerr) {
 			case UPDATE_REFS_MSG_ON_ERR:
 				error(str, updates[i]->refname); break;
@@ -3430,7 +3434,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	/* Copy, sort, and reject duplicate refs */
 	qsort(updates, n, sizeof(*updates), ref_update_compare);
-	ret = ref_update_reject_duplicates(updates, n, onerr);
+	ret = ref_update_reject_duplicates(updates, n, err, onerr);
 	if (ret)
 		goto cleanup;
 
-- 
1.9.1.528.g98b8868.dirty
