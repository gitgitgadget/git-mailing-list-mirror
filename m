From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/8] refactor trace code
Date: Thu, 24 Feb 2011 09:23:09 -0500
Message-ID: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psc67-0004Hh-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab1BXOXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:23:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33729 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755495Ab1BXOXK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:23:10 -0500
Received: (qmail 23181 invoked by uid 111); 24 Feb 2011 14:23:09 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:23:09 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:23:09 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167810>

A few weeks ago in:

  http://article.gmane.org/gmane.comp.version-control.git/165496

we discussed the possibility of removing the repo setup trace lines. I
mentioned that I had also recently done some debug code that would not
be appropriate to show all the time with GIT_TRACE. So here is a series
that jumbles it all together: refactors the trace code to handle
multiple environment variables, adds packet-tracing code on its own
variable, and puts the repo setup traces on their own variable.

With this, you can do:

  GIT_TRACE=1 \
  GIT_TRACE_PACKET=/tmp/packet.dump \
  GIT_TRACE_SETUP=0 \
  git whatever

There may be a few other places where it is worth either pushing some
traces to their variable (I think the notes merge code has some
debugging traces in it), or places where existing debugging code could
be enabled (e.g., there is some diffcore debugging code that I sometimes
turn on; it is not even compiled by default, but this would give a nice
way of pushing that decision to runtime).

I have mixed feelings on adding a bunch of debugging code. On the one
hand, it's mostly dead code that nobody runs. On the other hand, it is
sometimes really helpful to be able to tell a user "run with this
environment variable and tell us what it says" without having to get
them to apply a custom patch.

  [1/8]: compat: provide a fallback va_copy definition
  [2/8]: strbuf: add strbuf_addv
  [3/8]: trace: add trace_vprintf
  [4/8]: trace: refactor to support multiple env variables
  [5/8]: trace: factor out "do we want to trace" logic
  [6/8]: trace: add trace_strbuf
  [7/8]: add packet tracing debug code
  [8/8]: trace: give repo_setup trace its own key

-Peff
