From: Matt Mackall <mpm@selenic.com>
Subject: Mercurial vs Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 16:56:34 -0700
Message-ID: <20050623235634.GC14426@waste.org>
References: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Fri Jun 24 01:54:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlbWb-00008b-Kb
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVFWX7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVFWX7U
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:59:20 -0400
Received: from waste.org ([216.27.176.166]:50127 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262928AbVFWX4h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 19:56:37 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5NNuZqV030453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Jun 2005 18:56:35 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5NNuYPS030450;
	Thu, 23 Jun 2005 18:56:34 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <42B9E536.60704@pobox.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
> 
> Things in git-land are moving at lightning speed, and usability has 
> improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11

And here's a quick comparison with the current state of Mercurial..

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

Download from: http://selenic.com/mercurial/mercurial-snapshot.tar.gz
Build-deps: Python 2.3
Install: unpack && python setup.py install [--home=/usr/local]

> 2) download a linux kernel tree for the very first time
> 
> $ mkdir -p linux-2.6/.git
> $ cd linux-2.6
> $ rsync -a --delete --verbose --stats --progress \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> \          <- word-wrapped backslash; sigh
>     .git/

$ mkdir linux-2.6
$ cd linux-2.6
$ hg init http://www.kernel.org/hg/    # obviously you can also browse this

This downloads about 125M of data, which include the whole kernel history
back to 2.4.0 and everything in Linus' git repo as well.

> 3) update local kernel tree to latest 2.6.x upstream ("fast-forward merge")
> 
> $ cd linux-2.6
> $ git-pull-script \
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

$ hg pull        # defaults to where you originally pulled from

It takes about 4M of transfer and well under a minute to pull the
entire git history, starting from a base of 2.6.12-rc2.

> 4) check out files from the git repository into the working directory
> 
> $ git checkout -f

$ hg update      # or up or checkout or co, depending on your SCM habits

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

$ hg commit [files]    # check in everything changed or just the named files

5.1) undo the last commit or pull

$ hg undo

> 6) List all changes in working dir, in diff format.
> 
> $ git-diff-cache -p HEAD

$ hg status            # show changed files

> 7) List all changesets (i.e. show each cset's description text) in local 
> branch of local tree, that are not present in remote tree.
> 
> $ cd my-kernel-tree-2.6
> $ git-changes-script -L ../linux-2.6 | less

$ hg history | less         # How does git know what's not in the
                            # remote tree? Psychic?

> 8) List all changesets:
> 
> $ git-whatchanged

$ hg history | less

> 9) apply all patches in a Berkeley mbox-format file
> 
> First, download and add to your PATH Linus's git tools:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git
> 
> $ cd my-kernel-tree-2.6
> $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts

hg doesn't do mboxes directly, but you can do:

$ cat patch-list | xargs hg import

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

Tags in mercurial are properly version controlled and come along for
the ride with pulls. Also, the right thing happens with merges.
 
> 11) list all branches, such as those found in my netdev-2.6 or 
> libata-dev trees.
> 
> Download
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> 	or
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> 
> $ cd netdev-2.6
> $ ls .git/refs/heads/
> 
> { these are the current netdev-2.6 branches }
> >8139cp       forcedeth    master     qeth           smc91x         we18
> >8139too-iomap  for-linus    natsemi      r8169      smc91x-eeprom  wifi
> >airo           hdlc         ns83820      register-netdev  starfire
> >atmel          ieee80211    orinoco      remove-drivers   tlan
> >chelsio        iff-running  orinoco-hch  sis900           veth
> >dm9000         janitor      ppp          skge             viro

$ hg heads   # Has Andrew mentioned your git forest gives him a headache?

> 12) make desired branch current in working directory
> 
> $ git checkout -f $branch

$ hg update -C <rev or id or tag>

> 13) create a new branch, and make it current
> 
> $ cp .git/refs/heads/master .git/refs/heads/my-new-branch-name
> $ git checkout -f my-new-branch-name

Since the hg repo is lightweight, this is usually done by just having
different directories. Thus we don't explicitly name branches.

$ mkdir new-branch
$ cd new-branch
$ hg init -u ../linux   # makes hardlinks and does a checkout

> 14) examine which branch is current
> 
> $ ls -l .git/HEAD

$ echo $PWD

> 15) undo all local modifications (same as checkout):
> 
> $ git checkout -f

$ hg update -C

> 16) obtain a diff between current branch, and master branch
> 
> In most trees WITH BRANCHES, .git/refs/heads/master contains the current 
> 'vanilla' upstream tree, for easy diffing and merging.  (in trees 
> without branches, 'master' simply contains your latest changes)
> 
> $ git-diff-tree -p master HEAD

$ hg diff -r <rev> -r <rev> 

17) run a browsable, pullable repo server of the current repo on your
local machine

$ hg serve

18) push your changes to a remote server

$ hg push ssh://user@host/path/  # aliases and defaults in .hgrc

19) get per-file history

$ hg log <file> | less

20) get annotated file contents

$ hg annotate [file]

21) record that a file has been copied or renamed for the next commit

$ hg copy <source> <dest>

22) get online help

$ hg help [command]


More info at http://selenic.com/mercurial/

-- 
Mathematics is the supreme nostalgia of our time.
