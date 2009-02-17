From: Ward Wouts <ward@wouts.nl>
Subject: Re: git-svn error: Unable to parse date
Date: Tue, 17 Feb 2009 20:35:50 +0100
Message-ID: <20090217193550.GT7504@wouts.nl>
References: <20090217094850.GQ7504@wouts.nl> <7vd4dg6h93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ward Wouts <ward@wouts.nl>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 20:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZVkw-000734-Ey
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 20:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZBQTfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbZBQTfw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 14:35:52 -0500
Received: from mailhost.tue.nl ([131.155.2.19]:49970 "EHLO mailhost.tue.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbZBQTfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 14:35:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.tue.nl (Postfix) with ESMTP id D9CC55C06F;
	Tue, 17 Feb 2009 20:35:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at tue.nl
Received: from mailhost.tue.nl ([131.155.2.19])
	by localhost (pastinakel.tue.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3vqn5u372Ct; Tue, 17 Feb 2009 20:35:50 +0100 (CET)
Received: from umta.win.tue.nl (umta.win.tue.nl [131.155.71.100])
	by mailhost.tue.nl (Postfix) with ESMTP id A14AF5C05F;
	Tue, 17 Feb 2009 20:35:50 +0100 (CET)
Received: from sandcat.nl (pcwin165 [131.155.69.121])
	by umta.win.tue.nl (Postfix) with ESMTP id 754B64BC1F7;
	Tue, 17 Feb 2009 20:35:50 +0100 (CET)
Received: by sandcat.nl (Postfix, from userid 1104)
	id 8199B11407C; Tue, 17 Feb 2009 20:35:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vd4dg6h93.fsf@gitster.siamese.dyndns.org>
X-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110445>

On Tue, Feb 17, 2009 at 10:38:32AM -0800, Junio C Hamano wrote:
> Ward Wouts <ward@wouts.nl> writes:
> 
> > Unable to parse date: 2004-03-09T09:44:33.Z
> >  at /usr/bin/git-svn line 3995
> 
> A very nice problem description, illustrating what the code should accept
> but doesn't.

Thank you.

> > The message goes away with this one character patch:
> >
> > $ diff -bru git-svn*
> > --- git-svn     2009-02-17 10:23:24.000000000 +0100
> > +++ git-svn.orig        2009-02-17 10:20:30.000000000 +0100
> > @@ -2387,7 +2387,7 @@
> >  sub parse_svn_date {
> >         my $date = shift || return '+0000 1970-01-01 00:00:00';
> >         my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> > -                                           (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
> > +                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
> >                                          croak "Unable to parse date: $date\n";
> >         "+0000 $Y-$m-$d $H:$M:$S";
> >  }
> 
> You had me scratch my head by giving a reverse patch.

Yes, I'm sorry about that. Hopefully my other post about this subject,
sent after the remarks Deskin made, is in the proper format.

> I think neither regexp is quite correct, assuming that SVN timestamp is
> supposed to always have decimal point after seconds, with optional
> fractional part, followed by Z (presumably to mean Zulu).
> 
> -                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
> +                                           (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or
> 
> The decimal point should get quoted.

I think you're right.

Ward
