From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] solaris test fixups
Date: Thu, 23 Jan 2014 14:54:05 -0500
Message-ID: <20140123195404.GA31314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 20:54:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QLt-0004xm-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbaAWTyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:54:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:37688 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751544AbaAWTyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:54:07 -0500
Received: (qmail 26960 invoked by uid 102); 23 Jan 2014 19:54:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 13:54:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 14:54:05 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240932>

Due to the alignment bug in another thread, I had the pleasure of
visiting my old friend Solaris 9 today. The tests _almost_ all run out
of the box.

This series features two minor fixes:

  [1/2]: t7501: fix "empty commit" test with NO_PERL
  [2/2]: t7700: do not use "touch -r"

I had a few other failures related to encodings; I suspect the problem
is simply that the machine in question doesn't have eucJP support at
all.

The big one that I did not fix is in t7001-mv. We do this:

  test_must_fail git mv some-file no-such-dir/

and assume that it will fail. It doesn't. Solaris happily renames
some-file to a regular file named "no-such-dir". So we fail later during
the index-update, complaining about adding the entry "no-such-dir/", but
still exit(0) at the end. I'm mostly willing to just call Solaris crazy
for allowing the rename (Linux returns ENOTDIR), but I do wonder if
the index codepath could be improved (and especially to return an
error).

-Peff
