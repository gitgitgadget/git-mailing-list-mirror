From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Re: Add git-version-script.
Date: Thu, 8 Sep 2005 05:35:25 +0300
Message-ID: <20050908023525.GA14179@igloo.ds.co.ug>
References: <11259325781492-git-send-email-matlads@dsmagic.com> <7v1x402wiy.fsf@assigned-by-dhcp.cox.net> <431F9D0F.8070301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 04:37:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDCHk-0003Su-Pg
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 04:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVIHCgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 22:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVIHCgp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 22:36:45 -0400
Received: from mail1.starcom.co.ug ([217.113.72.31]:44646 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP id S932569AbVIHCgp
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 22:36:45 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Thu, 08 Sep 2005 05:36:31 +0300
  id 000E5FD5.431FA3AF.00003EF4
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP
	id 27D12514A; Thu,  8 Sep 2005 05:37:50 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EDCG5-0003sP-Sh; Thu, 08 Sep 2005 05:35:25 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <431F9D0F.8070301@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8193>

Add version string to git.

Signed-off-by: Martin Atukunda <matlads@dsmagic.com>

---

 Makefile |    3 ++-
 git.in   |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100755 git.in

6a9edfa27c41b7845bfd519e275c24d7e36ad702
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -218,7 +218,8 @@ $(LIB_FILE): $(LIB_OBJS)
 doc:
 	$(MAKE) -C Documentation all
 
-
+git: git.in Makefile
+	sed 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
 
 ### Testing rules
 
diff --git a/git.in b/git.in
new file mode 100755
--- /dev/null
+++ b/git.in
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+cmd=
+path=$(dirname $0)
+case "$#" in
+0)	;;
+*)	cmd="$1"
+	shift
+	if [ "$cmd" == "--version" ]; then
+		echo "git version @@VERSION@@"
+		exit 0
+	fi
+	test -x $path/git-$cmd-script && exec $path/git-$cmd-script "$@"
+	test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
+esac
+
+echo "git version @@VERSION@@"
+echo "Usage: git COMMAND [OPTIONS] [TARGET]"
+if [ -n "$cmd" ]; then
+    echo " git command '$cmd' not found: commands are:"
+else
+    echo " git commands are:"
+fi
+
+ls $path | sed -ne 's/^git-\(.*\)-script/  \1/p' | fmt


-- 
Your entire blood supply is filtered through your kidneys in four minutes.
