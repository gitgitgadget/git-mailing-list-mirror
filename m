From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH 3/3] Fix sed string regex escaping in module_name.
Date: Thu, 8 Nov 2007 22:48:49 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071108214849.GI31439@ins.uni-bonn.de>
References: <20071108214624.GF31439@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 22:49:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqFG1-0002zG-IT
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761153AbXKHVsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761265AbXKHVsv
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:48:51 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:60654 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761132AbXKHVsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:48:51 -0500
Received: from localhost.localdomain (xdsl-87-78-163-133.netcologne.de [87.78.163.133])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 0FF93400000BC
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 22:48:50 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1IqFF3-000591-IB
	for git@vger.kernel.org; Thu, 08 Nov 2007 22:48:49 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071108214624.GF31439@ins.uni-bonn.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64078>

When escaping a string to be used as a sed regex, it is important
to only escape active characters.  Escaping other characters is
undefined according to POSIX, and in practice leads to issues with
extensions such as GNU sed's \+.

Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c656be..82ac28f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -74,7 +74,7 @@ resolve_relative_url ()
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	re=$(printf '%s' "$1" | sed -e 's/\([^a-zA-Z0-9_]\)/\\\1/g')
+	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( GIT_CONFIG=.gitmodules \
 		git config --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
-- 
1.5.3.5.561.g140d
