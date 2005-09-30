From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Fix cg-admin-uncommit
Date: Fri, 30 Sep 2005 20:35:46 +0200
Message-ID: <20050930183545.15895.61691.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 20:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELPlb-0003U4-UX
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 20:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVI3Shw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVI3Shw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 14:37:52 -0400
Received: from ppp-62-11-79-147.dialup.tiscali.it ([62.11.79.147]:25823 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S965062AbVI3Shv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 14:37:51 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 3D29B2283DB;
	Fri, 30 Sep 2005 20:35:49 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9571>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

It uses $1 rather than ${ARGS[0]}, which breaks when optparse found some
options, i.e. with cg-admin-uncommit -t (cg-object-id -c -t is not nice).

Please, document optparse to explain this. It's absolutely non-obvious, and when
I first hit this I thought optparse was buggy but couldn't make my way to the
fix.

Both because I was using cogito rather than debugging it, and even considering
the obfuscation level, but above all I was looking for a call to shift in
optshift and didn't find it. Now I understood the thing I pity myself, though.

Btw, why doesn't optparse consume all the cmd arguments via shift, making thus
sure that $1 never works at all?

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-admin-uncommit |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -47,7 +47,7 @@ done
 
 base=$(cg-object-id -c) || exit 1
 
-commit=$(cg-object-id -c "$1") || exit 1
+commit=$(cg-object-id -c "${ARGS[0]}") || exit 1
 git-rev-list $base | grep -q $commit || \
 	die "$commit: not an ancestor of HEAD"
 
