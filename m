From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 15/19] tree-diff: no need to call "full" diff_tree_sha1 from show_path()
Date: Mon, 24 Feb 2014 20:21:47 +0400
Message-ID: <7e5e5a381ba4204eac14c5be9e270ffdc0e2be7a.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyIb-0004bE-2e
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbaBXQWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:22:03 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34255 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbaBXQVs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:48 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHq-00040r-Kh; Mon, 24 Feb 2014 20:21:46 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyJV-0007A9-Q2; Mon, 24 Feb 2014 20:23:29 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242605>

As described in previous commit, when recursing into sub-trees, we can
use lower-level tree walker, since its interface is now sha1 based.

The change is ok, because diff_tree_sha1() only invokes
__diff_tree_sha1(), and also, if base is empty, try_to_follow_renames().
But base is not empty here, as we have added a path and '/' before
recursing.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index f90acf5..aea0297 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -114,8 +114,8 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 
 	if (recurse) {
 		strbuf_addch(base, '/');
-		diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
-			       t2 ? t2->entry.sha1 : NULL, base->buf, opt);
+		__diff_tree_sha1(t1 ? t1->entry.sha1 : NULL,
+				 t2 ? t2->entry.sha1 : NULL, base->buf, opt);
 	}
 
 	strbuf_setlen(base, old_baselen);
-- 
1.9.rc1.181.g641f458
