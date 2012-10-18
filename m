From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] clean up filter-branch ident parsing
Date: Thu, 18 Oct 2012 03:22:08 -0400
Message-ID: <20121018072207.GA1605@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net>
 <1013956402.20121017125847@gmail.com>
 <20121017220912.GA21742@sigill.intra.peff.net>
 <507F9437.2070501@viscovery.net>
 <20121018053656.GA6308@sigill.intra.peff.net>
 <7vk3uomi0c.fsf@alter.siamese.dyndns.org>
 <20121018060847.GB6308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:22:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkQx-0007cg-L8
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab2JRHWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:22:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37518 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab2JRHWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:22:10 -0400
Received: (qmail 2469 invoked by uid 107); 18 Oct 2012 07:22:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 03:22:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 03:22:08 -0400
Content-Disposition: inline
In-Reply-To: <20121018060847.GB6308@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207971>

On Thu, Oct 18, 2012 at 02:08:47AM -0400, Jeff King wrote:

> Working on it now. git-sh-setup works, but chasing an annoying bug in
> filter-branch. I'm sure it's something silly and stupid.

Ugh. I was being caught by crazy dash-versus-bash stuff.

Try this:

  $ bash -c 'echo "\\\\"'
  \\
  $ dash -c 'echo "\\\\"'
  \

It's the "echo will automatically do backslash escaping" magic we have
so often enjoyed. I solved it with printf.

Patches to follow.

My primary motivation was cleanup, but it also has a net reduction of 5
fork+execs for each commit that filter-branch processes. This dropped
the run-time of "git filter-branch HEAD -1000" on my linux box from 62s
to 47s. A real filter-branch would do more work in the filters, of
course, but that translates to 7.5 minutes of time saved if you are
filtering all 30,000 commits of git.git.

  [1/2]: git-sh-setup: refactor ident-parsing functions
  [2/2]: filter-branch: use git-sh-setup's ident parsing functions

-Peff
