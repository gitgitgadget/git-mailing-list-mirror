From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 18/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Tue, 17 Jun 2014 08:53:32 -0700
Message-ID: <1403020442-31049-19-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:57:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvlj-0008A9-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbaFQP4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:17 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:51583 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756324AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so1514447ieb.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8k7mfUnJbkOQzMMpNssXT8JO/HGAZ3wgd+l0GhCLjBI=;
        b=PcJufyyrx7rJI+nAIU+xj9pUD+I5dWjVrlYzOMPS3ODa1GrDhEU+ohFNvpE1ctI5MR
         qKnoBCpRX0HbXvuog62dZtH8LsItk27+Of3/vdYAiIkTcAVWysynzVicNp8Z37B6Z+3C
         OI56oSTWen4lqRjU9H7eyR0V9FscUje9+5LRuHk+AuQXoUjUeyvNm529jF6pDhNKovki
         3xBYDewrqXJ8l027RkK4q8QqAvL0hlZ4Qpy5cL6MPHB6Juu0C+/aou7Lb5QRylgQsmW/
         SqyEjv+zDc3Pw04fxo0xqIdLnAiguQeVQHkQ7QkEN9wri2jbqVibA5pN/8EOFn6iaZq1
         YHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8k7mfUnJbkOQzMMpNssXT8JO/HGAZ3wgd+l0GhCLjBI=;
        b=hYRsvZv7SJn0UEpRcjLi99yJi0sLfj6uPckHoJoC4gMS5bUKK8u63MtGY2sTKAoeCO
         7hV1cmfHzXnLOfgD5CgramcRZATmt7q+q9FfIWxagjNcQfxCsOpHvUIjbjUWcYNjNsXS
         mN5cX4MU99LG2z9sHKkDc6ScbG8udRz1UZ9Nvu1Ajfomha9bElkBNx4EXxhT7alCsoJF
         Gmo3LiVd1d9FhTmrkWCMwtegFtRwBIlX3CQEJd/spOs/h+w3KIQLT70GYLxWXs9Lr/nH
         AlWGU0LYgde3NF0dz69tFdIM9LHYJjUtor5Xd2SuVMv3VMX572MbmhNnQ+ApKCDbnlMn
         g4ew==
X-Gm-Message-State: ALoCoQnhk/UErwtgGmAltJKoT/VhSS0dzoG1Qle15RAVrUVefFPaOKI/7bXyuoZLRtEbA9sz1p03
X-Received: by 10.182.27.40 with SMTP id q8mr6220302obg.22.1403020444943;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1207436yhl.7.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C692131C76C;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A4F7DE1354; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251912>

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
2.0.0.438.gec92e5c
