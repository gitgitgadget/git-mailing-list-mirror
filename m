From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 15:50:03 -0400
Message-ID: <20080625195003.GB15077@mit.edu>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:52:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBb2I-0006Mc-Aa
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014AbYFYTvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbYFYTvN
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:51:13 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:40668 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751328AbYFYTvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:51:12 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBb0Q-0002qg-PP; Wed, 25 Jun 2008 15:50:14 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBb0F-0007mT-Oa; Wed, 25 Jun 2008 15:50:03 -0400
Content-Disposition: inline
In-Reply-To: <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86331>

On Wed, Jun 25, 2008 at 10:22:08AM -0700, Junio C Hamano wrote:
> Isn't that this?
> 
>         #!/bin/sh
>         exec git checkout HEAD -- "$@"

Well, I think you really want this to handle filenames with spaces:

for i in $*
do
    git checkout HEAD -- "$i"
done

I still think it would be nice this as a built-in for "git
revert-file" since this is much easier to type than "git checkout HEAD
-- " (all those characters and capital letters).  But if it ends up
being a private shell script for people who do this a lot, that's also fine.

I will say that it was not at all obvious that "git checkout" can also
be used to revert files, so it wasn't one of the man pages that looked
for when trying to figure out how to implement revert files.  That's
why I ended up using:

    git show HEAD:$prefix$i > $i

      		      	     	 	    - Ted
