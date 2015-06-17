From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Wed, 17 Jun 2015 12:59:10 -0400
Message-ID: <20150617165909.GB22689@peff.net>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
 <20150610190512.GB22800@peff.net>
 <CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
 <20150611143204.GA3343@peff.net>
 <xmqq8ubi47jo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, Mike Edgar <adgar@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GgI-0003HI-P5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603AbbFQQ7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:59:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:47497 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754335AbbFQQ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:59:12 -0400
Received: (qmail 18788 invoked by uid 102); 17 Jun 2015 16:59:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 11:59:12 -0500
Received: (qmail 27204 invoked by uid 107); 17 Jun 2015 16:59:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 12:59:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 12:59:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8ubi47jo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271870>

On Wed, Jun 17, 2015 at 09:35:23AM -0700, Junio C Hamano wrote:

> > Of course it's hard to add to the test suite, since we do not have a way
> > of hitting a server that does not understand shallow (I simply fudged
> > server_supports() to return false on the client).
> 
> We've had the "shallow" capability advertised since ed09aef0
> (support fetching into a shallow repository, 2006-10-30), and this
> patch itself may not be that super-important in practice.  Let's not
> worry too much about a test for situations that may not likely
> matter to us [*1*].

I had actually started looking at doing a generic interop testing
suite. It would be nice to be able to do something like:

  cd t/interop
  ./run v1.0.0 v2.0.0 ./t0001-clone.sh

and then the test script looks something like:

  test_expect_success 'clone with A from B' '
	git.a clone -u "git.b upload-pack"
  '

The "run" script is similar to the version in t/perf that builds
arbitrary revisions for testing, but with the twist that it points
the PATH to "git.a" and "git.b", which symlink into the bin-wrappers/ of
the built directories (and probably disallows bare "git" to prevent
mistakes).

But I agree that this particular bug is not all that exciting to test.

> *1* How behind are re-implementations of upload-pack by other
> people, I have to wonder, though?

JGit advertises "shallow". Libgit2 does not, but it also does not
implement upload-pack. :)

I do wonder which server Mike was hitting to come across this in the
first place. Maybe the Google Code dulwich-based one?

-Peff
