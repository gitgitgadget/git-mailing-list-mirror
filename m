From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 20:53:12 -0500
Message-ID: <20110201015312.GB2722@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
 <AANLkTim6YN5k+JjxYBkfpXYze1MRxFNAmSeJ_0CQpBnf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk5Qm-0005XB-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511Ab1BABxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:53:15 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754272Ab1BABxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:53:15 -0500
Received: (qmail 15821 invoked by uid 111); 1 Feb 2011 01:53:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Feb 2011 01:53:14 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 20:53:12 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim6YN5k+JjxYBkfpXYze1MRxFNAmSeJ_0CQpBnf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165788>

On Tue, Feb 01, 2011 at 01:35:16AM +0100, Erik Faye-Lund wrote:

> > It will still be _slower_ to turn it on all the time, for one[1]. And
> > that's due to fundamental design decisions of the git data structure.
> 
> Does it really have to be? I mean, for whole-file rename-detection, if
> we say that we automatically enable rename-detection (by default) as
> we reach the first commit that doesn't have a given tree-entry, then
> it would only kick in as we're about to terminate the log-output. And
> since we're usually reading through a pager, it should means that it
> takes a little bit more time before the user knows he's at the end of
> the log. It shouldn't really affect the throughput of the data before
> the point that becomes an annoyance, right?

That's not quite true. You may be following not just a single file, but
some arbitrary pathspec. Any time there is a file creation event that
matches that pathspec, you will want to rename-detect any possible
sources for that created file, and add them to the list of interesting
paths.

But yeah, we don't have to do rename detection for every single case. So
the slowness may turn out to be not that bad. When I had
arbitrary-pathspec following this summer I thought I did some numbers,
but I don't remember the results and I can't find them on the list.

-Peff
