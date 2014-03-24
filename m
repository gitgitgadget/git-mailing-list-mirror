From: Ashwin Jha <ajha.dev@gmail.com>
Subject: [PATCH v3 1/2] fsck.c: modify fsck_ident() and fsck_commit()
Date: Mon, 24 Mar 2014 17:38:21 +0530
Message-ID: <1395662901-10617-1-git-send-email-ajha.dev@gmail.com>
Cc: Ashwin Jha <ajha.dev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 13:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS3h0-0002oy-EF
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 13:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014AbaCXMJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 08:09:22 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57429 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbaCXMJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 08:09:21 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so5345209pad.7
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1dev7xoA5cMw87XBH4Cq7hj8QwMOnhus10o2GfVFjV4=;
        b=D5ZArP+Eu12O752ExR4wOytYbOOv3tb5zgOf3MVLTz8JKMZIh8mJkpfvhaIoIVTwdC
         dq8yd3sIHanxTk4dCsriKKzrmzRCA0v+XyhRKl3NBscDdlCfEH+PeJZQcbEAg/mpn/WG
         Mui0pZ15WJj+81CBg6xGcd7d2rzabB+o7Uwqs7pc0fR9VvR9brMU6u0CjPvQlp0yVfVP
         Fggk1ytfDv6uqTj4QoXSrDk87kXEDlfxuMeqOtrC5N/+HKYhEoxUHME7uzGO6WntK5dF
         Ty5r3Y7ct5/8Fppgtf70rInhULTM5hSSR8YuWOv+lI2DltTnX8CEO9R4ye5BZVrFwuCb
         0Y6w==
X-Received: by 10.66.102.39 with SMTP id fl7mr69631696pab.43.1395662960780;
        Mon, 24 Mar 2014 05:09:20 -0700 (PDT)
Received: from ubuntu.59.160.212.34 (nkn-admin-map.isical.ac.in. [14.139.222.67])
        by mx.google.com with ESMTPSA id hw8sm32890293pbc.62.2014.03.24.05.09.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 05:09:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244818>

In fsck_ident(): Replace argument char **ident with const char **ident
In fsck_commit(): Replace char *buffer with const char *buffer

In both the cases, referenced memory addresses are not modified. So, it
will be a good practice, to declare them as const.

Signed-off-by: Ashwin Jha <ajha.dev@gmail.com>
---

Change in fsck_commit() and fsck_ident() as per the discussion with
Eric (follow at [1]).
[1]: http://git.661346.n2.nabble.com/PATCH-Modify-fsck-commit-Replace-memcmp-by-skip-prefix-td7606321.html

 fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 64bf279..b5f017f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -243,7 +243,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
+static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	char *end;
 
@@ -284,7 +284,7 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	const char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
-- 
1.9.1
