From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 08/44] update-ref.c: log transaction error from the update_ref
Date: Thu, 15 May 2014 10:29:23 -0700
Message-ID: <1400174999-26786-9-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:34:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzYR-000649-5o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbaEORcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:24 -0400
Received: from mail-yk0-f202.google.com ([209.85.160.202]:37812 "EHLO
	mail-yk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755362AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-yk0-f202.google.com with SMTP id 9so80220ykp.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fe1KnzJc1pgMFS3W8XV1BHcwmcwgZLv4kgwUymVX1mY=;
        b=jifiNuSq+qKlbrtlMwGgRwR/x3QtoA4XxdT4BVzB/ec1+BwWRSXUti8YImf90L0bZg
         vI04R5Lhf+uvEt+ybNW6An1gTfpOmaRPyfSwVM7QFKrTvQqZN2eyYTjIdTkMSDvaisIu
         6hM6Ki94+i4H/2JluGknNlSEzHl+xFsD9tYEZti/EsXx8v7pl5o1iUqZfRD2cigHjpi6
         emUCa05MWSO3252Y8XWSWNpZ9KAQxqkIWQ24FZm9S3fszScUZ7mKQqol2j9yLWX6tft3
         Ec7+ZYQyA8LQI2bN8f/5KXnVAbjQb3GuP9ofMAgZYQ8/GPYqm/nn5IU1fSuzLRszyn5x
         lJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fe1KnzJc1pgMFS3W8XV1BHcwmcwgZLv4kgwUymVX1mY=;
        b=HaCW9XJbjVKr45fQy/gYQ+mCh5KvLRY1pUA/6REWfItF4duK2MsWZ5au2oJLSOk/4v
         RkuUHmD5KmFxa5uxOhAMm35ISH1+mxmxCsI1XypVgtt/Kj5wwVZtedQ/dgUgMn5DJ8RP
         ReGG3CB+ZrkorWfFSIuOeQ2Brp0J2fvJmHZnGNUAt9/HpXnBUMHYllTXMNCtErpEIcSk
         QNNKBPuZhvmZFeXS0JTIFGNBU7/fAKM/zAF8gCMHfaeiNeG6qp3XzK3scV05/91cNzXO
         8JF33OCu4LMND1ha4bPvr24TlvJqck07mgkcX9vmMdUFdHF8kSv0OxdATNHfpFEDpWfA
         5Y8Q==
X-Gm-Message-State: ALoCoQmU1EMPOTxKC+dq+PHzDj9F5Wh4dlww0m6CfqFKmRVmIKKe/01vsuRbCqGpyF0nrTrz46FH
X-Received: by 10.58.25.99 with SMTP id b3mr5956295veg.28.1400175006213;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si199305yhj.5.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 132AC5A4320;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C4575E1084; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249165>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..207e24d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.rc3.477.g0f8edf7
