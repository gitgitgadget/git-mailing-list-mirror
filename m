From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Tue, 30 Oct 2012 00:28:50 -0400
Message-ID: <20121030042850.GA23263@sigill.intra.peff.net>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 05:29:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Rp-0006Gt-Qi
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920Ab2J3E2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:28:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43327 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894Ab2J3E2w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:28:52 -0400
Received: (qmail 27202 invoked by uid 107); 30 Oct 2012 04:29:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Oct 2012 00:29:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2012 00:28:50 -0400
Content-Disposition: inline
In-Reply-To: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208662>

On Tue, Oct 30, 2012 at 05:12:57AM +0100, Felipe Contreras wrote:

> No reason to use the full path in case this is used externally.

I think it is not just "no reason to", but it is actively wrong to use a
full path, as we do not take care to "mkdir -p" the intervening path
components.

However, this never comes up in practice, because all of the test
scripts assume you are running them from the test directory (i.e.,
they will fail otherwise because they will not find ./test-lib.sh).

Is this in support of putting remote-hg tests in contrib/? I had
expected you to just put

  export TEST_DIRECTORY="$(pwd)/../../../t"
  . "$TEST_DIRECTORY/test-lib.sh"

into the test script in contrib/remote-hg/t. I guess you are doing
something like:

  cd ../../../t && ../contrib/remote-hg/t/twhatever...

but the former seems much simpler to invoke (and if the goal is to get
your test-results in the right place, setting TEST_OUTPUT_DIRECTORY is
the best way to do that).

If this is part of the remote-hg series, I'd prefer to just see it as
part of the re-roll. It's much easier to evaluate it in context.

Or are you really just doing:

  cd git/t
  $PWD/t0000-basic.sh

I guess there is nothing wrong with that, though there is no reason not
to use "./" instead of $PWD.

-Peff
