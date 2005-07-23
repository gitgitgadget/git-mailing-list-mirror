From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 11:04:33 +0200
Message-ID: <20050723090433.GA11814@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <1122068634.7042.35.camel@localhost.localdomain> <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:05:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwFxC-0007JD-0Q
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 11:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVGWJFT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVGWJFT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 05:05:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12049 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261589AbVGWJEh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 05:04:37 -0400
Received: (qmail 14224 invoked by uid 2001); 23 Jul 2005 09:04:34 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Jul 23, 2005 at 01:07:05AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> 
> > Would such a template only have 'GIT:' prefixed lines? I usually put
> > another line like 'Signed-off-by:', for convenience. The problem with
> > StGIT appears when one wants to re-edit the patch description (stg
> > refresh -e), in which case the existing description should be merged
> > with a part of the template (if you want to get the editor setting for
> > example). It doesn't do this since there is no point in getting another
> > 'Signed...' line in the existing description.
> 
> If signed-off-by is the only thing you are worried about, how
> about making it not part of the commit template and the message
> user touches with the editor?  You first look at the user
> configuration somewhere to see if the user wants the
> signed-off-by line to his commits and with what value, and if
> the last lines of the edit result does not contain that value
> (to avoid duplicates), add it before feeding the message to
> git-commit-tree.

I would rather have something universal. Just avoid inserting duplicate
lines at the bottom.

> >>   - standard "dontdiff/ignore" file.
> >
> > StGIT currently uses .git/exclude, since I saw it used by cogito. What
> > is dontdiff supposed to do? The 'git diff' command only shows the diff
> > for the files added to the repository.
> 
> I see that what I wrote was vague and badly stated.  Please
> forget about my mentioning "dontdiff".  What I meant was your
> .git/exclude, Pasky's .gitignore file and friends.

Cogito supports .git/exclude too, but I'd rather rename it to
.git/ignore (or .git/conf/ignore) as well (gradually).

> >>   - environment overrides (COMMITTER_NAME, COMMITTER_EMAIL and
> >>     such).
> >
> > StGIT works the other way around. By default uses the environment, which
> > can be overridden by the stgitrc file. I could change this easily.
> 
> Again I was vague, and what you say StGIT does is exactly what I
> meant.  I have one value in my environment coming from the login
> shell, and a per- repository preference item overrides it to
> something else.

I have it the other way around, with the rationale that your default
settings should be in your ~/.gitrc, not environment, which is always
the highest priority. The simple reason is that how would I apply the
patches of other people otherwise? Now I do

	GIT_AUTHOR_NAME="Junio C Hamano" \
		GIT_AUTHOR_EMAIL="junkio@cox.net" \
		GIT_AUTHOR_DATE="2008-04-01 05:12:33" \
		cg-commit

and it makes complete sense to me.

> > For StGIT it makes sense to get some default settings via /etc/stgitrc.
> > There are things like a SMTP server and the diff3 command. These are set
> > when installing the application and can be overridden in your home
> > or .git directories.
> 
> Exactly, but that is not specific to StGIT, I presume, and I did
> not want to hear "``For StGIT'' it makes sense".  If StGIT needs
> to use "diff3" on a system, probably that is because "merge" is
> not available on that system.  In that case,  cogito needs to
> use it too, doesn't it?

diff3 throws its output on stdout, AFAIK.

> If we can make users and sysadmins not having to maintain two
> sets of configuration files for two Porcelains, if we
> can,... that is what I have been trying to address.

Yes, but it is a bit secondary to me. The most important for me is that
meta-files inside the project itself (e.g. .gitignore) should be as
portable as possible, as that'd be the biggest hurdle. The second
priority for me is to make ~/.git/ as universal as possible. Having
common per-user/per-system configuration file as well is nice too, but
not so crucial.

> > Before we get to "where", we should define the common
> > settings. I think that git should define the common settings
> > for its operations and the other tools should follow them.
> 
> Personally, unless it is something very obvious and basic, I do
> not think the core barebone Porcelain should be inventing
> arbitrary conventions and imposing them on other Porcelains.
> For very basic things I would agree.
> 
> I think Petr already started the discussion rolling for commit
> templates, and I like his proposal.  For ignore pattern files, I
> think what Cogito does sounds almost sensible [*1*] and I am
> sure StGIT have something similar.  I do not see Linus and co
> jumping up and down saying git-status should detect and show new
> files not registered in the cache, so for now I'd propose to
> skip adding this one to the barebone Porcelain (meaning, this is
> an example of not "git defining the common and others following
> suite").

(Quite some things came to git from Cogito anyway. ;-) And well, that's
completely natural.)

> *1* I said "almost sensible" but it is not meant to blame Pasky.
> I think the --exclude mechanism in git-ls-files should be
> extended to allow not just the filename-sans-leading-directory
> match but a full relative-to-the-project-root path match.  That
> way, cg-status would not have to run around in the tree to find
> individual .gitignore files.  
> 
> Personally, I think having to have ignore pattern like .cvsignore
> per-directory is simply _ugly_.

No, I think it's great. That increases the locality of things, which is
good. Think about it as of variables - it's nicer to have them local.
Also, with a central .gitignore file, how do you specify "Ignore all
*.html files under Documentation/" or so? (Without having ** - or you
need to support that one too to make the central .gitignore feasible.
But I think that in that case, it would depend on the user whether he
defines things in the central .gitignore or in subdirectories.)

> >>   - Use $HOME/.gitrc (could be a directory or a file in .ini
> >>     style like StGIT uses -- again, I do not care about the
> >>     details at this moment) to store per-user configuration.
> >
> > Again, having Porcelain specific options mixed in the same file might
> > lead to some confusion among users.
> 
> True.  We need to be careful.
> 
> Or course, there is an option of not worry about Porcelain
> compatibilities at all --- which is certainly simpler.  All we
> need is to make sure they do not use the same filename for
> conflicting purposes.  If everybody feels that way then this
> discussion is moot and I apologize for wasting people's time.

I don't think it is moot at all. (But see above - if we can't agree on
everything, I would much rather have common stuff in the project tree
than in ~ - there's not so much trouble of having multiple sets in ~,
but it's annoying to have e.g. .stgitignore, .cgignore and .jitignore in
each directory of the project, and if one project developer moves to
another Porcelain, having to add another set of files, and then keeping
them all up to date...)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
