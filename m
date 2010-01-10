From: Dave Dulson <dave@dulson.com>
Subject: [PATCH 1/2] Add tag message
Date: Sun, 10 Jan 2010 22:45:22 +0000
Message-ID: <2ee0b0aa1001101445j10336e89y79cba04327ab9cdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 23:46:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU6Xv-0007VH-EW
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab0AJWpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 17:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754388Ab0AJWp0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 17:45:26 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:48224 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0AJWpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 17:45:23 -0500
Received: by mail-ew0-f214.google.com with SMTP id 6so21251053ewy.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 14:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=9Gt8dtVwWJOLLN4t9DbS5CxIm3L6HT8zVuXji/lzjmA=;
        b=Vcctts5Yof5iTRg3oif6ddU2dSFX6uogMsGewbd1nTjoDYUy2/zxZ1b+1By3hzp5rP
         dbhipJQPxrhWiFBpZwbPELPGDOUOr9ZlC+z4g6vRucoMAQXpvn3Barnp6ktTzI0/pg7V
         dqhwEGWpOzdb1Izm90mU43TbdWAGg/rKvvFnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        b=k9OhVPXI8/i0HpzhIysmgkV1AfQibcy7KMydZ8NEbEKxCmH2PqUpSLj/iySM9qi+Bp
         Z3t7cxMLefgloigh8b05yIEFcQMoSnvUq52NlJr2nnFay/LORmMS0mxeReHsOROx6bLb
         3yBuAroQoK2Yn4av8WLTlS+iwSmbg1cA6jOQU=
Received: by 10.216.91.82 with SMTP id g60mr1561918wef.98.1263163522206; Sun, 
	10 Jan 2010 14:45:22 -0800 (PST)
X-Google-Sender-Auth: f86bcbaf17265526
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136591>

Add tag message support to the dialog and exec call

Signed-off-by: David Dulson <dave@dulson.com>
---
 gitk |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 86dff0f..b34b481 100755
--- a/gitk
+++ b/gitk
@@ -8701,6 +8701,11 @@ proc mktag {} {
     ${NS}::label $top.tlab -text [mc "Tag name:"]
     ${NS}::entry $top.tag -width 60
     grid $top.tlab $top.tag -sticky w
+    ${NS}::label $top.op -text [mc "Tag message is optional"]
+    grid $top.op -columnspan 2 -sticky we
+    ${NS}::label $top.mlab -text [mc "Tag message:"]
+    ${NS}::entry $top.msg -width 60
+    grid $top.mlab $top.msg -sticky w
     ${NS}::frame $top.buts
     ${NS}::button $top.buts.gen -text [mc "Create"] -command mktaggo
     ${NS}::button $top.buts.can -text [mc "Cancel"] -command mktagcan
@@ -8718,6 +8723,7 @@ proc domktag {} {

     set id [$mktagtop.sha1 get]
     set tag [$mktagtop.tag get]
+    set msg [$mktagtop.msg get]
     if {$tag == {}} {
 	error_popup [mc "No tag name specified"] $mktagtop
 	return 0
@@ -8727,7 +8733,11 @@ proc domktag {} {
 	return 0
     }
     if {[catch {
-	exec git tag $tag $id
+        if {$msg != {}} {
+            exec git tag -a -m "$msg" $tag $id
+        } else {
+            exec git tag $tag $id
+        }	
     } err]} {
 	error_popup "[mc "Error creating tag:"] $err" $mktagtop
 	return 0
-- 
1.6.6.75.g37bae.dirty
