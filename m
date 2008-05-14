From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Updating documentation to match Brandon Casey's proposed git-repack patch.
Date: Wed, 14 May 2008 03:25:14 -0400
Message-ID: <20080514072514.GA26202@foursquare.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 09:26:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwBNk-0003B9-Nh
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 09:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYENHZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 03:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbYENHZd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 03:25:33 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:38136 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYENHZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 03:25:32 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4E7PE8g029837;
	Wed, 14 May 2008 03:25:14 -0400
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82081>

I haven't heard any negative commentary on this patch, and I see
the repack patch is in next, so resending in case it was missed.

This patch clarifies the git-prune man page, documenting that it only
prunes unpacked objects.  git-repack is documented according to
the new git-repack -A behaviour, which does not depend on
git-pack-objects --keep-unreachable anymore.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---
 Documentation/git-prune.txt  |    5 ++++-
 Documentation/git-repack.txt |   14 +++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f92bb8c..3178bc4 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -18,12 +18,15 @@ git-prune. See the section "NOTES", below.
 
 This runs `git-fsck --unreachable` using all the refs
 available in `$GIT_DIR/refs`, optionally with additional set of
-objects specified on the command line, and prunes all
+objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
 running `git prune-packed`.
 
+Note that unreachable, packed objects will remain.  If this is
+not desired, see linkgit:git-repack[1].
+
 OPTIONS
 -------
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 3d95749..906d3c7 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git-repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,18 @@ OPTIONS
 	leaves behind, but `git fsck --full` shows as
 	dangling.
 
+-A::
+	Same as `-a`, but any unreachable objects in a previous
+	pack become loose, unpacked objects, instead of being
+	left in the old pack.  Unreachable objects are never
+	intentionally added to a pack, even when repacking.
+	When used with '-d', this option
+	prevents unreachable objects from being immediately
+	deleted by way of being left in the old pack and then
+	removed.  Instead, the loose unreachable objects
+	will be pruned according to normal expiry rules
+	with the next linkgit:git-gc[1].
+
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
-- 
1.5.4.4
