From: "Chris Lee" <clee@kde.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Thu, 4 Jan 2007 10:54:46 -0800
Message-ID: <204011cb0701041054h76f1f178j3fd7994a01299be8@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <204011cb0701031816hda8af9bw4d4a469c2b111339@mail.gmail.com>
	 <204011cb0701040956p11ea2cepe3efaaf396056ac0@mail.gmail.com>
	 <Pine.LNX.4.64.0701041016010.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 19:56:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2XlE-0002ZG-Jp
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 19:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbXADSzH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 13:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbXADSzG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 13:55:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:11296 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbXADSyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 13:54:47 -0500
Received: by wr-out-0506.google.com with SMTP id 68so918492wri
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 10:54:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BuJqYBJaOgh4ZHBLvxuWXtrjA9mYDvYq3dxG2karUn/iTGe8xkEYtOMuaZrGHNpixSo4A2T5YGryWIrgDNrHaNH6bpXKFZAGQJldYWJjZ2k1tVNzSNdWHyb9IAePLB0/yKlF2MZjGob0F8CZV0TLGR5yTFzKpVgDE4G4ZQvdqqg=
Received: by 10.90.79.6 with SMTP id c6mr336959agb.1167936886831;
        Thu, 04 Jan 2007 10:54:46 -0800 (PST)
Received: by 10.90.83.17 with HTTP; Thu, 4 Jan 2007 10:54:46 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701041016010.3661@woody.osdl.org>
Content-Disposition: inline
X-Google-Sender-Auth: 31323739b6a1fa5b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35945>

On 1/4/07, Linus Torvalds <torvalds@osdl.org> wrote:
> Well, the good news is, I think we could probably split it up from within
> git. It's not fundamentally hard, although it is pretty damn expensive
> (and it would require the subproject support to do really well).

I was hoping that'd be possible at some point. I really want to split
the submodules back out into first-class modules - one of my biggest
misgivings about the current KDE repository setup is how everything is
part of one gigantic repository.

> So ignore that issue for now. I'd love to see the end result, if only
> because it sounds like you have a test-case for git that is four times
> bigger than the mozilla archive - even if it's just because of some really
> really stupid design decisions from the KDE SVN maintainers ;)

The full on-disk size of the KDE SVN repo is about 37GB, last time I
checked. It may be up to 38 or 39GB now - I last ran rsync against the
svn repo a few weeks ago. I'm only focusing on importing the first
409k revisions at the moment, because that comprises the commits that
originally came from CVS and were imported into SVN. Almost
immediately after the CVS import, coolo made some changes - moving all
of the core KDE modules into /trunk/KDE, and their branches and tags
into /branches/KDE and /tags/KDE respectively. This, I suspect will
end up making things "fun" for the other part of the import, which is
another 200k revisions, give or take.

So, yes, I suspect it's quite a bit larger than Mozilla. I'm doing the
conversion to git as a test so that I can show some numbers to the KDE
guys; I'm not trying to campaign for a transition to git, but I think
it's definitely worth exploring what such a world would look like. But
in order for me to try to make a compelling argument for an eventual
project move to git, the git win32 support would need to be really
good. (In KDE4, we're supporting Windows and OS X as well as X11 as
first-class platforms.)

> (But I would actually expect that KDE SVN uses SVN subprojects, so
> hopefully it's not _really_ one big repository. Of course, I don't know if
> SVN really does subprojects or how well it does them, so that's just a
> total guess).

I don't think so, but I'll ask coolo (the KDE SVN administrator).

> The real problem with a SVN import is that I think SVN doesn't do merges
> right, so you can't import merge history properly (well, you can, if you
> decide that "properly" really means "SVN can't merge, so we can't really
> show it as merges in git either").
>
> I think both git-svn and git-svnimport can _guess_ about merges, but it's
> just a heuristic, afaik. Whether it's a good one, I don't know.

Not too worried about the merges right now - as long as I have a rough
approximation of what the original looked like, I'm pretty happy.

> > Yeah. I haven't bothered hacking git-svnimport yet - but it looks like
> > having it automatically repack every thousand revisions or so would
> > probably be a pretty big win.
>
> That, or making it use the same "fastimport" that the hacked-up CVS
> importer was made to use. Either way, somebody who understands SVN
> intimately (and probably perl) would need to work on it.
>
> That would not be me, so I can't really help ;)

Well, Shawn pointed me at the fastimport stuff, and I happen to know
Perl reasonably well (I think) so I'll take a stab at trying it that
way.

> > By default, if I had, say, one pack with the first 1000 revisions, and
> > I imported another 1000, running 'git-repack' on its own would leave
> > the first pack alone and create a new pack with just the second 1000
> > revisions, right?
>
> Yes. It's _probably_ better to do a full re-pack every once in a while
> (because if you have a lot of pack-files, eventually that ends up being
> problematic too), but as a first approximation, it's probably fine to just
> do a plain "git repack" every thousand commits, and then do a full big
> repack at the end.

Sounds like a good idea. Also sounds like it would be much less
painful than the current situation, where it takes over nine hours to
pack up all these revisions. :)

> The big repack will still be pretty expensive, but it should be less
> painful than having everything unpacked. And at least the import won't
> have run with millions and millions of loose objects.
>
> So doing a "git repack -a -d" at the end is a good idea, and _maybe_ it
> could be done in the middle too for really big packs.

Okay, good to know.

> Again, doing what fastimport does avoids most of the whole issue, since it
> just generates a pack up-front instead. But that requires the importer to
> specifically understand about that kind of setup.

I'll definitely be investigating the fastimport option. Looks like
I'll get to crack open some of my Perl books - haven't had to do that
in a while. :)
