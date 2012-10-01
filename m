From: Josef Assad <josef@josefassad.com>
Subject: [PATCH] more meaningful error message in gitk when git binary is
 not available
Date: Mon, 01 Oct 2012 09:17:20 +0200
Message-ID: <50694380.4090108@josefassad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 09:25:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIaNQ-0004QI-6E
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 09:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab2JAHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 03:25:04 -0400
Received: from li144-85.members.linode.com ([109.74.197.85]:38087 "EHLO
	li144-85.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821Ab2JAHZD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 03:25:03 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Oct 2012 03:25:03 EDT
Received: from [192.168.1.13] (unknown [2.107.83.160])
	by li144-85.members.linode.com (Postfix) with ESMTPA id 0C0BC1CB1E
	for <git@vger.kernel.org>; Mon,  1 Oct 2012 03:17:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206723>

Hi. I ran across what is a decidedly trivial little issue in gitk. The
TCL/Tk looked simple enough so I am giving you a patch anyhow in case
you want to fix it.

When for whatever reason the git binary is unavailable, gitk would
complain about missing git repository instead, so this patch adds a
check for git binary availability.

In case anyone is curious, I found this issue here:

http://stackoverflow.com/q/11967110/53936



Signed-off-by: Josef Assad <josef@josefassad.com>
---
 gitk-git/gitk |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..7e2e0a7 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11680,6 +11680,12 @@ setui $uicolor

 setoptions

+# check that the git executables are available for use
+if [catch {set gitexists [exec which git]}] {
+    show_error {} . [mc "Cannot find a suitable git executable."]
+    exit 1
+}
+
 # check that we can find a .git directory somewhere...
 if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
     show_error {} . [mc "Cannot find a git repository here."]
-- 
1.7.5.4
