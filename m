From: Dan Albert <danalbert@google.com>
Subject: [PATCH] Uses git-credential for git-imap-send
Date: Mon, 28 Apr 2014 20:00:04 -0700
Message-ID: <c3bb0fb7f87e6ada5c73923b14d66c743a76caa6.1398739667.git.danalbert@google.com>
References: <20140428192349.GC25993@sigill.intra.peff.net>
Cc: Dan Albert <danalbert@google.com>, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 05:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyHO-0002GZ-1M
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaD2DAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:00:16 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:60840 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaD2DAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:00:14 -0400
Received: by mail-pb0-f47.google.com with SMTP id up15so6574736pbc.34
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 20:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mIcxmLgleqjXHQVxw1nvypaSx1fIsspkkByHunfys4Y=;
        b=EDQCzlnL4wdspq7MlZWCHdovbRUelfecQgtOX+FzTtMCaFCXO1DN5zDsxwBHf8ZpuT
         XDUXrhl+0C8XCPW186KN6tjZtDbBtXlGg40uqcdQPrR5t48RWFWryPvj44geiPDHwxG9
         a8ltcDRSHelSh+VKea57mLmVfKdwGzBih/enmQFmgVfwRGDu2YIFmdmZ7upxja4MCUXw
         N7TCw6b/jO/xJrqudqueXpX/qcaiev569YjQmM/C2YluUjrTLRkHWE8VpJDcNvP65Xis
         7k+bAA8X3fBLuDFwSFSfRlTRi6Qd4YJ1+zSnxx6SiKhtmX3LDKX/PWLrPwckUzh0jYGv
         EA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mIcxmLgleqjXHQVxw1nvypaSx1fIsspkkByHunfys4Y=;
        b=Dx+2BVPdMScmcclYkFEm5kK0YpqvhQ/MW1JPdGnjl08jKnPX8TH//1CukshQtrlIqa
         lqiWEMbI0tsKnCqV4CtYfqTGCLvi5qHEjXYzohGbQybfbJV+ixZHZ5KwoZb1hzn9xW2M
         LqiGbgnX5tBcPNibbdSwd+k0JrPrYHsQB7m7LuJ1AhpmiCj0m1jOCDAabcvdMG/1UM+f
         L4G0oGapeDeGAB8iANXxd8hcGwpyM8HCeoIqbe1NDiPghlE3s8fgN4E9mdXd7GC4ot5c
         9vsZTLtyFYb/6EuMIQDRreezUlIM6SCBwEmtSqijOA5MQfri76yXAV5CNpTlBzz7PaUX
         cPqw==
X-Gm-Message-State: ALoCoQntGFEiifoRhsO+fIVa0FJ0JEjGgE48+WXCpM6ZSxsRD2XlvWNMx/aUvJ6hGzvsL1GQ6bE4EkPYr0SZuUqHvhS9CtkiaXDyEv6bWRj5EeD7yp4ai80e7wWXYa0GzNqE/mkaudWVa63qTRU8y9o4QvtDkCEMOq93ZXsWpUZOogSGwxBEn3Qm1s52ejRuTSB1Yqh7rN6vHluIp+XuudCiCcX26VW5UhnDuu9CXJY3IKyWei3FzNU=
X-Received: by 10.66.137.109 with SMTP id qh13mr29726482pab.39.1398740413545;
        Mon, 28 Apr 2014 20:00:13 -0700 (PDT)
Received: from localhost.localdomain ([50.185.89.111])
        by mx.google.com with ESMTPSA id tk5sm38175247pbc.63.2014.04.28.20.00.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 20:00:12 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.1.gce060f5
In-Reply-To: <20140428192349.GC25993@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247512>

git-imap-send was directly prompting for a password rather than using
git-credential. git-send-email, on the other hand, supports git-credential.

This is a necessary improvement for users that use two factor authentication, as
they should not be expected to remember all of their app specific passwords.

Signed-off-by: Dan Albert <danalbert@google.com>
---

> I noticed that we are just filling in the password here, since we'll
> always fill cred.username from srvc->user. The lines directly above are:
> 
>         if (!srvc->user) {
>                 fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
>                 goto bail;
>         }
> 
> That comes from the imap.user config variable. I wonder if we should
> just pass it off to credential_fill() in this case, too, which will fill
> in the username if necessary.
> 
> It probably doesn't matter much, though, as nobody is complaining. And
> if we were designing from scratch, I would say that "imap.user" and
> "imap.pass" would not need to exist, as you can configure
> "credential.imaps://host/.*" for the same purpose. But since we would
> have to keep supporting them anyway for compatibility, it's not worth
> trying to transition.

Yeah, doubtful anyone cares, but it's simple enough to do.

 imap-send.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..5c4f336 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -23,9 +23,9 @@
  */
 
 #include "cache.h"
+#include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
-#include "prompt.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
@@ -946,6 +946,7 @@ static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cmd, const cha
 
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 {
+	struct credential cred = CREDENTIAL_INIT;
 	struct imap_store *ctx;
 	struct imap *imap;
 	char *arg, *rsp;
@@ -1096,25 +1097,23 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 		}
 #endif
 		imap_info("Logging in...\n");
-		if (!srvc->user) {
-			fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
-			goto bail;
-		}
-		if (!srvc->pass) {
-			struct strbuf prompt = STRBUF_INIT;
-			strbuf_addf(&prompt, "Password (%s@%s): ", srvc->user, srvc->host);
-			arg = git_getpass(prompt.buf);
-			strbuf_release(&prompt);
-			if (!*arg) {
-				fprintf(stderr, "Skipping account %s@%s, no password\n", srvc->user, srvc->host);
-				goto bail;
-			}
-			/*
-			 * getpass() returns a pointer to a static buffer.  make a copy
-			 * for long term storage.
-			 */
-			srvc->pass = xstrdup(arg);
+		if (!srvc->user || !srvc->pass) {
+			cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
+			cred.host = xstrdup(srvc->host);
+
+			if (srvc->user)
+				cred.username = xstrdup(srvc->user);
+			if (srvc->pass)
+				cred.password = xstrdup(srvc->pass);
+
+			credential_fill(&cred);
+
+			if (!srvc->user)
+				srvc->user = xstrdup(cred.username);
+			if (!srvc->pass)
+				srvc->pass = xstrdup(cred.password);
 		}
+
 		if (CAP(NOLOGIN)) {
 			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
 			goto bail;
@@ -1153,10 +1152,18 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 		}
 	} /* !preauth */
 
+	if (cred.username)
+		credential_approve(&cred);
+	credential_clear(&cred);
+
 	ctx->prefix = "";
 	return ctx;
 
 bail:
+	if (cred.username)
+		credential_reject(&cred);
+	credential_clear(&cred);
+
 	imap_close_store(ctx);
 	return NULL;
 }
-- 
2.0.0.rc1.1.gce060f5
