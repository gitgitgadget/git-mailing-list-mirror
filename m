From: Petr Baudis <pasky@suse.cz>
Subject: Re: svn user trying to recover from brain damage
Date: Wed, 9 May 2007 18:22:59 +0200
Message-ID: <20070509162259.GY4489@pasky.or.cz>
References: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joshua Ball <sciolizer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 18:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlowa-0000a8-VI
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbXEIQXJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbXEIQXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:23:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55783 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755343AbXEIQXH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:23:07 -0400
Received: (qmail 3714 invoked by uid 2001); 9 May 2007 18:22:59 +0200
Content-Disposition: inline
In-Reply-To: <92fdc3450705090830t64c8f5b9r4af277807dfe834d@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46739>

  Hi,

On Wed, May 09, 2007 at 05:30:18PM CEST, Joshua Ball wrote:
> The git page says that this mailing list is for "bug reports, feature
> requests, comments and patches". Is there a mailing list for new users
> crying out for help? If so, forward me there.

  I think it fits in the "comments" category. :-)

> OK, I'm feeling very frustrated right now, so let me just say that git
> documentation sucks. All the documentation I can find anywhere falls
> into two categories:
> 
> 1. Tutorials for people brand new to version control, with just enough
> information for them to "obey the rules", but completely empty of any
> information that could help them exploit the real power of
> decentralized version control.
> 2. Technical documentation which assumes pre-obtained knowledge.
> 
> Now that I've insulted you and am probably not on your good side...
> 
> What the heck do these terms mean? The glossary on the Git wiki was
> unhelpful (I'll explain later). BTW, what is wrong with the wiki?
> (Particularly the excessive [grayed-out text [no match, add rest:
> "used by any common UNIX command. The fact that it is a
> mispronunciation of "]]. Is this some new kind of spam, or a buggy
> wiki feature?)

  Sorry, it was a bug-ridden wiki. I was desperately trying to debug
some weird behaviour, few moments ago I've finally nailed it down and
all should be fine now.

> HEAD
> HEAD REF
> working tree
> object
> branch
> merge
> master
> commit (as in the phrase "bring the working tree to a given commit")
> 
> While the Git wiki does in fact define all of these, it doesn't answer
> any of my questions about those terms:
> 
> Is there a difference between HEAD and the working tree?

  This is (unfortunately) case-sensitive:

  HEAD identifies the commit (our slightly confusing name for a
revision) that corresponds to your working tree - usually the latest
commit in your current branch (by default 'master').

  head is just the latest commit in a branch, any branch.

> Does HEAD change when I cg-switch/git-checkout?

  Yes, HEAD changes (starts pointing to your new branch) when you
cg-switch or git-checkout -b.

> What is an object? Is it a set of patches? A tree snapshot?

  Object is the basic unit of stored data Git works with. object may be
either:

	"blob" - file at a particular point of time
	"tree" - list of files, corresponding to a particular directory
	         (again at a particular point of time)
	"commit" - one revision in the project history; contains
	           information about the parent commit(s), who did
	           the commit, the commit message and link to the
	           corresponding root tree object
	"tag" - links to another object, with additional information
	        like who/when made the tag and the tag comment

  Git does not store patches on a conceptual level, only snapshots. (At
the implementation level, Git uses "patches" for more optimized storage,
but that's not so important.)

> What the heck is a branch? (Why does it have so many different
> definitions? I feel like every time I come across "branch" in the man
> pages, it means something different.)

  Because it's hard to define. :-)

  To make a cyclical definition, branch is the set of commits
referenced by a given head. Hmm, I'll have to think out some cute
non-confusing definition of branch, I'll follow up unless someone beats
me to it.

> More on branches: The wiki says that a group of commits linked
> together form a DAG. Does that mean every fork/clone/branch-create
> possibly doubles the number of branches. So if I fork and then
> remerge, do I have two branches?
> 
> A -> B -> D
> A -> C -> D
> 
> Would D be the head of this branch? If so, then heads do not uniquely
> identify a branch?

  Branch is a much looser concept than you seem to assume. Branch is
really just a fancy name for a 'head', so let's redefine 'head'. Let's
just say for now that 'head' is a named commit reference.

  This means that when you create a "new branch" 'foo' from branch
'master', the _only_ thing you really did was to copy the commit
reference 'master.

> Is there a standard revision notation? (Where my definition of
> "revision" is a tree snapshot. In SVN, it would be identified by a
> number.) `cg-diff -r A..B` works fine if A and B are branches, but how
> do I diff from an older revision to a newer revision? Can I diff
> between two revisions which haven't shared the same parent since 2006?

  You can diff between any two revisions. The ultimately "standard"
notation is to use the id of the revision (the long string of
hexadecimal digits), but the syntax is quite rich - see SPECIFYING
REVISIONS section of git-rev-parse(1).

  If you specify a branch where revision is expected, it means that the
latest commit (revision) on the branch is used.

> What about the master branch? Is there anything special about it? By
> special I mean, do any of the git or cogito commands implicitly assume
> that you are working with master? If git is truly decentralized, then
> wouldn't master be on an equal footing with all other branches?

  'master' is just the default name for the first branch in a
repository, but in theory you can name it any way you wish and use as
many branches as you want, all are equal.

  When fetching from a remote repository, some commands might assume in
certain conditions that 'master' is the primary branch of the remote
repository, but I'm not sure about the details and in which cases does
this still hold true.

> What is a merge? My understanding of merge comes from the SVN book,
> where it was described as diff+apply. Diff takes 2 arguments, and
> apply takes a 1 argument (if the patch is implicit). However, cg-merge
> only appears to take one branch. (There again a use of the word
> branch! Wouldn't commit or revision be a more accurate term?) Why does
> cg-merge only take one argument? Even if I use the -b switch, I'm
> still only up to two arguments. Where is the hidden argument?

  The hidden argument is your current branch. So cg-merge x will merge
the branch 'x' to your current branch: symbolically, kind of

	base=-b argument | base(HEAD, x)
	apply(HEAD, diff(base, x))

  The word 'branch' is used in an attempt to make it all less confusing
:-). But in fact, you can give cg-merge just id of a commit, it does not
have to be branch name.

> Lastly, the most important question of all, which may answer many of
> the questions above:
> 
> Can you fill in the missing pieces, making corrections where
> necessary? (recommend unispace font)
> 
> Command     |   Reads               |   Writes
> cg-fetch    | remote branch         | corresponding branch in local respository
> cg-commit   | working copy          | HEAD
> cg-update   | remote branch         | working copy AND HEAD
> cg-merge    | branch & working copy | working copy
> cg-diff     | arguments             | STDOUT
> cg-push     |                       | remote branch (usually origin)
> cg-pull     | remote branch         |
> cg-restore  |                       |

  Yes, mostly right. cg-merge calls cg-commit unless there are
conflicts, so it should be "working copy AND HEAD" too. cg-push reads
local branch (HEAD or -r argument). There is no cg-pull since people
coming from different VCSes have different ideas about what pull is; git
pull is equivalent to cg-update.

> Perhaps the Reads column should be split into two, like ReadInfo and 
> ReadSafety.
> ReadInfo would say which revision/branch/commit/object is being read for 
> actual
> content, while ReadSafety is only read to make sure that nothing will be 
> lost
> after running the command. (e.g., cg-update reads the working copy to make 
> sure
> that you are not in a partial merge, but once it knows that it is safe, it
> ignores the contents of working directory. I may have this totally wrong.)

  It actually does some magic so that you can do a merge while having
uncommitted changes in your working tree. ;-)

> On cg-fetch, is the remote branch necessarily remote? Or can you fetch
> from local
> cg-switch-branches? What does "corresponding branch in local
> repository" mean? Does cg-fetch touch your working copy?

  Fetch means that a remote branch's content is transferred to the local
repository; furthermore, all the remote branches have their local
counterparts that "reflect" how the branch looked in the remote
repository at a particular point of time. So e.g. when you clone a
repository, the remote default branch is mirrored locally as branch
'origin' - you can't switch to it (technically you could but that would
be very confusing), but you can merge it.

> What is the difference between cg-restore and cg-seek?

  cg-seek will temporarily bring your tree to a different commit to
explore the state back then, but you cannot make commits in this state;
your HEAD points to the seeked commit. On the other hand, cg-restore
only changes files in your working tree - it works on the individual
files, does not touch HEAD and does not make the tree "read-only".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
