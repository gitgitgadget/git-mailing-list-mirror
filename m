From: Alexey Borzenkov <snaury@gmail.com>
Subject: [PATCH] gitk: restore wm state to normal before saving geometry information
Date: Tue,  8 Sep 2009 23:22:36 +0400
Message-ID: <1252437756-81986-1-git-send-email-snaury@gmail.com>
Cc: paulus@samba.org, Alexey Borzenkov <snaury@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 21:30:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml6OB-00020g-O0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 21:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbZIHT3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZIHT3w
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 15:29:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:16585 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZIHT3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 15:29:52 -0400
Received: by qw-out-2122.google.com with SMTP id 9so127121qwb.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=PmY2zEQoms3O0XPyeFwdrJS4Bx/Tf7LpNyKBIy0w52w=;
        b=dUdoR5AGAGjEACg7Oux1w0VQ76F9gAY13/cDcYaw8JcXoXylTbeQQsmr3CvG5NaxHQ
         8/twlyAf/UM0YeCD0ORVsaTuIbjY/g5gjc1LXaN/byuaIi0TQvR4Xvknr/ek9dXrxsps
         7WnG57G+Tv7PjI7JHf9ggu/iwM2q49Dwdo3fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bIOPnOynv4Yaqh+QiX1fQPgnyZg1/nbBtOOSDQKk/+mBKMgy+Cejo/gEVmxZPidkM7
         QBCNpJA8rM0oqXird/1ABqm+Nu8ewSuYSB6DADYLRLRJBX40ljwI6zFvpstpIxgWSNQ2
         OuDiASrevqejsqtwn+jVeeopDKngHDtJmiIcU=
Received: by 10.224.117.145 with SMTP id r17mr10353370qaq.7.1252437772670;
        Tue, 08 Sep 2009 12:22:52 -0700 (PDT)
Received: from localhost ([80.252.153.11])
        by mx.google.com with ESMTPS id 7sm54695qwb.4.2009.09.08.12.22.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Sep 2009 12:22:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128026>

gitk now includes patches for saving and restoring wm state, however
because it saves wm geometry when window can still be maximized the
maximize/restore button becomes useless after restarting gitk (you
will get a huge displaced window if you try to restore it). This
patch fixes this issue by storing window geometry in normal state.

Signed-off-by: Alexey Borzenkov <snaury@gmail.com>
---
 My previous email didn't come out rights, I hope this one will
 Don't forget to cc me if you have any comments/questions

 gitk |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 8c08310..fedeb88 100755
--- a/gitk
+++ b/gitk
@@ -2555,8 +2555,11 @@ proc savestuff {w} {
 	puts $f [list set extdifftool $extdifftool]
 	puts $f [list set perfile_attrs $perfile_attrs]
 
-	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(state) [wm state .]"
+	if {[wm state .] eq {zoomed}} {
+		wm state . normal
+	}
+	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
         puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
-- 
1.6.4.2
