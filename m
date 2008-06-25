From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] repack.usedeltabaseoffset config option now defaults to "true"
Date: Wed, 25 Jun 2008 00:24:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806250023500.2979@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMaL-0007Hi-LL
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbYFYEYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbYFYEYz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:24:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49409 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYFYEYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:24:54 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K3000E5Z49H9OG0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Jun 2008 00:24:53 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86217>


As announced for 1.6.0.

Access over the native protocol by old git versions is unaffected as
this capability is negociated by the protocol.  Otherwise setting this
config option to "false" and doing a 'git repack -a -d' is enough to
remain compatible with ancient git versions (older than 1.4.4).

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/config.txt |   10 +++++++---
 git-repack.sh            |    6 +-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1e09a57..c7fbc63 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -996,9 +996,13 @@ remotes.<group>::
 	<group>".  See linkgit:git-remote[1].
 
 repack.usedeltabaseoffset::
-	Allow linkgit:git-repack[1] to create packs that uses
-	delta-base offset.  Defaults to false.
-
+	By default, linkgit:git-repack[1] creates packs that use
+	delta-base offset. If you need to share your repository with
+	git older than version 1.4.4, either directly or via a dumb
+	protocol such as http, then you need to set this option to
+	"false" and repack. Access from old git versions over the
+	native protocol are unaffected by this option.
+	 
 show.difftree::
 	The default linkgit:git-diff-tree[1] arguments to be used
 	for linkgit:git-show[1].
diff --git a/git-repack.sh b/git-repack.sh
index 072d1b4..8c3bc13 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -44,11 +44,7 @@ do
 	shift
 done
 
-# Later we will default repack.UseDeltaBaseOffset to true
-default_dbo=false
-
-case "`git config --bool repack.usedeltabaseoffset ||
-       echo $default_dbo`" in
+case "`git config --bool repack.usedeltabaseoffset || echo true`" in
 true)
 	extra="$extra --delta-base-offset" ;;
 esac
-- 
1.5.6.56.g29b0d
