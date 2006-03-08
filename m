From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: endless loop: ?
Date: Wed, 08 Mar 2006 21:04:28 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.03.08.20.04.24.62170@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Mar 08 21:14:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH51j-0003N4-To
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 21:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWCHUMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 15:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWCHUMx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 15:12:53 -0500
Received: from main.gmane.org ([80.91.229.2]:7563 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750749AbWCHUMw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Mar 2006 15:12:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FH50a-0002xv-J4
	for git@vger.kernel.org; Wed, 08 Mar 2006 21:11:44 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 21:11:44 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Mar 2006 21:11:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17384>

Hmmm...

# ps axurw
smurf    26367 84.1  0.2   3200  2068 pts/1    R    20:08  40:30 /usr/bin/git-rev-list --objects 5771c72e2908fb68906020d07d4e0cb77d2

# strace -p 26367
stat64("/daten/src/noris/kundet.git/.git/objects/23/ae4dd0bab2f05dba8a3c77d4c792542b07b73e", {st_mode=S_IFREG|0644, st_size=204, ...}) = 0
[ lots of different filenames, however ..:]

# strace -p 26367 | grep ae4dd
stat64("/daten/src/noris/kundet.git/.git/objects/23/ae4dd0bab2f05dba8a3c77d4c792542b07b73e", {st_mode=S_IFREG|0644, st_size=204, ...}) = 0
[ lots of repetitions of the same filename => we're in a bad loop of some sort ]

# gdb /daten/src/git/git/git-rev-list 26367
(gdb) whe
#0  0xffffe410 in __kernel_vsyscall ()
#1  0xb7ec08f8 in _xstat () from /lib/tls/i686/cmov/libc.so.6
#2  0x0804e2f0 in find_sha1_file (
    sha1=0x81ddb20 "#\uffffM\u043a\uffff\uffff]\uffff\212<w\uffff\uffff\222T+\a\uffff>\uffffr\005\b\uffff\uffff\035\b",
    st=0xbf87b450) at stat.h:366
#3  0x0804e752 in has_sha1_file (
    sha1=0x81ddb20 "#\uffffM\u043a\uffff\uffff]\uffff\212<w\uffff\uffff\222T+\a\uffff>\uffffr\005\b\uffff\uffff\035\b")
    at sha1_file.c:1600
#4  0x080514f8 in mark_parents_uninteresting (commit=0x0) at revision.c:106
#5  0x080514ed in mark_parents_uninteresting (commit=0x0) at revision.c:96
[ bah ]
#104 0x080514ed in mark_parents_uninteresting (commit=0x0) at revision.c:96
#105 0x080516d8 in prepare_revision_walk (revs=0x8066560) at revision.c:347
#106 0x08049ab4 in main (argc=1, argv=0xbf87c294) at rev-list.c:352

I'll dig further tomorrow...
