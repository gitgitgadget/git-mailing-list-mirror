From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 20:06:48 +0400
Message-ID: <20120619200648.2cc8a861.kostix@domain007.com>
References: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh0xG-0007Ap-TP
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 18:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494Ab2FSQGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 12:06:55 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:41044 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199Ab2FSQGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 12:06:54 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q5JG6mIc022701;
	Tue, 19 Jun 2012 20:06:49 +0400
In-Reply-To: <4FE091FB.7020202@desrt.ca>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200210>

On Tue, 19 Jun 2012 10:51:39 -0400
Ryan Lortie <desrt@desrt.ca> wrote:

> After helping someone on IRC who got themselves into a bit of a
> problem, I have a feature request for git.
> 
> In this case, the user wanted to checkout a branch of a module.  They
> did:
> 
>    git clone git://git.gnome.org/gtk+
>    cd gtk+
>    git branch gtk-3-4
> 
> Obviously this is a user error, but it's a pretty innocent one, and
> puts the user in a bad state.
> When they figure they should have
> typed "git checkout gtk-3-4" it is already too late -- they will be
> taken onto their locally-created copy of the master branch.
How bad this state really is?
The user is free to do
$ git branch -m gtk-3-4 mygtk-3-4
at any time after the error was detected.

> So feature request: 'git branch' should not allow creating a local 
> branch that has the same name as a branch that already exists on 
> 'origin' (or any remote?) without some sort of --force flag.  It
> could instead helpfully say:
[...]
> or something like that.
This would not protect from the obvious case when a branch has been
created on the remote (by someone else) but has not been fetched yet
and so the local repo does not know a branch with "conflicting"
name do exist.

> Thoughts?
Your intention is good but I think a safety net of the kind you
propose would be slightly over the top.
Basically you're trying to compensate for the user error who
thinks the "branch" command should take her to an already existing
branch while it does something completely different.
Hence preventing the `git branch gtk-3-4` command from completion
should there be a remote-tracking branch of the same name is just wrong
IMO.  On the other hand, posting a hint might be OK.  I'm talking about
something like this:

$ git branch gtk-3-4
The remote "origin" has the branch of the same name.
The created branch is not set to track it.

Such a hint would state the obvious thing but it would alert a user
who would not expect it (and hopefully make her google or ask for
assistance using this hint's message).

Anyway, this will make each call to git-branch to perform a crawl over
the refs/heads hierarchy which, I think, is not worth the result.
