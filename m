From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 10/41] update-ref: use err argument to get error from ref_transaction_commit
Date: Tue,  3 Jun 2014 14:37:28 -0700
Message-ID: <1401831479-3388-11-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwT7-0007ro-1a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965426AbaFCVlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:49 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:39282 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934171AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ig0-f202.google.com with SMTP id h18so28979igc.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HIrMlXf91cENYN6I1aSDayXBGs7BxucfiA9ka/dC1V4=;
        b=Sq+n6NrFdYDvbOlj6dyFATrMxxmkvKBs7AroMHNHC0kfYjl62164++T+rNywUEtlKT
         xSZPK6nL229eN7P4QpMKrrJM3+2Pzj2odNBQrvL+2ohMQBfFEQhpVT307aHqYF7SXmgr
         k7hkXmmT90tEX07MFJBsHwHn0bea89L8TnpQL+w5gPZl/Zskve1F2mWP1JbNifSDzRAI
         VvwaQCsvJc5yW3OKpk+nx/TWgMwAdJTWref5HEr0EwVXpdEvl6mwXsv9MiH/BdpIsgY6
         H9iWFBnth5vjIBIA1fkJVeOeCDMAaRbR1/nMYuF7xrbdAHABba9hL7CfE2Us6iQYdvNi
         httQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HIrMlXf91cENYN6I1aSDayXBGs7BxucfiA9ka/dC1V4=;
        b=Tja1lV+KROXBWeSIwlyH/7RVf+CTGBNVwz26AN2jjFJW7Prpuv8RJWD1rtV765s5a2
         kEd0/DyLQxrsB2tStSqlOEwtB8a+szYgzXROtJQ83YN3npyIx8Z5HQl0oJo764V4ImKe
         Niuaxh6Vu6IaAKlAL8wtnoI86MqVfo0btQlD2UYK1Q8dNJVLvTbpxvQNCYUswxlaLUaD
         44Lr8YaDhzA9/US3BqOxk6TvqhoPZnXmlzUntzw7oKkO5RJsrFxRmsE2+dRc7QloNUTi
         YcMVKs84iXfqwYgJbv0lEyX9X0N2mWHGhfv2iEVLXw2/rJE5G4dkPuRpqmfJXA5fJcyh
         59Kw==
X-Gm-Message-State: ALoCoQkTOhDKs1JiWEjMYYS6uSbjmPUuZE1usgfFRZa1FdvQi8K/56izLi4ejPTl57uUEBWCaKgU
X-Received: by 10.50.73.132 with SMTP id l4mr10893547igv.5.1401831487498;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si29245yhj.5.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 4CC7D5A43D3;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EDE2EE10F4; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250683>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 22617af..aec9004 100644
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
@@ -359,18 +360,17 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
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
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
 		ref_transaction_free(transaction);
-		return ret;
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.567.g64a7adf
