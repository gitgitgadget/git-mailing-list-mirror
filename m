From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 08:41:01 +0200
Message-ID: <20050624064101.GB14292@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Fri Jun 24 08:38:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlhpr-00021p-0l
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 08:38:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVFXGo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 02:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFXGo5
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 02:44:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63675 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263186AbVFXGlD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 02:41:03 -0400
Received: (qmail 18340 invoked by uid 2001); 24 Jun 2005 06:41:01 -0000
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050623235634.GC14426@waste.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 24, 2005 at 01:56:34AM CEST, I got a letter
where Matt Mackall <mpm@selenic.com> told me that...
> On Wed, Jun 22, 2005 at 06:24:54PM -0400, Jeff Garzik wrote:
> > 
> > Things in git-land are moving at lightning speed, and usability has 
> > improved a lot since my post a month ago:  http://lkml.org/lkml/2005/5/26/11
> 
> And here's a quick comparison with the current state of Mercurial..

And here's a quick back-comparison with Cogito. ;-)

> > 1) installing git
> > 
> > git requires bootstrapping, since you must have git installed in order 
> > to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
> > have put together a bootstrap tarball of today's git repository.
> > 
> > Download tarball from:
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2
> > 
> > tarball build-deps:  zlib, libcurl, libcrypto (openssl)
> > 
> > install tarball:  unpack && make && sudo make prefix=/usr/local install
> > 
> > jgarzik helper scripts, not in official git distribution:
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> > http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> > 
> > After reading the rest of this document, come back and update your copy 
> > of git to the latest:
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git
> 
> Download from: http://selenic.com/mercurial/mercurial-snapshot.tar.gz
> Build-deps: Python 2.3
> Install: unpack && python setup.py install [--home=/usr/local]

Download from: http://www.kernel.org/pub/software/scm/cogito/
Deps: git's + bash + reasonable shell environment
Install: edit Makefile, make + make install

> > 2) download a linux kernel tree for the very first time
> > 
> > $ mkdir -p linux-2.6/.git
> > $ cd linux-2.6
> > $ rsync -a --delete --verbose --stats --progress \
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
> > \          <- word-wrapped backslash; sigh
> >     .git/
> 
> $ mkdir linux-2.6
> $ cd linux-2.6
> $ hg init http://www.kernel.org/hg/    # obviously you can also browse this

$ cg-clone \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/

(that will checkout to linux-2.6/ directory; you can specify the target
directory as the optional second parameter)

> > 3) update local kernel tree to latest 2.6.x upstream ("fast-forward merge")
> > 
> > $ cd linux-2.6
> > $ git-pull-script \
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> $ hg pull        # defaults to where you originally pulled from

$ cg-update	# defaults to where you originally pulled from

(cg-pull just gets the changes to your repository, but won't merge them
into your branch)

> > 4) check out files from the git repository into the working directory
> > 
> > $ git checkout -f
> 
> $ hg update      # or up or checkout or co, depending on your SCM habits

In Cogito, all files are always checked out.

> > 5) check in your own modifications (e.g. do some hacking, or apply a patch)
> > 
> > # go to repo
> > $ cd linux-2.6
> > 
> > # make some modifications
> > $ patch -sp1 < /tmp/my.patch
> > $ diffstat -p1 < /tmp/my.patch
> > 
> > # NOTE: add '--add' and/or '--remove' if files were added or removed
> > $ git-update-cache <list of all files changed>
> > 
> > # check in changes
> > $ git commit
> 
> $ hg commit [files]    # check in everything changed or just the named files

$ cg-commit [-m"Message"...] [files] # check in everything changed or just
                                     # the named files

If you pass multiple -m arguments, they get formatted as separate
paragraphs in the log message. It is customary for the first -m argument
to contain a short one-line summary.

Note that you must add/remove files by

$ cg-add files...

and

$ cg-rm files...

> 5.1) undo the last commit or pull
> 
> $ hg undo

$ cg-admin-uncommit

Note that you should never do this if you already pushed the changes
out, or someone might get them. (That holds for regular Git too.) See

$ cg-help cg-admin-uncommit   # (or cg-admin-uncommit --help)

for details. (That's another Cogito's cool feature. Handy docs! ;-)

> > 6) List all changes in working dir, in diff format.
> > 
> > $ git-diff-cache -p HEAD
> 
> $ hg status            # show changed files

$ cg-status		# show changed files
$ cg-diff [-c] [files]	# show the diffs, -c colourfully

> > 7) List all changesets (i.e. show each cset's description text) in local 
> > branch of local tree, that are not present in remote tree.
> > 
> > $ cd my-kernel-tree-2.6
> > $ git-changes-script -L ../linux-2.6 | less
> 
> $ hg history | less         # How does git know what's not in the
>                             # remote tree? Psychic?

# -c colourfully, -s prints only summaries, one line per changeset
$ cg-log [-c] [-s] -m -r linux-2.6 # List changes only in linux-2.6

Note that | less is unnecessary (even undesirable with -c).

> > 8) List all changesets:
> > 
> > $ git-whatchanged
> 
> $ hg history | less

