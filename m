From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] negative hideRefs for overriding
Date: Tue, 28 Jul 2015 15:57:47 -0400
Message-ID: <20150728195747.GA13596@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 21:58:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB0c-0003Ci-1c
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbG1T5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:57:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:35976 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752295AbbG1T5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:57:49 -0400
Received: (qmail 32305 invoked by uid 102); 28 Jul 2015 19:57:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 14:57:49 -0500
Received: (qmail 20338 invoked by uid 107); 28 Jul 2015 19:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jul 2015 15:57:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jul 2015 15:57:47 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274824>

At GitHub, we keep some information in a private part of the refs
namespace. We use transfer.hideRefs so that users do not see it when
fetching or pushing, and that works well. However, sometimes we want to
expose part of the hidden namespace (e.g., for an internal fetch or
push), and that cannot be done with the existing code. Usually config
variables are last-one-wins, so you can simply overwrite any existing
values with "git -c ...". But for multi-valued config like hideRefs,
that just appends to the list, and the ref remains hidden.

This series adds negation to hideRefs, which gives us a reasonable
last-one-wins setup. That allows "git -c" to unhide a specific set of
refs (though note you have to use "--upload-pack='git -c ...'" since
upload-pack does not share our environment). It also allows more complex
config, like hiding all of "refs/foo" except for "refs/foo/bar". We
don't use that ourselves, but it might come in handy (and logically
falls out of the last-one-wins setup).

The first patch is some documentation cleanup. The interesting bit is in
the second one.

  [1/2]: docs/config.txt: reorder hideRefs config
  [2/2]: refs: support negative transfer.hideRefs

-Peff
