From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 06/21] refs: add method for initial ref transaction commit
Date: Fri,  5 Feb 2016 14:44:07 -0500
Message-ID: <1454701462-3817-7-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <rsahlberg@google.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJO-00012d-BG
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214AbcBEToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:44:54 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34153 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125AbcBETou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:50 -0500
Received: by mail-qk0-f171.google.com with SMTP id x1so38254352qkc.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ft/RM9kJ/Ur244F1SxddL/jo5bWSJ4+BwWbwZHbenjA=;
        b=n/gFR8KOa3l8rDoHSK0qRL1O9xHQnpnOptYNFivwePkmL0/Eqv6hRvjoztckQdt8xk
         AD9wRFwdkv+j9E1mXhjXqrrOydV4Uyp3XAh6nAY4LYXQ+zHDUu8vDqfWlPZhw0uglc9V
         u40reTbb3PwnHXU1N2FXf2kZoEQ1+Tpp16qMWQO5VX+5g+wjc/NXE/FKEcnBWHzeujn0
         JF/FnHjxp7D1oxrI6jEAD6s5dgEqhCesyhNGtQAarMKv8vMCkJc9kQl+wimbOkM4SHcg
         hFT2+vO6NZyx0hNJySQXQKlZt+0gzwQ49DaLfGYiA8jsW58ZwGYKMdUcMB/VQs4ETFAu
         bthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ft/RM9kJ/Ur244F1SxddL/jo5bWSJ4+BwWbwZHbenjA=;
        b=hNWGvOJaSdAtZiE4Z4Qrf2BySSIfml7KYMTnNvffkTymFpR5jJw6GsiZ2fIv95bk7l
         qJNfGjKk7l465JfpO+y9F9LLwrOz3+oKe5VdWE/YbVYmKtmyVvntoqHIRoEaObU2P9ny
         jhRBueJXbbB4il+doHKI7LCfli0loyjwrbVlLIWH6FQgNnP5If6w0yOayAOdbndwSj7U
         MELtrR3vVOVVe8OBuq8PBlifE8zAfPsIM+XF8G6+qsJGCc996z2Nsl3LQTZ8+svVW1F2
         KNRhessvA9o8j+o9807+op4VpkF3u9AM7X9554I1jBu5Bt58OqWuv64xD2myuuDGQ8Qs
         jzJw==
X-Gm-Message-State: AG10YOQcfXmcGFl6EK/6CuOsmj2uRWaJhOI0vOG7nv0wA300TfkNW+0SniU+0CwCLT0r8Q==
X-Received: by 10.55.73.74 with SMTP id w71mr19282625qka.60.1454701489736;
        Fri, 05 Feb 2016 11:44:49 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:48 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285605>

Signed-off-by: Ronnie Sahlberg <rsahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c               | 6 ++++++
 refs/files-backend.c | 5 +++--
 refs/refs-internal.h | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 3254378..d481a94 100644
--- a/refs.c
+++ b/refs.c
@@ -1258,3 +1258,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
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
index b3372e6..723127e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3337,8 +3337,8 @@ static int ref_present(const char *refname,
 	return string_list_has_string(affected_refnames, refname);
 }
 
-int initial_ref_transaction_commit(struct ref_transaction *transaction,
-				   struct strbuf *err)
+static int files_initial_transaction_commit(struct ref_transaction *transaction,
+					    struct strbuf *err)
 {
 	int ret = 0, i;
 	int n = transaction->nr;
@@ -3562,6 +3562,7 @@ struct ref_storage_be refs_be_files = {
 	NULL,
 	"files",
 	files_transaction_commit,
+	files_initial_transaction_commit,
 
 	files_for_each_reflog_ent,
 	files_for_each_reflog_ent_reverse,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index ee2bea6..142c663 100644
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
