From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 30 Mar 2010 19:04:08 -0400
Message-ID: <20100330230408.GD608@coredump.intra.peff.net>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <201003310059.33937.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Lars R. Damerow" <lars@pixar.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:04:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwkTy-0005Yo-Ax
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0C3XEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:04:21 -0400
Received: from peff.net ([208.65.91.99]:48767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965Ab0C3XEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:04:21 -0400
Received: (qmail 27009 invoked by uid 107); 30 Mar 2010 23:04:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 30 Mar 2010 19:04:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Mar 2010 19:04:08 -0400
Content-Disposition: inline
In-Reply-To: <201003310059.33937.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143619>

On Wed, Mar 31, 2010 at 12:59:33AM +0200, Thomas Rast wrote:

> Linus Torvalds wrote:
> > 
> > I suspect that it is _very_ unusual to have a source repo that crosses 
> > multiple filesystems, and the original reason for this patch-series seems 
> > to me to be likely to be more common than that multi-fs case. So having 
> > the logic go the other way would seem to match the common case, no?
> 
> Not sure if I'm the only one, but I noticed at some point that
> mounting the t/ directory of git.git on tmpfs gives a huge speed boost
> to the test suite...

I noticed it, too, but my solution was a little different:

  $ git show f423ef5f
    tests: allow user to specify trash directory location

    The tests generate a large amount of I/O activity creating
    and destroying repositories and files. We can improve the
    time it takes to run the test suite by creating trash
    directories on filesystems with better performance
    characteristic, even though we may not want the rest of the
    git repository on those filesystems (e.g., because they are
    not network connected, or because they are temporary
    ramdisks).

    For example, on a dual processor system:

      $ cd t && time make -j32
      real    1m51.562s
      user    0m59.260s
      sys     1m20.933s

      # /dev/shm is tmpfs
      $ cd t && time make -j32 GIT_TEST_OPTS="--root=/dev/shm"
      real    1m1.484s
      user    0m53.555s
      sys     1m5.264s

-Peff
