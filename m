From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/19] Provide access to the name attribute of git_attr
Date: Tue, 26 Jul 2011 16:12:50 +0200
Message-ID: <1311689582-3116-8-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlieu-0004gd-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1GZOaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:30:52 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40163 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1GZOav (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:30:51 -0400
X-Greylist: delayed 1060 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jul 2011 10:30:51 EDT
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-O6; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177869>

It will be present in any likely future reimplementation, and its
availability simplifies other code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

struct git_attr is an opaque structure containing, among other things,
the name of the attribute that it represents.  This patch adds a
function git_attr_name(struct git_attr *) that allows the name to be
read from the structure.  This functionality will be convenient for
later patches.

This seems harmless to me.  It is hardly conceivable that the
implementation will change so dramatically that it becomes impossible
to derive the attribute name from the git_attr.

Please check that the name that I chose for this function conforms to
git conventions.

 Documentation/technical/api-gitattributes.txt |    3 ++-
 attr.c                                        |    4 ++++
 attr.h                                        |    7 +++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

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
index b1d1d6d..a261550 100644
--- a/attr.c
+++ b/attr.c
@@ -36,6 +36,10 @@ static int attr_nr;
 static struct git_attr_check *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
+char *git_attr_name(struct git_attr *attr) {
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
