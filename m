From: Petr Baudis <pasky@suse.cz>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
	add new Git::Repo API)
Date: Sat, 19 Jul 2008 23:14:03 +0200
Message-ID: <20080719211403.GA10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 23:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKJlm-0006p9-73
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 23:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbYGSVOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbYGSVOI
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 17:14:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49250 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbYGSVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 17:14:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A4E702C4C02A; Sat, 19 Jul 2008 23:14:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807192254.24622.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89135>

On Sat, Jul 19, 2008 at 10:54:24PM +0200, Jakub Narebski wrote:
> On Fri, 18 July 2008, Petr Baudis wrote:
> 
> > But the experience shows that the pipe interface is actually
> > the _most_ used part of the Git Perl API.

  Note that I referred both to scripts that are part of Git and
(actually more) to various third-party scripts I wrote externally.

> Here is some statistics on the usage of Git Perl API among built-in
> and contrib commands.

  Thanks!

> The situation is worse for scripts in 'contrib/'.  From those, only
> contrib/examples/git-remote.perl uses Git.pm; neither blameview,
> continuous, git-import and import-tars in fast-import, setgitperms
> and update-paranoid in hooks, stats, nor other Perl scripts in
> examples (git-rerere, git-svnimport) include "use Git".

  I have actually once converted blameview to use Git locally, but in
the end never got around to submit it; I wonder if I have the source
still around somewhere. Not so important, I guess.

> Below there are stats on how different commands from Git.pm are
> used in mentioned Perl scripts:
> 
> 2. git-cvsexportcommit.perl uses (besides ->repository() constructor)
>    only once ->config; so I guess that current interface wrapping
>    git-config should stay, because parsing whole config for such
>    situation would be overkill.

  I don't understand. Parsing whole config happen will either happen in
git-config or in Git::Config, and the performance difference is so tiny
that it is not really worth the API complexity, I believe.

> 3. git-send-email.perl uses 5 config, 2 config_bool, 2 ident_person
>    (for author and for committer), 1 version, and of course once
>    ->repository() constructor.  
> 
>    Here we can see how to work around current API to: it uses
>    Git::config(@repo, "sendemail.identity") form, where 
>    	my $repo = eval { Git->repository() };
>    	my @repo = $repo ? ($repo) : ();
>    to make it work both with git repository (using repo config), and
>    outside/without git repository, using only user and system git
>    config.

  With the envisioned model, it could use $git which would be either
a reference to a Git::Standalone singleton or Git::Repo instance.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
