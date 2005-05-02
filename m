From: Alexander Beyn <malex-git@fatelectrons.org>
Subject: [PATCH] Add --help to cogito 0.8
Date: Sun, 1 May 2005 17:00:19 -0700
Message-ID: <20050502000019.GA1644@fatelectrons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 01:55:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSOGh-0007Jj-IB
	for gcvg-git@gmane.org; Mon, 02 May 2005 01:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVEBAAa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 20:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVEBAAa
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 20:00:30 -0400
Received: from adsl-66-51-204-13.dslextreme.com ([66.51.204.13]:39880 "EHLO
	mail.fatelectrons.org") by vger.kernel.org with ESMTP
	id S261444AbVEBAAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 20:00:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.fatelectrons.org (Postfix) with ESMTP id 0023E10FE2A0
	for <git@vger.kernel.org>; Sun,  1 May 2005 17:00:19 -0700 (PDT)
Received: from mail.fatelectrons.org ([127.0.0.1])
 by localhost (hmm [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00340-06 for <git@vger.kernel.org>; Sun,  1 May 2005 17:00:19 -0700 (PDT)
Received: by mail.fatelectrons.org (Postfix, from userid 1000)
	id AD06410FE291; Sun,  1 May 2005 17:00:19 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new at fatelectrons.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds -h and --help to all the cg- commands. It also moves the
detailed help printing from cg-help into cg-Xlib.

I created it because I could never remember if cg-log or cg-diff requires 
the -r before the revs.

Alexander


Index: cg-Xlib
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-Xlib  (mode:100755 sha1:940d27851019940d20d2a6b141977d1c9a5debc0)
+++ d8f4221f90207b6c472dd4a2de0bf5e4d131f745/cg-Xlib  (mode:100755 sha1:09668c5c9a02ff9df9957ce656db3358c8c1ca7f)
@@ -33,6 +33,17 @@
 	$(which mktemp) $dirarg $prefix"$1"
 }
 
+print_help () {
+	which "cg-$1" >/dev/null 2>&1 || exit 1
+	cat $(which cg-$1) | sed -n '3,/^$/s/^# *//p'
+	exit
+}
+
+for option in "$@"; do
+	if [ "$option" = "-h" -o "$option" = "--help" ]; then
+		print_help ${_cg_cmd##cg-}
+	fi
+done
 
 # Compatibility hacks:
 # 2005-04-26
Index: cg-help
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-help  (mode:100755 sha1:d16446c005c4698f408bf651afd718d95f5a9cfe)
+++ d8f4221f90207b6c472dd4a2de0bf5e4d131f745/cg-help  (mode:100755 sha1:0ea78197b1c255540a35bd389c48f9a67431e556)
@@ -10,9 +10,7 @@
 
 if [ "$1" ]; then
 	cmd=$(echo "$1" | sed 's/^cg-//')
-	which "cg-$cmd" >/dev/null 2>&1 || exit 1
-	cat $(which cg-$cmd) | sed -n '3,/^$/s/^# *//p'
-	exit
+	print_help $cmd
 fi
