From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) v2] gitk: Make line origin search update the busy status.
Date: Mon, 1 Dec 2008 20:30:09 +0300
Organization: HOME
Message-ID: <200812012030.09114.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Cdt-0001I1-9Q
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYLARbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbYLARbf
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:31:35 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:21347 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYLARbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:31:35 -0500
Received: by gv-out-0910.google.com with SMTP id e6so391435gvc.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bUCUTKB5pcZjJllg2wWn6YZoyidF6k+pa+fmoYifzSo=;
        b=vEFPfdWE3hIS1R5bEgXpBc5lIv7hvsCxRQwZVuES9TGfMh1F4FjoQgPHexk0kUq0V/
         EEUSSpzlpGnfex1hSRm+lFOBZKb/0SwM7uOcYxpiEeJWx/Oi8mjuHaN9Su2XA9etmX0M
         WXCI/kTSb4eLSAge+p0QHpeawxx/9TezzpomQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=VHu8rOTAmvzMMZY3HC7Uj3GeOOOrq4mXABeQRX5qGaCKeEFJiupCtY9l6LYswBNiDD
         zhAVjKlXRtwaxkUmWAqdlkFMN6Fz/7p0y4veS7zVC36mA+93pFxbKy69tUbi2s6eUFSF
         JqTNqdeGIm5rx0kSJtwVf5EqE/rqRc0+7YIlI=
Received: by 10.86.72.15 with SMTP id u15mr6522873fga.45.1228152692873;
        Mon, 01 Dec 2008 09:31:32 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id l12sm1230143fgb.55.2008.12.01.09.31.31
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 09:31:32 -0800 (PST)
User-Agent: KMail/1.10.3 (Linux/2.6.27.5-123.fc10.i686; KDE/4.1.3; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102068>

Currently the 'show origin of this line' feature does
not update the status field of the gitk window, so it
is not evident that any processing is going on. It may
seem at first that clicking the item had no effect.

This commit adds calls to set and clear the busy
status with an appropriate title, similar to other
search commands.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I changed the visible message to Searching.

	I think that this is something of a usability bug, so this
	probably should still go in 1.6.1.

	Alexander

 gitk |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 6eaeadf..076f036 100755
--- a/gitk
+++ b/gitk
@@ -3407,6 +3407,7 @@ proc show_line_source {} {
 	error_popup [mc "Couldn't start git blame: %s" $err]
 	return
     }
+    nowbusy blaming [mc "Searching"]
     fconfigure $f -blocking 0
     set i [reg_instance $f]
     set blamestuff($i) {}
@@ -3420,6 +3421,7 @@ proc stopblaming {} {
     if {[info exists blameinst]} {
 	stop_instance $blameinst
 	unset blameinst
+	notbusy blaming
     }
 }
 
@@ -3434,6 +3436,7 @@ proc read_line_source {fd inst} {
     }
     unset commfd($inst)
     unset blameinst
+    notbusy blaming
     fconfigure $fd -blocking 1
     if {[catch {close $fd} err]} {
 	error_popup [mc "Error running git blame: %s" $err]
-- 
1.6.0.4.30.gf4240
