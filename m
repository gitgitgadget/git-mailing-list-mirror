From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 18/48] update-ref: use err argument to get error from ref_transaction_commit
Date: Tue, 10 Jun 2014 15:29:06 -0700
Message-ID: <1402439376-25839-19-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:32:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYd-00051B-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbaFJWaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:30:10 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:39826 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbaFJW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:41 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so179262pab.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E5xMzzKPOL4W4kRQG4I87xgLYstFmZYBuAUB0U4ADPg=;
        b=cS45DMNDN0PA4qVkA5TQTeMQwYWXm9uNBKBmx02au5FoodzJ8xsIrW4drNkqAHROHf
         sGFAXWHIgaTRZWFopf/xjOdW4JHWTDwsVWmoWJutihqMZt4xzQvv4Xk6nfozQAekahfW
         p/M7zgS/TDB5ywFhzRJ7Q483N8ebB2OhmRvnRNLyfUX+Q0A6TtsdL+ASRcQuKVewVJGg
         0PDPSh102WROhlf2ig26zwJqnA76JaBtvUv//AJTXJHGaYH2QUv3PA0dycQy8zGq/V2J
         dNvpewSrO0tUI2bvHVKR4/mzF0UdtvgaxIvI6ED9oirU7TAH282fKzQa43woR8uo5jkB
         spBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E5xMzzKPOL4W4kRQG4I87xgLYstFmZYBuAUB0U4ADPg=;
        b=WMgSGQ64l27ZxKjhTeg7imKx51fJicIS9sSxwVMCb0zHSWnCLeWxx2T9BTsuMmJzMn
         YHiZ6swRgh726+ytJafQRQpZdrf41wJyQYuySpDe2hItk7Mi+1uH+IL/IJJ6QqfkoznI
         +dV6vQBS+AwT76djc5x9dwNGbaPYJC+s3bPuVfRtB65pHAEWXMnhVRsbQM64/Vi8RgAn
         nc7/zwp4qRin7EfOVIxGgzK66kMvKAer4jpSDmTaKtBCWRvAHe8+M2CYRRHDFfSmPOl7
         sG+AsqlzFFqrpBqkm+iPoGdV/sKtmecMwWYPB+lNlLp22doqQWpSgNME2QVNjQiP+yrl
         U0tQ==
X-Gm-Message-State: ALoCoQkG+646WgYOVbDmIcH6S1X8oKsy2fssjYxNavuMBOIGxhwNGbaUANHOShhAP9Sqsp4dZ75A
X-Received: by 10.66.156.2 with SMTP id wa2mr127750pab.0.1402439380722;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si1394552yhl.7.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8207431C766;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59AB3E13E4; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251269>

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
2.0.0.574.g30c2c5e
