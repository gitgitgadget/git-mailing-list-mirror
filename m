From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] gitk: Fix crash with --all in non-English locales
Date: Tue, 20 Oct 2015 14:33:01 +0200
Message-ID: <1445344384-12762-2-git-send-email-tiwai@suse.de>
References: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 14:33:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoW6p-0006b9-BC
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 14:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbbJTMdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 08:33:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:35274 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752398AbbJTMdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 08:33:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C246FACA0;
	Tue, 20 Oct 2015 12:33:16 +0000 (UTC)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1445344384-12762-1-git-send-email-tiwai@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279907>

When gitk is invoked with --all option in a non-English locale, it
crashes like:
$ LC_ALL="de_DE.UTF-8" gitk --all
Error in startup script: bad menu entry index "Ansicht bearbeiten ..."
    while executing
".bar.view entryconf [mca "Edit view..."] -state normal"
    invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
    # create a view for the files/dirs specified on the command line
    se..."
    (file "/usr/bin/gitk" line 12442)

The reason is the leftover strings that don't match any longer with
the new string containing accelerator mark (&).  This patch corrects
these strings.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=951153
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 gitk-git/gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2028b554f487..fcc606eab735 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12452,8 +12452,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewchanged(1) 0
     set vdatemode(1) 0
     addviewmenu 1
-    .bar.view entryconf [mca "Edit view..."] -state normal
-    .bar.view entryconf [mca "Delete view"] -state normal
+    .bar.view entryconf [mca "&Edit view..."] -state normal
+    .bar.view entryconf [mca "&Delete view"] -state normal
 }
 
 if {[info exists permviews]} {
-- 
2.6.1
