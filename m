From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Mon, 29 Jul 2013 08:23:45 -0700
Message-ID: <20130729152345.GA10393@sigill.intra.peff.net>
References: <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
 <20130726213705.GJ14690@google.com>
 <20130726214036.GB1388@sigill.intra.peff.net>
 <20130726224359.GA3928@sigill.intra.peff.net>
 <20130726230527.GA12968@sigill.intra.peff.net>
 <20130726230857.GK14690@google.com>
 <20130726231902.GA1674@sigill.intra.peff.net>
 <20130726233928.GD12968@sigill.intra.peff.net>
 <7vtxjd1jje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:23:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3pIf-0007PU-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab3G2PXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:57885 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab3G2PXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:23:49 -0400
Received: (qmail 3694 invoked by uid 102); 29 Jul 2013 15:23:49 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Jul 2013 10:23:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Jul 2013 08:23:45 -0700
Content-Disposition: inline
In-Reply-To: <7vtxjd1jje.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231289>

On Mon, Jul 29, 2013 at 08:18:45AM -0700, Junio C Hamano wrote:

> >  	if (file_exists(git_path("MERGE_HEAD")))
> >  		whence = FROM_MERGE;
> > -	else if (file_exists(git_path("CHERRY_PICK_HEAD")))
> > +	else if (file_exists(git_path("CHERRY_PICK_HEAD"))) {
> >  		whence = FROM_CHERRY_PICK;
> > +		if (file_exists(git_path("sequencer")))
> > +			sequencer_in_use = 1;
> 
> Should this be
> 
> 	sequencer_in_use = file_exists(...)
> 
> so readers do not have to wonder what the variable is initialized
> to?

Yeah, I think that is a readability improvement. I suppose the use-site
could also just run "file_exists" itself, but I wanted to keep the
filesystem-reading "magic name" bits together.

I had also originally considered adding new states to "whence" to cover
these cases (i.e., FROM_CHERRY_PICK_MULTI), but there are fallouts all
over the place for call sites that do not care whether we are in the
single- or multi-commit mode.

-Peff
