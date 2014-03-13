From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH v3 1/2] fsck.c: Change the type of fsck_ident()'s first argument
Date: Thu, 13 Mar 2014 12:45:50 +0800
Message-ID: <1394685951-9726-2-git-send-email-yshuiv7@gmail.com>
References: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 05:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNxXE-00079G-HK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 05:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbaCMEqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 00:46:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:42839 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaCMEqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 00:46:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so549305pab.5
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wHRaOxkP8DkMjqP/x4l2MaU4mRsQ4lfLdBo6DtcmHq4=;
        b=btqsLijpwWT55ZtjIG/DAOzp0sKsBQfCAK31OeLbjvBr+UjcAWmIym7xWjxzHdoGVR
         07gLqukVnSyTVg/FamJJSRBKu50Y4uLnAD/7ZGax3BIIuQG+Y8slmyp4EB5jbE8uomES
         oPcN9waGP0sPXoFh4sRT23ZqGQG22OFDcDYQA1tp4KOOU1roRM6GrlS87bKdZIehYBlE
         ypTKxO3yLW08tTQ8XwzqdzCP7b6NHVRyqZeAogGJR1ofxskPGMhKg9WRbwoBdCMYBNQu
         lPrE+Dseiq6sWwAqKbWmUEY6zem2AbTbUzQK89PG9V5Z/mHEiGEDhnNc3bGtQ4J1zyqw
         1R4Q==
X-Received: by 10.66.228.201 with SMTP id sk9mr1755844pac.134.1394685969385;
        Wed, 12 Mar 2014 21:46:09 -0700 (PDT)
Received: from localhost.localdomain ([123.151.32.162])
        by mx.google.com with ESMTPSA id zb2sm2528040pbc.30.2014.03.12.21.46.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Mar 2014 21:46:08 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394685951-9726-1-git-send-email-yshuiv7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244021>

Since fsck_ident doesn't change the content of **ident, the type of
ident could be const char **.

This change is required to rewrite fsck_commit() to use skip_prefix().

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 fsck.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 99c0497..7776660 100644
--- a/fsck.c
+++ b/fsck.c
@@ -243,7 +243,7 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
+static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	if (**ident == '<')
 		return error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
@@ -281,7 +281,7 @@ static int fsck_ident(char **ident, struct object *obj, fsck_error error_func)
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	char *buffer = commit->buffer;
+	const char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
-- 
1.9.0
