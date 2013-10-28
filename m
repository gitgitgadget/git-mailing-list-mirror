From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t/README: tests can use perl even with NO_PERL
Date: Mon, 28 Oct 2013 15:54:29 -0400
Message-ID: <20131028195429.GA8299@sigill.intra.peff.net>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
 <1382951633-6456-1-git-send-email-bdwalton@gmail.com>
 <526EA7C8.2020607@kdbg.org>
 <20131028182718.GA4242@google.com>
 <xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
 <20131028192216.GB4242@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bdwalton@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:54:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VastY-0007Md-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab3J1Tyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:54:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:57210 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756040Ab3J1Tyc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:54:32 -0400
Received: (qmail 12606 invoked by uid 102); 28 Oct 2013 19:54:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 14:54:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 15:54:29 -0400
Content-Disposition: inline
In-Reply-To: <20131028192216.GB4242@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236855>

On Mon, Oct 28, 2013 at 12:22:16PM -0700, Jonathan Nieder wrote:

> The git build system supports a NO_PERL switch to avoid installing
> perl bindings or other features (like "git add --patch") that rely on
> perl on runtime, but even with NO_PERL it has not been possible for a
> long time to run tests without perl.  Helpers such as
> 
> 	nul_to_q () {
> 		"$PERL_PATH" -pe 'y/\000/Q/'
> 	}
> 
> use perl as a better tr or sed and are regularly used in tests without
> worrying to add a PERL prerequisite.
> 
> Perl is portable enough that it seems fine to keep relying on it for
> this kind of thing in tests (and more readable than the alternative of
> trying to find POSIXy equivalents).  Update the test documentation to
> clarify this.
> 
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Yeah, I think this accurately the conclusions we've come to informally
during review on the list (for a long time we did not even use
$PERL_PATH for such "vanilla" cases, but some people have a broken perl
in their PATH).

Your patch looks good, and I think Ben's patch does not need a PERL
prerequisite. However, it is supposed to use $PERL_PATH, which it does
not.

Speaking of which, is there any reason to use the ugly "$PERL_PATH"
everywhere, and not simply do:

  perl () {
    "$PERL_PATH" "$@"
  }

in test-lib.sh?

-Peff
