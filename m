From: Peter Kleiweg <p.c.j.kleiweg@rug.nl>
Subject: old but persistent problem: bad line length character
Date: Tue, 7 Jun 2011 18:33:07 +0200
Organization: -= de Laatste Huismus =-
Message-ID: <alpine.DEB.1.10.1106071832470.4175@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 18:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzP2-0001i0-4V
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 18:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1FGQpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 12:45:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:36628 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615Ab1FGQpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 12:45:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QTzOp-0001aj-Mj
	for git@vger.kernel.org; Tue, 07 Jun 2011 18:45:03 +0200
Received: from pebbe.xs4all.nl ([80.101.76.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 18:45:03 +0200
Received: from p.c.j.kleiweg by pebbe.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 18:45:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pebbe.xs4all.nl
X-X-Sender: peter@localhost
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Accept-Language: nl,af,da,de,en,ia,nds,no,sv,fr,it
X-Face: "K~X:~!ydgSdjNy;]_+BCb\OM^pqyg_q*Le84$l46M\-mL=.^,L4B}bDK>`o#r4_>O*
X-Mailer: Alpine 1.10 (DEB 962 2008-03-14), Linux 2.6.18-6-686, i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175214>


I get this error message with git version 1.7.5.GIT: 

    fatal: protocol error: bad line length character:

Git version 1.4.4.4 works fine.

I have read this was a very old problem, and there were some 
fixes, then how come I still get this in the latest version of 
Git? All the explanations I could find about this bug don't seem 
to apply for my case. 

How do bugs in Git get solved? I can't find an issue tracker. 


Details:

$ export GIT_TRACE=1
$ export GIT_TRACE_PACKET=1
$ git push 
trace: built-in: git 'push'
trace: run_command: 'ssh' 'github' 'git-receive-pack '\''pebbe/Gabmap.git'\''' 
fatal: protocol error: bad line length character:

The output above comes immediately. When I run the ssh command 
listed above, it takes time before I get a response. So even if 
Git does run the command, it doesn't wait for a response from 
the server.

Setting GIT_TRACE_PACKET doesn't seem to have any effect. 


I added some debug code in pkt-line.c, function 
packet_read_line(). This tells me that 'buffer' that is passed 
to packet_read_line() contains nothing but null characters, 
while 'size' is set to 1000.


Running the ssh command as listed by trace works fine:

$ ssh github git-receive-pack 'pebbe/Gabmap.git'
00720444852406fd34c3eb0c8cdcb05cd2af979d2b34 refs/heads/master report-status delete-refs side-band-64k ofs-delta
0000

-- 
Peter Kleiweg
http://pkleiweg.home.xs4all.nl/
