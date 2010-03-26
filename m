From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH 11/12] git submodule: infrastructure for reading .gitmodules files in arbitrary locations
Date: Fri, 26 Mar 2010 15:25:39 +0000
Message-ID: <1269617140-7827-12-git-send-email-peter@pcc.me.uk>
References: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 16:27:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvBRB-0006Hb-K8
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 16:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab0CZP03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 11:26:29 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:55551 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0CZPZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 11:25:58 -0400
Received: from [10.179.145.9] (helo=lapas.pcc.me.uk)
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ3-0001oC-2o; Fri, 26 Mar 2010 15:25:55 +0000
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1NvBQ1-00023Y-LH; Fri, 26 Mar 2010 15:25:53 +0000
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1269617140-7827-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143249>

This patch modifies the module_name function in git-submodule.sh to take
an optional parameter which specifies the path of the .gitmodules
file to read.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-submodule.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d0b7a79..3fd067a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -64,12 +64,18 @@ module_list()
 # Map submodule path to submodule name
 #
 # $1 = path
+# $2 = .gitmodules file, default ".gitmodules"
 #
 module_name()
 {
+	modfile="$2"
+	if test -z "$modfile"
+	then
+		modfile=".gitmodules"
+	fi
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
 	re=$(printf '%s\n' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
-	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
+	name=$( git config -f "$modfile" --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
        die "No submodule mapping found in .gitmodules for path '$path'"
-- 
1.6.5
