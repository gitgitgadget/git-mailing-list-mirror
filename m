From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 18:25:51 +0400
Message-ID: <20080416142551.GB3133@dpotapov.dyndns.org>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <4805FD7C.5000206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 16:38:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm8b2-0006ac-1N
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 16:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbYDPOZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYDPOZ7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 10:25:59 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:17798 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbYDPOZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 10:25:58 -0400
Received: by ik-out-1112.google.com with SMTP id c28so573761ika.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=YCn2TxBwHial3/F7FC0C80yH2lKkA5RNAwvdqnq9qJg=;
        b=fu/ovvYjVEa3y7AD7KY6R6977INeBSmsbKXTlFLdhBo0us0hFjpU2JzN8SXO3l3JHyRL+8vyCpByGcSG4NV1x1kRB5+eb8ajPVzqJcr4LTLE5Ts0CWr1v+21NJxLBxMS0q6zem2yVHsMaObZUgnaYgVW0rYDfqV6e85QysQU3a8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=FoAz0b4eYXpZsDs+hHsOOPIeEXgRHj7XzCBWLIF47iQAyJKI6bw2gaVh/tTTurGk8bhENMlGZXwLPVlRMLy05caN51h/D/xLUAWFxZ0CHGTuQCc9ticMYpWPCaSSXq6HVO0PT/2DRshoH9YDrXQ8/m/5Oh+dDoeGeHgTSNiuVY4=
Received: by 10.78.150.7 with SMTP id x7mr210157hud.41.1208355955469;
        Wed, 16 Apr 2008 07:25:55 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id k10sm13770441nfh.17.2008.04.16.07.25.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 07:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4805FD7C.5000206@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79709>

On Wed, Apr 16, 2008 at 03:22:04PM +0200, Johannes Sixt wrote:
> Brian Foster schrieb:
> > Dmitry Potapov <dpotapov@gmail.com> correctly deduced:
> >>  I suspect your original git repository has info/grafts
> > 
> > hi Dmitry,
> > 
> >  bingo!  YES, it does:
> ...
> >  the goal is to put things into a sane state so any new
> >  clones are healthy.  there's only one(?) existing clone,
> >  which may or may not be(? become?) an issue.
> 
> Just move info/grafts out of the way and you *may* be all set. Don't
> delete it - there might be a reason that the file exists.

I believe that parts of history hidden by info/grafts are removed now,
otherwise git clone would not have problems to clone this repository.
So the best option now is only to turn the "fake" history to the real
one using git filter-branch as you wrote.


> - The repository is broken. Then 'git repack -f -d -a' was done while the
> grafts were in effect (and obviously the grafts had hidden parts of the
> history, which are now no longer available).

Actually, 'git repack -f -d -a' does not remove hidden parts of the
history (because 'git prune-packed' does not remove hidden parts), but
'git prune' does remove hidden parts. I believe 'git prune' relies on
'git-fsck --unreachable', which outputs hidden parts as unreachable.
Perhaps, git-fsck should be corrected, so it will not treat hidden as
unreachable, because anything what is hidden is still reachable for
anyone who is trying to clone the repository.

Dmitry
