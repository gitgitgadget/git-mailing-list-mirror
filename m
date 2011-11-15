From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] upload-archive security issues
Date: Tue, 15 Nov 2011 16:42:00 -0500
Message-ID: <20111115214159.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 22:42:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQQm7-0007MV-9U
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 22:42:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617Ab1KOVmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 16:42:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42808
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504Ab1KOVmC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 16:42:02 -0500
Received: (qmail 10271 invoked by uid 107); 15 Nov 2011 21:42:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 16:42:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 16:42:00 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185489>

[Note to readers who haven't been following the recent thread on
upload-archive bugs: these security issues are in c09cd77e, which has
not actually been released. So this is "security problems, and we need
fixes before this ships in 1.7.8" and not "OMG your git site is 0wned"].

Looking at Erik's c09cd77e again, there are some serious security
problems, in that we are too lenient with what gets passed to
git-archive, which is not hardened to accept random client arguments.
That lets a client do all sorts of nasty things like running arbitrary
code.

These patches fix it by making cmd_archive handle the remote-request
flag better. An alternative would be to pass only known-good options
through upload-archive. That might be more future-proof, but also
involves upload-archive knowing about the innards of write_archive and
its options.  See also the comments in patch 2/2 for another alternative
fix.

  [1/2]: archive: don't allow negation of --remote-request
  [2/2]: archive: limit ourselves during remote requests

And yes, I feel like a moron for not noticing these problems during my
initial review.

-Peff
