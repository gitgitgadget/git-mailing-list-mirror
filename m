From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 11:30:35 +0200
Message-ID: <20050723093035.GB11814@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <1122068634.7042.35.camel@localhost.localdomain> <7vu0imh23q.fsf@assigned-by-dhcp.cox.net> <1122108098.6863.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:31:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwGLV-0000nE-PA
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 11:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVGWJal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 05:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGWJak
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 05:30:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34321 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261656AbVGWJai (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 05:30:38 -0400
Received: (qmail 16767 invoked by uid 2001); 23 Jul 2005 09:30:35 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <1122108098.6863.38.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 10:41:38AM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> Another problem with the template is when one wants a header as well as
> footer (for things like '-*- mode: text; -*-'). Maybe something like
> below would work:
> 
> GIT: your header
> @DESCRIPTION@
> GIT: your footer
> GIT: @FILELIST@
> 
> where @DESCRIPTION@ is either a blank line for cogito or the existing
> patch description for StGIT. One could also add a 'Signed-...' line when
> the patch is first created (instead of a blank line).
> 
> For StGIT, one could add something like @PATCHNAME@ as well.

Great idea.

> > When you merge two projects like Linus did between git.git and
> > gitk, obviously the person who is merging the two is responsible
> > for merging the per-project default configuration and resolving
> > conflicts.  This probably should be overridable by individual
> > developers who pull/fetch into their repository by having per-
> > repository configuration.
> 
> The problem appears when one upstream maintainer changes the
> configuration, should this be merged again? In this case you can get
> conflicts.

So you resolve them...? If the upstream keeps doing changes frequent
enough and large-scale enough to this becoming annoying, something is
wrong. :-)

> > > That's the thing I didn't like in GNU Arch. You modify the file ignoring
> > > rules for example and the change will be included in the next commit.
> > > You could only get some defaults when cloning a repository, otherwise
> > > once you have different preferences from the repository's maintainer,
> > > you start getting conflicts in the config files.
> > 
> > That's why I suggested to have "_git" (project wide default)
> > separate from $GIT_DIR/info (repository owner's discretion), the
> > latter overriding the former.
> 
> That's OK with one issue - git should be able to exclude _git when
> generating a diff between 2 trees, unless one can enforce the _git/*
> files to be read-only.

Why? I think those meta-information is important too, and if it differs,
I want to see it in the diff. Oh, now I see what you mean - to
optionally exclude it. That would be nice, having --exclude in
common diff options.

> Another option would be to have .git/info/<branch> and, with cogito for
> example, .git/info/origin should always be pulled, even if the local
> files were modified. You would override these settings
> in .git/info/master. The problem is to define the branches order in
> which the settings are read.

Yes, and you may be pulling from multiple branches. I would keep
.git/info simple and single-instanced. If you want your stuff to
propagate to others, put it to .gitinfo/.

> > > Again, having Porcelain specific options mixed in the same file might
> > > lead to some confusion among users.
> > 
> > True.  We need to be careful.
> 
> This could be avoided by using ini-like files (well, easy to read in
> Python) and have [git] (for the common things like author name),
> [cogito], [stgit] etc. sections.

Now if it is going to look like this, I think separate files would be
much more practical, more effective and likely simpler for the user as
well. For Cogito-specific stuff, the user can well dive into
Cogito-specific configuration files, I think. (Well, there's none now;
there is .cgrc but that only contains default options for Cogito
commands and will stay so; I plan ~/.cg/cogito.conf or something.
Actually, perhaps the Git configuration file should be ~/.git/git.conf -
it looks cool, doesn't it?)

> The problem is how much similar we want the Porcelains to be regarding
> the settings and the templates. For StGIT, it is much simpler to have
> something like '%(FILELIST)s' rather than '@FILELIST@' in a template but
> I have not problem with switching to a common syntax. But we should see
> what can easily be changed.

I chose @FILELIST@ only since it is a common convention to have this as
rewrite placeholders, and I think it's more visually clear than
%(FILELIST). Were you insisting on the second syntax, I wouldn't have
%any problem switching, though. Cogito does no @@ rewriting yet.

> I will write a list with what files StGIT uses and where they are placed
> and we can agree on a structure. I think the .git/ directory usage is
> more important to be clarified than having a common {git,cogito,stgit}rc
> file.

Agreed. What Cogito uses:

	.git/author	Default author information in format
				Person Name <email@addy>

	.git/branch-name
			Symbolic name of the branch of this repository.
			This is purely descriptive, does not need to be
			unique and is used only in commit-post. I need
			to distinguish commits done in git-pb and Cogito
			so that's the contents of this file in those two
			repositories. Quite ad-hoc and deserves a better
			solution, but I have none so far; in the future,
			I might just have shared repository for those
			two and use the head name.

	.git/commit-template
			Commit template to use in the commit editor
			instead of some short header (most of it is
			still hardcoded).

	.git/exclude	--exclude-from for git-ls-files
			I want to rename this to .git/ignore

	.git/hooks/commit-post
			COMMIT-ID BRANCHNAME
			(could be <headname> if no branchname defined)

	.git/hooks/merge-pre
			BRANCHNAME BASE CURHEAD MERGEDHEAD MERGETYPE
			MERGETYPE is either "forward" or "tree".
			The merge is cancelled if the script returns
			non-zero exit code.

	.git/hooks/merge-post
			BRANCHNAME BASE CURHEAD MERGEDHEAD MERGETYPE STATUS
			MERGETYPE is either "forward" or "tree".
			For "forward", the STATUS is always "ok",
			while for "tree" the STATUS can be
			"localchanges", "conflicts", "nocommit",
			or "ok".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
