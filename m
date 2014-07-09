From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t/Makefile: always test all lint targets when
 running tests
Date: Wed, 9 Jul 2014 01:30:05 -0400
Message-ID: <20140709053005.GD2318@sigill.intra.peff.net>
References: <53B5D6FE.2090700@web.de>
 <53B5D76D.1090509@web.de>
 <xmqq38eddolk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4kSg-00016c-9T
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbaGIFaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:30:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58491 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754661AbaGIFaH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:30:07 -0400
Received: (qmail 23751 invoked by uid 102); 9 Jul 2014 05:30:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 00:30:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 01:30:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38eddolk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253064>

On Mon, Jul 07, 2014 at 11:13:11AM -0700, Junio C Hamano wrote:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> > Only the two targets "test-lint-duplicates" and "test-lint-executable" are
> > currently executed when running the test target. This was done on purpose
> > when the TEST_LINT variable was added in 81127d74. But as this does not
> > include the "test-lint-shell-syntax" target added the same day in commit
> > c7ce70ac, it is easy to accidentally add non portable shell constructs
> > without noticing that when running the test suite.
> 
> I not running the lint-shell-syntax that is fundamentally flaky to
> avoid false positives is very much on purpose.  The flakiness is not
> the fault of the implementor of the lint-shell-syntax, but comes
> from the approach taken to pretend that simple pattern matching can
> parse shell scripts.  It may not complain on the current set of
> scripts, but that is not really by design but by accident.
> 
> So I am not very enthusiastic to see this change myself.

Let me play devil's advocate for a moment.

Is lint-shell-syntax in fact flaky? I know we discussed false positives
when it was originally added, but I think the current implementation
tries hard to avoid them. Given that it provides no false positives on
the current code base (without many people running it), it seems likely
to stay that way. And the cost if we are wrong is either fixing the tool
or disabling it (so worst case we are back where we started, modulo a
little effort to enable it and then revert).

What do we gain? We have an extra line of defense that helps newer shell
script writers fix their bugs before they make it to the list. That
catches more bugs, and reduces effort for reviewers. And it is exactly
these newer shell script writers that need the default flipped; they do
not know about portability and the lint target in the first place.

I dunno. I am not that enthusiastic about the change, either, but I tend
to think it will probably not hurt, and may help.

-Peff
