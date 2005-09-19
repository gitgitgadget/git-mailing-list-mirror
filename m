From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 12:19:36 +0200
Message-ID: <u5tmzm9bbrb.fsf@lysator.liu.se>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 19 12:24:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHIn6-0006Y4-Ti
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 12:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVISKWT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVISKWT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 06:22:19 -0400
Received: from main.gmane.org ([80.91.229.2]:18116 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932218AbVISKWS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 06:22:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHIlQ-00068C-Bi
	for git@vger.kernel.org; Mon, 19 Sep 2005 12:20:44 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 12:20:44 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 12:20:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:tg+85bdlLKUvNYlrc27rOTa1wcc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8853>

These flags override the GIT_DIR and EDITOR environment variables.

---
This is more generic way to specify GIT_DIR than Linus' suggestion,
although it is only targeted at more porcelainish usage of the git
driver script.

I needed this for the Emacs commands I've been hacking on, since it's
hard to set environment variables for single commands without
involving /bin/env or a shell.

 git.sh |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

b9a38ed5a16289f86b353c0bb541e607d35180a9
diff --git a/git.sh b/git.sh
--- a/git.sh
+++ b/git.sh
@@ -2,19 +2,32 @@
=20
 cmd=3D
 path=3D$(dirname $0)
-case "$#" in
-0)	;;
-*)	cmd=3D"$1"
-	shift
-	case "$cmd" in
-	-v|--v|--ve|--ver|--vers|--versi|--versio|--version)
-		echo "git version @@GIT_VERSION@@"
-		exit 0 ;;
-	esac
-	test -x $path/git-$cmd && exec $path/git-$cmd "$@" ;;
-esac
=20
-echo "Usage: git COMMAND [OPTIONS] [TARGET]"
+while test "$#" -gt 0
+do
+        case "$1" in
+        -d)	export GIT_DIR
+                GIT_DIR=3D$2
+                shift
+                ;;
+        -e)	export EDITOR
+                EDITOR=3D$2
+                shift
+                ;;
+        *)	cmd=3D"$1"
+                shift
+                case "$cmd" in
+                -v|--v|--ve|--ver|--vers|--versi|--versio|--version)
+                        echo "git version @@GIT_VERSION@@"
+                        exit 0 ;;
+                esac
+                test -x $path/git-$cmd && exec $path/git-$cmd "$@"
+                ;;
+        esac
+        shift
+done
+
+echo "Usage: git [GLOBAL OPTIONS] COMMAND [COMMAND OPTIONS]"
 if [ -n "$cmd" ]; then
     echo " git command '$cmd' not found: commands are:"
 else

--=20
David K=E5gedal
