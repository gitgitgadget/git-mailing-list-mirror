From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 5 Jun 2007 12:34:22 +0200
Message-ID: <20070605103421.GB16160@diku.dk>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org> <Pine.LNX.4.64.0706030147520.4046@racer.site> <20070605101845.GA16160@diku.dk> <7vzm3ebsnk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWMx-00070e-S2
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763373AbXFEKe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763457AbXFEKeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:34:25 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:48146 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763373AbXFEKeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:34:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 51282F0056;
	Tue,  5 Jun 2007 12:34:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id muv4lecLKe6h; Tue,  5 Jun 2007 12:34:23 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 08C05F002F;
	Tue,  5 Jun 2007 12:34:23 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A85026DFB5B; Tue,  5 Jun 2007 12:32:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D3A6862A5D; Tue,  5 Jun 2007 12:34:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzm3ebsnk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49187>

Junio C Hamano <gitster@pobox.com> wrote Tue, Jun 05, 2007:
> Jonas Fonseca <fonseca@diku.dk> writes:
> 
> > $ git filter-branch H2
> > /home/fonseca/bin/git-filter-branch: 386: arith: syntax error: "i+1"
> > $
> >
> > A possible fix that makes the test pass for me.
> >
> > diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> > index 0c8a7df..5cf9d3c 100644
> > --- a/git-filter-branch.sh
> > +++ b/git-filter-branch.sh
> > @@ -339,7 +339,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
> >  
> >  i=0
> >  while read commit; do
> > -	i=$((i+1))
> > +	i=$(echo i+1 | bc)
> 
> Are you sure this is not "echo $i+1"???

Yes, I noticed this right after sending the mail. People on this list
are just too damn fast for me to send a correction. ;)

> There are quite a few $((arithmetic)) already in our shell code,
> so I was initially a bit surprised.  However, upon closer
> inspection, this particular use is not kosher at all.
> 
> The portable ones we already have in the code say things like:
> 
> 	msgnum=$(($msgnum+1))

Yes, I should have investigated before sending.

> The one in filter-branch that bit you does not dereference 'i'.
> I am reasonably sure if you fix it to read:
> 
> 	i=$(( $i+1 ))
> 
> dash would grok it.

This works here. Even without the spaces.

-- 
Jonas Fonseca
