From: Jeff King <peff@peff.net>
Subject: [PATCHv2 0/13] credential helpers
Date: Tue, 6 Dec 2011 01:21:28 -0500
Message-ID: <20111206062127.GA29046@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 07:21:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoPL-00048w-7y
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925Ab1LFGVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 01:21:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40038
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932910Ab1LFGVa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 01:21:30 -0500
Received: (qmail 1017 invoked by uid 107); 6 Dec 2011 06:28:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 01:28:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 01:21:28 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186319>

This is a re-roll of the credential helper series. Changes are noted
below.

  [01/13]: test-lib: add test_config_global variant
  [02/13]: t5550: fix typo
  [03/13]: introduce credentials API

    - simplified "first word is alnum" rules. You can now use "!f() {"
      to get a shell snippet helper.
    - documentation clarifications based on discussion with Junio
    - fix missing EOF in test script (same as the fixup in pu)
    - minor code style fixups

  [04/13]: credential: add function for parsing url components
  [05/13]: http: use credential API to get passwords
  [06/13]: credential: apply helper config
  [07/13]: credential: add credential.*.username
  [08/13]: credential: make relevance of http path configurable
  [09/13]: docs: end-user documentation for the credential subsystem
  [10/13]: credentials: add "cache" helper

    - don't die on unknown action, as suggested by credential helper
      docs. This is to leave room for new actions later.

  [11/13]: strbuf: add strbuf_add*_urlencode
  [12/13]: credentials: add "store" helper

    - don't die on unknown action, as above
    - "store --store=foo" is now spelled "store --file=foo"
    - passwords are now stored in most-recently-added order
    - drop remove/lookup restrictions, per discussion with Junio

    This last one has an interesting side effect. You can now
    do: "git credential-store erase </dev/null" to erase everything
    (since you have provided no restrictions, it matches everything).
    It's not something git would send intentionally, but it seems
    accidentally destructive (e.g., for some reason the main git process
    dies and closes the pipe). Perhaps a "credential on the wire" should
    be re-defined as a set of key/value lines followed by a blank line
    to signal "end"?

  [13/13]: t: add test harness for external credential helpers

    - actually invoke cleanup functions. The lib-credential script
      provides a best-effort cleanup function, since external helpers
      may be writing to system storage outsid of the trash directory.
      But in v1 we didn't actually call it.

-Peff
