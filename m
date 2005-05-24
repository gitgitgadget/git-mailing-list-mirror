From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] adjust git-deltafy-script to the new diff-tree output format
Date: Mon, 23 May 2005 21:58:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505232122390.16151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaOf8-00008E-Vz
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVEXB6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVEXB6P
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:58:15 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14239 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261302AbVEXB6C
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 21:58:02 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR010.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGZ00DZ11GOLE@VL-MO-MR010.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 May 2005 21:58:00 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Also prevent 'sort' from sorting on the sha1 which was screwing the 
history listing.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/git-deltafy-script b/git-deltafy-script
--- a/git-deltafy-script
+++ b/git-deltafy-script
@@ -23,8 +23,9 @@ curr_file=""
 
 git-rev-list HEAD |
 git-diff-tree -r --stdin |
-sed -n '/^\*/ s/^.*->\(.\{41\}\)\(.*\)$/\2 \1/p' | sort | uniq |
-while read file sha1; do
+awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6 }' |
+LC_ALL=C sort -s -k 2 | uniq |
+while read sha1 file; do
 	if [ "$file" == "$curr_file" ]; then
 		list="$list $sha1"
 	else
