From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 09:41:38 +0100
Message-ID: <1122108098.6863.38.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <1122068634.7042.35.camel@localhost.localdomain>
	 <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 10:42:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwFZx-0005oh-AC
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 10:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGWIln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 04:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVGWIln
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 04:41:43 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:60181 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261560AbVGWIlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 04:41:42 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050723084140.NSSX25008.mta09-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Sat, 23 Jul 2005 09:41:40 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050723084140.IPAO24042.aamta11-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Sat, 23 Jul 2005 09:41:40 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-07-22 at 16:07 -0700, Junio C Hamano wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>
> If signed-off-by is the only thing you are worried about, how
> about making it not part of the commit template and the message
> user touches with the editor?  You first look at the user
> configuration somewhere to see if the user wants the
> signed-off-by line to his commits and with what value, and if
> the last lines of the edit result does not contain that value
> (to avoid duplicates), add it before feeding the message to
> git-commit-tree.

That's an idea.

Another problem with the template is when one wants a header as well as
footer (for things like '-*- mode: text; -*-'). Maybe something like
below would work:

GIT: your header
@DESCRIPTION@
GIT: your footer
GIT: @FILELIST@

where @DESCRIPTION@ is either a blank line for cogito or the existing
patch description for StGIT. One could also add a 'Signed-...' line when
the patch is first created (instead of a blank line).

For StGIT, one could add something like @PATCHNAME@ as well.

> > StGIT currently uses .git/exclude, since I saw it used by cogito. What
> > is dontdiff supposed to do? The 'git diff' command only shows the diff
> > for the files added to the repository.
> 
> I see that what I wrote was vague and badly stated.  Please
> forget about my mentioning "dontdiff".  What I meant was your
> .git/exclude, Pasky's .gitignore file and friends.

.gitignore are note currently supported by StGIT but I'll add this.

> When you merge two projects like Linus did between git.git and
> gitk, obviously the person who is merging the two is responsible
> for merging the per-project default configuration and resolving
> conflicts.  This probably should be overridable by individual
> developers who pull/fetch into their repository by having per-
> repository configuration.

The problem appears when one upstream maintainer changes the
configuration, should this be merged again? In this case you can get
conflicts.

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

This is not always the case. With StGIT you can define your own options
and tools for a three-way merge. This was implemented because Bryan
Larsen, I think, asked whether a different (smarter) tool could be used.
One might also want that when diff3 fails, a xxdiff or emacs should be
automatically started for the conflict files.

This could be simplified if we enforce the presence of a gitmerge.sh
file which only calls merge or diff3 by default. Users can create a new
file and put it in the $PATH.

> If we can make users and sysadmins not having to maintain two
> sets of configuration files for two Porcelains, if we
> can,... that is what I have been trying to address.

That's probably a good reason. Also people might use 2 Porcelains and
the plain git, they could have a common configuration, especially where
settings overlap.

> I think Petr already started the discussion rolling for commit
> templates, and I like his proposal.

I like it too.

> > That's the thing I didn't like in GNU Arch. You modify the file ignoring
> > rules for example and the change will be included in the next commit.
> > You could only get some defaults when cloning a repository, otherwise
> > once you have different preferences from the repository's maintainer,
> > you start getting conflicts in the config files.
> 
> That's why I suggested to have "_git" (project wide default)
> separate from $GIT_DIR/info (repository owner's discretion), the
> latter overriding the former.

That's OK with one issue - git should be able to exclude _git when
generating a diff between 2 trees, unless one can enforce the _git/*
files to be read-only.

Another option would be to have .git/info/<branch> and, with cogito for
example, .git/info/origin should always be pulled, even if the local
files were modified. You would override these settings
in .git/info/master. The problem is to define the branches order in
which the settings are read.

> > Again, having Porcelain specific options mixed in the same file might
> > lead to some confusion among users.
> 
> True.  We need to be careful.

This could be avoided by using ini-like files (well, easy to read in
Python) and have [git] (for the common things like author name),
[cogito], [stgit] etc. sections.

> Or course, there is an option of not worry about Porcelain
> compatibilities at all --- which is certainly simpler.  All we
> need is to make sure they do not use the same filename for
> conflicting purposes.  If everybody feels that way then this
> discussion is moot and I apologize for wasting people's time.

I don't think this is a waste of time. It's useful to have at least some
basic conventions. StGIT places files all over the place but without any
convention, not even a .stgit extension.

The problem is how much similar we want the Porcelains to be regarding
the settings and the templates. For StGIT, it is much simpler to have
something like '%(FILELIST)s' rather than '@FILELIST@' in a template but
I have not problem with switching to a common syntax. But we should see
what can easily be changed.

I will write a list with what files StGIT uses and where they are placed
and we can agree on a structure. I think the .git/ directory usage is
more important to be clarified than having a common {git,cogito,stgit}rc
file.

-- 
Catalin
