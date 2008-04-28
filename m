From: Dave Jones <davej@redhat.com>
Subject: git-fetch segfault in git 1.5.5.1
Date: Mon, 28 Apr 2008 14:41:38 -0400
Message-ID: <20080428184138.GA30702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 20:43:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYJO-00019K-4t
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934559AbYD1Slm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934598AbYD1Slm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:41:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43274 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934007AbYD1Slk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:41:40 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m3SIfdSf025082
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:41:39 -0400
Received: from file.rdu.redhat.com (file.rdu.redhat.com [10.11.255.147])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m3SIfdk5022816
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:41:39 -0400
Received: from quoit.install.boston.redhat.com (quoit.install.boston.redhat.com [10.13.0.212])
	by file.rdu.redhat.com (8.13.1/8.13.1) with ESMTP id m3SIfcdo006769
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:41:39 -0400
Received: from quoit.install.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by quoit.install.boston.redhat.com (8.14.2/8.14.1) with ESMTP id m3SIfc2G017805
	for <git@vger.kernel.org>; Mon, 28 Apr 2008 14:41:38 -0400
Received: (from davej@localhost)
	by quoit.install.boston.redhat.com (8.14.2/8.14.2/Submit) id m3SIfcCm017804
	for git@vger.kernel.org; Mon, 28 Apr 2008 14:41:38 -0400
X-Authentication-Warning: quoit.install.boston.redhat.com: davej set sender to davej@redhat.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80580>

Since master.kernel.org updated to latest, I noticed that I could crash
git-fetch by doing this..

export KERNEL=/pub/scm/linux/kernel/git/
git fetch $KERNEL/torvalds/linux-2.6 master:linus

(gdb) bt
#0  0x000000349fd6d44b in free () from /lib64/libc.so.6
#1  0x000000000048f4eb in transport_unlock_pack (transport=0x7ce530) at transport.c:811
#2  0x000000349fd31b25 in exit () from /lib64/libc.so.6
#3  0x00000000004043d8 in handle_internal_command (argc=3, argv=0x7fffea4449f0) at git.c:379
#4  0x0000000000404547 in main (argc=3, argv=0x7fffea4449f0) at git.c:443
#5  0x000000349fd1c784 in __libc_start_main () from /lib64/libc.so.6
#6  0x0000000000403ef9 in ?? ()
#7  0x00007fffea4449d8 in ?? ()
#8  0x0000000000000000 in ?? ()

I then remembered, my .bashrc has this..

export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))

which is handy for showing up such bugs.

More info on this glibc feature is at http://udrepper.livejournal.com/11429.html

	Dave

-- 
http://www.codemonkey.org.uk
