From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH][RESEND] guilt: add option guilt.diffstat
Date: Thu, 18 Dec 2008 19:26:43 +0800
Message-ID: <20081218112643.GA15416@localhost>
References: <20081213021422.GA28249@localhost> <20081213044357.GD15407@josefsipek.net> <20081213131700.GA8649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Boyd Stephen Smith Jr." <bss03@volumehost.net>
To: Josef Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 12:28:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDH3f-0005ZC-Bv
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 12:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYLRL1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 06:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYLRL1L
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 06:27:11 -0500
Received: from mga03.intel.com ([143.182.124.21]:10206 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbYLRL1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 06:27:09 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 18 Dec 2008 03:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,242,1228118400"; 
   d="scan'208";a="91606436"
Received: from unknown (HELO localhost) ([10.254.153.195])
  by azsmga001.ch.intel.com with ESMTP; 18 Dec 2008 03:26:57 -0800
Received: from wfg by localhost with local (Exim 4.69)
	(envelope-from <fengguang.wu@intel.com>)
	id 1LDH1f-00048K-Qw; Thu, 18 Dec 2008 19:26:43 +0800
Content-Disposition: inline
In-Reply-To: <20081213131700.GA8649@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103453>

Introduce option guilt.diffstat so that we don't have to type
"guilt refresh --diffstat" in its full form every time.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---

Jeff: This patch is against the latest guilt v0.32-rc1.

 Documentation/guilt-refresh.txt |   10 ++++++++--
 guilt                           |    9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

--- guilt.orig/guilt
+++ guilt/guilt
@@ -646,7 +646,7 @@ __refresh_patch()
 
 		[ ! -z "$4" ] && diffopts="-C -M --find-copies-harder"
 		
-		if [ ! -z "$5" ]; then
+		if [ -n "$5" -o $diffstat = "true" ]; then
 			(
 				echo "---"
 				git diff --stat $diffopts "$2"
@@ -737,10 +737,17 @@ guilt_hook()
 # used for: git apply -C <val>
 guilt_push_diff_context=1
 
+# default diffstat value: true or false
+DIFFSTAT_DEFAULT="false"
+
 #
 # Parse any part of .git/config that belongs to us
 #
 
+# generate diffstat?
+diffstat=`git config --bool guilt.diffstat`
+[ -z "$diffstat" ] && diffstat=$DIFFSTAT_DEFAULT
+
 #
 # The following gets run every time this file is source'd
 #
--- guilt.orig/Documentation/guilt-refresh.txt
+++ guilt/Documentation/guilt-refresh.txt
@@ -20,8 +20,14 @@ OPTIONS
 	format (e.g., rename and copy detection).
 
 --diffstat::
-	Include a diffstat output in the patch file. Useful for cases where
-	patches will be submitted with other tools.
+Include a diffstat output in the patch file. Useful for cases where
+patches will be submitted with other tools.
++
+If the command line option is omitted, the corresponding git-config
+option "guilt.diffstat" will be queried. So this would enable diffstat
+output by default:
+
+	git config --global guilt.diffstat true
 
 Author
 ------
