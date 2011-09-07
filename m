From: Jeff King <peff@peff.net>
Subject: Re: git push output goes into stderr
Date: Wed, 7 Sep 2011 17:57:16 -0400
Message-ID: <20110907215716.GJ13364@sigill.intra.peff.net>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
 <7v8vq3ztym.fsf@alter.siamese.dyndns.org>
 <20110906074916.GC28490@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:57:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Q7V-0006Pd-GK
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab1IGV5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:57:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51940
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757310Ab1IGV5S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:57:18 -0400
Received: (qmail 6862 invoked by uid 107); 7 Sep 2011 21:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Sep 2011 17:58:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2011 17:57:16 -0400
Content-Disposition: inline
In-Reply-To: <20110906074916.GC28490@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180921>

On Tue, Sep 06, 2011 at 09:49:16AM +0200, Clemens Buchacher wrote:

> On Sun, Sep 04, 2011 at 05:57:53PM -0700, Junio C Hamano wrote:
> > Lynn Lin <lynn.xin.lin@gmail.com> writes:
> > 
> > > When I create a local branch and then push it to remote. I find that
> > > the output without error goes into stderr, is this expected?
> > 
> > Progress output are sent to the stderr stream.
> 
> But it's not only progress output that goes to stderr in case of
> git push. Even the summary written in tranport_print_push_status
> goes to stderr, unless we specify git push --porcelain. Can't we
> let that part of the output go to stdout unconditionally?

We could, though it makes more sense on stderr to me.

Stdout has always been about "the main program output" and stderr about
diagnostic messages. With a program whose main function is to generate
output (e.g., "git tag -l", it's very easy to know that the list of tags
is the main program output (which you don't want to pollute with
anything else), and any problems or even general chattiness goes to
stderr.

But with a program whose main function is to perform an action, like
"git push", I think there are really two ways to look at it:

  1. There is no main output; any progress or status update is just
     diagnostic chat, and should go to stderr.

  2. The main output is the status report; it goes to stdout, and
     progress updates go to stderr.

I think both are equally valid mental models, and both are consistent
with the philosophy above. If we switch, I wouldn't be surprised to see
somebody say "why is this going to stdout, it should be on stderr". In
fact, I seem to recall that we've had this discussion before on the
list.

-Peff
