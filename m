From: Jeff King <peff@peff.net>
Subject: Re: git-config: case insensitivity for subsections
Date: Mon, 29 Aug 2011 11:58:19 -0400
Message-ID: <20110829155819.GA756@sigill.intra.peff.net>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
 <20110825205849.GA10384@sigill.intra.peff.net>
 <20110825215757.GA94231@hal.rescomp.berkeley.edu>
 <1314579031.10094.19.camel@umgah.localdomain>
 <20110829054240.GB94231@hal.rescomp.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Vandiver <alex@chmrr.net>, git@vger.kernel.org
To: milki <milki@rescomp.berkeley.edu>
X-From: git-owner@vger.kernel.org Mon Aug 29 17:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4EL-0004EU-2H
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 17:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab1H2P61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 11:58:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab1H2P60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 11:58:26 -0400
Received: (qmail 18094 invoked by uid 107); 29 Aug 2011 15:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 11:59:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 11:58:19 -0400
Content-Disposition: inline
In-Reply-To: <20110829054240.GB94231@hal.rescomp.berkeley.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180313>

On Sun, Aug 28, 2011 at 10:42:40PM -0700, milki wrote:

> A user gave me a link [1] to his git-config and I cannot correctly
> parse, for example, his alias.last.
> [...]
> [1] https://github.com/kergoth/homefiles/blob/master/.gitconfig#L67

Isn't his config somewhat broken?  It looks like this:

  last = "!f(){ since="$1"; shift; git lg --since=\"last $since\" "$@"; }; f"

Those interior double-quotes should all be backslash-escaped. I didn't
check, but git should interpret this as:

  !f(){ since=$1; shift; git lg --since="last $since" $@; }; f

which is probably not quite what he wanted (the quotes around $1 were
actually superfluous, but the ones around $@ are important).

That being said, I think it is intentional that the value is not just "a
single double-quoted chunk" but rather could consist of several quoted
(or unquoted) chunks concatenated together. What does your parser think
of:

  [foo]
    bar = "foo"bar"baz"

It should be:

  $ git config foo.bar
  foobarbaz

-Peff
