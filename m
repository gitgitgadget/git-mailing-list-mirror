From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] git-submodule: Error messages from 'git describe' shouldn't end up on the terminal
Date: Wed, 25 Jul 2007 09:21:51 -0500
Message-ID: <11853733111502-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 16:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDhpz-0003HV-5D
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 16:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763500AbXGYO1c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 10:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762975AbXGYO1b
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 10:27:31 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:49543 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762303AbXGYO1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 10:27:30 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id l6PERS89012066
	for <git@vger.kernel.org>; Wed, 25 Jul 2007 07:27:28 -0700 (MST)
Received: from localhost.localdomain ([10.82.124.180])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6PERRfY008214;
	Wed, 25 Jul 2007 09:27:27 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc2.38.g11308-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53695>

As of now a failure to locate the closest tag to a commit (e.g because there is
no tag in the repository) is handled explicitly by displaying an 'undefined' tag
error message. However when git describe fails it will still display an
undesirable  "fatal: cannot describe SHA1" message. This patch hides that
message as git-submodule has an alternative and explicit error handling method
in place for this situation

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1f0cb99..3804f18 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -233,7 +233,7 @@ modules_list()
 			say "-$sha1 $path"
 			continue;
 		fi
-		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1)
+		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1 2>/dev/null)
 		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
-- 
1.5.3.rc2.38.g11308-dirty
