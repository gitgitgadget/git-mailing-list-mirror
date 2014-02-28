From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 01:27:15 -0500
Message-ID: <20140228062715.GE32556@sigill.intra.peff.net>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
 <20140228053703.GA32556@sigill.intra.peff.net>
 <CAN7MxmWP9N==0DnoE-0=Xr7NWkNMSGBC+yiz1a3wS5EbHigvKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 07:27:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJGun-0002it-UU
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 07:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbaB1G1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 01:27:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:58493 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750795AbaB1G1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 01:27:17 -0500
Received: (qmail 9484 invoked by uid 102); 28 Feb 2014 06:27:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 00:27:17 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 01:27:15 -0500
Content-Disposition: inline
In-Reply-To: <CAN7MxmWP9N==0DnoE-0=Xr7NWkNMSGBC+yiz1a3wS5EbHigvKg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242890>

On Fri, Feb 28, 2014 at 03:17:28PM +0900, Brian Gesiak wrote:

> > For an operation like "git branch foo origin" where setting up the
> > tracking is a side effect, a warning makes sense. But the sole purpose
> > of the command above is to set the upstream, and we didn't do it; should
> > this warning actually be upgraded to an error?
> 
> I agree. I originally wrote the test using test_expect_failure--imagine my
> surprise when the exit status was 0, despite the fact that the upstream wasn't
> set!

For reference, you don't want test_expect_failure here; it is about "we
want this to succeed, but git is currently buggy and we know it, so mark
it as a failing test". You want test_must_fail to indicate a command
inside a test that must exit non-zero:

  test_expect_success 'pointing upstream to itself fails' '
          test_must_fail git branch -u ...
  '

I notice that the warning comes from install_branch_config, which gets
used both for "branch -u", but also in the "side effect" case I
mentioned above. Is it possible to trigger this as part of such a case?
I think maybe "git branch -f --track foo foo" would do it. If so, we
should perhaps include a test that it does not break if we upgrade the
"-u" case to an error.

> Patch is on the way, just waiting for the tests to complete. Thanks
> for pointing that out! Also, sorry if it's in the Makefile somewhere,
> but is there an easy way to run just a single test file in the t
> directory?

You can run "./tXXXX-....sh" explicitly.

-Peff
