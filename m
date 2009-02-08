From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 2/2] git-web--browse: Use xdg-open if it is available
Date: Sun, 8 Feb 2009 18:13:33 -0500
Message-ID: <505e3349e025bb4ac91fdfaa987a19cc729fa8fb.1234127422.git.tmz@pobox.com>
References: <e44161a223e7ec2cfb1f1b71399b995626c2d208.1234127422.git.tmz@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 09 00:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWIrf-0001nt-Fs
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 00:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZBHXNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbZBHXNh
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 18:13:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbZBHXNh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 18:13:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCC8898F21;
	Sun,  8 Feb 2009 18:13:36 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4920B98F20; Sun,
  8 Feb 2009 18:13:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <e44161a223e7ec2cfb1f1b71399b995626c2d208.1234127422.git.tmz@pobox.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: 1D1E27DC-F636-11DD-8129-8B21C92D7133-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109025>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

For now, I didn't remove any of the KDE specific hacks.  It seemed
better to add  xdg-open and let it prove whether it's workable first.

Is testing for start and xdg-open based on their paths robust enough?
Is there a more portable, preferred method to search for these
programs in $PATH?

 git-web--browse.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 7ed0fad..a72cd5b 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,7 @@ valid_custom_tool()

 valid_tool() {
 	case "$1" in
-		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start)
+		firefox | iceweasel | konqueror | w3m | links | lynx | dillo | open | start | xdg-open)
 			;; # happy
 		*)
 			valid_custom_tool "$1" || return 1
@@ -118,6 +118,10 @@ if test -z "$browser" ; then
     if test -x /bin/start; then
 	browser_candidates="start $browser_candidates"
     fi
+    # Use xdg-open if it is available
+    if test -x /usr/bin/xdg-open; then
+	browser_candidates="xdg-open $browser_candidates"
+    fi

     for i in $browser_candidates; do
 	init_browser_path $i
@@ -161,7 +165,7 @@ case "$browser" in
 		;;
 	esac
 	;;
-    w3m|links|lynx|open|start)
+    w3m|links|lynx|open|start|xdg-open)
 	eval "$browser_path" "$@"
 	;;
     dillo)
-- 
1.6.1.3

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
He may look like an idiot and talk like an idiot but don't let that
fool you. He really is an idiot.
    -- Groucho Marx
