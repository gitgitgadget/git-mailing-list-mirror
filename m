From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: [PATCH] git-gui: Add shortcut keys for Show More/Less Context
Date: Fri, 28 Mar 2008 13:22:47 +0000
Message-ID: <57518fd10803280622v3a5f6ae8lcfd35270ab9ede1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEeF-0008IA-9M
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYC1N2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYC1N2x
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:28:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:39203 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbYC1N2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:28:52 -0400
Received: by wr-out-0506.google.com with SMTP id c48so171972wra.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=PssSJ3BWE2OgH1Zb1JN707lPC1tizhiMeCT4KfLhs4s=;
        b=JXMRDBiOFLuKsxZGmPzBsbormgCufztHW9b/UYeX5f7LDY0kutsZER3HhIC1g68gYcziE+etNacJA0mEWJg77WaxGFji+DTmZQ9LoNh82ut3kjMBcHjk3Jo2SCEsODPhgh4OWdMVbvOKKQQMLnHHYu6gP0WLER+dfTzToDVsUPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=lx2SfdH9GI9WX7/PW8GBVuXGkAfsUaam+WDQVTrbW5fdYOaLSVERkvv5a1vcF9SlL/kLAkzSGsJDHI8tcW0l1Ey8wLWhC1cJVRnOCIzfCoLAY/HQzh8QegWcsBy5yP0eVqdPsvIzWFtzKK9ZsBV1M2DoQKS+DHhM0nWb6wOwEd8=
Received: by 10.141.142.15 with SMTP id u15mr235599rvn.66.1206710567663;
        Fri, 28 Mar 2008 06:22:47 -0700 (PDT)
Received: by 10.141.86.15 with HTTP; Fri, 28 Mar 2008 06:22:47 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 91fd9f4e7c91e72b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78407>

Bound to Ctrl/Cmd (depending on your platform) + left & right square brackets.
---

I'm not at all familiar with Tcl, so I apologise in advance for any
wrongness.  I frequently find myself repeatedly right-clicking->Show
Less Context in order to stage a specific hunk, seems like a shortcut
for this would be useful.  Thoughts?

 git-gui/git-gui.sh |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 5e97fbf..c476753 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1845,7 +1845,21 @@ proc add_range_to_selection {w x y} {
 	}
 	$w tag add in_sel $begin.0 [expr {$end + 1}].0
 }
+proc show_more_context {} {
+	global repo_config
+	if {$repo_config(gui.diffcontext) < 99} {
+		incr repo_config(gui.diffcontext)
+		reshow_diff
+	}
+}

+proc show_less_context {} {
+	global repo_config
+	if {$repo_config(gui.diffcontext) >= 1} {
+		incr repo_config(gui.diffcontext) -1
+		reshow_diff
+	}
+}
 ######################################################################
 ##
 ## ui construction
@@ -2593,17 +2607,11 @@ lappend diff_actions [list $ctxm entryconf
$ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
 	-label [mc "Show Less Context"] \
-	-command {if {$repo_config(gui.diffcontext) >= 1} {
-		incr repo_config(gui.diffcontext) -1
-		reshow_diff
-	}}
+	-command show_less_context
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
 	-label [mc "Show More Context"] \
-	-command {if {$repo_config(gui.diffcontext) < 99} {
-		incr repo_config(gui.diffcontext)
-		reshow_diff
-	}}
+	-command show_more_context
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
@@ -2695,6 +2703,8 @@ bind $ui_comm <$M1B-Key-v> {tk_textPaste %W; %W
see insert; break}
 bind $ui_comm <$M1B-Key-V> {tk_textPaste %W; %W see insert; break}
 bind $ui_comm <$M1B-Key-a> {%W tag add sel 0.0 end;break}
 bind $ui_comm <$M1B-Key-A> {%W tag add sel 0.0 end;break}
+bind $ui_comm <$M1B-Key-\[> {show_less_context;break}
+bind $ui_comm <$M1B-Key-\]> {show_more_context;break}

 bind $ui_diff <$M1B-Key-x> {tk_textCopy %W;break}
 bind $ui_diff <$M1B-Key-X> {tk_textCopy %W;break}
-- 
1.5.4.3.450.gb92176.dirty
