From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 16:07:05 -0700
Message-ID: <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 01:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw6bv-0001YQ-PY
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 01:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVGVXHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 19:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGVXHJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 19:07:09 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3494 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262218AbVGVXHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 19:07:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722230704.ZJYY1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 19:07:04 -0400
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> Would such a template only have 'GIT:' prefixed lines? I usually put
> another line like 'Signed-off-by:', for convenience. The problem with
> StGIT appears when one wants to re-edit the patch description (stg
> refresh -e), in which case the existing description should be merged
> with a part of the template (if you want to get the editor setting for
> example). It doesn't do this since there is no point in getting another
> 'Signed...' line in the existing description.

If signed-off-by is the only thing you are worried about, how
about making it not part of the commit template and the message
user touches with the editor?  You first look at the user
configuration somewhere to see if the user wants the
signed-off-by line to his commits and with what value, and if
the last lines of the edit result does not contain that value
(to avoid duplicates), add it before feeding the message to
git-commit-tree.

>>   - standard "dontdiff/ignore" file.
>
> StGIT currently uses .git/exclude, since I saw it used by cogito. What
> is dontdiff supposed to do? The 'git diff' command only shows the diff
> for the files added to the repository.

I see that what I wrote was vague and badly stated.  Please
forget about my mentioning "dontdiff".  What I meant was your
.git/exclude, Pasky's .gitignore file and friends.

>>   - environment overrides (COMMITTER_NAME, COMMITTER_EMAIL and
>>     such).
>
> StGIT works the other way around. By default uses the environment, which
> can be overridden by the stgitrc file. I could change this easily.

Again I was vague, and what you say StGIT does is exactly what I
meant.  I have one value in my environment coming from the login
shell, and a per- repository preference item overrides it to
something else.

>>   - Per project.  A project may want to enforce pre-commit hook
>>     for all participants;
>
> As Petr said, it's hard to define a project.

By reading the part you talk about your hating tla, I think you
know exactly what I mean.

When you merge two projects like Linus did between git.git and
gitk, obviously the person who is merging the two is responsible
for merging the per-project default configuration and resolving
conflicts.  This probably should be overridable by individual
developers who pull/fetch into their repository by having per-
repository configuration.

> For StGIT it makes sense to get some default settings via /etc/stgitrc.
> There are things like a SMTP server and the diff3 command. These are set
> when installing the application and can be overridden in your home
> or .git directories.

Exactly, but that is not specific to StGIT, I presume, and I did
not want to hear "``For StGIT'' it makes sense".  If StGIT needs
to use "diff3" on a system, probably that is because "merge" is
not available on that system.  In that case,  cogito needs to
use it too, doesn't it?

If we can make users and sysadmins not having to maintain two
sets of configuration files for two Porcelains, if we
can,... that is what I have been trying to address.

> Before we get to "where", we should define the common
> settings. I think that git should define the common settings
> for its operations and the other tools should follow them.

Personally, unless it is something very obvious and basic, I do
not think the core barebone Porcelain should be inventing
arbitrary conventions and imposing them on other Porcelains.
For very basic things I would agree.

I think Petr already started the discussion rolling for commit
templates, and I like his proposal.  For ignore pattern files, I
think what Cogito does sounds almost sensible [*1*] and I am
sure StGIT have something similar.  I do not see Linus and co
jumping up and down saying git-status should detect and show new
files not registered in the cache, so for now I'd propose to
skip adding this one to the barebone Porcelain (meaning, this is
an example of not "git defining the common and others following
suite").

> That's the thing I didn't like in GNU Arch. You modify the file ignoring
> rules for example and the change will be included in the next commit.
> You could only get some defaults when cloning a repository, otherwise
> once you have different preferences from the repository's maintainer,
> you start getting conflicts in the config files.

That's why I suggested to have "_git" (project wide default)
separate from $GIT_DIR/info (repository owner's discretion), the
latter overriding the former.

>>   - Use $HOME/.gitrc (could be a directory or a file in .ini
>>     style like StGIT uses -- again, I do not care about the
>>     details at this moment) to store per-user configuration.
>
> Again, having Porcelain specific options mixed in the same file might
> lead to some confusion among users.

True.  We need to be careful.

Or course, there is an option of not worry about Porcelain
compatibilities at all --- which is certainly simpler.  All we
need is to make sure they do not use the same filename for
conflicting purposes.  If everybody feels that way then this
discussion is moot and I apologize for wasting people's time.

[Footnote]

*1* I said "almost sensible" but it is not meant to blame Pasky.
I think the --exclude mechanism in git-ls-files should be
extended to allow not just the filename-sans-leading-directory
match but a full relative-to-the-project-root path match.  That
way, cg-status would not have to run around in the tree to find
individual .gitignore files.  

Personally, I think having to have ignore pattern like .cvsignore
per-directory is simply _ugly_.
