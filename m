From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-log: also search the initial commit for files
Date: Thu, 2 Jun 2005 15:10:00 +0200
Message-ID: <20050602131000.GA16143@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 15:14:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdpUy-0002QI-QL
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 15:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFBNOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 09:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVFBNOL
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 09:14:11 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:54987 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261404AbVFBNKE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 09:10:04 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5ABD16E18A1; Thu,  2 Jun 2005 15:09:24 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 275276E167E; Thu,  2 Jun 2005 15:09:24 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 22C3B61FE0; Thu,  2 Jun 2005 15:10:01 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When restricting the log to a set of files pass --root to git-diff-tree if
no parent is found so the initial commit is also checked.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-log |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -167,7 +167,9 @@ $revls | $revsort | while read time comm
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
 	if [ $# -ne 0 ]; then
 		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
-		[ "$parent" ] && [ "$(git-diff-tree -r $commit $parent "$@")" ] || continue
+		diff_ops=
+		[ "$parent" ] || diff_ops=--root
+		[ "$(git-diff-tree -r $diff_ops $commit $parent "$@")" ] || continue
 	fi
 	if [ "$user" ]; then
 		git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
-- 
Jonas Fonseca
