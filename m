From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 18:12:11 -0500
Message-ID: <20110131231210.GD14419@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Feb 01 00:12:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2v3-0007Es-G4
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 00:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab1AaXMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 18:12:17 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50012 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824Ab1AaXMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 18:12:16 -0500
Received: (qmail 14610 invoked by uid 111); 31 Jan 2011 23:12:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 23:12:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 18:12:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165773>

On Mon, Jan 31, 2011 at 04:28:49PM -0500, Nicolas Pitre wrote:

> > Besides being just one more directory to go up and down, it does make 
> > history browsing more annoying. As much as I love git's "don't record 
> > renames" philosophy, our handling of renames on the viewing side is 
> > often annoying. I already get annoyed sometimes following stuff across 
> > the s!builtin-!builtin/! change. This would be like that but more so.
> 
> So... we do suck at something?  So why not take this opportunity to 
> shake yourself out of this easy comfort and improve Git as a result on 
> both front?  :-)

Yes, we do suck at rename following. The problem is that it is partially
an implementation issue, and partially a fundamental issue. Obviously
--follow sucks pretty hard right now, and that could be fixed. Namely it
follows only a single file, and it interacts very badly with history
simplification.

But even with those things fixed, there will still be annoyances.

It will still be _slower_ to turn it on all the time, for one[1]. And
that's due to fundamental design decisions of the git data structure.
And I'm not knocking those decisions; I think they made the right
tradeoff. But that doesn't mean we don't pay the cost for that tradeoff.

And no matter what your model, renames can be annoying. On-going topics
will have a painful rebase or merge. And people looking at history will
have to deal with the code-base having different names at different
points. Yeah, you can say it's all just "content", but the filenames we
put things in are actually useful.

So I don't think it's wrong to say "renames are a pain, and so should
not be done lightly". I do think it's wrong to say "renames can't be
done"; I just the cost needs to be considered.

-Peff

[1] I'd be interested to see how much we can get around that slowness
using a notes-cache.
