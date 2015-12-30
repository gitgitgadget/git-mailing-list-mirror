From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Segfault in git reflog
Date: Wed, 30 Dec 2015 10:24:01 +0100
Message-ID: <20151230092400.GA9319@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 10:24:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aECzm-0004ty-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 10:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbbL3JYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 04:24:10 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34982 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbL3JYG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 04:24:06 -0500
Received: by mail-wm0-f43.google.com with SMTP id f206so31840983wmf.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 01:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=xsxvAXLy95Ru5RVDZdTqr25zo02rW6tNfKfYUv3g06A=;
        b=OaHIVzZaqsm/ELsccCPYUBODtH0u+6bTfVN+TQzDvjV/ziaF0VTh3P6OAZr1twUe8/
         GNs7TQP3wKdfXrweZ+Yc4tb1N7mMHvt0zjiZfOmdt0OJQL/DD/A0JK2JYoVXTLf3rJXZ
         pKs+ZaHJM8plV8HkrUQkrNaLSj4PlH7yCjnChFaDzHAIu880VhrF84z7dyLFnHc3gXW+
         YqkbSEa/Pycgc85UlLhc2BdrxReks+734NBZNGbK77vraN/vZPnB3djwW5MsL0h4K1g9
         2kNzLyqeqnSUOzD0CiOQyLLWR0xj/BG9A83HdWb1+u/+S9H6T5rCr9BBPvcScmWNCjr4
         TQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=xsxvAXLy95Ru5RVDZdTqr25zo02rW6tNfKfYUv3g06A=;
        b=bhuf3zCnelGf2rLFpFozR/vcVwomN3Mtkrxn1LfTnlatPKVJJw6Vmg3dHC7MjxuJTw
         n+li1DqkWA64TwXd37/t4lhH4B0Z3nLyNyFmTYT404CU3rQfBWjrCMtGY49tH612DH1R
         i+43+LCox62WPkSwwAhZjXSFzFqPKrflnOORJ6H/+tz2TGRCsQGJhBs5vyuCjx2b70YK
         phuGYkiriKIxAoCxoLaR1u/Np16CEPafPab96CyoO9AgaisO0S8NGWqUbX08pr09EFEa
         PD3oU1UdedxEd5Ou1Y7Pm3w4FZ7BLBkfUtzLNp8gjBpvURH8WR2AbWgggj3LmwSdfx3C
         i02Q==
X-Gm-Message-State: ALoCoQkFeOnPt4m2/z9/oL7jQquzYHiVADz1MnQmj/LnCmge+2hn0EnniKkrMiJn/tiZwNGiH47vC++yPCLMaMH0Ox+LiLi48Q==
X-Received: by 10.194.123.8 with SMTP id lw8mr68638108wjb.72.1451467444238;
        Wed, 30 Dec 2015 01:24:04 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id m65sm33016884wma.13.2015.12.30.01.24.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Dec 2015 01:24:03 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283169>

I've hit a segfault in git reflog with latest git, reproducable in git.git:

spirit:~/code/git (master)$ ./git describe
v2.7.0-rc3

I've minimized the reflog to:

spirit:~/code/git (master)$ cat .git/logs/HEAD
2635c2b8bfc9aec07b7f023d8e3b3d02df715344 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765642 +0100  
74c855f87d25a5b5c12d0485ec77c785a1c734c5 54bc41416c5d3ecb978acb0df80d57aa3e54494c Dennis Kaarsemaker <dennis@kaarsemaker.net> 1446765951 +0100  checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master

...which I realize looks a bit broken. I think at the time I was playing with
some patches that also caused segfaults, causing gaps in the reflog.
Nevertheless, I think segfaulting is bad. All objects in the reflog are
reachable.

gdb has the following to say:

spirit:~/code/git (master)$ gdb --args ./git --no-pager reflog
(gdb) run
Starting program: /home/dennis/code/git/git --no-pager reflog
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
28274d0 (HEAD -> master, tag: v2.7.0-rc3, upstream/master, peff/jk/tag-source-propagate, peff/jk/sigpipe-report, gitster/master) HEAD@{0}: checkout: moving from 3c3d3f629a6176b401ebec455c5dd59ed1b5f910 to master

Program received signal SIGSEGV, Segmentation fault.
copy_commit_list (list=0x4834dc7000000011) at commit.c:450
450         pp = commit_list_append(list->item, pp);
(gdb) bt
#0  copy_commit_list (list=0x4834dc7000000011) at commit.c:450
#1  0x000000000050705e in save_parents (commit=commit@entry=0x928a90, revs=0x7fffffffcb80) at revision.c:3044
#2  0x000000000050a54e in get_revision_1 (revs=revs@entry=0x7fffffffcb80) at revision.c:3119
#3  0x000000000050a710 in get_revision_1 (revs=<optimized out>) at revision.c:3112
#4  get_revision_internal (revs=0x7fffffffcb80) at revision.c:3248
#5  0x000000000050a99d in get_revision (revs=revs@entry=0x7fffffffcb80) at revision.c:3322
#6  0x0000000000446032 in cmd_log_walk (rev=rev@entry=0x7fffffffcb80) at builtin/log.c:344
#7  0x0000000000446bf8 in cmd_log_reflog (argc=1, argv=0x7fffffffd6a8, prefix=0x0) at builtin/log.c:626
#8  0x0000000000406126 in run_builtin (argv=0x7fffffffd6a8, argc=1, p=0x7bbec0 <commands+1920>) at git.c:350
#9  handle_builtin (argc=1, argv=0x7fffffffd6a8) at git.c:536
#10 0x0000000000405261 in run_argv (argv=0x7fffffffd4c8, argcp=0x7fffffffd4ac) at git.c:582
#11 main (argc=1, av=<optimized out>) at git.c:690
(gdb) p list
$1 = (struct commit_list *) 0x4834dc7000000011
(gdb) p list->item
Cannot access memory at address 0x4834dc7000000011

A bisect blames 53d00b3 (log: use true parents for diff even when rewriting),
which does indeed touch the code that seems to be segfaulting.

I've tried digging into this, but didn't get very far.
-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
