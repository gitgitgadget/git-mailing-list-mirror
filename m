From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2 8/9] git submodule: infrastructure for reading .gitmodules files in arbitrary locations
Date: Sat, 10 Apr 2010 19:23:49 +0100
Message-ID: <1270923830-11830-9-git-send-email-peter@pcc.me.uk>
References: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Cc: Peter Collingbourne <peter@pcc.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 20:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0fMO-0007O3-Ht
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab0DJSYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:24:16 -0400
Received: from master.pcc.me.uk ([207.192.74.179]:37797 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061Ab0DJSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:23:56 -0400
Received: from lapas.pcc.me.uk ([10.179.130.3])
	by master.pcc.me.uk with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLW-0006qV-1J; Sat, 10 Apr 2010 19:23:54 +0100
Received: from peter by lapas.pcc.me.uk with local (Exim 4.69)
	(envelope-from <peter@pcc.me.uk>)
	id 1O0fLU-00036T-NI; Sat, 10 Apr 2010 19:23:52 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1270923830-11830-1-git-send-email-peter@pcc.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144563>

This patch modifies the module_name function in git-submodule.sh to take
an optional parameter which specifies the path of the .gitmodules
file to read.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
 git-submodule.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f1e4e22..75c50b8 100755
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
