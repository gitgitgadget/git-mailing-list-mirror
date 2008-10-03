From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Associate 'git gui clone' with the git:// protocol
Date: Fri, 3 Oct 2008 14:19:08 +0200
Message-ID: <20081003121908.GD10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Oct 03 14:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KljfB-0006Tx-Iy
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbYJCMTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbYJCMTL
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:19:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38200 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793AbYJCMTK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:19:10 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C845C3939B47; Fri,  3 Oct 2008 14:19:08 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97419>

This MSysGit patch makes the installer register 'git gui clone'
as the Git URL protocol handler. This depends on the 'git gui clone'
functionality itself, of course - currently in the process of getting
accepted upstream (hopefully).

Signed-off-by: Petr Baudis <petr.baudis@novartis.com>

---

Sorry if the line offsets are a bit off.

diff --git a/share/WinGit/install.iss b/share/WinGit/install.iss
index 05fdae6..82e8ecf 100644
--- a/share/WinGit/install.iss
+++ b/share/WinGit/install.iss
@@ -484,6 +484,16 @@ begin
             // so we continue.
         end;
     end;
+
+    if (not RegWriteStringValue(HKEY_CLASSES_ROOT,'git','','URL:Git Protocol'))
+    or (not RegWriteStringValue(HKEY_CLASSES_ROOT,'git','URL Protocol',''))
+    or (not RegWriteStringValue(HKEY_CLASSES_ROOT,'git\shell\open\command','','"'+AppDir+'\bin\wish.exe" "'+AppDir+'\bin\git-gui" "clone" "%1"')) then begin
+        Msg:='Line {#emit __LINE__}: Unable to set up the "git://" URL protocol handler.';
+        MsgBox(Msg,mbError,MB_OK);
+        Log(Msg);
+        // This is not a critical error, the user can probably fix it manually,
+        // so we continue.
+    end;
 end;
 
 {
