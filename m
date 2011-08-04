From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/23] Provide access to the name attribute of git_attr
Date: Thu,  4 Aug 2011 06:36:17 +0200
Message-ID: <1312432593-9841-8-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QopgS-0005Mu-6y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab1HDEhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:37:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39643 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1HDEg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:59 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHl029203;
	Thu, 4 Aug 2011 06:36:56 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178673>

It will be present in any likely future reimplementation, and its
availability simplifies other code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-gitattributes.txt |    3 ++-
 attr.c                                        |    5 +++++
 attr.h                                        |    7 +++++++
 3 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 916720f..ab3a84d 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -13,7 +13,8 @@ Data Structure
 	An attribute is an opaque object that is identified by its name.
 	Pass the name to `git_attr()` function to obtain the object of
 	this type.  The internal representation of this structure is
-	of no interest to the calling programs.
+	of no interest to the calling programs.  The name of the
+	attribute can be retrieved by calling `git_attr_name()`.
 
 `struct git_attr_check`::
 
diff --git a/attr.c b/attr.c
index b1d1d6d..bfa1f43 100644
--- a/attr.c
+++ b/attr.c
@@ -36,6 +36,11 @@ static int attr_nr;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
+char *git_attr_name(struct git_attr *attr)
+{
+	return attr->name;
+}
+
 static unsigned hash_name(const char *name, int namelen)
 {
 	unsigned val = 0, c;
diff --git a/attr.h b/attr.h
index 8b3f19b..d4f875a 100644
--- a/attr.h
+++ b/attr.h
@@ -29,6 +29,13 @@ struct git_attr_check {
 	const char *value;
 };
 
+/*
+ * Return the name of the attribute represented by the argument.  The
+ * return value is a pointer to a null-delimited string that is part
+ * of the internal data structure; it should not be modified or freed.
+ */
+char *git_attr_name(struct git_attr *);
+
 int git_checkattr(const char *path, int, struct git_attr_check *);
 
 enum git_attr_direction {
-- 
1.7.6.8.gd2879
