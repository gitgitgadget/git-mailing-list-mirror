From: Gisle Aas <gisle@aas.no>
Subject: [PATCH] Force gitk as the forground process when it starts up on Mac 
	OS X
Date: Mon, 2 Feb 2009 14:36:46 +0100
Message-ID: <b48ea8a00902020536t1baea7fbw4fbf27f235024639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 14:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTz0B-0002Rh-3u
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 14:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbZBBNgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 08:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbZBBNgt
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 08:36:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:15444 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZBBNgs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 08:36:48 -0500
Received: by fg-out-1718.google.com with SMTP id 16so587651fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7kbhHPicwuPLnoU41m704DM3a6hlQqDWl3emS7qtJEo=;
        b=Jhyt1CvMfe6oT8CGBkACHj/84+sKjWbnskV7qtwxCT7pluq7t0CmlaYpsynyW4EPqm
         HGvaxNk8xSOg+4rrI4xNU7xBrGlSHCMCgIF+Kw2sM5f3ZMl4V0BKnvWSmYeoD6+jFB+d
         UjdJhD5+bayk5lOA8H1t3lheYKZc8DsBGvLAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=DR1il0WClRQg3OGnxj3404tsdUckwDxn3jZlFcKSlHMzjiK4zGyV6W6SSp/+5XkCpf
         p+wGz6aP/kAB7T8dpnudsAi4fZH1G7dk0nQgURqprwHZfLKVZupWi4orkzz6r3tQF/1y
         I1gghmyaKET3f+LeXcBlfeBi7ywe48KIAcsrk=
Received: by 10.86.91.3 with SMTP id o3mr1210845fgb.35.1233581806946; Mon, 02 
	Feb 2009 05:36:46 -0800 (PST)
X-Google-Sender-Auth: 3b8fd7ec46079288
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108086>

It annoys me that gitk always start out in the background on Mac OS X.
 This patch fixes this for those that have the tclCarbonProcess
package installed.  Unfortunately that package is not shipped by
default from Apple, but it's part of ActiveTcl.

--Gisle


>From 272c7f9b6a2bcdf48e4141b9dc5af445fa69a27b Mon Sep 17 00:00:00 2001
From: Gisle Aas <gisle@aas.no>
Date: Mon, 2 Feb 2009 14:27:20 +0100
Subject: [PATCH] Force gitk as the forground process when it starts up
on Mac OS X

Signed-off-by: Gisle Aas <gisle@aas.no>
---
 gitk-git/gitk |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index dc2a439..e0c11f7 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10918,5 +10918,11 @@ if {[info exists permviews]} {
 if {[tk windowingsystem] eq "win32"} {
     focus -force .
 }
+if {[tk windowingsystem] eq "aqua"} {
+    catch {
+        package require tclCarbonProcesses
+        carbon::setFrontProcess [carbon::getCurrentProcess]
+    }
+}

 getcommits {}
-- 
1.6.1.28.gc32f76
