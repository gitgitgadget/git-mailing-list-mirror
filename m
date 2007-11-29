From: "Gustaf Hendeby" <hendeby@gmail.com>
Subject: Re: git-svn: surprising behaviors/bugs?
Date: Thu, 29 Nov 2007 10:59:51 +0100
Message-ID: <bf7b2dda0711290159v49b5bc2elb072b610d2237755@mail.gmail.com>
References: <bf7b2dda0711220537h3f37c84ag899b74daa9a8fe1f@mail.gmail.com>
	 <20071129081031.GF32277@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 11:00:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxgBq-0001s7-Oz
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 11:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758403AbXK2J7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 04:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758116AbXK2J7y
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 04:59:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:62878 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108AbXK2J7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 04:59:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1495694rvb
        for <git@vger.kernel.org>; Thu, 29 Nov 2007 01:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c+NtBHBlj3eP3pZsk1axh5EZOD/v1tkJEwi4Zuxyijk=;
        b=kWwXB0lLzVnv7+zyhU01erYa1AtnQRpPmAO/sHEQUnghmsFMJDvsWzz97YmNVFIJNm8H1nS7YkvjnA0o2z+FoCgA3Kfm2GtNN8vIuGqGfgbXDiQ7YB40TElErfAjKrFiFBMM+PNPTnvULCh2P+m2gLMsdyyiE1oXVm1/+XKFmh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HqqADKDgwFg5aMOejkUma7HtwSzTHPeUS8hQQZ5QANXPxBKurbOK8Wfaq+ZbV6+AHA2DW23e0TOkDLXbGTnCcRLKvJkYmvb2SVeukGrpue5ylxHrTdjFYD57MS3r8pzDJhBjcNjsvDo9jVkwmPEPKlaUlfYdrL3aS97RO2rXLVg=
Received: by 10.141.189.4 with SMTP id r4mr3162688rvp.1196330391728;
        Thu, 29 Nov 2007 01:59:51 -0800 (PST)
Received: by 10.140.173.1 with HTTP; Thu, 29 Nov 2007 01:59:51 -0800 (PST)
In-Reply-To: <20071129081031.GF32277@soma>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66523>

On Nov 29, 2007 9:10 AM, Eric Wong <normalperson@yhbt.net> wrote:
> Gustaf Hendeby <hendeby@gmail.com> wrote:
> > 1.  I don't really like svn's committer info, so I got an authorsfile
> > set.  This works great when I'm fetching/dcommitting from the
> > top-directory in my git checkout (the one with .git in), however, if
> > I'm in a subdirectory the authorsfile doesn't kick in and I get the
> > svn commiter info.  This is not a big deal, but a bit surprising and
> > my history gets a bit ugly.
>
> I see you've already fixed that.  Thanks.

Yes, it turned out to be easier than I thought.  The fix indicates
that other options are lost as well, but I don't know how to test for
that or it would have been easier for others to verify the problem.

> > 2.  My second problem involves getting the support in git-svn for tags
> > and branches to work.  Having a standard layout of the svn repository,
> > in this case
> >    /source/project/(trunk|branch|tags)
> > svn clone -s only works as expected sometimes.  Sometimes I only get
> > the revision history, not including any actual content (ie none files
> > of the files under control turns up in git) from the clone.  When I
> > get this problem I usually clone the trunk only, and add tags myself.
> > This is far from optimal, and also error prone.  Other times, the
> > clone works as expected and gives me the tags and branches and all the
> > content.
>
> Any chance there's a BOFH at the other end playing around with
> permissions while you were testing?

This time I think BOFH is innocent, unless for maybe setting up the
SVN repository in a stupid way.

> > I think the problem occurs when I'm not the owner of the svn
> > repository, and only have access (read/write) to the
> > project/(trunk|branch|tag) part, and don't have any access at all to
> > source.  Ie, svn ls works for /source/project and
> > /source/project/trunk etc, but not /source (where I returns 403
> > Forbidden access).  All svn access is through a svn-server that I
> > can't control myself.
>
> I'll have to look into that some other time.

Would be great, thanks, let me know how I can help.  I've tried to
answer your questions about the setup below.

>
> Does `svn log -v' work for /source/project ?

Works just fine.

>
> Am I correct in what you have is currently like this?
>
> [svn-remote "svn"]
>         url = http://domain/
>         branches = source/project/branches/*:refs/remotes/*
>         tags = source/project/tags/*:refs/remotes/tags/*
>         fetch = source/project/trunk:refs/remotes/trunk
>
>
> If so, can you change it to something like this?
>
> [svn-remote "svn"]
>         url = http://domain/source/project
>         branches = branches/*:refs/remotes/*
>         tags = tags/*:refs/remotes/tags/*
>         fetch = trunk:refs/remotes/trunk
>
> And see if that works all the time?

I just made three different setups to get the same (problematic) project.

PLAIN TRUNK (works as expected, but lacks tags/branches)
git svn init https://svn.isy.liu.se/rt/tidefelt/source/shapes shapes.trunk
cd shapes.trunk
git svn fetch  # Now gives me the history of the trunk with all content
cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://svn.isy.liu.se/rt/tidefelt/source/shapes/trunk
        fetch = :refs/remotes/git-svn


WITH STANDARD LAYOUT (gets no content)
git svn init -s https://svn.isy.liu.se/rt/tidefelt/source/shapes shapes
cd shapes
git svn fetch  # No files present in any commit
cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://svn.isy.liu.se/rt
        fetch = tidefelt/source/shapes/trunk:refs/remotes/trunk
        branches = tidefelt/source/shapes/branches/*:refs/remotes/*
        tags = tidefelt/source/shapes/tags/*:refs/remotes/tags/*

What seems to complicate things here, and that I didn't realize
before, is that I have access to https://svn.isy.liu.se/rt (at least
read), so if git-svn starts from the bottom and checks for premissions
it will find this root directory.

WITH CHANGED STANDARD LAYOUT (retrieves neither content nor tags)
git svn init -s https://svn.isy.liu.se/rt/tidefelt/source/shapes shapes.fix
cd shapes.fix
# Edit .git/config
git svn fetch
cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[svn-remote "svn"]
        url = https://svn.isy.liu.se/rt/tidefelt/source/shapes
        fetch = trunk:refs/remotes/trunk
        branches = branches/*:refs/remotes/*
        tags = tags/*:refs/remotes/tags/*

The version where I make changes in .git/config file fails also for a
project that I don't have any problems with just using the -s option.
Do I have to do anything more than just change the config file?

All of the above git svn fetch complains a bit the first time with a
message similar to:

W: Ignoring error from SVN, path probably does not exist: (175007):
HTTP Path Not Found: REPORT request failed on
'/rt/!svn/bc/100/tidefelt/source/shapes':
'/rt/!svn/bc/100/tidefelt/source/shapes' path not found

Please, let me know if there is any other information that would be useful.

/Gustaf
