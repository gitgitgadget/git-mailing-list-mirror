From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 19/19] fsck: support ignoring objects in `git fsck` via
 fsck.skiplist
Date: Thu, 18 Jun 2015 22:10:13 +0200
Organization: gmx
Message-ID: <49c65f7a3409bf7241302f2ea6c102503ddb2b8a.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8s-0004Ui-6q
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbbFRUKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:10:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:62956 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbbFRUKX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:10:23 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MEFqW-1ZL4LF3GP2-00FSHq; Thu, 18 Jun 2015 22:10:13
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:CcyIoSCzpp+iCccHKeBfAZ41s2cTD2r5n+RGriD+SJFQmrQqSr1
 MXi3/okb1R+lsi9QSpcQyjLcsR9ofTZ9vk+ivF00XBCcfqbC6zWk75rqsBjiqcyR3lcpNzX
 3n0qOcHgMK4LfsO3BUcq2yr39ePCDQ700J7v3llvA9ZmotFNC3jfAgrQjtsG78ME1wmRhcQ
 p6EoE18cKI6avKjgOQH/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZBqFjOcR0f8=:uf14TjM7rflmV39cZyTPj+
 GS1m70dOtJwFXi/E7DaNbva4HioX7hy4UViCf5a30E3szdlovk4OFynzJVFlWXyGoB071H6l0
 yK9TT6j6Lv9Iud/qCHHktW0o498XsWORxGTCnqg7scpASbeOpn3g/YCX05nqQsdOdGem5Do9Y
 fI0bdC5eku13z2NoyFnlTobrz94xYMRACbL7CONapTUWHuVvyLjlSGHEuPDpFBxKp42vYWSJS
 7YoVfPNnq/SDGhBrvbS8jlFC3mDVz4Q5Ox6InTLbYWNEXPGvB8XEmIEvUmSIxerDcXOCYGLrj
 E8Bi6oK5hphxbaXmM36xaRmo6dokf8lI+CDhv4JGnkqo/MjtjOlgeef/MvuLi66IO+SKZi0ph
 tAftTfgXaw0Qz3E8Ki6TLkdzfzZgit7U49CwPh8tulXgw0l4x1YngZ1ZfLeUT6oOJ0aiVxGcj
 XVyjmHwptwv4d/o7pNM0dnasy3IjGktvVZtxm+dlAbMaH1XeO92DZUPDZrvnUon9jjhnc7r22
 0PTuWXo+TqWfmz5an1VtFC2EvWMLzb3N29AdSyc/TmSOYBIU0GLpxhnI1fa3wl9j0y6H5g9BB
 KQ8o18Bhsj8Z0FJwZS6Z4RjuW6zgtQVsdojohBdevEJxp/dGXrlsJmZ+ot1lOaoZ9NnfyIALh
 hSXtPwGqfDGtkrwic45IhpLtRoVe16byomgRokzqNU91ivlWH0so+V660ILdZmVuCvdA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272060>

Identical to support in `git receive-pack for the config option
`receive.fsck.skiplist`, we now support ignoring given objects in
`git fsck` via `fsck.skiplist` altogether.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  7 +++++++
 builtin/fsck.c           | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f45115..5aba63a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1261,6 +1261,13 @@ that setting `fsck.missingemail = ignore` will hide that issue.
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
 
+fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 75fcb5f..ce538ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -54,6 +54,16 @@ static int fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		fsck_set_msg_types(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.3.1.windows.1.9.g8c01ab4
