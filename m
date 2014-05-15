From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 08/44] update-ref.c: log transaction error from the update_ref
Date: Thu, 15 May 2014 16:15:05 -0700
Message-ID: <1400195741-22996-9-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:18:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4ug-0000ye-Pz
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756371AbaEOXR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:57 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:63589 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so388986iec.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7PjiQSbE3ZXKsfpNQvHOd7gMKeoZiwkDMEezDJjmULw=;
        b=XKd/1/RFF1dJW9Fpj/+7SW7p1LiwZzvt+NZRHi3hDm+I4PJMzNheS9mMWNt0t1OxRE
         ZjPtpul4hh/GX6EgcQrwBh25hp/LoXRJzqtAxoSD3i4uWhR9sO18IeajXHBZ4zKOtKG9
         a03hlU8N8HcEMk80caAZF+hOjJGZ36ZXdHdoakItEf3f2eEFyfE3XDylgySnaS7j/Fjs
         JqJifHl+mpTnoeVvhLJ6Uv+Ck+1qPCtL0vTScEemDUPrBdP0r48WAtxjqXcgWd26VIKH
         DLybI9JVxe+KQSIgZ30AuSTufJpSQYDN+M/kmTLw4z2NGk5WNWKg0loWGhVdFs4GpKBn
         1Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7PjiQSbE3ZXKsfpNQvHOd7gMKeoZiwkDMEezDJjmULw=;
        b=T1AOSyLuLP2S4mzNlZzPuWuJ+pHku6zmB9yf+aa3WHa+Wna6yvkyU2kvWE3B6IN6N0
         EbjpaaR2yGkCgLW5CRg2WCYa5PMufU2QHstNj0R/v2caZ2MTSDhYWYY9T7t4KkaXnIH2
         l+qY0lOApFl9Mixtj4fjk1izGMA+GdfYBpQVSsXBZYgsnip4IYuhZy++Z3I2aU6Fp4u9
         LanrgJxkuNt7Oe6uFQlWaWS+nePEi32ogTaO+9xusle3u4Wy+QLR1yzjwmyrXUWZGHim
         cktA5WjXhztt7WYLvWKk26PcMOq/GK5viAhzf2SDqrQa/9lk6eKFEwLl2AAqgDmfTz3d
         TUXw==
X-Gm-Message-State: ALoCoQktCnsXyL/vDHc7vYu/TNCUAU94j7kqZKxsDm9TWIzcOV2puAh26slCzkRadU9Sx9e74Ebw
X-Received: by 10.42.6.71 with SMTP id 7mr2194014icz.25.1400195744784;
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si319188yhj.2.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9959B31C318;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 55048E0FBE; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249265>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.0.0.rc3.477.gffe78a2
