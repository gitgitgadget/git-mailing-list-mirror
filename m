From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Cleanup: git-verify-tag-script
Date: Sat, 16 Jul 2005 14:18:40 -0600
Message-ID: <m13bqepkrj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 16 22:19:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtt83-0002xq-Hv
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 22:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVGPUTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGPUTE
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 16:19:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30168 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261509AbVGPUTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 16:19:03 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6GKIf1W020620;
	Sat, 16 Jul 2005 14:18:42 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6GKIfQF020618;
	Sat, 16 Jul 2005 14:18:41 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


- Use git-verify-parse to allow sha1 tags references
- When the tag does not verify set an appropriate exit status
- Use git-sh-setup-script to verify the .git directory

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 git-verify-tag-script |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

f0b9fc0d7e2c8a23d73337ffa6907ee597aab53f
diff --git a/git-verify-tag-script b/git-verify-tag-script
--- a/git-verify-tag-script
+++ b/git-verify-tag-script
@@ -1,9 +1,8 @@
 #!/bin/sh
-GIT_DIR=${GIT_DIR:-.git}
+. git-sh-setup-script || die "Not a git archive"
 
-tag=$1
-[ -f "$GIT_DIR/refs/tags/$tag" ] && tag=$(cat "$GIT_DIR/refs/tags/$tag")
+tag=$(git-rev-parse $1) || exit 1
 
 git-cat-file tag $tag > .tmp-vtag || exit 1
-cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag -
+cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag - || exit 1
 rm -f .tmp-vtag
