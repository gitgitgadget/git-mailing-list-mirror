From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] merging renames of empty files
Date: Thu, 22 Mar 2012 18:46:51 -0400
Message-ID: <20120322224651.GA14874@sigill.intra.peff.net>
References: <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
 <20120322190303.GA32756@sigill.intra.peff.net>
 <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:46:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAqmZ-0007iX-3v
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031317Ab2CVWqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:46:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56994
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756995Ab2CVWqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 18:46:53 -0400
Received: (qmail 6662 invoked by uid 107); 22 Mar 2012 22:47:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 18:47:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 18:46:51 -0400
Content-Disposition: inline
In-Reply-To: <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193723>

On Thu, Mar 22, 2012 at 12:12:06PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That is a slight layering violation, in that we are making assumptions
> > about how the diffcore-rename subsystem works.
> 
> I do not think I have to say any more than that.  The special case we want
> to have is for the "empty to empty" case and nothing else, and I do not
> want to see people having to remember to look at the merge-recursive code
> if/when rename detection starts to treat "empty to small" as "rename with
> minor modification."

Here's a 2-patch series to replace the old 3/3 (they go on top of the
first two cleanups from the previous iteration).

  [1/2]: teach diffcore-rename to optionally ignore empty content
  [2/2]: merge-recursive: don't detect renames of empty files

Thinking on this more, it is actually a more generic problem than just
empty files. It is really a problem of having generic placeholder files
with the same content. So a fully general solution would be something
like a gitattribute for "don't do renames on this". However, in
practice, these placeholder files are empty (since any non-empty file is
likely to actually have different content). So I think just dropping the
empty files as rename candidates is a pretty good heuristic, and it's
nice and simple.

After responding to Jonathan, I'm on the fence about whether diff should
follow the same heuristic. I left the diff behavior unchanged, but a 3/2
that turns it off by default would be a trivial one-liner.

-Peff
