From: Matthew Wilcox <matthew@wil.cx>
Subject: New ref generates 8MB mail message
Date: Wed, 18 Jan 2006 07:09:07 -0700
Message-ID: <20060118140907.GV19769@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 18 15:09:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzDzs-00009o-E3
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWAROJI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWAROJI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:09:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:11160 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030314AbWAROJH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 09:09:07 -0500
Received: by palinux.hppa (Postfix, from userid 26919)
	id 99D15494054; Wed, 18 Jan 2006 07:09:07 -0700 (MST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14826>


There's a bit of an unfortunate mistake in the default mail script
that causes making a new ref for Linus' kernel tree to generate an 8MB
mail message.

Based on the idea that a new branch is probably a branch off master, and
if it isn't, then at least sending a log vs master is better than a log
vs the beginning of time, I propose this patch:

diff --git a/templates/hooks--update b/templates/hooks--update
index 6db555f..609b4fe 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -13,7 +13,7 @@ recipient="commit-list@example.com"
 if expr "$2" : '0*$' >/dev/null
 then
 	echo "Created a new ref, with the following commits:"
-	git-rev-list --pretty "$3"
+	git-rev-list --pretty "$3" ^master
 else
 	base=$(git-merge-base "$2" "$3")
 	case "$base" in
