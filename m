From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] apply, entry: speak of submodules instead of subprojects
Date: Tue, 16 Jul 2013 11:21:59 +0200
Message-ID: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:22:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1SU-0003r5-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab3GPJWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:22:04 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:5548 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752815Ab3GPJWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:22:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:21:58 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:21:59 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <87bo631odi.fsf@hexa.v.cablecom.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230551>

There are only four (with some generous rounding) instances in the
current source code where we speak of "subproject" instead of
"submodule".  They are as follows:

* one error message in git-apply and two in entry.c

* the patch format for submodule changes

The latter was introduced in 0478675 (Expose subprojects as special
files to "git diff" machinery, 2007-04-15), apparently before the
terminology was settled.  We can of course not change the patch
format.

Let's at least change the error messages to consistently call them
"submodule".

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---

This and the next one are message changes for things I found during my
review.

 builtin/apply.c | 2 +-
 entry.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0e9b631..f1d4cc9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3847,7 +3847,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 		const char *s = buf;
 
 		if (get_sha1_hex(s + strlen("Subproject commit "), ce->sha1))
-			die(_("corrupt patch for subproject %s"), path);
+			die(_("corrupt patch for submodule %s"), path);
 	} else {
 		if (!cached) {
 			if (lstat(path, &st) < 0)
diff --git a/entry.c b/entry.c
index d7c131d..6af4b6a 100644
--- a/entry.c
+++ b/entry.c
@@ -199,9 +199,9 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("cannot create temporary subproject %s", path);
+			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
-			return error("cannot create subproject directory %s", path);
+			return error("cannot create submodule directory %s", path);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
-- 
1.8.3.2.998.g1d087bc
