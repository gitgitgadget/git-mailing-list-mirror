From: Jeff King <peff@peff.net>
Subject: Re: [BUG/RFC] Raw diff output format (git-diff-tree) and
 --relative[=<path>] option
Date: Mon, 9 Aug 2010 10:59:56 -0400
Message-ID: <20100809145956.GB3438@sigill>
References: <201007051015.26995.jnareb@gmail.com>
 <201007081419.42702.jnareb@gmail.com>
 <20100708142341.GA9991@coredump.intra.peff.net>
 <201007081656.23474.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 17:00:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiTpu-00049f-02
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 17:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab0HIPAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 11:00:00 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685Ab0HIO77 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 10:59:59 -0400
Received: (qmail 22171 invoked by uid 111); 9 Aug 2010 14:59:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 09 Aug 2010 14:59:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Aug 2010 10:59:56 -0400
Content-Disposition: inline
In-Reply-To: <201007081656.23474.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152972>

On Thu, Jul 08, 2010 at 04:56:20PM +0200, Jakub Narebski wrote:

> > Or was that what you had in mind the whole time? My impression was that
> > you wanted --relative=foo to always be equivalent to --relative=foo/.
> > The subtle difference is that I want the "/" removed only if it is the
> > next character (or another way of thinking about it is to append "/" to
> > the prefix only if it is an actual directory).
> 
> What I wanted is for "git diff-tree A B --relative=sub" to behave as
> "git diff-tree A:sub B:sub".  Currently without -r / -t (without turning
> on recursive mode) it produces no output; well at least no output if
> 'sub' is really subdirectory.

I think this is a separate issue from the extra slash problem. I don't
think it would hurt anything to enable "-r" automatically in diff-tree,
but _only_ if we know that the prefix we stripped ended in "/". Since
that is just changing a case that is already nonsensical, whereas
turning on recursion for "git diff-tree --relative=foo- A B" would
actually be a change in behavior.

It should be possible, but it is a bit more surgery, since the prefix
stripping code is pretty dumb currently.

> What's more I wanted for "git diff --raw" in any combination to behave
> the same... although I guess here point is moot, as "git diff" is
> automatically recursive regardless of output format, and you can't turn
> it off.

Yeah, I think "git diff" already does what you want, since 82cb8af
(git-diff: turn on recursion by default, 2007-07-29).

-Peff
