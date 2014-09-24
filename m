From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Wed, 24 Sep 2014 17:35:12 -0400
Message-ID: <20140924213512.GA7619@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 23:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWua5-0006qO-IG
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 23:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbaIXV63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 17:58:29 -0400
Received: from longford.logfs.org ([213.229.74.203]:44068 "EHLO
	longford.logfs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbaIXV62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 17:58:28 -0400
X-Greylist: delayed 1126 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Sep 2014 17:58:28 EDT
Received: from joern by longford.logfs.org with local (Exim 4.72)
	(envelope-from <joern@logfs.org>)
	id 1XWuDQ-0002Cr-9g; Wed, 24 Sep 2014 17:35:12 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257468>

git-quiltimport passed "-C1" to git-apply, supposedly to roughly match
the quilt default of --fuzz 2.  This is against the spirit of git.
Quoting Linus:
  Except unlike the standard "patch" program, "git apply" doesn't accept
  fuzz by default (which to me is a huge deal - I hate how "patch" tries
  to apply stuff that clearly isn't valid any more)

It also causes active harm when combining git-quiltimport with regular
quilt and quilt is used with --fuzz=0, as it should be by any prudent 
person.

Signed-off-by: Joern Engel <joern@logfs.org>
---
 git-quiltimport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 167d79fea809..3eb2e2fd3648 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -130,7 +130,7 @@ do
 	fi
 
 	if [ -z "$dry_run" ] ; then
-		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
+		git apply --index ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-- 
2.1.0
