From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] send-pack: avoid deadlock when pack-object dies early
Date: Tue, 26 Apr 2011 04:23:02 -0400
Message-ID: <20110426082302.GC26874@sigill.intra.peff.net>
References: <20110331184243.GA12027@sigill.intra.peff.net>
 <201104142136.25778.j6t@kdbg.org>
 <20110414202110.GA6525@sigill.intra.peff.net>
 <201104142243.33522.j6t@kdbg.org>
 <20110414205113.GA7451@sigill.intra.peff.net>
 <7vsjtkfs10.fsf@alter.siamese.dyndns.org>
 <4DB48B2C.2090904@kdbg.org>
 <4DB48CCD.40304@kdbg.org>
 <20110425165007.GB1589@sigill.intra.peff.net>
 <4DB5E1CA.8000105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 10:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEdYB-0003D0-J1
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 10:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213Ab1DZIXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 04:23:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50588
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1DZIXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 04:23:05 -0400
Received: (qmail 16316 invoked by uid 107); 26 Apr 2011 08:24:45 -0000
Received: from c-67-172-212-47.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.212.47)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Apr 2011 04:24:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2011 04:23:02 -0400
Content-Disposition: inline
In-Reply-To: <4DB5E1CA.8000105@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172077>

On Mon, Apr 25, 2011 at 11:04:10PM +0200, Johannes Sixt wrote:

> > In the comments for 1/2, you said this goes directly on 38a81b4e. But in
> > that commit, we use #ifndef WIN32 to decide whether or not to fork for
> > async code. So shouldn't this use the same test (I don't even see
> > ASYNC_AS_THREAD defined anywhere else)?
> 
> Here's the fixed patch. I squashed both earlier patches into a single patch
> because they are about the same topic, as you showed with your tests of
> git-push via smart http.

Thanks, this one looks good to me, and I think the squash is sensible.

> Again, this should go on top of 38a81b4e. When it is merged to f6b60983 or
> later, the '#ifndef WIN32' must be changed to '#ifdef NO_PTHREADS'.

I see Junio has an evil merge in pu that takes care of this.

I wonder if it might have been nicer to "cherry-pick -n" the old fix on
top of master, fixing up the tree to use NO_PTHREADS, and then resolving
the ensuing merge conflict in favor of the cherry-picked version. . I
guess it is just a matter of style (the fact that a few of our
archaeology tools do not find content in evil merges very well is a
downside, but that just means we should fix the tools :) ).

-Peff
