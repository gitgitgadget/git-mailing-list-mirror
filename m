From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Tue, 19 Oct 2010 12:12:15 +0530
Message-ID: <20101019064210.GA14309@kytes>
References: <20101018051702.GD22376@kytes>
 <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 08:43:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P85ua-0002PI-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 08:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab0JSGm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 02:42:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51003 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab0JSGm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 02:42:58 -0400
Received: by gwj19 with SMTP id 19so220164gwj.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t2IENkv0CGrtU2z2Rg060smrrZrSufWGIKUx+zLw6T0=;
        b=eDdHWTCD04qjmfrEIdIyufCxjqYjIndLO6XCe/CziQvJ07G+Q4Wo3fc+r3nF16SNK7
         n+r7v/iAofXTEJPfMXMrWECtzkVqwkchq8kSiCvBNuiEOl6h9GGZkZfjLHueNz9fYGae
         mnD8YzJnTvPn++3cpwUn4nYxUM902I4eHqA54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=P6YCR5qU2wBhp7WT2LOS9cpa8QxdfMOExeWcg0WZIiKNSDOzIi20kH3yuP+8o96XRp
         EnEgl/lU2SzznlUElOPm1zaqG7B4X7tmlu98lDfO/FgtJYOp3aEFwLOw6LuPPWr6Myed
         1gWMcYgwOD+Oi5kjwdIf+56LioYep7EkXYZ1Q=
Received: by 10.101.74.11 with SMTP id b11mr3657868anl.204.1287470577548;
        Mon, 18 Oct 2010 23:42:57 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id b25sm23312874anb.23.2010.10.18.23.42.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 23:42:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8043579.526738.1287452576766.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159307>

Hi Stephen,

Stephen Bash writes:
> > From: "Ramkumar Ramachandra" <artagnon@gmail.com>
> > Stephen Bash writes:
> > > Extracting SVN's History
> > > ------------------------
> > > First we want to understand SVN's branching/tagging history. Modify
> > > buildSVNTree.pl as necessary, then run
> > >    perl buildSVNTree.pl > svnBranches.txt
> > 
> > > ...
> >
> > Unnecessary
> 
> I'm going to collapse all these comments because I think we're
> coming at this from different angles.  I agree, discovering the
> copies in git is "easy" (albeit an n^2 operation), and git will
> correctly identify file content.  But when I was asked to preserve
> the SVN history, I decided to extract a DAG from SVN and migrate
> that DAG to Git.  Thus the history itself is preserved (sans
> merges), not just the contents of the files.  This is the purpose of
> buildSVNTree.  I can elaborate further if requested.

Yep, they're certainly two different ways to approach the problem: I'd
be interested in investigating why it will produce different
results. Since we both agree that it's easier (and faster) to do it in
Git-land, I'm looking into the the areas where it falls short.

Yes, I understand your script (although I can't actually read Perl
:p), but the differences are still not very clear to me.

> > > Ah, I should probably mention: svn-fe can produce "empty"
> > > commits, and filterBranch does nothing to remove them. By "empty" I
> > > mean there will be a commit object without any content changes. So
> > > creating a branch/tag in SVN creates a commit, but doesn't change
> > > content. That commit will be part of the new Git history.
> > > Similarly, filterBranch will create git tags from svn tags, but they
> > > point to one of these "empty" commits rather than the branch they
> > > are tagged from. It's not very git-ish, but it seems to work...
> > 
> > Oh, I didn't realize that fast-import allows the creation of empty
> > commits. We should probably fix this?
> 
> To be precise: svn-fe creates commits where
>   git diff-tree treeA treeB
> is empty with treeA being the tree object of /trunk/project and
> treeB being the tree of /branches/foo/project.  This version of my
> tools does not squash these commits, a future version probably will
> (this may cause problems with two-way communication?).

Right, that IS expected behavior. Don't they correspond to separate
SVN revisions anyway? Why would you want to squash them?

[Ignore this; see later in the email]

