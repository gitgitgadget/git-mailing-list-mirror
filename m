From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and
	broken branch imports
Date: Wed, 02 Apr 2008 21:44:50 -0400
Organization: Cobite
Message-ID: <1207187090.17329.15.camel@gandalf.cobite.com>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
	 <7vprt8838y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 03:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhEWN-0006mQ-FR
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 03:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbYDCBpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 21:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbYDCBo7
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 21:44:59 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:51989 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754928AbYDCBo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 21:44:59 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id C32E1E19F6;
	Wed,  2 Apr 2008 21:44:57 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBELpAPDeFZD; Wed,  2 Apr 2008 21:44:51 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 3C8FBE196C;
	Wed,  2 Apr 2008 21:44:51 -0400 (EDT)
In-Reply-To: <7vprt8838y.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78720>



On Wed, 2008-04-02 at 12:29 -0700, Junio C Hamano wrote:
> David Mansfield <david@cobite.com> writes:
> 
> > In case you're wondering, I'm actually the original author of cvsps,
> > which is behind the scenes for cvsimport.  I don't call myself
> > maintainer because I've hardly been that over the last few years.
> >
> > Anyway, the fix to cvsps is attached (1st 2 patches) as well as the
> > patch to git-cvsimport.perl (2nd 2 patches) against the master branch as
> > of today's git repo.
> >
> > The cvsps patches apply with fuzz against the 2.1 version which is out
> > there.
> 
> When output from an unfixed cvsps is fed to the updated cvsimport, does it
> gracefully do the wrong thing (iow, create the same broken history not too
> much worse than the original)?
> 
> > @@ -826,12 +824,9 @@ while (<CVS>) {
> >  		$branch = $_;
> >  		$state = 5;
> >  	} elsif ($state == 5 and s/^Ancestor branch:\s+//) {
> > -		s/\s+$//;
> > -		$ancestor = $_;
> > -		$ancestor = $opt_o if $ancestor eq "HEAD";
> > +		# now ignored.  see 'Branches' below
> >  		$state = 6;
> >  	} elsif ($state == 5) {
> > -		$ancestor = undef;
> >  		$state = 6;
> >  		redo;
> >  	} elsif ($state == 6 and s/^Tag:\s+//) {
> 

Not currently.  I'm just searching for failure modes for the feature at
the moment (I've already found one myself). 

You're right to point this out though.  Maybe someone can help me write
some tests for this?

Also, how does the git packaging (non-rpm version) specify and/or
guarantee dependencies are at a certain version anyway?

David
