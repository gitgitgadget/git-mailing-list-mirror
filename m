From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 2/2] git-verify-tag: detect wrong syntax
Date: Sun, 09 Oct 2005 20:12:56 +0200
Message-ID: <20051009181256.17885.6626.stgit@zion.home.lan>
References: <20051009181246.17885.81654.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 20:54:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOgIS-0007p6-JO
	for gcvg-git@gmane.org; Sun, 09 Oct 2005 20:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVJISxH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Oct 2005 14:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJISxH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Oct 2005 14:53:07 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:34534 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932217AbVJISxG
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 9 Oct 2005 14:53:06 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 94787229AA1;
	Sun,  9 Oct 2005 20:12:56 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20051009181246.17885.81654.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9866>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Print proper error messages when failing, and handle -h/--help to avoid, if
possible, to print double error message (from git-cat-file and from
git-verify-tag).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 git-verify-tag.sh |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/git-verify-tag.sh b/git-verify-tag.sh
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -1,9 +1,16 @@
 #!/bin/sh
 . git-sh-setup || die "Not a git archive"
 
+usage() {
+	die "usage: git-verify-tag <tag>"
+}
+
+[ $# = 1 ] || usage
+[ "$1" = "-h" -o "$1" = "--help" ] && usage
+
 tag=$(git-rev-parse $1) || exit 1
 
-type=$(git-cat-file -t $tag) || exit 1
+type=$(git-cat-file -t $tag) || usage
 [ "$type" = "commit" ] && die "Light tag - verification impossible"
 [ "$type" = "tag" ] || die "Bad tag - SHA1 doesn't refer to a tag object nor to a commit one."
 
