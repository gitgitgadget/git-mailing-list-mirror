From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 5/6] Update git-tag-script to create the .git/refs/tags if
 it does not already exist
Date: Thu, 14 Jul 2005 19:00:15 -0600
Message-ID: <m1br54yjc0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:02:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEab-0002wL-Qt
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVGOBBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVGOBBv
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:01:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20157 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261735AbVGOBAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:00:31 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F10FGs020942;
	Thu, 14 Jul 2005 19:00:15 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F10Fs1020941;
	Thu, 14 Jul 2005 19:00:15 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


When testing tags I ran into an interesting problem.
git-tag-script dies if .git/refs/tags/ does not exist.
And that directory didn't get created when I build my repository,
so we need to create it if it doesn't exist.

Signed-of-by: Eric W. Biederman <ebiederm@xmission.com> 
---

 git-tag-script |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

362c96f2a2959b648c8313d3530ea1e6df17e96c
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -20,5 +20,6 @@ grep -v '^#' < .editmsg | git-stripspace
 ( echo -e "object $object\ntype $type\ntag $name\n"; cat .tagmsg ) > .tmp-tag
 rm -f .tmp-tag.asc .tagmsg
 gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
+mkdir -p "$GIT_DIR/refs/tags"
 git-mktag < .tmp-tag > "$GIT_DIR/refs/tags/$name"
 #rm .tmp-tag .tmp-tag.sig
