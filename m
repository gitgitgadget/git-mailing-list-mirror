From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/19] Provide access to the name attribute of git_attr
Date: Thu, 28 Jul 2011 06:46:46 +0200
Message-ID: <1311828418-2676-8-git-send-email-mhagger@alum.mit.edu>
References: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 28 06:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIVc-0005eI-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab1G1Erm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:47:42 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57268 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab1G1ErW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:47:22 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmITD-000889-FG; Thu, 28 Jul 2011 06:45:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311828418-2676-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178022>

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