> > > filterBranch is probably the longest step of the process; there's a
> > > lot of filtering going on. It will be very verbose on STDOUT, so I
> > > recommend tee'ing to a file or a terminal with infinite scroll back.
> > > It also involves a lot of disk hits (somewhat reduced if $tempdir is
> > > a RAM disk), and potentially a lot of space (it will create a git
> > > repo for every branch/tag in your subversion history). For our
> > > repository this step took about 1.5-2 hours IIRC.
> > 
> > Wow, this really brute-force.
> 
> Yes it is.  If I get around to writing a new version, I'll at least
> advance to a single pass using commit-tree.  Beyond that I'm
> probably into the fast-import code, which I'll happily leave to the
> rest of you :)

*nod*

> > > Note that SVN rev to Git commit can be one to many!
> >
> > Unless there's a one-to-one mapping between Git revisions and SVN
> > revisions, a two-way bridge will become very difficult to build. Can
> > you think of any scenarios where a one-to-one mapping doesn't make
> > sense?
> 
> I have 32 SVN revs in my history that touch multiple Git commit
> objects.  The simplest example is
>   svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
> which creates a single SVN commit that touches two branches
> (badBranchName will have all it's contents deleted, goodBranchName
> will have an "empty commit" as described above).  The more devious
> version is the SVN rev where a developer checked out / (yes, I'm not
> kidding) and proceeded to modify a single file on all branches in
> one commit.  In our case, that one SVN rev touches 23 git commit
> objects.  And while the latter is somewhat a corner case, the former
> is common and probably needs to be dealt with appropriately (it's
> kind of a stupid operation in Git-land, so maybe it can just be
> squashed).

Ouch! Thanks for the illustrative example- I understand now. We have
to bend backwards to perform a one-to-one mapping. It's finally struck
me- one-to-one mapping is nearly impossible to achieve, and I don't
know if it makes sense to strive for it anymore. Looks like Jonathan
got it earlier.

> > Grafts and filter-branch. db-svn-filter-root does this more elegantly.
> 
> I found a 'db-svn-filter-root' branch, but it was not entirely
> obvious to me what code I should be looking at...

Um, there's just one commit that deviates from the branch it's based
on (but you don't know that, and I should have been clearer): look at
contrib/svn-fe/svn-filter-root.py

It's just a minimalistic mapper, but it's fast and done nicely. You
can use ideas from it when you're building yours.

> > > Hiding 'Deleted' Branches
> > > -------------------------
> > 
> > Hm. You didn't include the history of deleted branches in the main
> > repository. Why? 
> 
> The commit objects are still there, I simply moved the refs to
> refs/hidden/{heads,tags}.  Because my goal was to maintain the full
> SVN history I needed to somehow protect the objects from garbage
> collection.  At the time I didn't know about "git merge -s ours", so
> this strategy achieved my goal of protecting the objects.  In this
> case, the refs are not cloned, but are fetch-able, so I found it to
> be a reasonable solution.

Oh.

> > Does it make sense to provide the user an option to
> > exclude some (deleted) branches in the SVN history? It'll make the
> > two-way mapping extremely difficult.
> 
> I think there are cases where a user could say "I don't care about
> dead development branches".  In my current system, all branches,
> even those that do not contribute back to the trunk are saved in the
> hidden namespace.  But I could see users that don't care about some
> or all extraneous branches and would be happy to not convert them or
> to let them be garbage collected.

When I made this comment, I was thinking of the one-to-one mapping. It
makes much more sense now.

> > Thanks for the interesting and insightful read :)
> 
> I'm glad it's stimulating conversation.  I'm beginning to wonder if
> there might be competing design goals for one-way vs. two-way
> compatibility...  Performance is one place where opinions probably
> greatly differ (I didn't mind taking an extra 30 minutes to mirror
> my SVN repo because it probably saved more than that in
> communication overhead later in the process, but that mirror
> operation is very taxing on your timeline); my exhaustive search of
> all SVN copies is another (I wanted to be *extremely* certain I knew
> about all the misplaced branches/tags, but it's inefficient for a
> casual developer who just wants to interact with an SVN server).
> It's all just food for thought, and I'm happy to carry on the
> conversation from my different point-of-view :)

Ok, I still don't get this part- why mirror at all? Can't all the
information be mined out of the in-memory tree that svn-fe builds
while parsing the dumpfile? From the SVN-side, all that's required is
a streaming dumpfile like the one that `svnrdump dump` produces.

-- Ram
