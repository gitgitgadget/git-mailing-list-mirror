From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] gitk: Fix nextfile() and add prevfile()
Date: Wed, 27 Sep 2006 00:22:34 +0900
Message-ID: <873bae3b5x.fsf_-_@duaron.myhome.or.jp>
References: <873bag12k3.fsf@duaron.myhome.or.jp>
	<7vpsdjryj2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Sep 26 17:30:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSEod-0003fD-Qv
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 17:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIZPZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWIZPZe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 11:25:34 -0400
Received: from mail.parknet.jp ([210.171.160.80]:53257 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932120AbWIZPZd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 11:25:33 -0400
X-AuthUser: hirofumi@parknet.jp
Received: from ibmpc.myhome.or.jp ([210.171.168.39]:1250)
	by parknet.jp with [XMail 1.21 ESMTP Server]
	id <SACAB> for <git@vger.kernel.org> from <hirofumi@mail.parknet.co.jp>;
	Wed, 27 Sep 2006 00:24:36 +0900
Received: from duaron.myhome.or.jp (duaron.myhome.or.jp [192.168.0.2])
	by ibmpc.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFNZX8004766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:23:36 +0900
Received: from duaron.myhome.or.jp (localhost [127.0.0.1])
	by duaron.myhome.or.jp (8.13.8/8.13.8/Debian-2) with ESMTP id k8QFNZGV004340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Sep 2006 00:23:35 +0900
Received: (from hirofumi@localhost)
	by duaron.myhome.or.jp (8.13.8/8.13.8/Submit) id k8QFMYKF004338;
	Wed, 27 Sep 2006 00:22:34 +0900
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <7vpsdjryj2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 25 Sep 2006 22\:24\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27797>

The current nextfile() jumps to last hunk, but I think this is not
intention, probably, it's forgetting to add "break;". And this
patch also adds prevfile(), it jumps to previous hunk.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 gitk |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff -puN gitk~gitk-nextfile-fix gitk
--- git/gitk~gitk-nextfile-fix	2006-09-27 00:16:11.000000000 +0900
+++ git-hirofumi/gitk	2006-09-27 00:16:48.000000000 +0900
@@ -4440,12 +4440,26 @@ proc getblobdiffline {bdf ids} {
     }
 }
 
+proc prevfile {} {
+    global difffilestart ctext
+    set prev [lindex $difffilestart 0]
+    set here [$ctext index @0,0]
+    foreach loc $difffilestart {
+	if {[$ctext compare $loc >= $here]} {
+	    $ctext yview $prev
+	    break
+	}
+	set prev $loc
+    }
+}
+
 proc nextfile {} {
     global difffilestart ctext
     set here [$ctext index @0,0]
     foreach loc $difffilestart {
 	if {[$ctext compare $loc > $here]} {
 	    $ctext yview $loc
+	    break
 	}
     }
 }
_
