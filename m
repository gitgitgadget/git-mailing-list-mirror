From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow fetching references from any namespace
Date: Fri, 11 May 2007 22:35:22 +0200
Message-ID: <20070511203522.GA2741@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 22:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmbqH-00054s-Gq
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761995AbXEKUf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXEKUf0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:35:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38544 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761995AbXEKUfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:35:25 -0400
Received: from tigra.home (Fca58.f.strato-dslnet.de [195.4.202.88])
	by post.webmailer.de (klopstock mo42) (RZmta 6.1)
	with ESMTP id C00563j4BJt0f9 ; Fri, 11 May 2007 22:35:22 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 996D7277BD;
	Fri, 11 May 2007 22:35:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 238F7D171; Fri, 11 May 2007 22:35:21 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTLyXg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46981>

not only from the three defined: heads, tags and remotes.

Noticed when I tried to fetch the references created by git-p4-import.bat:
they are placed into separate namespace (refs/p4import/, to avoid showing
them in git-branch output). As canon_refs_list_for_fetch always prepended
refs/heads/ it was impossible, and annoying: it worked before. Normally,
the p4import references are useless anywhere but in the directory managed
by perforce, but in this special case the cloned directory was supposed
to be a backup, including the p4import branch: it keeps information about
where the imported perforce state came from.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-parse-remote.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 437b0c3..0506b12 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -143,13 +143,13 @@ canon_refs_list_for_fetch () {
 		fi
 		case "$remote" in
 		'' | HEAD ) remote=HEAD ;;
-		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		refs/*) ;;
 		heads/* | tags/* | remotes/* ) remote="refs/$remote" ;;
 		*) remote="refs/heads/$remote" ;;
 		esac
 		case "$local" in
 		'') local= ;;
-		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
+		refs/*) ;;
 		heads/* | tags/* | remotes/* ) local="refs/$local" ;;
 		*) local="refs/heads/$local" ;;
 		esac
-- 
1.5.2.rc3.17.ge713
