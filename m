From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 5/5] git-gui: update shortcut tools to use _gitworktree
Date: Sat, 23 Jan 2010 11:03:38 +0100
Message-ID: <1264241018-6616-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcrC-0000WZ-BE
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab0AWKEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806Ab0AWKEY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:24 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:64393 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab0AWKEN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:13 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so155449fxm.29
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BATEJD03LMyckW8Ixy+ocdQDmbBvW8+qmpcnfICVx48=;
        b=Z34OGsUOltNypUxh9pSJlZ2jH9ZR5dbsyZLdg08RAiyM/U/RdrXOqoWOCBAylj27md
         WpeD+sY/MpIn0B4uiFdUlCxeXCVJvLaMFYgmsQmOKcjCriGYhxbQ0jVyOVOdeqD2rV2U
         pv7HcyPlk+drKWoZUi0UqKTApFP/JMbDH3Tlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FZfHkrNnQd8pqFZNjWS995jY9JIIxCJ9LSsPthRuOy/bsW/UpVv5JyvMjWGgkGSr5R
         VswQhx7U1Dl0I+5jP1T/lnEh/a4l3Pmiq/Zt27sfTSegiCrB0miJsovjQGwgihrudXJS
         COLqFZ1qTKfnsnT1D363ttrJf2GH2jb13+DSw=
Received: by 10.223.75.66 with SMTP id x2mr2320676faj.7.1264241052974;
        Sat, 23 Jan 2010 02:04:12 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 15sm1740183fxm.2.2010.01.23.02.04.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:12 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137831>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/lib/shortcut.tcl |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
index 2f20eb3..79c1888 100644
--- a/git-gui/lib/shortcut.tcl
+++ b/git-gui/lib/shortcut.tcl
@@ -2,6 +2,7 @@
 # Copyright (C) 2006, 2007 Shawn Pearce
 
 proc do_windows_shortcut {} {
+	global _gitworktree
 	set fn [tk_getSaveFile \
 		-parent . \
 		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
@@ -15,7 +16,7 @@ proc do_windows_shortcut {} {
 					[info nameofexecutable] \
 					[file normalize $::argv0] \
 					] \
-					[file dirname [file normalize [gitdir]]]
+					[file normalize [$_gitworktree]]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
@@ -23,7 +24,7 @@ proc do_windows_shortcut {} {
 }
 
 proc do_cygwin_shortcut {} {
-	global argv0
+	global argv0 _gitworktree
 
 	if {[catch {
 		set desktop [exec cygpath \
@@ -56,7 +57,7 @@ proc do_cygwin_shortcut {} {
 					$sh -c \
 					"CHERE_INVOKING=1 source /etc/profile;[sq $me] &" \
 					] \
-					[file dirname [file normalize [gitdir]]]
+					[file normalize [$_gitworktree]]
 			} err]} {
 			error_popup [strcat [mc "Cannot write shortcut:"] "\n\n$err"]
 		}
-- 
1.6.6.rc1.295.g3a4e71
