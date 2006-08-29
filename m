From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] Check if pack directory exists prior to descending into it
Date: Tue, 29 Aug 2006 11:12:14 +0200
Message-ID: <20060829091214.GA10155@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Tue Aug 29 11:12:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHze3-00031m-MS
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 11:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWH2JM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 05:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWH2JM2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 05:12:28 -0400
Received: from mail11.bluewin.ch ([195.186.18.61]:33254 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S932202AbWH2JM1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 05:12:27 -0400
Received: from spinlock.ch (83.79.21.244) by mail11.bluewin.ch (Bluewin 7.3.116)
        id 44E1C5080036C8FD; Tue, 29 Aug 2006 09:12:22 +0000
Received: (nullmailer pid 10289 invoked by uid 1000);
	Tue, 29 Aug 2006 09:12:14 -0000
To: junkio@cox.net, git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.18-rc4 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26197>

This fixes the following warning:

git-repack: line 42: cd: .git/objects/pack: No such file or directory

This happens only, when git-repack -a is run without any packs in the
repository.

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 git-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 9da92fb..584a732 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -38,7 +38,7 @@ case ",$all_into_one," in
 	pack_objects=
 
 	# Redundancy check in all-into-one case is trivial.
-	existing=`cd "$PACKDIR" && \
+	existing=`test -d "$PACKDIR" && cd "$PACKDIR" && \
 	    find . -type f \( -name '*.pack' -o -name '*.idx' \) -print`
 	;;
 esac
-- 
1.4.2.g2f76
