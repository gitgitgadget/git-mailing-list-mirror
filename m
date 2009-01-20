From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Rename detection: Avoid repeated filespec population
Date: Tue, 20 Jan 2009 17:12:14 -0500
Message-ID: <20090120221214.GA13668@coredump.intra.peff.net>
References: <20090120155957.GA23237@atjola.homenet> <20090120212723.GA10967@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPOqs-0003wm-9e
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 23:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbZATWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755153AbZATWMR
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 17:12:17 -0500
Received: from peff.net ([208.65.91.99]:43602 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbZATWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 17:12:16 -0500
Received: (qmail 4747 invoked by uid 107); 20 Jan 2009 22:12:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 17:12:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 17:12:14 -0500
Content-Disposition: inline
In-Reply-To: <20090120212723.GA10967@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106528>

On Tue, Jan 20, 2009 at 04:27:23PM -0500, Jeff King wrote:

> I have a pathological real-world rename test case from a long time ago.
> It's so awful on rename because almost the whole repo was reorganized,
> but almost every path got its content adjusted, too. I was hoping it
> would be better with your patch, but it isn't: as it turns out, it is
> _too_ uniform. The cheap size checks don't work because all of the files
> are almost the same size (they're all jpgs from a camera).

Nevermind, I'm stupid. Your patch _does_ yield a significant improvement
for my test case. I was accidentally comparing your patch to some of my
previous optimization attempts, not to vanilla git.

Without your patch, I get:

  $ time git show -l0 06d28867 >/dev/null
  841.88user 146.95system 17:18.99elapsed 95%CPU (0avgtext+0avgdata 0maxresident)k
  2476880inputs+0outputs (19372major+27092797minor)pagefaults 0swaps

With it, I get:

  $ time git show -l0 06d28867 >/dev/null
  100.51user 5.76system 2:31.07elapsed 70%CPU (0avgtext+0avgdata 0maxresident)k
  2020176inputs+0outputs (15771major+836127minor)pagefaults 0swaps

So much much better.

-Peff
