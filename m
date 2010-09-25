From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 4/4] rev-parse: make --flags imply --no-revs for remaining arguments.
Date: Sat, 25 Sep 2010 23:33:53 +1000
Message-ID: <1285421633-22684-5-git-send-email-jon.seymour@gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 25 15:31:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUqm-0002J2-H9
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab0IYNbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:31:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55724 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176Ab0IYNbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:31:23 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so844960pwj.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=HRC9flXGCpkP8qpYn/i7JG2ur6JXXb6wDYxfNTsoJYs=;
        b=lbd3tCSaVnf1+iP5+wXVSONI6/0Ymvzzt0yDS3OZ17Zkgtep6ABBsWBQ0mWA4r5JAM
         krEnyvJspBvPJQC1KPBMWtwIonfjP0dWIPspUb+MNyQEiufDI+4Egjlz51Gy7rZz8yvs
         FMT/T+jjGPRDdSeg4lQUgL6AhlTFd8SnViKXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IPwbY1ZBVfSRjnF7RiFfI0w5hyjk5XQeoVFijznqk8YkpObTqMR2woVO0pP496ci25
         Q2/PdqDbt/PYLufCSSLZoAZZbFBsvf10ICP3CJ//PgBstQBpB06cDnHvQGzGkdjjomu/
         m8VRZoko7/JeuuOxpRIf6J3L5IMYmvADnsZA0=
Received: by 10.142.14.6 with SMTP id 6mr4038733wfn.66.1285421483153;
        Sat, 25 Sep 2010 06:31:23 -0700 (PDT)
Received: from localhost.localdomain ([120.16.118.189])
        by mx.google.com with ESMTPS id l42sm3924235wfa.9.2010.09.25.06.31.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 06:31:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4.ge900b
In-Reply-To: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157154>

This change ensures that git rev-parse --flags complies with its documentation,
namely:

   "Do not output non-flag parameters".

Previously:
   $ git rev-parse --flags HEAD
   <sha1 hash of HEAD>
   $

Now:
   $ git rev-parse --flags HEAD
   $

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   24 +++++++++++++-----------
 builtin/rev-parse.c             |    6 +++++-
 t/t1510-rev-parse-flags.sh      |    2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index f5e6637..f26fc7b 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -49,20 +49,22 @@ OPTIONS
 	'git rev-list' command.
 
 --flags::
-	Do not output non-flag parameters which are not also revisions.
-	+
-	If specified, this option causes 'git rev-parse' to stop
-	interpreting remaining arguments as options for its own
-	consumption. As such, this option should be specified
-	after all other options that 'git rev-parse' is expected
-	to interpret.
+	Do not output non-flag parameters.
++
+If specified, this option causes 'git rev-parse' to stop
+interpreting remaining arguments as options for its own
+consumption. As such, this option should be specified
+after all other options that 'git rev-parse' is expected
+to interpret.
++
+If `--flags` is specified, `--no-revs` is implied.
 
 --no-flags::
 	Do not output flag parameters.
-	+
-	If both `--flags` and `--no-flags` are specified, the first
-	option specified wins and the other option is treated like
-	a non-option argument.
++
+If both `--flags` and `--no-flags` are specified, the first
+option specified wins and the other option is treated like
+a non-option argument.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 2ad269a..84f9f07 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -13,7 +13,7 @@
 #define DO_REVS		1
 #define DO_NOREV	2
 #define DO_FLAGS	4
-#define DO_NONFLAGS	8
+#define DO_NONFLAGS	(8|DO_REVS)
 static int filter = ~0;
 
 static const char *def;
@@ -521,6 +521,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--flags")) {
+				if (!(filter & DO_FLAGS)) {
+					/* prevent --flags being interpreted if --no-flags has been seen */
+					continue;
+				}
 				filter &= ~DO_NONFLAGS;
 				continue;
 			}
diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
index 53002df..4dd6228 100755
--- a/t/t1510-rev-parse-flags.sh
+++ b/t/t1510-rev-parse-flags.sh
@@ -31,7 +31,7 @@ test_expect_success 'git rev-parse --no-revs --flags HEAD -> ""' \
 
 test_expect_success 'git rev-parse --symbolic --flags HEAD -> "HEAD"' \
 '
-	echo HEAD > expected &&
+	: > expected &&
 	git rev-parse --symbolic --flags HEAD >actual &&
 	test_cmp expected actual
 '
-- 
1.7.3.3.gc4c52.dirty
