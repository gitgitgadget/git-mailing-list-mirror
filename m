From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add --format that is a synonym to --pretty
Date: Mon, 23 Feb 2009 23:50:41 -0500
Message-ID: <20090224045041.GA4615@coredump.intra.peff.net>
References: <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com> <7v63j2z7bh.fsf@gitster.siamese.dyndns.org> <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com> <7vbpsuxqpo.fsf@gitster.siamese.dyndns.org> <94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com> <7vljrxveqa.fsf@gitster.siamese.dyndns.org> <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com> <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com> <7v3ae4r53f.fsf@gitster.siamese.dyndns.org> <20090224130626.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, felipe.contreras@gmail.com,
	git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 05:52:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbpHK-0002Mb-Hm
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 05:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZBXEuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 23:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbZBXEup
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 23:50:45 -0500
Received: from peff.net ([208.65.91.99]:46274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752949AbZBXEup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 23:50:45 -0500
Received: (qmail 11056 invoked by uid 107); 24 Feb 2009 04:51:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Feb 2009 23:51:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2009 23:50:41 -0500
Content-Disposition: inline
In-Reply-To: <20090224130626.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111206>

On Tue, Feb 24, 2009 at 01:06:26PM +0900, Nanako Shiraishi wrote:

> Some people prefer to call the pretty-print styles "format", and get
> annoyed to see "git log --format=short" fail.  Introduce it as a synonym
> to --pretty so that both can be used interchangeably without breaking
> examples in existing web pages or ppeople's expectations.

Thinking about this in context of the proposal to support --oneline (et
al), I think this part by itself gives confusing behavior. That is,
--pretty=oneline can be shortened to --oneline, but --pretty=format:$x
cannot be shortened to --format=$x.

But that is modified by what happens next:

> Having to say --format="format:%h %s" is redundant because none of the
> predefined pretty-print styles have per-cent sign in it, so this patch
> also makes it possible to say --pretty="%h %s" (and --format="%h %s").

This implies that --format=$x is equivalent to --pretty=format:$x, but
the patch actually implements the equivalent of --pretty=tformat:$x.

So that raises two concerns:

  1. We have to pick one as the "most common" for this shorthand; are we
     sure tformat is it? (Personally, I think it is, but I think it is a
     subtle point which we should be sure of).

  2. This _almost_ fixes the point I raised above. That is, --format=$x
     would match its longer --pretty=format:$x counterpart. Except that
     --format does _tformat_, which I would have expected to get via
     --tformat under such a proposal.

-Peff