$ cg-log [-c] [-s]

8.1) List all changesets in the origin branch:

$ cg-log [-c] [-s] -r origin

8.2) List all changesets concerning files CREDITS and fs/inode.c:

$ cg-log [-c] [-s] CREDITS fs/inode.c

> > 9) apply all patches in a Berkeley mbox-format file
> > 
> > First, download and add to your PATH Linus's git tools:
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git
> > 
> > $ cd my-kernel-tree-2.6
> > $ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts
> 
> hg doesn't do mboxes directly, but you can do:
> 
> $ cat patch-list | xargs hg import

Theoretically, dotest should work just fine even if you use Cogito.
Anyone tested it?

> > 10) don't forget to download tags from time to time.
> > 
> > git-pull-script only downloads sha1-indexed object data, and the 
> > requested remote head.  This misses updates to the .git/refs/tags/ and 
> > .git/refs/heads directories.  It is advisable to update your kernel .git 
> > directories periodically with a full rsync command, to make sure you got 
> > everything:
> >
> > $ cd linux-2.6
> > $ rsync -a --delete --verbose --stats --progress \
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
> > \          <- word-wrapped backslash; sigh
> >     .git/
> 
> Tags in mercurial are properly version controlled and come along for
> the ride with pulls. Also, the right thing happens with merges.

cg-update and cg-pull takes fetches new tags during a pull.

> > 11) list all branches, such as those found in my netdev-2.6 or 
> > libata-dev trees.
> > 
> > Download
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
> > 	or
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> > 
> > 
> > $ cd netdev-2.6
> > $ ls .git/refs/heads/
> > 
> > { these are the current netdev-2.6 branches }
> > >8139cp       forcedeth    master     qeth           smc91x         we18
> > >8139too-iomap  for-linus    natsemi      r8169      smc91x-eeprom  wifi
> > >airo           hdlc         ns83820      register-netdev  starfire
> > >atmel          ieee80211    orinoco      remove-drivers   tlan
> > >chelsio        iff-running  orinoco-hch  sis900           veth
> > >dm9000         janitor      ppp          skge             viro
> 
> $ hg heads   # Has Andrew mentioned your git forest gives him a headache?

$ cg-branch-ls

# Note that Cogito supports only remote  branches properly now; that
# will yet evolve (in some backwards-compatible way).

> > 12) make desired branch current in working directory
> > 
> > $ git checkout -f $branch
> 
> $ hg update -C <rev or id or tag>

You can check the desired branch out into another directory:

$ cg-clone path/to/linux-2.6/.git#branch anotherdir

Switching branches in place will be supported soon (although I have
doubts about its usefulness).

> > 13) create a new branch, and make it current
> > 
> > $ cp .git/refs/heads/master .git/refs/heads/my-new-branch-name
> > $ git checkout -f my-new-branch-name
> 
> Since the hg repo is lightweight, this is usually done by just having
> different directories. Thus we don't explicitly name branches.
> 
> $ mkdir new-branch
> $ cd new-branch
> $ hg init -u ../linux   # makes hardlinks and does a checkout

$ mkdir new-branch
$ cd new-branch
$ cg-clone -s ../linux-2.6

(Note that cg-clone given local path will do hardlinks too.)

We don't explicitly name branches either. You can make the branch
visible from the other tree by

$ cg-branch-add new-branch ../new-branch

and then refer to it as new-branch.

> > 14) examine which branch is current
> > 
> > $ ls -l .git/HEAD
> 
> $ echo $PWD

Always the "master" branch.

> > 15) undo all local modifications (same as checkout):
> > 
> > $ git checkout -f
> 
> $ hg update -C

$ cg-cancel

> > 16) obtain a diff between current branch, and master branch
> > 
> > In most trees WITH BRANCHES, .git/refs/heads/master contains the current 
> > 'vanilla' upstream tree, for easy diffing and merging.  (in trees 
> > without branches, 'master' simply contains your latest changes)
> > 
> > $ git-diff-tree -p master HEAD
> 
> $ hg diff -r <rev> -r <rev> 

$ cg-diff -r <rev> -r <rev>

> 17) run a browsable, pullable repo server of the current repo on your
> local machine
> 
> $ hg serve

Make it accessible over HTTP, SSH, rsync, or for the local users if you
just want them to access it.

> 18) push your changes to a remote server
> 
> $ hg push ssh://user@host/path/  # aliases and defaults in .hgrc

Will be supported Real Soon (tm) (well, probably sometimes next week).

> 19) get per-file history
> 
> $ hg log <file> | less

$ cg-log [-c] [-s] <file>

> 20) get annotated file contents
> 
> $ hg annotate [file]

Planned.

> 22) get online help
> 
> $ hg help [command]

$ cg-help [command]

Cool. Except where the concepts are just different, Cogito mostly
appears at least equally simple to use as Mercurial. Yes, some features
are missing yet. I hope to fix that soon. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
