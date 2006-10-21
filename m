From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 12:55:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211237460.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca>
	<20061021181149.GM75501@over-yonder.net>
	<20061021191949.GA8096@coredump.intra.peff.net>
	<200610212130.31414.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 21:56:06 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMwv-0001C4-LH
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 21:56:05 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbMwk-0004i4-8K; Sat, 21 Oct 2006 20:55:54 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GbMwh-0004hz-Ra
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 20:55:52 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9LJtkaX005900
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 12:55:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9LJtiF8032017;
	Sat, 21 Oct 2006 12:55:45 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610212130.31414.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29668>



On Sat, 21 Oct 2006, Jakub Narebski wrote:
> 
> That's good example of fully distributed approach. I can fetch directly
> (actually, I cannot) from Junio private repository, I can fetch from
> public git.git repository, either using git:// or http:// protocol,
> I can fetch from somebody else clone of git repository: intermixing
> those fetches, and revids (commit-ids) remain constant and unchanged.

This is nice for a couple of situations:

 - if some particular machine is down, nobody really cares. It doesn't 
   really change the workflow at all if "master.kernel.org" were to be 
   off-line due to some trouble - it just happens to be a machine with 
   good bandwidth that a number of kernel (and git) developers have access 
   to, but if you want to sync with something else, go wild. We could just 
   sync directly between developers, although most people tend to have 
   firewalls (I certainly have a very anal one - not even ssh gets in) 
   making it usually easier to go through some - any - public place.

   But in git, the "public place" really is just an intermediary. It has 
   nothing to do with anything history-wise, and it's revision ID's are a 
   non-issue. It's just a temporary staging area (although re-using the 
   same repo over and over for pushing things out obviously means you can 
   do just incremental updates, so most everybody does that)

 - sometimes you have multiple branches in the same tree that have very 
   _different_ sources. For example, you might start out cloning my tree, 
   but if you _also_ want to track the stable tree, you just do so: you 
   can just do

	git fetch <repo> <remote-branch-name>:<local-branch-name>

   at any time, and you now have a new branch that tracks a different 
   repository entirely (to make it easier to keep track of them, you'd 
   probably want to make note of this in your .config file or your remote 
   tracking data, but that's a small "usability detail", not a real 
   conceptual issue).

 - the same "multi-source" thing is true for pushing things out too, not 
   just fetching: I still have my personal git.git repository on 
   kernel.org for historical reasons, even though Junio maintains the 
   normal one. So when I did some experimental (and broken) stuff for "git 
   unpack-objects" in a local branch, and others were interested in fixing 
   it, I just pushed it out to my git repo as a new branch - one that 
   Junio doesn't have.

   So now my kernel.org git repo not only tracks all of Junio's branches 
   (basically just a mirror of his tree), I also have a few stale branches 
   of my own that I did some work on separately. So it's kind of a 
   "frankensteins monster" of different branches from different sources. 

   And I think that's fairly common, actually (ie many kernel developers 
   that publicise their own git trees often have a "linus" branch that 
   tracks mine, along with their own "real" branches)

And note how in none of these situtations does it matter what the 
"original" branch was. It might even be a way to just pre-populate the 
tree. For a real-life example, a week or two ago, Jesper Juhl wanted to 
download my kernel tree (which is about 140MB in size), but he's somewhere 
in Europe, and apparently the connection to kernel.org was just _really_ 
slow. 

So what I told him to do was:

   Hmm. I suspect most mirrors avoid the /pub/scm directory, but there are a 
   few places that mirror git trees in general, eg

        http://www.jur-linux.org/git/

   might be closer to you.

   Once you have _one_ kernel repo, you can clone another easily using

        git clone --reference <mylocalrepo> <remotereponame> [localdir]

   but you do need to have the thing in git format, not just a snapshot, to 
   do that.

and that's exactly what he did (and he could have just fetched into the 
original archive entirely):

   I could only get 2-3kb/sec from kernel.org and at that speed 140MB is 
   *HUGE*.

   That was a lot better. got more than 200kb/sec from there.

so the point here is, "distributed" really is more than star-topology. If 
you think outside the star, you can take useful shortcuts.

Now, I'm sure that bzr can probably do all the same things. This is likely 
less an issue of "technology" than of "mindset". The "git way" tends to 
make all of these things very trivial - the notion of tracking multiple 
branches from multiple _different_ repositories in one local repo just 
fits very naturally in the whole git mentality.

			Linus
