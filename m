From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Thu, 24 May 2012 20:39:20 -0400
Message-ID: <20120525003920.GB11300@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
 <201205241817.46034.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri May 25 02:39:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXiZ7-0007Bg-4V
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 02:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527Ab2EYAj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 20:39:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54660
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab2EYAjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 20:39:22 -0400
Received: (qmail 2857 invoked by uid 107); 25 May 2012 00:39:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 20:39:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 20:39:20 -0400
Content-Disposition: inline
In-Reply-To: <201205241817.46034.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198455>

On Thu, May 24, 2012 at 06:17:45PM -0600, Martin Fick wrote:

> On Monday, May 21, 2012 04:14:17 pm Jeff King wrote:
> > On Mon, May 21, 2012 at 01:45:25PM -0400, Jeff King wrote:
> > Martin, let me know if this improves things for your
> > many-ref cases (and if you are still seeing slowness in
> > your repos with many refs, let me know which operations
> > cause it).
> 
> I have not been ignoring you, I am sorry that I have not 
> replied yet.  Unfortunately, I am having a very hard time 
> getting conclusive tests with my large repo.  I making
> plenty of mistakes in what I think I am testing I believe,
> but also I am having a hard time getting reproducible 
> results so far.  And some tests take quite a while, so it is 
> not always obvious what I might be doing wrong.

No worries. I am pretty confident that the patches I supplied so far are
a good thing whether they help your case or not. So if you come back in
a month and show that they solved all your problems, then great. And if
they don't, then it will just show us what new problems we have to work
on. :)

> Were your tests mostly warm cache tests?

Yes, exclusively warm. And all of the refs were packed, which makes the
warm/cold difference less interesting (it's one 30MB or so file).  I
don't think there's much point in thinking about the performance of 400K
loose refs (which would be absolutely horrific cold-cache on most
traditional filesystems). If you have that many, you would want to keep
the bulk of them packed.

-Peff
