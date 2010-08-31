From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix quotes in maint-reflog-beyond-horizon and
 detached-stash
Date: Tue, 31 Aug 2010 11:54:57 -0400
Message-ID: <20100831155457.GB11014@sigill.intra.peff.net>
References: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:54:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTAf-0006jB-2c
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484Ab0HaPyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:54:40 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43256 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461Ab0HaPyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:54:40 -0400
Received: (qmail 28345 invoked by uid 111); 31 Aug 2010 15:54:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 15:54:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 11:54:57 -0400
Content-Disposition: inline
In-Reply-To: <1283266160-11665-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154922>

On Wed, Sep 01, 2010 at 12:49:18AM +1000, Jon Seymour wrote:

> In two recent series, I introduced tests that use test_must_fail incorrectly.
> 
> In effect, I was calling:
> 
>    test_must_fail "foo bar"
> 
> but this was failing because "foo bar" is not comamnd and not because
> the command "foo" fails with arguments "bar".
> 
> These two patches fix these problems.

I grepped around and I think you got all of the cases. I think we can
catch this in the test harness itself, though, with the following
series:

  [1/2]: tests: make test_must_fail more verbose
  [2/2]: tests: make test_must_fail fail on missing commands

With this series, I get (on pu):

  $ ./t1503-rev-parse-verify.sh -v -i
  [...]
  eval: 9: git rev-parse --verify master@{4}: not found
  test_must_fail: command not found: git rev-parse --verify master@{4}
  not ok - 7 master@{n} for various n

-Peff
