From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 2/3] Fix sed script to work with AIX and BSD sed.
Date: Thu, 8 Nov 2007 22:48:24 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071108214824.GH31439@ins.uni-bonn.de>
References: <20071108214624.GF31439@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 22:48:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFEv-0002eI-Rs
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761633AbXKHVs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761629AbXKHVs1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:48:27 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60623 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761648AbXKHVs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:48:26 -0500
Received: from localhost.localdomain (xdsl-87-78-163-133.netcologne.de [87.78.163.133])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 1E941400002BA
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 22:48:25 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IqFEe-00058u-Lr
	for git@vger.kernel.org; Thu, 08 Nov 2007 22:48:24 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071108214624.GF31439@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64077>

\n is not portable in a s/// replacement string, only
in the regex part.  backslash-newline helps.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
I'm a bit unsure whether you would prefer to avoid breaking the
indentation with something like
  tr '|' '\n'

OTOH, \n in a tr set is not universally portable either (for example
Solaris /usr/ucb/tr mishandles it, and \012 fails on EBCDIC), but
I'm still on my way of finding out the level of portability you
prefer.  ;-)

Cheers,
Ralf

 git-bisect.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index c18bd32..3aac816 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -276,7 +276,8 @@ exit_if_skipped_commits () {
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
