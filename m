From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2 1/2] gitk: Refactor code for binding modified function keys
Date: Tue,  2 Oct 2012 11:04:44 -0400
Message-ID: <1349190285-7788-2-git-send-email-andrew.kw.w@gmail.com>
References: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
 <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Cc: gitster@pobox.com, szeder@ira.uka.de, paulus@samba.org,
	Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 17:05:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ425-0006xZ-Ai
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 17:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424Ab2JBPE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 11:04:57 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64255 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2JBPEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 11:04:55 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so14848778iea.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zHXDHfTAw2efHMSgr98r7GHsQqOCx7IKCP0uO18cLGM=;
        b=CEk/jsUE4rm4RHJRfgSjklNIIqnufCLvIq0/bBCLLAFeSugpbfDWcEXYXiWUPxlYPg
         972C/x/LFGjJ5oiVBFy8x3kQyRmKFi+/686Q4r3L4BCesBY6o+WzB6XNCD2T7YGOFoPR
         VBlYl0o/V5Ph8gm9O1a60+Q223X7UhgeCZ7i+eSmwqhk7Szjdn5r7Yu5jFoMSWd3bQTI
         rYxJtQp9ePXrxT6+ZznmLfnDntMOR/CsiaOqLNZC/Iwfto4bbSjI7jAfl82gWEjmYRGv
         jvARXjtMKhMWlLeRwKhWsDIDZYUiWNvSUxu7elxov0fak01vTtEGsG3XoUkjVPTWgD0p
         HdDA==
Received: by 10.50.158.201 with SMTP id ww9mr9290400igb.22.1349190295627;
        Tue, 02 Oct 2012 08:04:55 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id t4sm8973635igt.1.2012.10.02.08.04.53
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 08:04:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349190285-7788-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206802>

The function includes a workaround for systems where F* keys are mapped
to XF86_Switch_VT_* when modifiers are used.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 gitk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 379582a..f8f89a5 100755
--- a/gitk
+++ b/gitk
@@ -2503,8 +2503,7 @@ proc makewindow {} {
     bind . <F5> updatecommits
     bind . <Shift-F5> reloadcommits
     bind . <F2> showrefs
-    bind . <Shift-F4> {newview 0}
-    catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }
+    bindmodfunctionkey Shift 4 {newview 0}
     bind . <F4> edit_or_newview
     bind . <$M1B-q> doquit
     bind . <$M1B-f> {dofind 1 1}
@@ -2653,6 +2652,11 @@ proc bindkey {ev script} {
     }
 }
 
+proc bindmodfunctionkey {mod n script} {
+    bind . <$mod-F$n> $script
+    catch { bind . <$mod-XF86_Switch_VT_$n> $script }
+}
+
 # set the focus back to the toplevel for any click outside
 # the entry widgets
 proc click {w} {
-- 
1.7.12.1.382.gb0576a6
