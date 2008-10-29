From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Using the --track option when creating a branch
Date: Wed, 29 Oct 2008 17:25:37 +0100
Message-ID: <adf1fd3d0810290925s493cdc6oc7534904c864db28@mail.gmail.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:27:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvDsq-0006bT-Sc
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbYJ2QZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYJ2QZp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:25:45 -0400
Received: from mail-gx0-f18.google.com ([209.85.217.18]:49396 "EHLO
	mail-gx0-f18.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbYJ2QZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:25:44 -0400
Received: by gxk11 with SMTP id 11so2989497gxk.13
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 09:25:42 -0700 (PDT)
Received: by 10.103.224.17 with SMTP id b17mr4303631mur.16.1225297537764;
        Wed, 29 Oct 2008 09:25:37 -0700 (PDT)
Received: by 10.103.131.8 with HTTP; Wed, 29 Oct 2008 09:25:37 -0700 (PDT)
In-Reply-To: <18696.32778.842933.486171@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99378>

On Wed, Oct 29, 2008 at 4:23 PM, Bill Lear <rael@zopyra.com> wrote:
> We have had a few "crossed stream" problems when developers are
> working on a local branch and they do an unguarded git push/pull,
> when they really intended to do git push/pull origin branchname.
>
> We use git in a way that makes it desirable for us to only push/pull
> to the same remote branch.  So, if I'm in branch X, I want 'git push'
> to push to origin/X, and 'git pull' to fetch into origin/X and then
> merge into X from origin/X.
>
> In other words, we want git push/pull to behave in branches other than
> master the same way it does when in master.
>
> I have discovered the '--track' option when creating a local branch,
> and this appears to me to be the thing that gives us the desired
> behavior.

branch.autosetupmerge controls if --track is used by default (it is
true by default since a long time)
(See "git help config" for details)

>
> Before I tell the rest of the team that this is the correct way
> to do things, I need to be sure I am correct, so if anyone here
> can confirm or deny this, I'd appreciate it.

It should just work (at least in the lastest releases) when creating a
branch from a remote branch.

$ git checkout -b X origin/X
or
$ git branch X origin/X
Branch X set up to track remote branch refs/remotes/origin/X

>
> Also, once a branch has been created, how can we add a '--track' option
> after the fact?

It it just two configs (apart from the remote repository). A help
message should appear when using "git pull" without arguments and it
cannot figure out the branch to merge:

$ # currently in branch next
$ git pull
You asked me to pull without telling me which branch you
want to merge with, and 'branch.next.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.next.remote = <nickname>
    branch.next.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.

[end]

so to add it after the fact you should execute:

$ git config branch.next.remote origin
$ git config branch.next.merge refs/heads/next

>
> Finally, is there a 'global' config setting that would set this behavior
> for all repos (new or existing)?

See above.

>
> We are using git 1.6.* versions here, mostly.
>

Santi
