From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] builtin-config: add --exec-editor for use in scripts
Date: Mon, 2 Feb 2009 20:55:20 -0800
Message-ID: <20090203045520.GB2483@dcvr.yhbt.net>
References: <20090201025349.GA22160@dcvr.yhbt.net> <7v4ozdo7yt.fsf@gitster.siamese.dyndns.org> <m3pri1w484.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 05:57:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUDL5-0001jw-NJ
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 05:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZBCEzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 23:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZBCEzW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 23:55:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47100 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbZBCEzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 23:55:21 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1AC61F5F3;
	Tue,  3 Feb 2009 04:55:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3pri1w484.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108145>

Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Eric Wong <normalperson@yhbt.net> writes:
> > 
> > > This exposes the launch_editor() library function for use by
> > > various scripting languages.  This allows the ensure consistent
> > > handling of GIT_EDITOR/VISUAL/EDITOR environment variables as
> > > well as the handling of special characters such as spaces in the
> > > various environment variables.
> > >
> > > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > > ---
> > >
> > >  I'm not sure if git-config is the best place to stick it.  I plan to
> > >  start using this in git-svn but I don't want to implement Git::Editor
> > >  in Perl and have to keep track of editor.c.  Of course this also makes
> > >  the logic/rules used in libgit usable to any other scripting language
> > >  capable of launching other programs.
> > 
> > I agree that git-config is probably a wrong place.  A separate command
> > "git editor" (or "git user-preference --editor", if you extend it to pager
> > and others) perhaps?
> > 
> > I also agree that something like this would make scripting Porcelains a
> > much pleasant experience.
> 
> I don't think this is something that should be put in 'git rev-parse',
                                   You meant 'git config' --/
				   Unless you remotely accessed my
				   brain while I was deciding on this
				   before I picked 'git config' :)

> but perhaps a bit obscure 'git var' (print a git logical variable)
> would be a good place for that?

Well, it would involve executing another program; so 'git var' might not
be a good fit.  I don't want it to just print out what command to run
because of quoting rules (and my primary reason for wanting to
standardize on this was because a user privately emailed me about
wanting to use 'mate -w' as his GIT_EDITOR with git-svn).

Junio: "git user-preference" would be confusing given we
already have "git config"...

Perhaps a new command called 'git exec-helper' ?

git exec-helper pager
git exec-helper editor <FILE>
...
git exec-helper sendmail ?
git exec-helper browser <URL> ?

-- 
Eric Wong
