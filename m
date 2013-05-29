From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] test-lib: verbose mode for only tests matching a
 pattern
Date: Wed, 29 May 2013 01:00:00 -0400
Message-ID: <20130529050000.GB31762@sigill.intra.peff.net>
References: <cover.1368736093.git.trast@inf.ethz.ch>
 <10e5eacece7fc9657c312b5c51747d23ae9ef40b.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 29 07:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhYUd-0002oa-UX
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359Ab3E2FAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:00:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863Ab3E2FAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:00:05 -0400
Received: (qmail 9890 invoked by uid 102); 29 May 2013 05:00:43 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 May 2013 00:00:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 May 2013 01:00:00 -0400
Content-Disposition: inline
In-Reply-To: <10e5eacece7fc9657c312b5c51747d23ae9ef40b.1368736093.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225735>

On Thu, May 16, 2013 at 10:50:14PM +0200, Thomas Rast wrote:

> With the new --verbose-only=<pattern> option, one can enable --verbose
> at a per-test granularity.  The pattern is matched against the test
> number, e.g.
> 
>   ./t0000-basic.sh --verbose-only='2[0-2]'
> 
> to see only the full output of test 20-22, while showing the rest in the
> one-liner format.
> 
> This is arguably not *too* useful on its own, but makes the next patch
> easier to follow.

Hmm, I don't think this is quite right. Try:

  ./t4052-stat-output.sh --verbose-only=85

The script and test number aren't important; I just picked these at
random, but they show the issue clearly.  The output I get is:

  [...]
  ok 83 - log respects prefix greater than COLUMNS (big change)
  ok 84 - log --graph respects prefix greater than COLUMNS (big change)
  Switched to a new branch 'branch'
  ok 85 - merge --stat respects COLUMNS (big change)

  expecting success: 
          COLUMNS=100 git merge --stat --no-ff master >output &&
          grep " | " output >actual
          test_cmp expect actual

  ok 86 - merge --stat respects COLUMNS (long filename)

So we see 83 and 84 non-verbose, which is good. And we see the actual
output from 85 (the output from a "git checkout"). But we do not see the
"expecting success" for it. We see it for the _next_ test, which we
should not see at all. So I think your toggling is happening in the
wrong spot, but I haven't looked further than that.

-Peff
