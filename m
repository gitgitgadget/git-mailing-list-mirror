From: Brian Moran <bmoran@onehub.com>
Subject: Bus Error- git merge
Date: Fri, 30 Jan 2009 10:15:44 -0800
Message-ID: <C5A883D0.E243%bmoran@onehub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 19:17:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSxw2-00057k-PE
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 19:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbZA3SQU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 13:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753004AbZA3SQU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 13:16:20 -0500
Received: from server515i.exghost.com ([72.32.253.75]:3573 "EHLO
	server515.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752255AbZA3SQT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 13:16:19 -0500
Received: by server515.appriver.com (CommuniGate Pro PIPE 5.2.8)
  with PIPE id 123690890; Fri, 30 Jan 2009 12:16:06 -0600
Received: from FE3.exchange.rackspace.com ([72.32.49.36] verified)
  by server515.appriver.com (CommuniGate Pro SMTP 5.2.8)
  with ESMTP id 123690677 for git@vger.kernel.org; Fri, 30 Jan 2009 12:15:46 -0600
Received: from 34093-C5-EVS1.exchange.rackspace.com ([192.168.1.96]) by FE3.exchange.rackspace.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 30 Jan 2009 12:15:47 -0600
Received: from 69.84.249.99 ([69.84.249.99]) by 34093-C5-EVS1.exchange.rackspace.com ([192.168.1.105]) via Exchange Front-End Server owa.mailseat.com ([192.168.1.53]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 30 Jan 2009 18:15:47 +0000
User-Agent: Microsoft-Entourage/12.12.0.080729
Thread-Topic: Bus Error- git merge
Thread-Index: AcmDBsQcCoCJENVteUOGGrULXc8CQQ==
X-OriginalArrivalTime: 30 Jan 2009 18:15:47.0945 (UTC) FILETIME=[C6763D90:01C98306]
X-Policy: GLOBAL - onehub.com
X-Primary: bmoran@onehub.com
X-Note: This Email was scanned by AppRiver SecureTide
X-ALLOW: bmoran@onehub.com ALLOWED
X-Virus-Scan: V-
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 72.32.49.36
X-Note-Reverse-DNS: 
X-Note-WHTLIST: bmoran@onehub.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 94 95 96 97 101 102 170 
X-Note: Mail Class: ALLOWEDSENDER
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107860>

I am getting a bus error on a git merge, including the more recent vers=
ions.
=46ollowing the instructions from a bug August, I got the latest source=
s,
compiled them up, and executed the merge in the debugger to repro. Here=
=B9s
what I found:

gdb ../git-1.6.1.2/git-merge
GNU gdb 6.3.50-20050815 (Apple version gdb-768) (Tue Oct  2 04:07:49 UT=
C
2007)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and yo=
u are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for deta=
ils.
This GDB was configured as "i386-apple-darwin"...Reading symbols for sh=
ared
libraries ........ done

(gdb) set args -v v1-ftp-support
(gdb) run
Starting program: /Users/bmo/Documents/repo/git-1.6.1.2/git-merge -v
v1-ftp-support
Reading symbols for shared libraries +++++++. done

Program received signal EXC_BAD_ACCESS, Could not access memory.
Reason: KERN_PROTECTION_FAILURE at address: 0x00000004
0x000863c3 in sha_eq (a=3D0x4 <Address 0x4 out of bounds>, b=3D0x7bf004=
 "<some
random chars>") at cache.h:575
575        return memcmp(sha1, sha2, 20);

(gdb) backtrace
#0  0x000863c3 in sha_eq (a=3D0x4 <Address 0x4 out of bounds>, b=3D0x7b=
f004
"<some random chars>") at cache.h:575
#1  0x00086dc6 in merge_trees (o=3D0xbfffedd4, head=3D0x7bf020, merge=3D=
0x7bf000,
common=3D0x0, result=3D0xbfffed28) at merge-recursive.c:1164
#2  0x00088960 in merge_recursive (o=3D0xbfffedd4, h1=3D0x4f4060, h2=3D=
0x4f4000,
ca=3D0x53cc20, result=3D0xbfffee2c) at merge-recursive.c:1294
#3  0x0003871c in try_merge_strategy (strategy=3D0xd28ce "recursive",
common=3D0x53a040, head_arg=3D0xc3508 "HEAD") at builtin-merge.c:586
#4  0x00039fef in cmd_merge (argc=3D1, argv=3D0xbffff860, prefix=3D0x0)=
 at
builtin-merge.c:1131
#5  0x000025db in handle_internal_command (argc=3D3, argv=3D0xbffff860)=
 at
git.c:243
#6  0x00002c48 in main (argc=3D3, argv=3D0xbffff860) at git.c:453
(gdb)=20
Any suggestions on how to proceed? I am available to gather more inform=
ation
on this as I can reproduce at will.
Thanks,
Brian Moran

http://www.onehub.com
