From: Josef Wolf <jw@raven.inka.de>
Subject: Re: git-svn clone behaves non-deterministic
Date: Thu, 27 Nov 2008 19:29:47 +0100
Message-ID: <20081127182947.GB12716@raven.wolf.lan>
References: <20081127075351.GA12716@raven.wolf.lan> <492E6E80.7010209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 19:31:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5leG-0007tR-Jt
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 19:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbYK0SaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 13:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbYK0SaP
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 13:30:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:59186 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYK0SaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 13:30:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1L5lcx-0003YP-BH; Thu, 27 Nov 2008 19:30:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 96FDD3A732; Thu, 27 Nov 2008 19:29:47 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <492E6E80.7010209@drmicha.warpmail.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101820>

Thanks for your reply, Michael!

On Thu, Nov 27, 2008 at 10:55:12AM +0100, Michael J Gruber wrote:
> Josef Wolf venit, vidit, dixit 27.11.2008 08:53:
> > Hello,
> > 
> > I am new to git and decided to get my feet wet by first cloning and
> > playing with my existing svn repositories.  Thus, I've done this:
> > 
> >  cd /my/test/repos
> >  for i in repo1 repo2 repo3; do
> >    repos=https://my.repos.server/repos/$i/trunk
> >    svn co        $repos svn/$i
> >    git-svn clone $repos git/$i
> >  done
> > 
> >  for i in `cd svn; echo *`; do diff --exclude /.svn -Nruw */$i; done
> > 
> > With this, I see that four of the repositories are cloned as expected,
> > but the fifth has only the .git directory in it.  It appears that
> > the clone command stopped cloning at r2008, while the repository is
> > currently at r3761.  So almost the half of the history was not
> > cloned at all.  I've investigated the offending revision and the
> > revisions around it, but I can't see anything special about them.
> > The effect is perfectly reproducible and it stops always on the very
> > same revision.  I get no error message at all.  I've attached the
> > last lines of the clone operation at the end of this mail.
> 
> First of all: What does git --version say? Is it self-compiled git or
> git as it comes with U 8.10?

This is git-1.5.6.3 as it comes with U-8.10.

> Then: I assume the above is not quite what you did, otherwise I would be
> surprised you see a 4th and 5th clone...

That's correct. :-)  I have actually changed the names and number of the
repositories to avoid disclosing too much privacy ;-)

> Your repo is probably one giant svn repo.

This are 5 repositories in total.  The repos with the problem above is
the biggest of them (about 80MB, 3761 revisions).  But on the other
machine the other repositories also have missing files.

> In any case, the fact that the
> repo is at $rev does not imply that the last commit on trunk is at $rev.
> What is the last commit on trunk?

While I have created the recommended tags/branches/trunk layout to be
prepared, there have never been commits to tags or branches.  A long
time ago (at revisions 83..90) there were commits to /vendor, but after
r90 only trunk was ever used.

So all commits from r90 on were commits to trunk and none of the
revisions since r2008 up to HEAD ever touched anything outside trunk.

> Other than that: There are so many sins you can commit (!) in an svn
> repo that it it is hard to tell which one threw git-svn off. Can you
> share the repo?

Unfortunately not. :-(

> > Then I go to another machine and enter exactly the same commands as
> > above.  Both machines are fresh ubuntu-8.10 default installs.
> > 
> > To my surprise, on this other machine the clone operation seems to
> > have worked for all the repositories.  But the diff command shows
> > me that arbitrary files are missing in _all_ of the repositories.
> 
> I don't think computers behave deterministically, at least not according
> to my experience. After all they rely on quantum mechanics, and who has
> ever understood the measurement process, the collapsing of the wave
> function?

Although everything relies on quantum mechanics, common experience shows
that our world is much more deterministic than one would expect from
quantum theory.  Have you ever seen a cat being dead and alive at the
same time? ;-)

> OK: Whenever I got 2 different results after doing the same twice I
> found that indeed some hidden/forgotten variable was not the same...
> Any chance you find one?

Well, I am new to git, so I was searching for help/guidance on the list.

BTW: I just found the git-fsck command:

     Checking HEAD link
     notice: HEAD points to an unborn branch (master)
     Checking object directory
     Checking reflog 0000..0000->e23f..6f50
     [ 1998 more "Checking reflog" files deleted ]
     Checking reflog 273e..5c24->43bb..aee6
     Checking connectivity (32 objects)
     Checking 03ea6bbee94997ab9ddaecb3088b460eb4b87636
     Checking edcb1771f35ff085b7dfd546bcc51938f15a05d0
     Checking d7c3ec4b134ebf151cf2e78f6af729ed3d345e0d

The output of this command looks a little bit strange to me as a
newcomer:

- "HEAD points to unborn branch" confirms that the import failed
- there are exactly 2000 "Checking reflog" lines.  Since the last
  imported revision was 2008, I would have expected 2008 (or 2007
  or 2009) such lines.  My first thought was this might be related
  to the --repack option defaulting to 1000.  But with --repack=570
  it also stops after r2008.
- the "Checking connectivity" line mentions 32 objects, but only
  three "Checking" lines are listed after that.
