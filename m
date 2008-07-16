From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] Fix pre-commit hooks under MinGW/MSYS
Date: Thu, 17 Jul 2008 00:12:28 +0400
Organization: TEPKOM
Message-ID: <200807170012.28769.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDNZ-0001VM-BE
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754955AbYGPUMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754889AbYGPUMi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:12:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:53878 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbYGPUMh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:12:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2502208fgg.17
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-disposition:from
         :organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=MrBaJaSoxH6jED2oypZK6oMrhAecvARFT96Vl7At0/M=;
        b=CczvQGlQ2mPEx1/egwB1KvH4+/skynLDZo0a85SFO3GgR0T03M0uSblK7Kvg0C/oqZ
         wMN+jKLi/sQEW/4AF29XNPSKQvpKHB8Gn39hmsSmXKAysdD+HkCU0GeI+Xq7jC8aaVHT
         IWhdZ2O6eTHrw4R5Szw7AnvqZEmkZdob+PhJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-disposition:from:organization:to:subject:date:user-agent:cc
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=WXT2TCLIdeijEARIR17XyLulNc5Msf3qOTwtC4jUG9LPlJK+9DaeYXTv72vpP1UnsW
         tfe8/lsgl8o799qF/6dNDnDHtZKFzmDa7SqRMD9ZxzwFqwmFpgbPXi+9SnM1+GtnkqWX
         Qco+7SCaZujIc07yZnrEcCMg1v+0YJbGgFyT0=
Received: by 10.86.28.2 with SMTP id b2mr2669185fgb.20.1216239156138;
        Wed, 16 Jul 2008 13:12:36 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm1985034fgb.7.2008.07.16.13.12.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 13:12:35 -0700 (PDT)
Content-Disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88738>

Apply the work-around for checking the executable
permission of hook files not only on Cygwin, but on
Windows in general.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
	This is a fix for msysgit issue #118.
	(http://code.google.com/p/msysgit/issues/detail?id=118)

	I've already sent this patch, but resend it as I haven't received any reply,
	and it is not in git-gui.git yet.

	-- Alexander

 git-gui.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e6e8890..2d14bf2 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -473,10 +473,10 @@ proc githook_read {hook_name args} {
 	set pchook [gitdir hooks $hook_name]
 	lappend args 2>@1
 
-	# On Cygwin [file executable] might lie so we need to ask
+	# On Windows [file executable] might lie so we need to ask
 	# the shell if the hook is executable.  Yes that's annoying.
 	#
-	if {[is_Cygwin]} {
+	if {[is_Windows]} {
 		upvar #0 _sh interp
 		if {![info exists interp]} {
 			set interp [_which sh]
-- 
1.5.3.3
