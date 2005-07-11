From: Joel Becker <Joel.Becker@oracle.com>
Subject: Commit 7c5977297f07c2a52c8c0f486309076b2a795d33 appears to have broken cg-init
Date: Sun, 10 Jul 2005 18:58:20 -0700
Message-ID: <20050711015820.GA16618@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 11 03:58:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrnZ5-0000sl-HG
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 03:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVGKB63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 21:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVGKB63
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 21:58:29 -0400
Received: from agminet03.oracle.com ([141.146.126.230]:30408 "EHLO
	agminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262184AbVGKB62 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 21:58:28 -0400
Received: from rgmgw1.us.oracle.com (rgmgw1.us.oracle.com [138.1.191.10])
	by agminet03.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j6B1wLIO028623;
	Sun, 10 Jul 2005 20:58:21 -0500
Received: from rgmgw1.us.oracle.com (localhost [127.0.0.1])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j6B1wLEB031351;
	Sun, 10 Jul 2005 19:58:21 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw1.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j6B1wKoh031344;
	Sun, 10 Jul 2005 19:58:21 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.52)
	id 1DrnYq-0005by-4O; Sun, 10 Jul 2005 18:58:20 -0700
To: Petr Baudis <pasky@suse.cz>, git <git@vger.kernel.org>
Content-Disposition: inline
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr,
	Commit 7c5977297f07c2a52c8c0f486309076b2a795d33 contains the
chunk:

-uri=$1
+
+infoonly=
+while optparse; do
+	if optparse -N; then
+		infoonly=-N
+	else
+		optfail
+	fi
+done
+
+uri=$ARGV

	However, $ARGV is not a variable I've ever seen supported in a
Bourne-like shell.  Certainly Bash supports BASH_ARGV, but not ARGV.
	The recent option parsing code adds ARGS in cg-Xlib, but not
ARGV.
	The upshot is that a cg-clone/cg-init attempt thinks $uri is
empty, and always creates an initial commit.  No clone.  I don't know
how folks have gotten cg-clone rsync://linus to work since this change
went in.
	I don't know what the proper solution is with the modern option
code, but changing it back to 'url=$1' allows me to grab Linus' tree.

Joel
-- 

Life's Little Instruction Book #3

	"Watch a sunrise at least once a year."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
