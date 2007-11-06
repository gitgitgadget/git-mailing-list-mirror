From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 2/5] Fix sed script to work with AIX sed.
Date: Tue, 6 Nov 2007 21:17:37 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071106201737.GC6361@ins.uni-bonn.de>
References: <20071106201518.GA6361@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 21:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUs5-0001yJ-0e
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbXKFURk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755263AbXKFURk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:17:40 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:57090 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbXKFURk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:17:40 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id DC0FA4000269A
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 21:17:38 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071106201518.GA6361@ins.uni-bonn.de>
User-Agent: Mutt/1.5.17 (2007-11-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63716>

\n is not portable in a s/// replacement string, only
in the regex part.  backslash-newline helps.
---
 git-bisect.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b74f44d..1ed44e5 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -275,7 +275,8 @@ exit_if_skipped_commits () {
 	if expr "$_tried" : ".*[|].*" > /dev/null ; then
 		echo "There are only 'skip'ped commit left to test."
 		echo "The first bad commit could be any of:"
-		echo "$_tried" | sed -e 's/[|]/\n/g'
+		echo "$_tried" | sed -e 's/[|]/\
+/g'
 		echo "We cannot bisect more!"
 		exit 2
 	fi
-- 
1.5.3.5.561.g140d
