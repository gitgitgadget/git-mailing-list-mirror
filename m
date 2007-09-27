From: Dan Nicholson <dbn.lists@gmail.com>
Subject: [PATCH] quiltimport: Skip non-existent patches
Date: Thu, 27 Sep 2007 13:30:59 -0700
Message-ID: <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
Cc: git@vger.kernel.org
To: Geert.Uytterhoeven@sonycom.com
X-From: git-owner@vger.kernel.org Thu Sep 27 22:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib00u-00084p-A9
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 22:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbXI0UbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 16:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbXI0UbD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 16:31:03 -0400
Received: from sccrmhc11.comcast.net ([63.240.77.81]:52088 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbXI0UbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 16:31:01 -0400
Received: from tilt.dwcab.com ([24.19.23.110])
          by comcast.net (sccrmhc11) with ESMTP
          id <2007092720305901100kf3ffe>; Thu, 27 Sep 2007 20:31:00 +0000
Received: by tilt.dwcab.com (Postfix, from userid 1000)
	id 948CA14AD5A; Thu, 27 Sep 2007 13:30:59 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.2
In-Reply-To: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59329>

When quiltimport encounters a non-existent patch in the series file,
just skip to the next patch. This matches the behavior of quilt.

Signed-off-by: Dan Nicholson <dbn.lists@gmail.com>
---
 git-quiltimport.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 74a54d5..880c81d 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -71,6 +71,10 @@ commit=$(git rev-parse HEAD)
 
 mkdir $tmp_dir || exit 2
 for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
+	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
+		echo "$patch_name doesn't exist. Skipping."
+		continue
+	fi
 	echo $patch_name
 	git mailinfo "$tmp_msg" "$tmp_patch" \
 		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
-- 
1.5.3.2
