From: Steven Cole <elenstev@mesatop.com>
Subject: Errors received during git pull from linux-2.6.git, but resulting
 kernel looks OK.
Date: Thu, 21 Apr 2005 07:55:26 -0600
Message-ID: <4267B0CE.7020504@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:52:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOc5Z-0003vZ-Pp
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 15:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVDUNzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 09:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVDUNzv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 09:55:51 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:4327 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261383AbVDUNza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 09:55:30 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher-b.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3LDtTBJ017228
	for <git@vger.kernel.org>; Thu, 21 Apr 2005 07:55:29 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j3LDtQPA022109;
	Thu, 21 Apr 2005 07:55:27 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Executive summary: I received some alarming errors while doing
a git pull of the latest kernel from kernel.org, but it appears
that all is well.  Continue reading for the gory details.

I updated my git-pasky tools this morning, by doing "git pasky pull", "make", "make install".

Working from a repo converted yesterday using Linus'instructions and subsequently
successfully updated once:

[steven@spc0 linux-2.6-origin]$ git lsremote
origin  rsync://www.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git
[steven@spc0 linux-2.6-origin]$ time git pull origin
MOTD:
MOTD:   Welcome to the Linux Kernel Archive.
MOTD:
MOTD:   Due to U.S. Exports Regulations, all cryptographic software on this
MOTD:   site is subject to the following legal notice:
MOTD:
MOTD:   This site includes publicly available encryption source code
MOTD:   which, together with object code resulting from the compiling of
MOTD:   publicly available source code, may be exported from the United
MOTD:   States under License Exception "TSU" pursuant to 15 C.F.R. Section
MOTD:   740.13(e).
MOTD:
MOTD:   This legal notice applies to cryptographic software only.
MOTD:   Please see the Bureau of Industry and Security,
MOTD:   http://www.bis.doc.gov/ for more information about current
MOTD:   U.S. regulations.
MOTD:


receiving file list ... done
18/13b464853cba4439b3c30412059ed6284114a0
8d/a3a306d0c0c070d87048d14a033df02f40a154
a2/755a80f40e5794ddc20e00f781af9d6320fafb

sent 181 bytes  received 952105 bytes  272081.71 bytes/sec
total size is 63450766  speedup is 66.63

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
Tree change: 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9:a2755a80f40e5794ddc20e00f781af9d6320fafb
*100644->100644 blob    8e5f9bbdf4de94a1bc4b4da8cb06677ce0a57716->8da3a306d0c0c070d87048d14a033df02f40a154     Makefile
Tracked branch, applying changes...
Fast-forwarding 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9 -> a2755a80f40e5794ddc20e00f781af9d6320fafb
         on top of 4d78b6c78ae6d87e4c1c8072f42efa716f04afb9...
error: bad index version
error: verify header failed
read_cache: Invalid argument
gitdiff.sh: no files matched
error: bad index version
error: verify header failed


real    6m4.771s
user    0m16.538s
sys     0m12.952s
[steven@spc0 linux-2.6-origin]$

Maybe those errors are "harmless".  Checking out the new repo:

[steven@spc0 linux-2.6-origin]$ git export ../linux-2.6.12-rc3
[steven@spc0 linux-2.6-origin]$ cd ..
[steven@spc0 GIT]$ diff -urN linux-2.6.11 linux-2.6.12-rc3 >gitdiff-2.6.12-rc3

So, now I have patch-2.6.12-rc3 from kernel.org and gitdiff-2.6.12-rc3 made above.

[steven@spc0 GIT]$ diffstat gitdiff-2.6.12-rc3 | tail -n 2
  sound/usb/usx2y/usbusx2yaudio.c                              |    1
  4622 files changed, 271839 insertions(+), 156792 deletions(-)

[steven@spc0 GIT]$ diffstat patch-2.6.12-rc3 | tail -n 2
  sound/usb/usx2y/usbusx2yaudio.c                              |    1
  4622 files changed, 271839 insertions(+), 156792 deletions(-)

Despite the errors from the "git pull", the files look OK.

Steven
