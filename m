From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 06/21] refs: add method for initial ref transaction commit
Date: Mon, 11 Jan 2016 20:22:05 -0500
Message-ID: <1452561740-8668-7-git-send-email-dturner@twopensource.com>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIngK-0003hc-Ds
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761798AbcALBWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:40 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33906 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761448AbcALBWg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:36 -0500
Received: by mail-qk0-f176.google.com with SMTP id t64so491509qke.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vwagnwXqMZ6a3bAIJ8911GrTQD4Egk3oZBcv7VB6QU=;
        b=OB95FvHAETqhQC2ah0ruUwrbmuBy4aaiBVdVtyA77w8ADnjOEBdKWuPolnefCM0TGM
         1gDPvbhpRObttUwakE28n0hLzPG9UxIGDLDZwPfzLSNKOOrpCDFMCjJ5Ba95movvVAHN
         qwqTpIdPB6IR7wIiBurZ4VCC80s6dbKioZt5TAFk+fdAbdIRRZhN91dzx9tZxh9+8jm0
         ab32bXvsFNy2tXY/CUcFkX241tjaqyXe3h1aB2WDswaLkiYAszFE11wRllVBojA5RXp2
         nHPAla/i7aYJc42MKTR6J3HJ9Eq0HT/5b2XsKFCt7LN3iOnCalI8yNgUtjmZ7gmxlcyz
         bP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7vwagnwXqMZ6a3bAIJ8911GrTQD4Egk3oZBcv7VB6QU=;
        b=Gm8aoZFdZZdMy5Ww195QOdxHhIIezPATn6GfgWdrwYr0GmEGYZwSLBmH1eQKOoxWX4
         JQnn3HjWdNlAyHaPvQiW34tnmtVpn9odXsiw/BrydBNcp9QuWWFwOG5H2MmaVmeE8Xwl
         La/6CQR7Kb+9I9Itfx4HzxjPpQ858ebGE2z0pugdz4gwnq3NLLdihb7ibgGXbE9qL2Rv
         soXrOBBusIV+6XAmSDn5+t8mTvAa1x+6q/Ka64zcMuRsSOU2eeHLH3XebgARVR/yDHWm
         ibMCqUIDG4ZaVOTCicznHUNNsQ7DsVWskdeHdSSrOck+eo38AVCV9bJ1pPhHbl2fVrWG
         Nrvg==
X-Gm-Message-State: ALoCoQk1VGFcNs02m5p5YR+9YxwCcchJpKLRuYPnHqFsa29qbZ+eoX8hp1VbQ2XPk3P8SJsP7HhbnqNK478YHL2YXPrlRRj1EA==
X-Received: by 10.55.73.199 with SMTP id w190mr8352530qka.77.1452561755611;
        Mon, 11 Jan 2016 17:22:35 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:34 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283756>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index f66484e..ccbec52 100644
--- a/refs.c
+++ b/refs.c
@@ -1247,3 +1247,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 					       prepare_fn, should_prune_fn,
 					       cleanup_fn, policy_cb_data);
 }
+
+int initial_ref_transaction_commit(struct ref_transaction *transaction,
+				   struct strbuf *err)
+{
+	return the_refs_backend->initial_transaction_commit(transaction, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 520bf40..1a1d0fc 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3313,8 +3313,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3538,6 +3538,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 7583f60..5ec5ede 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -267,6 +267,7 @@ struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
 	ref_transaction_commit_fn *transaction_commit;
+	ref_transaction_commit_fn *initial_transaction_commit;
 
 	for_each_reflog_ent_fn *for_each_reflog_ent;
 	for_each_reflog_ent_reverse_fn *for_each_reflog_ent_reverse;
-- 
2.4.2.749.g730654d-twtrsrc
