From: Johan Herland <johan@herland.net>
Subject: [PATCH] Fix submodule sync with relative submodule URLs
Date: Mon, 22 Sep 2008 18:08:31 +0200
Message-ID: <200809221808.31730.johan@herland.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 18:11:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kho0G-0000TD-FW
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbYIVQKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 12:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbYIVQKD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 12:10:03 -0400
Received: from sam.opera.com ([213.236.208.81]:47635 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbYIVQKB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 12:10:01 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m8MG8Vxm030406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Sep 2008 16:08:37 GMT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96493>

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-submodule.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1c39b59..92be0fe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -634,6 +634,14 @@ cmd_sync()
 	do
 		name=$(module_name "$path")
 		url=$(git config -f .gitmodules --get submodule."$name".url)
+
+		# Possibly a url relative to parent
+		case "$url" in
+		./*|../*)
+			url=$(resolve_relative_url "$url") || exit
+			;;
+		esac
+
 		if test -e "$path"/.git
 		then
 		(
-- 
1.6.0.1.400.gd2470
