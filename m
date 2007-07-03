From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: pushing a project started in git back to a subversion repository...
Date: Tue, 3 Jul 2007 11:06:42 -0400
Message-ID: <e2a1d0aa0707030806w274fef7fkdcf9f2b0549c1c1c@mail.gmail.com>
References: <e2a1d0aa0707021329p29242393ua10817c85ca7422a@mail.gmail.com>
	 <20070703043733.GC4007@coredump.intra.peff.net>
	 <e2a1d0aa0707030656h63676f49l36579197ef662232@mail.gmail.com>
	 <20070703142633.GC18597@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Jeff King" <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 17:06:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5jxr-0000CN-5Z
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 17:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757486AbXGCPGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 11:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760315AbXGCPGo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 11:06:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:50648 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760266AbXGCPGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 11:06:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2792506wah
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 08:06:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jl2irKJLatCA5v7m5PbjGo1MIGSiPG0NvrwL5RZTYg51fl6p9f7x3kne0ZRP1tQEx8CeKVoYiHGAStA9SlcVR0Ix97Zorm8XjJz7dDCVQWU/MbzB158p5hAVC611kc68RBp/QG4eEXqKZzF1euCYRLQHOk4nf49hvhse2P3Ctzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wc8vaLZ8+qVncpxlW8WyBQonSygG2HupaWUZ7TJKQ7Pol1SpjyRhstzMqFIdDi21YAHjOeuOiSvDH9h3tnmS/sCwGkcbaMOx9C57inA5cD2u1DTM9Uk3Qvd89sDlBPzWyKDM3+h0v5pFqAaTmRvgQW/zkEJ54+OcsDCJ6GO2+iw=
Received: by 10.115.76.1 with SMTP id d1mr6277344wal.1183475202259;
        Tue, 03 Jul 2007 08:06:42 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Tue, 3 Jul 2007 08:06:42 -0700 (PDT)
In-Reply-To: <20070703142633.GC18597@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51506>

Oh dear, I just noticed that my previous reply was to you directly,
instead of the list at large.

On 7/3/07, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 03, 2007 at 09:56:06AM -0400, Patrick Doyle wrote:
>
> > I started off with something like this -- actually, I tried "git-pull"
> > as well as "git-fetch", but in each case I ended up with a single
> > commit in the SVN repository with a log message reading something like
> > "merged ../path/to/original" instead of multiple commits, tracking the
> > log messages from the original repository.
>
> git-pull is the equivalent of git-fetch followed by a merge. But you
> don't want to do the merge, since you are going to graft. So you
> definitely don't want to pull. However, the merge should have all of the
> original commits in it, unless git-svn is somehow squashing the merge
> down into a single commit.
>
I thought that the git-merge implicit in "git-pull" is what was
squashing the merge down into a single commit.  Nowadays, when I try a
"git-pull" from my unrelated repository followed by a "git-svn
dcommit", I get an error (from the dcommit command) that it is unable
to extract revision information from one of the commits in the chain.

>
> > I found I needed to do "git-branch -D original", which makes me think
> > that either I'm still not doing something completely Kosher here, that
> > I'm still not understanding something, or that "git-branch" doesn't
> > know about the "info/grafts" file.  (I put my money on the first
> > explanation, and include the 3rd just for completeness).
>
> Hmm. It worked for me with '-d'. I did:
>
Ahhh... if I do the "git-branch -d original" _before_ I do the
"git-svn dcommit", then I get no warning, which makes sense because
everything on the "original" branch is on the "master" branch.  But,
if I do it _after_ I do the "git-svn dcommit", I get the warning and
have to use -D.  This is probably consistent with the history rewrite
that occurs with the "dcommit"

>
> > Oops, my bad, I mean "git-rev-list".  But even now, writing that, I
> > realize that they wouldn't show up there either -- git-rev-list lists
> > the commit chain for a given branch.  I'm just wondering what happened
> > to commit 0e3e0e1e that was in my original git repo and which seems to
> > have been replaced with commit 50a9979a in the new repo.  Of course
> > the hash has changed, since git-svn added a "git-svn-id" line to my
> > log message.  But I wonder why git-fsck doesn't report it as dangling.
> > "git-cat-file -p 0e3e" prints it out.
>
> Hmm. I wonder if git-svn squashed your changes during the merge, as I
> had mentioned previously. You could really get better answers from one
> of the git-svn people. :)
Ahh, but I forgot to include any git-svn people in my previous reply :-(

>
>
> It is presumably still referenced somewhere. Maybe even in your reflog
> (try git-reflog show).
>
yep -- it's referenced there.  Not that this matters.  I'm in the
"gee, now I'm curious" phase -- a dozen or so 200 byte entries
squished in the pack file aren't going to make any difference.

> > > > I'm also curious what experts would think of my fumbling efforts to
> > > > transfer this git-managed project into a git/svn-managed project,
> > > > maintaining the initial history.  Did I go tremendously out of my way
> > > > to do something that was a one-line command?
> > >
> > > More or less. ;)
> > >
> > > Presumably you could take your _existing_ repository, point it at your
> > > svn upstream (look in the .git/config of your svn-cloned repo, and there
> > > is presumably some svn config), and do the dcommit. Unfortunately, I
> > > have the privilege of never having used svn or git-svn, so I can't
> > > comment further.
> > >
> > I'm not sure that would work, as it appears that git-svn plays some
> > games to associate git commits with SVN commits (hence my question
> > about about why the 0e3e commit doesn't dangle anywhere).
>
> Right. It seems like there ought to be a way around this, but again, one
> of the git-svn people can answer better. :) Maybe try re-asking your
> question as "is there a way to do this easily" and cc'ing Eric Wong.
>
or, perhaps by bringing this back on the list, I'll get some more feedback :-)

> > Thanks for the comments and explanations.  At this point, I'm not sure
> > that git offers me anything better for me and my work-flows than what
> > I get from Subversion, or CVS, (or RCS, or for that matter, SCCS -- if
> > anybody still remembers that!), but I'm learning something new, and
>
> I thought the same way when I started with git, and then I realized that
> git opened up a lot of possibilities for changing my workflow in little
> ways. Coming from CVS, the concept of actually looking through history
> for information on a code problem was foreign to me. But now I use
> "git-log -p -S" all the time (-S is semi-confusingly documented under
> git-diff). And that becomes more useful when I make concise,
> well-documented commits, which is another thing git is great for. :)
>
> -Peff

Thanks again...

--wpd
