From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: [PATCH/RFC] Add [] as an alias for a reference to the empty tree
Date: Fri,  7 May 2010 18:37:27 +0200
Message-ID: <1273250247-20762-1-git-send-email-pkj@axis.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 18:37:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAQYU-0006Ch-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 18:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab0EGQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 12:37:32 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:49464 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0EGQhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 12:37:31 -0400
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.93.3.2])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o47GbTe1013374;
	Fri, 7 May 2010 18:37:29 +0200
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.3/8.14.3) with ESMTP id o47GbTK6020796;
	Fri, 7 May 2010 18:37:29 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.3/8.14.3/Submit) id o47GbTRq020794;
	Fri, 7 May 2010 18:37:29 +0200
X-Mailer: git-send-email 1.7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146540>

Instead of specifying the SHA1 for the empty tree (i.e.,
4b825dc642cb6eb9a060e54bf8d69288fbee4904) one can now say [], e.g.,
'git diff [] v1.7.1' would give all the changes between the empty tree
and the tag v1.7.1.

The rationale for selecting [] as the alias for the empty tree was that
it looks empty, the brackets are not used for anything related to
references (AFAIK), they are not allowed in references according to
'man git-check-ref-format', and the syntax can easily be extended to
allow other types of references by adding information between the
brackets.

Signed-off-by: Peter Kjellerstedt <pkj@axis.com>
---
 sha1_name.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

This is in response to the discussion in [1]. I am not sure the use of
'[]' as an alias for the empty tree will be accepted, but I think having
an alias similar to this is much easier to implement than adding support
for a --root option to all commands which can take a <tree-ish>...

Since this is mostly an RFC I have not included any new tests (though
the existsing once still pass after this change).

[1] http://thread.gmane.org/gmane.comp.version-control.git/146468/focus=146484

diff --git a/sha1_name.c b/sha1_name.c
index bf92417..ba58eab 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -347,6 +347,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	int refs_found = 0;
 	int at, reflog_len;
 
+	if (len == 2 && str[0] == '[' && str[1] == ']')
+		return get_sha1_hex(EMPTY_TREE_SHA1_HEX, sha1);
+
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
-- 
1.7.0.1
