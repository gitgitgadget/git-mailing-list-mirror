From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/25] cmd_diff(): make it obvious which cases are exclusive of each other
Date: Sat, 25 May 2013 11:08:06 +0200
Message-ID: <1369472904-12875-8-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgAVP-0006Ka-VC
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab3EYJLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:11:07 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:58127 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752991Ab3EYJJE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:04 -0400
X-AuditID: 12074411-b7f286d0000008e8-f3-51a07faf3f95
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id EF.12.02280.FAF70A15; Sat, 25 May 2013 05:09:03 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98guh000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:02 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsUixO6iqLu+fkGgwY5ea4uuK91MFg29V5gt
	5t3dxWRxe8V8ZosfLT3MFncvr2J3YPP4+/4Dk8ell9/ZPG6/ns/s8ax3D6PHxUvKHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ+z6vIS1YDp3xYRfvawNjI84uhg5OSQETCQuHd/LBmGLSVy4tx7I
	5uIQErjMKNH79AuUc4FJYsOlNrAqNgFdiUU9zUwgtoiAo8SJB9dZQYqYBXoZJR4++g6WEBaI
	ldh95z07iM0ioCox5/c2MJtXwEVixd/FrBDrFCQuz1rD3MXIwcEp4Crx9gQnSFgIqOT5p3Os
	Exh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQICTTBHYwzTsodYhTg
	YFTi4RUonx8oxJpYVlyZe4hRkoNJSZSXv3ZBoBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXoYU
	oBxvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYJ3bx1Qo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoNuKLgdEBkuIB2nsWpJ23uCAxFygK0XqKUZdj8/nJ
	7xiFWPLy81KlxHlvghQJgBRllObBrYCllVeM4kAfC/MuAKniAaYkuEmvgJYwAS25mTsfZElJ
	IkJKqoEx76/dnDUnS3yVFqzSZU7d6HzwxgGhJxtnP3GykvnvuG6ewLfNL6aoMEWd3R6b+9Cj
	ad+Jp0EX4za+6ubsrp685cjHviM3aryW/ymewM1Ta7jxq2fiBru80j+r/3w5I703 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225517>

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
index 84243d9..9fc273d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -350,22 +350,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
