From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 10/11] tree-diff: no need to call "full" diff_tree_sha1 from show_path()
Date: Fri,  7 Feb 2014 21:48:51 +0400
Message-ID: <cd28df7033a83d4930cb70ab8794b86cb2601de6.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWt-0000ne-2S
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbaBGRrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:36 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33802 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753311AbaBGRrd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:33 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWV-0002Lm-Nk; Fri, 07 Feb 2014 21:47:31 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpYH-0004AT-HI; Fri, 07 Feb 2014 21:49:21 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241787>

As described in previous commit, when recursing into sub-trees, we can
use lower-level tree walker, since its interface is now sha1 based.

The change is ok, because diff_tree_sha1() only invokes
__diff_tree_sha1(), and also, if base is empty, try_to_follow_renames().
But base is not empty here, as we have added a path and '/' before
recursing.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index dd6c760..e385ed4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -116,8 +116,8 @@ static void show_path(struct strbuf *base, struct diff_options *opt,
 
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
