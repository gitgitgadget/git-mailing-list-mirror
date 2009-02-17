From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn error: Unable to parse date
Date: Tue, 17 Feb 2009 13:49:14 -0800
Message-ID: <20090217214914.GD26706@dcvr.yhbt.net>
References: <20090217094850.GQ7504@wouts.nl> <7vd4dg6h93.fsf@gitster.siamese.dyndns.org> <20090217193550.GT7504@wouts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ward Wouts <ward@wouts.nl>
X-From: git-owner@vger.kernel.org Tue Feb 17 22:51:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZXqR-0002J8-Cz
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 22:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbZBQVtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbZBQVtR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 16:49:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36828 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633AbZBQVtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 16:49:15 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0671F447;
	Tue, 17 Feb 2009 21:49:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090217193550.GT7504@wouts.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110455>

Ward Wouts <ward@wouts.nl> wrote:
> On Tue, Feb 17, 2009 at 10:38:32AM -0800, Junio C Hamano wrote:
> > Ward Wouts <ward@wouts.nl> writes:
> > 
> > > Unable to parse date: 2004-03-09T09:44:33.Z
> > >  at /usr/bin/git-svn line 3995
> > 
> > A very nice problem description, illustrating what the code should accept
> > but doesn't.
> 
> Thank you.
> 
> > > The message goes away with this one character patch:
> > >
> > > $ diff -bru git-svn*
> > > --- git-svn     2009-02-17 10:23:24.000000000 +0100
> > > +++ git-svn.orig        2009-02-17 10:20:30.000000000 +0100
> > > @@ -2387,7 +2387,7 @@
> > >  sub parse_svn_date {
> > >         my $date = shift || return '+0000 1970-01-01 00:00:00';
> > >         my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> > > -                                           (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
> > > +                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
> > >                                          croak "Unable to parse date: $date\n";
> > >         "+0000 $Y-$m-$d $H:$M:$S";
> > >  }
> > 
> > You had me scratch my head by giving a reverse patch.
> 
> Yes, I'm sorry about that. Hopefully my other post about this subject,
> sent after the remarks Deskin made, is in the proper format.
> 
> > I think neither regexp is quite correct, assuming that SVN timestamp is
> > supposed to always have decimal point after seconds, with optional
> > fractional part, followed by Z (presumably to mean Zulu).
> > 
> > -                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
> > +                                           (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> > 
> > The decimal point should get quoted.
> 
> I think you're right.

Yup.  Consider a patch with the quoted decimal point to be
  Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks Junio, Deskin and Ward.


Ward: Just curious, which version of the SVN libraries are you running?

Odd that this hasn't come up before, I wonder if it's the latest
versions (which I haven't tried, still on 1.5.1) or if SVN just
truncates the zeroes...

-- 
Eric Wong
