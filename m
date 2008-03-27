From: Josh Elsasser <josh@elsasser.org>
Subject: Re: [PATCH v2] Allow git-cvsserver database table name prefix to be specified.
Date: Thu, 27 Mar 2008 13:57:27 -0700
Message-ID: <20080327205727.GN2324@opal.elsasser.org>
References: <1205989546855-git-send-email-josh@elsasser.org> <7vwsnyx8ga.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 21:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JezAq-0000im-Ho
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 21:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112AbYC0U5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758067AbYC0U53
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 16:57:29 -0400
Received: from opal.elsasser.org ([198.145.64.114]:27836 "EHLO
	opal.elsasser.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301AbYC0U52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 16:57:28 -0400
Received: by opal.elsasser.org (Postfix, from userid 1000)
	id A723E3E247; Thu, 27 Mar 2008 13:57:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwsnyx8ga.fsf@gitster.siamese.dyndns.org>
X-PGP-Key-URL: http://www.elsasser.org/pubkey.asc
X-PGP-Key-Fingerprint: 8F39 9F2B 3738 54D9 3E40 4604 CFD5 EA3F B833 FD50
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78364>

On Wed, Mar 19, 2008 at 10:36:53PM -0700, Junio C Hamano wrote:
> Josh Elsasser <josh@elsasser.org> writes:
> 
> > The purpose of this patch is to easily allow a single database (think
> > PostgreSQL or MySQL) to be shared by multiple repositories.
> 
> I am not sure if this is even a good idea.  You can share a single
> database cluster (in PostgreSQL lingo, I do not recall how MySQL calls it)
> and have multiple database instances on it, which would give you better
> isolation between repositories.  What's the advantage of your approach, I
> have to wonder.

Unless I misunderstand what you mean, that is exactly what I would
like to be able to avoid. A user may not always be able to create new
database instances, or may just want to avoid creating a new one for
each repository.

> > +gitcvs.dbprefix::
> 
> And it would not be dbprefix but table name prefix.  

All right, how does gitcvs.dbTableNamePrefix sound?

> > @@ -2349,10 +2353,10 @@ sub new
> >      }
> >  
> >      # Construct the revision table if required
> > -    unless ( $self->{tables}{revision} )
> > +    unless ( $self->{tables}{"$self->{dbprefix}revision"} )
> 
> Hmmm.  If we are going to insist on having multiple tables in a single
> database, can we make sure we have better chances of catching mistakes by
> doing something like...
> 
>     * Identify the set of tables and indices one repository would use
>       (i.e. revision, revision_ix1, etc.)

It did occur to me that I should abstract it a little more, I just
ended up being lazy about it. A slightly cleaner version should follow
this mail.

 -jre
