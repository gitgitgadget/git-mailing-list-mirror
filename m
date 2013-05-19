From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/17] cmd_diff(): make it obvious which cases are exclusive of each other
Date: Sun, 19 May 2013 22:27:02 +0200
Message-ID: <1368995232-11042-8-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:29:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeAE2-0004xT-4z
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3ESU2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:47 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:61200 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754730Ab3ESU2G (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:06 -0400
X-AuditID: 1207440d-b7fd06d000000905-9c-519935d6de7a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C4.1A.02309.6D539915; Sun, 19 May 2013 16:28:06 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5Q026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:05 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqHvNdGagwa15ShZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTtjyqovbAXTuSvOvTnE3sD4iKOLkZNDQsBEYvmPhcwQtpjEhXvr2boYuTiEBC4zShzd
	sxHKOc8kMePkWXaQKjYBXYlFPc1MILaIgKzE98MbGUFsZoEJjBJL+wtBbGGBKIkJLdvBprII
	qEq8adzIAmLzCrhInN+5hwlim4LE5VlrwGo4BVwltrTvYgWxhYBq/vXfZp3AyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkhQ8e5g/L9O5hCjAAejEg+vxrvpgUKs
	iWXFlbmHGCU5mJREed+ZzAwU4kvKT6nMSCzOiC8qzUktPsQowcGsJMK7Rwgox5uSWFmVWpQP
	k5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4O0AGSpYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPio34YmB0gKR4gPbeB2nnLS5IzAWKQrSeYtTl2Hx+8jtGIZa8/LxUKXHe
	fpAiAZCijNI8uBWwFPKKURzoY2HeIyBVPMD0AzfpFdASJqAlrNemgiwpSURISTUwZmtLHwo1
	ni7MuuDu3TrO3P8+3AJ6gXrXdhem3PN+sipIp6TusM3U27dzTHbsKJV37pvNWREcOeNW/Zpl
	Chrq5x06XHnCWHobpH+umXahxEzp1LdGz7VrZkdtlGLdfVci7qr9uzdvis79+qp1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224923>

At first glance the OBJ_COMMIT, OBJ_TREE, and OBJ_BLOB cases look like
they might be mutually exclusive.  But the OBJ_COMMIT case doesn't end
the loop iteration with "continue" like the other two cases, but
rather falls through.  So use if...else if...else construct to make it
more obvious that only the last two cases are mutually exclusive.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 7cac6de..3b90ee6 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -349,22 +349,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
 			obj = &((struct commit *)obj)->tree->object;
+
 		if (obj->type == OBJ_TREE) {
 			obj->flags |= flags;
 			add_object_array(obj, name, &ent);
-			continue;
-		}
-		if (obj->type == OBJ_BLOB) {
+		} else if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
 			blob[blobs].mode = entry->mode;
 			blobs++;
-			continue;
 
+		} else {
+			die(_("unhandled object '%s' given."), name);
 		}
-		die(_("unhandled object '%s' given."), name);
 	}
 	if (rev.prune_data.nr) {
 		if (!path)
-- 
1.8.2.3
