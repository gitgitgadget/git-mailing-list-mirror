From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 22:43:54 +0100
Message-ID: <1122068634.7042.35.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org, Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 23:48:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw5NT-0001WP-0W
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVGVVrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVGVVpX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:45:23 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:29117 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262199AbVGVVn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:43:58 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta08-winn.ispmail.ntl.com with ESMTP
          id <20050722214357.CPW889.mta08-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Fri, 22 Jul 2005 22:43:57 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050722214356.GWFM19483.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Fri, 22 Jul 2005 22:43:56 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-07-22 at 13:39 -0700, Junio C Hamano wrote:
> I would like to see Porcelains stay compatible when the do not
> have to differ.  The commit template [*2*] is one example of
> such.  

For StGIT it is not a problem to use any commit template with any
prefix. It doesn't generate extra lines.

Would such a template only have 'GIT:' prefixed lines? I usually put
another line like 'Signed-off-by:', for convenience. The problem with
StGIT appears when one wants to re-edit the patch description (stg
refresh -e), in which case the existing description should be merged
with a part of the template (if you want to get the editor setting for
example). It doesn't do this since there is no point in getting another
'Signed...' line in the existing description.

> First, I will talk about the "what" part.  I can see there are
> various "preference" items we may want to use:
> 
>   - commit template (to enforce a certain style)

OK

>   - standard "dontdiff/ignore" file.

StGIT currently uses .git/exclude, since I saw it used by cogito. What
is dontdiff supposed to do? The 'git diff' command only shows the diff
for the files added to the repository.

>   - pre-commit hook (to enforce a certain tests to pass)
>   - post-commit-hook (sending commit-notification perhaps).

OK

>   - environment overrides (COMMITTER_NAME, COMMITTER_EMAIL and
>     such).

StGIT works the other way around. By default uses the environment, which
can be overridden by the stgitrc file. I could change this easily.

> There may be others.  Many of them would have different origin:
> 
>   - Per project.  A project may want to enforce pre-commit hook
>     for all participants;

As Petr said, it's hard to define a project.

>   - Per user.  A user may want to use different environment
>     settings for different projects [*4*].
> 
>   - Per repository (or work tree).  A user may have more than
>     one work tree for the same project, and want to use
>     different "preference" items per tree.

StGIT uses /etc/stgitrc, ~/.stgitrc and .git/stgitrc, the latter
overriding the former.

> Personally, given the nature of GIT being a distributed system,
> I do not think something like /etc/git.conf (which suggests "per
> system" configuration) makes much sense; except working around a
> mailhost name configuration, perhaps.

For StGIT it makes sense to get some default settings via /etc/stgitrc.
There are things like a SMTP server and the diff3 command. These are set
when installing the application and can be overridden in your home
or .git directories.

> About the "where" part, one proposal I have off the top of my
> head is something like this:

Before we get to "where", we should define the common settings. I think
that git should define the common settings for its operations and the
other tools should follow them.

Once you get unique settings for an application (like mail templates or
three-way merge commands), it's pretty hard to put them in the same
file. It would even be confusing for users.

>   - Have a directory at the root of the tree, "_git" (I do not
>     care about the name at this moment.  The point being it can
>     be revision controlled as part of the project and propagate
>     to other repositories), to store per-project configuration.

That's the thing I didn't like in GNU Arch. You modify the file ignoring
rules for example and the change will be included in the next commit.
You could only get some defaults when cloning a repository, otherwise
once you have different preferences from the repository's maintainer,
you start getting conflicts in the config files.

>   - Use $GIT_DIR/conf/ as a convention to store per repository
>     configuration files.  This does not propagate with
>     pulls/pushes/merges across repositories.

That's fine.

>   - Use $HOME/.gitrc (could be a directory or a file in .ini
>     style like StGIT uses -- again, I do not care about the
>     details at this moment) to store per-user configuration.

Again, having Porcelain specific options mixed in the same file might
lead to some confusion among users.

> But normally
> the per-repository one would take precedence over per-user one
> which in turn would take precedence over per-project one.

With a note if specifying what a project is.

> *3* .gitignore in the cwd is used in Cogito, if I am not
> mistaken.

I will to add this to StGIT.

> *4* E.g. I would commit for GIT project with junkio@cox.net
> while using junio@twinsun.com for my day-job projects.

In StGIT this is settable via authorname/authoremail in the stgitrc file
and can be per repository or per user.

-- 
Catalin
