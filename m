From: Ximin Luo <xl269@cam.ac.uk>
Subject: Re: [git-svn] [FEATURE-REQ] track merges from git
Date: Sun, 06 Sep 2009 23:15:51 +0100
Message-ID: <4AA43497.8090101@cam.ac.uk>
References: <4A9565ED.4010608@cam.ac.uk> <20090905080337.GE22272@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 00:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkQ1R-0006Uj-PR
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 00:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149AbZIFWOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758135AbZIFWOY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 18:14:24 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:50906 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758125AbZIFWOY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 18:14:24 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from 94-192-233-202.zone6.bethere.co.uk ([94.192.233.202]:54277 helo=[192.168.1.64])
	by ppsw-5.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.155]:587)
	with esmtpsa (PLAIN:xl269) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1MkQ09-0006fk-Iq (Exim 4.70)
	(return-path <xl269@cam.ac.uk>); Sun, 06 Sep 2009 23:14:25 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20090905080337.GE22272@dcvr.yhbt.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127873>

Eric Wong wrote:
> You may want to try the "set-tree" function of git svn instead of
> dcommit, it was originally named "commit" back in the day  set-tree does
> not rewrite any history.
> 
> It fell out of favor because you could end up with a lot of non-linear
> history making it difficult for sharing diffs with SVN-using cow-orkers.
> 
> It is useful if you don't want to share your individual changesets, but
> push your work upstream to the SVN repos as one big ugly change.
> 
> But if you want a staircase effect in gitk, set-tree can be used to make
> individual commits where every change ends up as a merge (and you'll see
> two commits for every change you made)

My problem no longer requires using set-tree (see below), but just to let you
know that when I try to set-tree, it gives:

  $ git svn set-tree HEAD
  config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned
error: 1

In my repo, "remotes/git-svn" doesn't exist; I have

  $ git branch -a
  * master
    test1
    remotes/test1
    remotes/trunk

but the manual doesn't tell me how to select an svn-remote that's not "git-svn"..

>> (17:16:40) infinity0: i read a thread where it says those are different things
>> (17:16:41) offby1: infinity0: I suspect you're using git svn for something for
>> which it wasn't designed.
>> (17:17:17) infinity0: would it be possible, in theory, to have git-svn store
>> the git merge information in eg. the same way it stores the git-svn tag in the
>> svn commit message
>> (17:17:33) Grum: then just use svn?
>> (17:17:37) Grum: and a postit?
> 
> I don't agree with having git-specific metadata on the SVN side itself.
> Often times that git-specific metadata has SHA1s unique to the user that
> committed it, so it wouldn't be useful to anyone else unless users are
> merging from each others git repos (which is not an easy/natural
> workflow if SVN is the mainline).  Patch exchange is more
> reliable/easier...
> 
> I've also worked in places where alternative tools are frowned upon, so
> sending git-specific metadata over to SVN should always be optional.
> 
> The majority of folks I've worked with on SVN-hosted projects have never
> known about my git usage (that is changing as git popularity increases,
> however).
> 
>> (17:18:01) infinity0: i'm trying to link two separate svn repos together via git
>> (17:18:17) Grum: and that is just what offby1 said
>> (17:18:30) infinity0: "what" is
>> (17:18:40) Grum: I suspect you're using git svn for something for which it
>> wasn't designed.
>> (17:18:42) infinity0: as you all are saying, git merges and svn "merges" are
>> different things
>> (17:18:58) infinity0: ok, but it would be possible to make git-svn have this
>> functionality? or not
>> (17:18:59) offby1: certainly
>> (17:19:16) offby1: I fear not, since Eric Wong seems like a smart fella; if it
>> were doable, I suspect he'd have done it already.
>> (17:19:21) offby1: But then ... who knows, maybe he's busy.
> 
> I'm not smart but I am busy :)
> 
> Summary of the git svn merge tracking situation:
> 
> Mapping git <-> git merges to SVN:
> 
>   * already doable for the committing user with set-tree,
>     but makes history ugly for:
> 
>     a) yourself (with every commit set-tree'd individually)
>     b) SVN users (single set-tree with the newest commit)
>     c) all of the above (varying granularity)
> 
>   * Pushing git metadata to SVN will annoy SVN-only users
> 
>   * Putting git metadata in SVN may not be useful since SHA1s
>     may be specific to the user that made that commit.
> 
> Mapping SVN <-> SVN merges to SVN via git svn:
> 
>   * most likely to be doable, they'll become plain SVN <-> SVN merges,
>     see problems with getting SVN <-> SVN merges back to git, however...
> 
> Mapping SVN <-> SVN merges to git:
> 
>   * SVN can represent merges that git can't, SVN can be/is extremely
>     complicated when it comes to merges.
> 
>   * I don't see many projects (I care about) use SVN merge tracking,
>     which projects actually use it?  Maybe it's still too new and
>     distros/users are behind the upgrade curve...
> 
> I've probably missed some, I've been dozing off while replying to
> emails...
> 

Actually, it turns out that my original problem is simpler than any of these
scenarios. What I was doing was git <-> git merges, where both of these git
branches were tracking *different* SVN branches (in my original case, from
different repos; in my simplified test case, from the same repo).

Consider this scenario:

----A0*-----A1---+
     \            \
      B0*----B1----B2

branchA: A1
branchB: B2

Where A0* and B0* have both been dcommited into their SVN branches, but A1, B1
and B2 are present in the git repo only. A0* and B0* have the "git-svn-id" tag,
and show my svn committer name; A1, B1 and B2 are still pure git commits, and
show my git commiter name.

Scenario 1:

If HEAD is at B2, and we try to "git-svn dcommit", then what happens currently
is, git-svn will dcommit B1 then B2, re-writing them in the process (adding
git-svn-id and using the svn credentials instead of git credentials); however,
it will *miss out* dcommitting A1. So we get this:

----A0*-----A1----+
     \             \
      B0*----B1*----B2*

branchA: A1
branchB: B2*

where B1* and B2* are the re-written versions of B1 and B2, with the added
git-svn-id and the svn committer name instead of the git committer name. There
isn't a problem yet; but when we switch to branchA and dcommit, we get this:

      +-----A1*
     /
----A0*-----A1----+
     \             \
      B0*----B1*----B2*

branchA: A1*
branchB: B2*

Where A1* is the re-written version of A1. But B2* still has A1 as a parent,
and now we have an extra "duplicate" commit in our git repo. What's even worse
is that A1* is **not a parent** of B2*, and so future merges on the branches
will potentially need to resolve conflicts that were resolved already when
merging (A1, B1) to B2.

Scenario 2:

If however, we dcommit A1, then B1, then B2, the commits will be re-written in
such a way that the proper merge history is preserved, including the correct
parents.

In one of the follow-up emails to my original posting, I supplied a test script
(gitsvntest.sh) which demonstrates the 2 scenarios. You can use a GUI to review
the history graphs. I can re-send it if you can't find that email.

I'm not sure how hard this is to fix; I guess it would involve making dcommit
detecting the case where a commit has more than 1 parent, and recursing down
all the parents to see if they are tracking an svn branch.

At the very least, I think this situation can be detected and the user warned.
In switching from svn to git, git-svn was very helpful to me, but this
behaviour confused me completely - sometimes things worked fine, depending on
the order in which I dcommited stuff, so it was incredibly hard to figure out,
especially since at that time I had no understanding of the concept of object
graphs and rewriting commits and that sort of thing.

X
