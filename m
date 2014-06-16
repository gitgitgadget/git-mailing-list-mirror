From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 05/48] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Mon, 16 Jun 2014 11:03:36 -0700
Message-ID: <1402941859-29354-6-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKr-0007ty-Rt
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbaFPSIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:22 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:46303 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932629AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so851767qac.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d0UmaiWpGgAZhG66qucBehGteVT9ATYhnFOfwqiW7S8=;
        b=WS5101uowIac6UUPkoyDBOY001IZJrgV47l6vRML4nizuf5YmvvSbbLsflpgWLl9rp
         br9q3KgctmRCdR69CDC+BZB9hwRKsCWsSCZq0jl5rbGaULDdkQkNifINssHG8oYWhQVF
         EINBUVbYz9sgN6MiK4XxGRTJtmZvD8uVt/3tEEWrOr8Vd4A/p7VdYSPvpebx98rLMfXk
         J5Fw/1kKpWAtbP41MeNKr+NCWz4FfxuHGLd4FGkwG6Dz6TtmTj74oL9gVe2nyyP7Mc6U
         ZVePD1GD9yGk9MtNjJmRfjuH1tYSvJq3lvo0C8AoiJAsEipxhrRV5WoR5DaQuTYDsKDQ
         hwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d0UmaiWpGgAZhG66qucBehGteVT9ATYhnFOfwqiW7S8=;
        b=KOEUrJBtIW/rD5iGEP5+GzED6k713xhVuXbUmbJV3FAw+IxrnD541YFkhGpjLungvB
         gf+VGMUPYxC5vz3VauSF/44FXfofYGr7XJFKTY4c2OeccNgNfGxAj4tBmgyRVO7n1mr+
         M5O4K1O7jMS3f9Ip/aSbyCI7rBWJnVb6p4YLsA3OkssDsSkf3EQ1n7680dsVvhIT6Snc
         vHi0JdKk1K4j23LTDNvjz/g8Vwh+cfNihe4hgp8LYnQW71z+KOR2yka3AKMTOXQz3xDl
         +Is96JTmnSxp686HvEkGWxnelVKcvvPNxoIR32oW7/5G015hgkNMN8Tk5zurlRZDx0r3
         YIeg==
X-Gm-Message-State: ALoCoQmmukWHDNX34u6fEw1I+eufxTE4zHp/QatFTRYj/5VDuSLve+p7X1rSfTQzqt7fDhxr2rP7
X-Received: by 10.236.138.113 with SMTP id z77mr3654494yhi.25.1402941862619;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si997789yhb.3.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 793D75A4911;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 02B03E0A0A; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251788>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 6 +++++-
 refs.h               | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1fd7a89..22617af 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		ref_transaction_free(transaction);
 		return ret;
diff --git a/refs.c b/refs.c
index 0faed29..25c3a93 100644
--- a/refs.c
+++ b/refs.c
@@ -3418,7 +3418,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3447,6 +3448,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index b893838..94d4cd4 100644
--- a/refs.h
+++ b/refs.h
@@ -266,9 +266,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /*
  * Free an existing transaction and all associated data.
-- 
2.0.0.282.g3799eda.dirty
