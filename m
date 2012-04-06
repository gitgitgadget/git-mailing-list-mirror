From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Fri, 6 Apr 2012 03:33:14 -0400
Message-ID: <20120406073314.GB27115@sigill.intra.peff.net>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
 <20120406022058.GA16264@sigill.intra.peff.net>
 <7v4nsx2vu1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG3fg-0002cp-Du
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 09:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955Ab2DFHdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 03:33:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49773
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab2DFHdT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 03:33:19 -0400
Received: (qmail 491 invoked by uid 107); 6 Apr 2012 07:33:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 03:33:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 03:33:14 -0400
Content-Disposition: inline
In-Reply-To: <7v4nsx2vu1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194856>

On Thu, Apr 05, 2012 at 11:55:18PM -0700, Junio C Hamano wrote:

> I agree that submitters would benefit from an automated way to propagate
> these addresses from reroll to reroll, and in a larger workflow "tweak and
> record while amending a commit for reroll" would be a natural place to do
> so, so I can see why it is tempting to abuse Cc: in the body of the
> message, but not knowing other ways is not a good excuse for such an
> abuse.  A workable solution is already available [*1*]: commit with a
> "---" line followed by Cc: and whatever extra junk while amending.

I've played with that workflow before. While it's a neat trick, note
that something like "format-patch -s" will put the signoff at the end,
like:

  commit subject

  commit body
  ---
  Cc: whomever
  Signed-off-by: you

which is not what you want. We could perhaps teach it to be smarter
about finding a "---", though I worry about hurting people who do not
use an email-based workflow, since they otherwise don't have to care
about "---".

About a year ago I had an RFC series to let "git commit" parse off the
"---" bit and turn it into a git-note (mostly for keeping track of
changes to the series between versions). It does solve that problem, and
response was reasonably positive. It does make things more complicated,
though, because IIRC you have to turn on note-rewriting manually to keep
the notes attached as you rebase.  Ultimately I didn't follow up because
I've found that I just don't end up keeping a lot of notes. I tend to do
the re-roll and then send it out pretty soon afterward, so I just write
any notes in the emails as they go out.

For complex "cc" lists and the like, I have a (fairly hacky) script that
takes an existing message as input and generates a format-patch series
with the to, cc, and in-reply-to fields filled in (and then I ship the
result out via my regular MUA after proof-reading and tweaking).
Potentially git-send-email could do the same thing.

-Peff
