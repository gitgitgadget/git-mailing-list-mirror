From: Dan Albert <danalbert@google.com>
Subject: [PATCH] Uses git-credential for git-imap-send
Date: Sun, 27 Apr 2014 10:58:51 -0700
Message-ID: <907d1444a8e17a43c03ee0c2bb04038bdd3372b8.1398620231.git.danalbert@google.com>
References: <20140426180835.GE21493@sigill.intra.peff.net>
Cc: Dan Albert <danalbert@google.com>, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:59:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTMk-0005T7-Or
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 19:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaD0R7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 13:59:14 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44112 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbaD0R7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 13:59:13 -0400
Received: by mail-pb0-f44.google.com with SMTP id jt11so3257745pbb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7QlJUF0v/jM4/0Q0dnTi2Gva+89DrLH9m7eHs6XlJHQ=;
        b=MUKMjf3Se7Po9rU39NdXqhQjsVf3pAL7RAW0+NN02Cs5dQFRFZR0/VmI8LfdtiQiLd
         oKQnqDZ24+AQQou7CiyUv6N0YZ44tZCVL4n41BhQE0mGO3BDN0pdWTDygJ172G9ffQ2D
         6fOevHrNYFnlWKm6rOEF26qz7FumI4vyC3giztEDHqTO+5oLs+ankBeVOf0MPpd5RDdx
         ZnUjAbF62jkimmSqb+QIZj1ECXCtZrkl9V5QX94VhkA/ZzRTYcG71Pxo+E84EBSA17zP
         K9xTULOC4w9HsckQK4PnE0PnXsv7upA2/Q4yX15dElksZV+b6YWskCBlds6tE12OwhPK
         LSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7QlJUF0v/jM4/0Q0dnTi2Gva+89DrLH9m7eHs6XlJHQ=;
        b=XFihA26JaZjdRn85l6IxffSrI4gmxGX2/guq6HN5/657tp6F86cDJhJ5OBcokWYlLW
         JvuKFdk1FTgkqBSmWOJqElU/nfemWpDFi3GSKq+4OKI9oVpCVRpynbhhmhBdVlpUncZT
         NmVWF07haG8cPvN9tNtYiAlqDLln2ssuzqXGn2SVMMgNSxss+5i6d911d6HhjpraWUBw
         6uHQ4ZnNcBh/ggxnwA7wnioehb7eijO1bBMY+GQJ5jTRJ+WyZ3kzIRyySqOvqQfOTYJk
         Qfjx1YuD/iy456SaqTcsTMHyDhjfzTiJSgFYSUnn7NwSV0eiUb+qRSsw9jK4Ecye+R3h
         fzOg==
X-Gm-Message-State: ALoCoQkAgkDcdwz3Y+8Xiwehdi5JkHAnZ+WXqiftNmh5cXnTX16m/ML+B8mz9zqItjHaerwk8qcgUY+mI1+Lw9ac/R2czit5IbTDCxzXAccBIs5nB+AcFesn/tslj4zIKOaVlAn1+qwTBbtAhFskVOX6WfIiT+exiVYL3js+ueAsQ2AmBkk9Kr8MG7ngbYKJLO0jbHFaGksKuwTtTowoP/aCA/W2ddADW0qCkeMJw0ga2BwMrLwPLX0=
X-Received: by 10.68.100.1 with SMTP id eu1mr24344299pbb.36.1398621552759;
        Sun, 27 Apr 2014 10:59:12 -0700 (PDT)
Received: from localhost.localdomain ([50.185.89.111])
        by mx.google.com with ESMTPSA id sy2sm29660991pbc.28.2014.04.27.10.59.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 10:59:11 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.1.gce060f5
In-Reply-To: <20140426180835.GE21493@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247211>

git-imap-send was directly prompting for a password rather than using
git-credential. git-send-email, on the other hand, supports git-credential.

This is a necessary improvement for users that use two factor authentication, as
they should not be expected to remember all of their app specific passwords.

Signed-off-by: Dan Albert <danalbert@google.com>
---

>> About imap vs. imaps: I actually had your exact line in before, but decided
>> that as long as its for the same host the user probably wants to use the
>> same credentials for both imap and imaps (if they for some reason had both
>> configured). Hard coding "imap" allows them to use either protocol with
>> only one keychain entry. The use case is a stretch, but it doesn't do any
>> harm to implement it this way.
>
> My concerns with conflating the two are:
> 
>   1. The system helper might care about the distinction and prefer imaps
>      (e.g., it might already have the credential stored for your regular
>      mail client, which uses imaps). But osxkeychain is the only helper
>      that makes the distinction, and I don't really know how OS X's
>      keychain code handles the distinction.
> 
>   2. With http and https, we are careful to make the distinction,
>      because we would not want to accidentally share a credential over http
>      that was stored via https. But it's pretty easy to use an http URL
>      rather than an https one. It's probably pretty rare to accidentally
>      turn off imap SSL.
> 
> So I'd be OK with leaving it as "imap" for now, and waiting for somebody
> to actually come up with a real case where the distinction matters.

These are good points. I've made the change.

 imap-send.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0bc6f7f..112fc83 100644
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
@@ -1101,19 +1102,11 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
 			goto bail;
 		}
 		if (!srvc->pass) {
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
+			cred.username = xstrdup(srvc->user);
+			cred.protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
+			cred.host = xstrdup(srvc->host);
+			credential_fill(&cred);
+			srvc->pass = xstrdup(cred.password);
 		}
 		if (CAP(NOLOGIN)) {
 			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
@@ -1153,10 +1146,18 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
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
