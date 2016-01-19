From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Tue, 19 Jan 2016 18:29:50 -0500
Message-ID: <20160119232950.GB31181@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
 <xmqqio2p89mb.fsf@gitster.mtv.corp.google.com>
 <20160119230633.GA31142@sigill.intra.peff.net>
 <xmqq60yp8837.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:29:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfin-0004PK-4s
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294AbcASX3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:29:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:56568 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932702AbcASX3w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:29:52 -0500
Received: (qmail 17445 invoked by uid 102); 19 Jan 2016 23:29:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 18:29:52 -0500
Received: (qmail 27848 invoked by uid 107); 19 Jan 2016 23:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 18:30:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 18:29:50 -0500
Content-Disposition: inline
In-Reply-To: <xmqq60yp8837.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284398>

On Tue, Jan 19, 2016 at 03:26:04PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > You can also note that if we ever delete a test script, it will still be
> > mentioned in prove's state file. I think prove is smart enough to
> > realize it went away and not bother you.
> 
> The inverse might be more problematic.  When we add a new test
> script (which we still do from time to time), does prove notice
> that we asked it to run more tests than it already knows about?

Yes. It runs the union of the state-file and what you give it on the
command line. E.g.:

  $ rm .prove
  $ prove --state=slow,save t0000-basic.sh
  No saved state, selection will be empty
  t0000-basic.sh .. ok    
  All tests successful.
  Files=1, Tests=77,  1 wallclock secs ( 0.03 usr  0.00 sys +  0.08 cusr 0.06 csys =  0.17 CPU)
  Result: PASS

  $ prove --state=slow,save t0001-init.sh
  t0000-basic.sh .. ok    
  t0001-init.sh ... ok    
  All tests successful.
  Files=2, Tests=113,  1 wallclock secs ( 0.03 usr  0.00 sys +  0.06 cusr  0.10 csys =  0.19 CPU)
  Result: PASS

-Peff
