From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/config.c: Fix a sparse warning
Date: Mon, 29 Oct 2012 01:47:02 -0400
Message-ID: <20121029054702.GD30186@sigill.intra.peff.net>
References: <508D9E15.1040105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSiBz-0005J3-Tp
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796Ab2J2FrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 01:47:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41800 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab2J2FrF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:47:05 -0400
Received: (qmail 15519 invoked by uid 107); 29 Oct 2012 05:47:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 01:47:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 01:47:02 -0400
Content-Disposition: inline
In-Reply-To: <508D9E15.1040105@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208587>

On Sun, Oct 28, 2012 at 09:05:25PM +0000, Ramsay Jones wrote:

> Sparse issues an "Using plain integer as NULL pointer" warning while
> checking a 'struct strbuf_list' initializer expression. The initial
> field of the struct has pointer type, but the initializer expression
> is given as '{0}'. In order to suppress the warning, we simply replace
> the initializer with '{NULL}'.

I slightly disagree with sparse here, as the 0 here is not about
explicitly setting the pointer, but is an idiomatic shorthand for
requesting static-like initialization (and it is purely a style thing,
not a bug, as 0 is a fine null pointer, even on platforms without
all-bits-zero null pointers).

But I think it is still worth changing in the name of
sparse-cleanliness. Thanks.

> I try to catch these types of warnings while the patches are still
> in the pu branch. I don't know how I missed this one, but I don't
> remember your 'jk/config-ignore-duplicates' branch being in pu.
> 
> Sorry about that.

Not your fault. The time during which it would have been in pu was after
Junio left but before I had pushed out my pu. I did have it locally in
pu for a bit, but it ended up on next the first time it was published,
because the series had already received favorable review on the list in
the meantime.

But I forgot that some people may first see the new code via the
published pu, not the list (e.g., if they are pulling and building pu
routinely with sparse).  I'll try to be better about making sure stuff
is actually published in pu for a cycle before merging to next.

-Peff
