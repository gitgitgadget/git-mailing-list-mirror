From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Wed, 29 May 2013 22:30:37 +0100
Message-ID: <20130529213037.GC17475@serenity.lan>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130529062007.GA11955@sigill.intra.peff.net>
 <7vip21u09d.fsf@alter.siamese.dyndns.org>
 <20130529183658.GA15616@sigill.intra.peff.net>
 <7vy5axsju2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Kevin Bracey <kevin@bracey.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 23:30:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhnxM-00032t-1k
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 23:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935186Ab3E2Vat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 17:30:49 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:54786 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab3E2Var (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 17:30:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 8FF6622BB5;
	Wed, 29 May 2013 22:30:46 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3zfhfMOJUSTJ; Wed, 29 May 2013 22:30:45 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 2D8AB230A8;
	Wed, 29 May 2013 22:30:39 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vy5axsju2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225892>

On Wed, May 29, 2013 at 11:48:53AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Wed, May 29, 2013 at 11:08:46AM -0700, Junio C Hamano wrote:
> >
> >> This has rather interesting ramifications on cherry-pick and rebase,
> >> though.  Both command can handle changes that come from an old tree
> >> before some paths were renamed, but strict patch-id would not spot
> >> equivalent changes we already have in our history if our change
> >> happened after a rename, i.e.
> >> 
> >>    Z
> >>   /
> >>  O---R---X---Y
> >> 
> >> where Z updates path F, R moves F to G and X changes G the same way
> >> as Z changes F, and we are trying to cherry-pick Z on top of Y.  The
> >> cherry-pick filter will see different patch-id for Z and X.
> >
> > True. That is a problem with the current patch-id system, no?
> 
> Correct.  That is why I suggested not to change the external
> interface (i.e. what is shown from patch-id command) as people may
> have kept them, but wondered if a possible improvement may be to
> exclude the name from ids when we internally generate two sets of
> Ids and intersect them, i.e. log --cherry.

Would that not rely on the files still being in the same order?  Since
we essentially hash the content of the patch, it will presumably be
quite different if the order of the files in the patch changes.

I expect it's possible to work around that by being a bit more clever
though.  Perhaps hash each file individually and then sort those and
hash the concatenated result?
