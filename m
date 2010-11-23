From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: fix browser with initial path
Date: Tue, 23 Nov 2010 08:37:50 +0100
Message-ID: <1290497870-28673-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 08:38:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKnSH-0001VV-66
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 08:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752477Ab0KWHiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 02:38:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59612 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323Ab0KWHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 02:38:13 -0500
Received: by eye27 with SMTP id 27so4486667eye.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 23:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ToRT7aGy4ozXrS2sVYdZBN69n+BW6sP0i1fZegwsTls=;
        b=izxrbwq7klftYWEr7pGE0+bsavDnYDYtC4uMhz1fhbZXdjrFwpqx8g4Tx0ra0C0Ooj
         RieoEf0GztBkFBc77bWIQPbYZ0DR1k2z7FU2fSOEq9yDwV88vo1mAFMvOZN9cKDRoOwI
         ysDGE9/eoQDfLveadZWz+LNnwnhHIBa2aOAQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HN8zhC+KbzjPwqfoRmZvlKGlxg5A9jlgzyb7vHThPY33Fv3FEjNh3kv/9C3OdcT3j8
         JMP/Ow+MggRerJwA7KtmMBt+nPHZW6k7fd7jy6+S5jw2sgJSxRRRpHwowg2o+Fy1fnD0
         UfNDLBf0sQHve2USODr9uieITC4ph0t8CfXfA=
Received: by 10.213.26.13 with SMTP id b13mr2411083ebc.90.1290497891885;
        Mon, 22 Nov 2010 23:38:11 -0800 (PST)
Received: from localhost ([188.46.72.74])
        by mx.google.com with ESMTPS id v51sm5514830eeh.22.2010.11.22.23.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 23:38:11 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161928>

The path given to the browser does not end in a slash, which results in bad
path given to blame and broke [Up To Parent]. Also the path was not
escaped before displaying.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/lib/browser.tcl |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
index c241572..a88a68b 100644
--- a/git-gui/lib/browser.tcl
+++ b/git-gui/lib/browser.tcl
@@ -26,8 +26,14 @@ constructor new {commit {path {}}} {
 	wm withdraw $top
 	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
 
+	if {$path ne {}} {
+		if {[string index $path end] ne {/}} {
+			append path /
+		}
+	}
+
 	set browser_commit $commit
-	set browser_path $browser_commit:$path
+	set browser_path "$browser_commit:[escape_path $path]"
 
 	${NS}::label $w.path \
 		-textvariable @browser_path \
-- 
tg: (6f10c41..) bw/git-gui/fix-browser-up (depends on: master)
