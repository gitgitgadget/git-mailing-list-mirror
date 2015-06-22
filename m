From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 19/19] fsck: support ignoring objects in `git fsck` via
 fsck.skiplist
Date: Mon, 22 Jun 2015 17:27:23 +0200
Organization: gmx
Message-ID: <48da2ac1fac1e4e68142c174846ba5977f3e0788.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73dN-0007dk-GO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbbFVP1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:27:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:51950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbbFVP1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:31 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M1n4s-1Yo0bm22v4-00tj6T; Mon, 22 Jun 2015 17:27:24
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Bv/95jo+fWI/boH2k1k3VbyDTHu2IG9Q/oDPaSDokD+Yes4QVVI
 UHsndPXWOhN1+Ubea3f1VcEIxSXCmF4wFtzqbW9b31tfsQf/jc2XOVMlULgmp1WJjEeQc7/
 n+loqHx3ckhMK3z7yAY51gJmUsC3pV3PqU+PUcH0Ezj1QJIurddb0CNQyp3+znQ+k2LOFS/
 ZZ4Wv1I3MYPjeE84BWT5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dl+jDy5nFog=:qItSw9ty+zvUbvIWVRSIyU
 04d45KW6sdCGJPVmnbFgHWrWzTq+MnPFifBJqxORsb7jTaFaHN0Tp+VxXRdHCdnTMVWFDdTOM
 +YgBki4EDb2BCahnxaAaCL0+WdsfVykVyieid6T0YnlPojSj2tGeLDU7vF3KGEbZY8FyBjuvf
 dfCDBmAYnfd5Iuf9XPkyC29qce1kgfLHDWlaxqYh1MREh0t4V/SglTKS3Ras+83aXJMZXJoo2
 fGkwcSWpc4IdZ4jHSnHcnwxR156zxpWQFvTKSxK3WGC/JSf5Z8vQQrajXTzTFW7oavxu6joQt
 lfAv+0PqI+qn1e+HZ3reJWWDTWfuuDeshHA28fCul0o6J+VvZj+4lNLQ7lcB0oSJZ01o22qXX
 Z3ciQNfW3xmdrXwCAaSrRFjkU7hlY0yrlUOLRv4iK4EVgl0NNvRuX6Q4sFnEisQ+z0TB4PDa/
 5ho9g1YfNJfLo5hNyP2XtOiEjMWj6dQNfhGNPC9b8/f3zcfpriAkVjFlUeSm2XX6Jvp89kkva
 DszAeWEoykQUSZLT7j7W/FEbeWlZ/1BaljqzWJSFbMRqnr5rg6MqdUGmcijsTr9tvXPr+IcvH
 c/NbI7toxrJJp0U+752FNS0hiSOOeJ3rxfiOs2rUN+/MeHwI4orHI+hJ1LFk/slm7wqwCoHEp
 NMCNZCieiigE44yoIYqnmXLQEBO4ePYHcsH9VKt1MwKpm4IVLu8yINFL9jnHGp82sa+s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272389>

Identical to support in `git receive-pack for the config option
`receive.fsck.skiplist`, we now support ignoring given objects in
`git fsck` via `fsck.skiplist` altogether.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  8 ++++++++
 builtin/fsck.c           | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ed7f37f..69dda93 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1261,6 +1261,14 @@ that setting `fsck.missingEmail = ignore` will hide that issue.
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
 
+fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+	Note: corrupt objects cannot be skipped with this setting.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2d14298..7e3df20 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,6 +49,19 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		const char *path;
+		struct strbuf sb = STRBUF_INIT;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		free((char *) path);
+		fsck_set_msg_types(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	if (skip_prefix(var, "fsck.", &var)) {
 		fsck_set_msg_type(&fsck_obj_options, var, value);
 		return 0;
-- 
2.3.1.windows.1.9.g8c01ab4
