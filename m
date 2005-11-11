From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Fri, 11 Nov 2005 17:10:21 +0100
Message-ID: <200511111710.21984.Josef.Weidendorfer@gmx.de>
References: <1124832796.23795.9.camel@dv> <200511111522.37979.Josef.Weidendorfer@gmx.de> <1131722791.1284.20.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 17:11:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EabTw-0007h7-6a
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 17:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVKKQKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 11:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKKQKZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 11:10:25 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:58244 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750833AbVKKQKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 11:10:25 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id A3B8423A2;
	Fri, 11 Nov 2005 17:10:23 +0100 (MET)
To: Pavel Roskin <proski@gnu.org>
User-Agent: KMail/1.8.2
In-Reply-To: <1131722791.1284.20.camel@dv>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11612>

On Friday 11 November 2005 16:26, Pavel Roskin wrote:
> > AFAIK, there is not really a "new" and "old" style, but more the
> > git way (attributes for remote repositories in .git/remotes) and the
> > Cogito way (attributes for a remote branch).
> 
> Switching to the "git way" is long overdue, since hashes can be used in
> the actual path.

Currently, Git does not store mappings of remote to local branches in
.git/remotes/ per se. "Pull" lines allow you to specify default actions
for git-fetch/git-pull, but even this is quite limited:
"git-fetch" defaults to fetching all heads mentioned, and "git-pull"
defaults to merging the first head on the first "Pull" line.

Because the git way is per-remote-repository, you always have to specify
the remote repository shortcut in git-fetch/git-pull/git-push, as there
is no implicit remote repository. With per-branch, it is far simpler as
you always have a current active branch which is HEAD. By using
.git/remotes, you more or less get a shortcut name for a remote repository.
Of course, Cogito could use this shortcut in the .git/branches/, too.

Another thing: Per branch configuration is not only about branches which
have a mapping to a remote file. I would *love* to be able to specify
merge candidates and default merge branches for every local branch.
Such configuration of local branches can also reside in .git/branches.

But you are right, hashes can be part of an path, so Cogito should use
multiple lines in .git/branches/ like Git does in .git/remotes.

So what are possible configuration items for a branch?
Branches can be of 2 kinds: either a branch should track a remote branch,
or it is used for local development.

A branch which is tracking a remote one does need
* the remote repository URL, or path (if local)
* the branch name to track from the remote repository

A branch used for development can have:
* set of local branch names which are candidates for merging
* set of local branch names for default merge action
* a default remote branch to use for pushing

> > For cg-clone, this is no problem because cg-clone writes this file itself.
> > Another thing is if you add later on a remote branch with cg-branch-add
> > without specifying a concrete remote branch name. Do we want the
> > record the branch name at the first cg-fetch for the future?
> 
> Good that you noticed that.
> 
> cg-fetch could do that, but maybe cg-branch-add would be an even better
> place for that?  I mean, cg-branch-add could actually check the
> repository and prompt the user which branch to use if there is no
> obvious default.  I think, there should be a way to run cg-branch-add
> without having it connect the repository or prompt the user, but the
> default should be user-friendly.

Yes.

Josef
