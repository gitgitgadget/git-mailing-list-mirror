From: Fraser Tweedale <frase@frase.id.au>
Subject: Re: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Sun, 10 Apr 2011 20:13:46 +1000
Message-ID: <20110410101345.GD1521@bacardi.wooloowin.frase.id.au>
References: <1302415936-7362-1-git-send-email-frase@frase.id.au>
 <m362qm4kvu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 12:31:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8rvs-0008DF-8l
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 12:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035Ab1DJKbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 06:31:47 -0400
Received: from 60-242-254-5.static.tpgi.com.au ([60.242.254.5]:64207 "EHLO
	bacardi.wooloowin.frase.id.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755826Ab1DJKbq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 06:31:46 -0400
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Apr 2011 06:31:45 EDT
Received: from bacardi.wooloowin.frase.id.au (localhost [127.0.0.1])
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4) with ESMTP id p3AADnD0008800;
	Sun, 10 Apr 2011 20:13:49 +1000 (EST)
	(envelope-from frase@frase.id.au)
Received: (from Fraser@localhost)
	by bacardi.wooloowin.frase.id.au (8.14.4/8.14.4/Submit) id p3AADkfi008799;
	Sun, 10 Apr 2011 20:13:46 +1000 (EST)
	(envelope-from frase@frase.id.au)
X-Authentication-Warning: bacardi.wooloowin.frase.id.au: Fraser set sender to frase@frase.id.au using -f
Content-Disposition: inline
In-Reply-To: <m362qm4kvu.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171249>

On Sun, Apr 10, 2011 at 12:38:32AM -0700, Jakub Narebski wrote:
> Fraser Tweedale <frase@frase.id.au> writes:
> 
> > Subject: [PATCH] supply '-n' to gzip to produce identical tarballs
> >
> > Without the '-n' ('--no-name') argument, gzip includes timestamp in
> > output which results in different files.  Important systems like FreeBSD
> > ports and perhaps many others hash/checksum downloaded files to ensure
> > integrity.  For projects that do not release official archives, gitweb's
> > snapshot feature would be an excellent stand-in but for the fact that the
> > files it produces are not identical.
> > 
> > Supply '-n' to gzip to exclude timestamp from output and produce idential
> > output every time.
> > 
> > Signed-off-by: Fraser Tweedale <frase@frase.id.au>
> 
> Very good description, except subject line should denote which
> subsystem this commit affects, i.e.:
> 
>   gitweb: supply '-n' to gzip to produce identical tarballs
> 
Thank you.  Do I need to amend the message and resubmit the patch?  (first
time submitting a patch to git; I used git send-email).

> Hmmm... gzip in gitweb's 'snapshot' action gets data compressed from
> standard input, not from filesystem.  Isn't -n / --no-name no-op then?
> Just asking...
> 
It is not no-op; I have tested to confirm this.  I'm not sure whether
a file name is recorded in the stdin case, or if so what it is, but the
timestamp is recorded and that makes the difference.

> > ---
> >  gitweb/gitweb.perl |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 46186ab..2ab08da 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -186,7 +186,7 @@ our %known_snapshot_formats = (
> >  		'type' => 'application/x-gzip',
> >  		'suffix' => '.tar.gz',
> >  		'format' => 'tar',
> > -		'compressor' => ['gzip']},
> > +		'compressor' => ['gzip', '-n']},
> 
> Perhaps it would be more clear to use
> 
>   +		'compressor' => ['gzip', '--no-name']},
> 
> >  
> >  	'tbz2' => {
> >  		'display' => 'tar.bz2',
> > -- 
> > 1.7.4.3
> > 
> 
Definitely, if the argument is the same (or even present) on all systems.
On FreeBSD and GNU both '-n' and '--no-name' are do the job, but an audit
of other systems should be done to ensure they don't break.  I chose '-n'
as it seemed the more conservative choice.

> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
