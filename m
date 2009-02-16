From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 19:11:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161909440.6289@intel-tinevez-2-302>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl> <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <alpine.DEB.1.00.0902161443230.6289@intel-tinevez-2-302> <alpine.DEB.1.00.0902161451210.6289@intel-tinevez-2-302>
 <4999A378.2040905@pelagic.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 16 19:13:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7xW-0005IQ-CY
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 19:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbZBPSLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 13:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbZBPSLR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 13:11:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43734 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbZBPSLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 13:11:17 -0500
Received: (qmail invoked by alias); 16 Feb 2009 18:11:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 16 Feb 2009 19:11:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/sfT0KajTsJQkz75A7a3mn+wWzkPntlf09wqGxme
	A+/DF7OA1Hnf1b
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4999A378.2040905@pelagic.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110223>

Hi,

On Mon, 16 Feb 2009, Ferry Huberts (Pelagic) wrote:

> Johannes Schindelin wrote:
>
> > On Mon, 16 Feb 2009, Johannes Schindelin wrote:
> >
> >   
> > > On Mon, 16 Feb 2009, Ferry Huberts (Pelagic) wrote:
> > >
> > >     
> > > > I solved it:
> > > >
> > > > it has to do with the
> > > > core.autocrlf=input
> > > > core.safecrlf=true
> > > >
> > > > settings I had in my global config.
> > > >       
> > > Thanks!
> > >
> > >     
> > > > Maybe the manual page should warn against having these defined?
> > > >       
> > > Maybe it should be solved differently?  As cvsimport needs to operate with
> > > autocrlf=false, it seems, it could set that variable when it creates a
> > > repository, and check the variable otherwise (erroring out if it is set
> > > inappropriately)?
> > >     
> >
> > IOW something like this:
> >
> > -- snip --
> >  git-cvsimport.perl |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> > index e439202..a27cc94 100755
> > --- a/git-cvsimport.perl
> > +++ b/git-cvsimport.perl
> > @@ -562,12 +562,16 @@ my %index; # holds filenames of one index per branch
> >  unless (-d $git_dir) {
> >   system("git-init");
> >   die "Cannot init the GIT db at $git_tree: $?\n" if $?;
> > +	system("git-config core.autocrlf false");
> > +	die "Cannot set core.autocrlf false" if $?;
> >   system("git-read-tree");
> >   die "Cannot init an empty tree: $?\n" if $?;
> >  
> >   $last_branch = $opt_o;
> >   $orig_branch = "";
> > } else {
> > +	die "Cannot operate with core.autocrlf other than 'false'"
> > +		if (`git-config --bool core.autocrlf` =~ /true|input/);
> >   open(F, "git-symbolic-ref HEAD |") or
> >   	die "Cannot run git-symbolic-ref: $!\n";
> > 	chomp ($last_branch = <F>);
> > -- snap --
> >
> > If you could add a test to t9600 and a few words to the man page, that would
> > be awesome.
> >
> > Ciao,
> > Dscho
> >
> > P.S.: I think the same strategy should be applied to git-svn...
> >   
> I'm willing to give it a stab but I'm not versed on Perl at all.

Well, the tests and the man page changes I asked you to do don't require 
Perl..

> Isn't it a better idea to have the original authors do this? They 
> understand the code.

No.  This is Open Source, and it is not their itch.

> Also, doing this would constitute my first patch to git. I'm unfamiliar 
> with its codebase and the requirements of the people that contribute to 
> it. Willing to learn though :-)

That's the best way to start.

> My patches would then probably need some review and would take a bit 
> longer to develop. If that's acceptable then I'm willing to try.

No problem, I am here (if you want to cope with me, that is).

Ciao,
Dscho
