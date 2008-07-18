From: SungHyun Nam <namsh@posdata.co.kr>
Subject: git-remote SEGV on t5505 test.
Date: Fri, 18 Jul 2008 10:46:02 +0900
Message-ID: <g5osl6$4g3$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 04:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJfHT-0000li-Th
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 04:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYGRCAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 22:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYGRCAH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 22:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:55719 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbYGRCAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 22:00:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KJfGM-0005lc-IW
	for git@vger.kernel.org; Fri, 18 Jul 2008 02:00:03 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 02:00:02 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 02:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88978>

Hello,

The gdb backtrace said:
(gdb) bt
#0  0xff03455c in strlen () from /usr/lib/libc.so.1
#1  0xff087058 in _doprnt () from /usr/lib/libc.so.1
#2  0xff088c18 in printf () from /usr/lib/libc.so.1
#3  0x0007df20 in prune (argc=1556136, argv=0x139cd0) at
builtin-remote.c:590

The codes in builtin-remote.c:590,
         printf(" * [%s] %s\n", dry_run ? "would prune" : "prune",
                skip_prefix(refname, "refs/remotes/"));

And the 'skip_prefix()' returns NULL in this case.
(The old skip_prefix() never returns NULL).

It seems there is another place need to be checked:
   builtin-remote.c:464 : can pass NULL to the strdup().

Regards,
namsh
