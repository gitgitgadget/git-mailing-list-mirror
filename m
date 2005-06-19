From: Paul Mackerras <paulus@samba.org>
Subject: quick patch for gitk-1.1
Date: Sun, 19 Jun 2005 22:01:57 +1000
Message-ID: <17077.24245.159322.636067@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Jun 19 13:57:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjyQD-0004NL-9A
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 13:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVFSMCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 08:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVFSMCY
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 08:02:24 -0400
Received: from ozlabs.org ([203.10.76.45]:62935 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261820AbVFSMCK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 08:02:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id B19CB67B2B; Sun, 19 Jun 2005 22:02:04 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It turns out that Linus' linux-2.6 tree now has a commit in it with
one of the parents listed twice, which confuses gitk and causes it to
stop with an error.  I have a new version of gitk almost ready to go,
but in the meantime here is a quick patch for gitk-1.1 to fix the
problem.

The confusing commit is 13e652800d1644dfedcd0d59ac95ef0beb7f3165.

Paul.

--- gitk~	2005-06-01 18:14:51.000000000 +1000
+++ gitk	2005-06-19 21:55:02.000000000 +1000
@@ -582,6 +582,7 @@
 	set ofill white
 	if {[info exists parents($id)]} {
 	    foreach p $parents($id) {
+		if {[lsearch -exact $actualparents $p] >= 0} continue
 		if {[info exists ncleft($p)]} {
 		    incr ncleft($p) -1
 		    if {![info exists commitinfo($p)]} {
