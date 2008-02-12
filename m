From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix shell quoting in git-bisect
Date: Tue, 12 Feb 2008 21:06:50 +0100
Message-ID: <20080212200650.GA15258@steel.home>
References: <200802122023.28879.elendil@planet.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Tue Feb 12 21:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP1Pe-0008RC-ID
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 21:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYBLUGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 15:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYBLUGy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 15:06:54 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:38667 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbYBLUGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 15:06:54 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcN+Psg==
Received: from tigra.home (Fa946.f.strato-dslnet.de [195.4.169.70])
	by post.webmailer.de (mrclete mo36) (RZmta 16.5)
	with ESMTP id x002bck1CHdrOD ; Tue, 12 Feb 2008 21:06:51 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C3DFD277BD;
	Tue, 12 Feb 2008 21:06:50 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 24F2956D24; Tue, 12 Feb 2008 21:06:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200802122023.28879.elendil@planet.nl>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73686>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Frans Pop, Tue, Feb 12, 2008 20:23:28 +0100:
> During a git bisect session I ended up with the following in the
> .git/BISECT_LOG:
> 
> # bad: [38a382ae5dd4f4d04e3046816b0a41836094e538] Kobject: convert 
> arch/alpha arch/arm arch/avr32 arch/blackfin arch/cris arch/frv arch/h8300 
> ...
> 
> From the following command you can see shat happened: the 'arch/*' from the 
> commit log was expanded in the comment line in the bisect log file.

This should fix it

 git-bisect.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5385249..0bb51d7 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -131,7 +131,7 @@ bisect_write() {
 		*)		die "Bad bisect_write argument: $state" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev"
-	echo "# $state: "$(git show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
+	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
 	test -z "$nolog" && echo "git-bisect $state $rev" >>"$GIT_DIR/BISECT_LOG"
 }
 
-- 
1.5.4.1.112.g94408
