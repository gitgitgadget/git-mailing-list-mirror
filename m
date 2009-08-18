From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Tue, 18 Aug 2009 11:52:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181150090.4680@intel-tinevez-2-302>
References: <4A89E185.2010307@fastmail.fm> <alpine.DEB.1.00.0908180117140.8306@pacific.mpi-cbg.de> <4A8A2EFE.6000203@fastmail.fm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLMe-0003x1-4e
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbZHRJwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZHRJwP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:52:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751176AbZHRJwP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:52:15 -0400
Received: (qmail invoked by alias); 18 Aug 2009 09:52:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp066) with SMTP; 18 Aug 2009 11:52:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zstsyOktzBjMzOmqX4veduokFQjRH3JZMWodtrT
	oKDDPteRsyQtei
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4A8A2EFE.6000203@fastmail.fm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126367>

Hi,

On Mon, 17 Aug 2009, Karthik R wrote:

> Johannes Schindelin wrote:
>
> > On Mon, 17 Aug 2009, Karthik R wrote:
> >
> > > Setting GIT_SSH when using "git svn clone svn+ssh://..." does not 
> > > override the default ssh; SVN_SSH needed to be set instead.
> >
> > This is now in past tense, no?
>
> Yes... this is all in the past tense now :) ... should be "did not 
> override the default ssh". I'll fix it if I have to resend the patch for 
> a different reason.

> > > diff --git a/git-svn.perl b/git-svn.perl
> > > index b0bfb74..9bc1e71 100755
> > > --- a/git-svn.perl
> > > +++ b/git-svn.perl
> > > @@ -21,6 +21,13 @@ $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} ||
> > > 'git-svn';
> > > $Git::SVN::Ra::_log_window_size = 100;
> > > $Git::SVN::_minimize_url = 'unset';
> > >
> > > +# If GIT_SSH is set, also set SVN_SSH...
> > > +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
> > > +# ... and escape \s in shell-variable on Windows
> > > +if ($^O eq 'MSWin32' || $^O eq 'msys') {
> > > +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
> > > +}
> > >     
> >
> > This is a change from before... I do not know if it is a good one, as 
> > SVN_SSH could be defined differently by the user, no?  In that case, 
> > the user was most likely using the correct amount of backslashes...
>
> Dscho, The *correct* amount of backslashes is 1 (per dir) - same as used 
> with GIT_SSH. If the user has set SVN_SSH but not GIT_SSH (most likely 
> without escaping \), then fixing up SVN_SSH for use with git-svn is not 
> a bad thing.
> 
> I did this change to retain existing behavior (using SVN_SSH to 
> override) even when user doesn't know the \\ quirk - or if the user has 
> set it for some other non-msys version of svn.

Two things: you want to say that much in the commit message, lest people 
as stupid as me fall into the same trap.  And you might want to avoid 
doing that for MSWin32: we may have a MinGW Perl in the near future (Bosko 
was working really hard on that), and then we do _not_ want that behavior, 
right?

Ciao,
Dscho
