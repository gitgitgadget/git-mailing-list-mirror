From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [RFC PATCH 1/2] add a --delete option to git push
Date: Thu, 13 Aug 2009 22:05:48 -0700
Message-ID: <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 07:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbozY-000376-FN
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 07:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbZHNFGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 01:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbZHNFGK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 01:06:10 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:48733 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613AbZHNFGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 01:06:09 -0400
Received: by pxi34 with SMTP id 34so193529pxi.4
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yRh1dcdQeGRHA3B2RzYVejkk+atvwfNEh7g7q2zvqOY=;
        b=n5Eb/xK38tP0ebzgBbLO3VeIOjeH861BKiC4vtVDBDgTDeej5F47fqHt+aG21AAbvr
         dzDqfPzNkTlMpAKs7wAlZr8L+LngvaVM8Aj6UDwIa2K1ZFwX22ZsFnsbOOd+ocEKg74e
         3UXRQ4ZGzHs52UMnGD0fwjhaG80y9FF67jNu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=azRTw6+5dRQd3nlriRsqMdaGTNzqRvNlU8AWlQlduffZKfKGhCkiUEKiPMJM2JbX99
         expszJH1N+xOjPfczBlD/xE3p4sXDKojQzVWWUe5CcUGbr4gWIo3ciIfYtBEWFn9IqjS
         BNsJdZoNYsupv+PZ75ov8Pi2Mn0NbJ2aHe490=
Received: by 10.140.185.17 with SMTP id i17mr41166rvf.1.1250226370904;
        Thu, 13 Aug 2009 22:06:10 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm5737547rvb.40.2009.08.13.22.06.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Aug 2009 22:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
In-Reply-To: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125895>

Those new to git have a hard time learning how to delete a remote
ref. This makes it easier for them to find out how by providing a
flag to git push.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

    Currently `git push --delete master:master` results in a somewhat
    cryptic error message. It seems unlikely however, that those new
    to git would use the 'old:new' notation, so I haven't bothered
    guarding against it and settled for documenting it.

 Documentation/git-push.txt |    8 +++++++-
 builtin-push.c             |   10 +++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 58d2bd5..1ecc6ca 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose]
+	   [--repo=<repository>] [-f | --force] [-v | --verbose] [-d | --delete]
 	   [<repository> <refspec>...]
 
 DESCRIPTION
@@ -137,6 +137,12 @@ useful if you write an alias or script around 'git-push'.
 --verbose::
 	Run verbosely.
 
+-d::
+--delete::
+    Delete the specified refs. Prefixes all refs with ':' to tell the
+    push machinery to delete the specified ref. As such, the refs
+    that are to be deleted should not contain a ':' specifier.
+
 include::urls-remotes.txt[]
 
 OUTPUT
diff --git a/builtin-push.c b/builtin-push.c
index 67f6d96..b954235 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,11 +10,12 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [-d | --delete] [<repository> <refspec>...]",
 	NULL,
 };
 
 static int thin;
+static int push_delete;
 static const char *receivepack;
 
 static const char **refspec;
@@ -44,6 +45,12 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
+		if (push_delete) {
+			struct strbuf deleted = STRBUF_INIT;
+			strbuf_addstr(&deleted, ":");
+			strbuf_addstr(&deleted, refs[i]);
+			ref = strbuf_detach(&deleted, NULL);
+		}
 		add_refspec(ref);
 	}
 }
@@ -188,6 +195,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		OPT_BOOLEAN('d', "delete", &push_delete, "delete ref"),
 		OPT_END()
 	};
 
-- 
1.6.4.16.g72c66.dirty
