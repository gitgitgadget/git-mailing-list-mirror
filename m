From: Amin Azez <azez@ufomechanic.net>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Fri, 08 Jul 2005 16:18:57 +0100
Message-ID: <42CE9961.3090708@ufomechanic.net>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 17:33:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqupA-0000el-Ag
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 17:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVGHPbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 11:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVGHPbS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 11:31:18 -0400
Received: from main.gmane.org ([80.91.229.2]:8675 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262683AbVGHPbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 11:31:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Dqunj-0000P9-La
	for git@vger.kernel.org; Fri, 08 Jul 2005 17:30:03 +0200
Received: from 82.219.220.170 ([82.219.220.170])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 17:30:03 +0200
Received: from azez by 82.219.220.170 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 17:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.219.220.170
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <42B9E536.60704@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thanks for the HOWTO, Jeff, but it gives me problems in step 4.
I checked out your latest git source today and "make install"ed it as 
part of your instructions and at step 4 I get:

$ git checkout -f
error: cannot map sha1 file f8640c306db2d583b9a30f2e52f8fb0a4cf624e0
fatal: failed to unpack tree object a92b7b80579fe68fe229892815c750f6652eb6a9

$ cat .git/HEAD
a92b7b80579fe68fe229892815c750f6652eb6a9

Naturally I have no idea what f8640c306db2d583b9a30f2e52f8fb0a4cf624e0 
refers to.

Step 3:
$ git-pull-script \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

said I was already up to date.

Variations on step 4:

$ git-read-tree -m HEAD
or
$ git-read-tree a92b7b80579fe68fe229892815c750f6652eb6a9
also fail in the same way.

My linux-2.6 directory only has one entry, .git, containing about 75M of 
files.

Sam

Jeff Garzik wrote:
> 
> Things in git-land are moving at lightning speed, and usability has 
> improved a lot since my post a month ago:  
> http://lkml.org/lkml/2005/5/26/11
> 
> 
> 
> 1) installing git
> 
> git requires bootstrapping, since you must have git installed in order 
> to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
> have put together a bootstrap tarball of today's git repository.
> 
> Download tarball from:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> 
> tarball build-deps:  zlib, libcurl, libcrypto (openssl)
> 
> install tarball:  unpack && make && sudo make prefix=/usr/local install
> 
> jgarzik helper scripts, not in official git distribution:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> 
> After reading the rest of this document, come back and update your copy 
> of git to the latest:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> 
> 
> 2) download a linux kernel tree for the very first time
> 
> $ mkdir -p linux-2.6/.git
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> \          <- word-wrapped backslash; sigh
>     .git/
> 
> 
> 3) update local kernel tree to latest 2.6.x upstream ("fast-forward merge")
> 
> $ cd linux-2.6
> $ git-pull-script \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> 
> 4) check out files from the git repository into the working directory
> 
> $ git checkout -f
> 
> 
> 5) check in your own modifications (e.g. do some hacking, or apply a patch)
> 
> # go to repo
> $ cd linux-2.6
> 
> # make some modifications
> $ patch -sp1 < /tmp/my.patch
> $ diffstat -p1 < /tmp/my.patch
> 
> # NOTE: add '--add' and/or '--remove' if files were added or removed
> $ git-update-cache <list of all files changed>
> 
> # check in changes
> $ git commit
> 
> 
> 6) List all changes in working dir, in diff format.
> 
> $ git-diff-cache -p HEAD
> 
> 
> 7) List all changesets (i.e. show each cset's description text) in local 
> branch of local tree, that are not present in remote tree.
> 
> $ cd my-kernel-tree-2.6
> $ git-changes-script -L ../linux-2.6 | less
> 
> 
> 8) List all changesets:
> 
> $ git-whatchanged
> 
> 
> 9) apply all patches in a Berkeley mbox-format file
> 
> First, download and add to your PATH Linus's git tools:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git
> 
> $ cd my-kernel-tree-2.6
> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts
> 
> 
> 10) don't forget to download tags from time to time.
> 
> git-pull-script only downloads sha1-indexed object data, and the 
> requested remote head.  This misses updates to the .git/refs/tags/ and 
> .git/refs/heads directories.  It is advisable to update your kernel .git 
> directories periodically with a full rsync command, to make sure you got 
> everything:
> 
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> \          <- word-wrapped backslash; sigh
>     .git/
> 
> 
> 11) list all branches, such as those found in my netdev-2.6 or 
> libata-dev trees.
> 
> Download
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>     or
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> 
> $ cd netdev-2.6
> $ ls .git/refs/heads/
> 
> { these are the current netdev-2.6 branches }
> 
>> 8139cp       forcedeth    master     qeth           smc91x         we18
>> 8139too-iomap  for-linus    natsemi      r8169      smc91x-eeprom  wifi
>> airo           hdlc         ns83820      register-netdev  starfire
>> atmel          ieee80211    orinoco      remove-drivers   tlan
>> chelsio        iff-running  orinoco-hch  sis900           veth
>> dm9000         janitor      ppp          skge             viro
> 
> 
> 
> 12) make desired branch current in working directory
> 
> $ git checkout -f $branch
> 
> 
> 13) create a new branch, and make it current
> 
> $ cp .git/refs/heads/master .git/refs/heads/my-new-branch-name
> $ git checkout -f my-new-branch-name
> 
> 
> 14) examine which branch is current
> 
> $ ls -l .git/HEAD
> 
> 
> 15) undo all local modifications (same as checkout):
> 
> $ git checkout -f
> 
> 
> 16) obtain a diff between current branch, and master branch
> 
> In most trees WITH BRANCHES, .git/refs/heads/master contains the current 
> 'vanilla' upstream tree, for easy diffing and merging.  (in trees 
> without branches, 'master' simply contains your latest changes)
> 
> $ git-diff-tree -p master HEAD
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
