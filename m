From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Wed, 20 Apr 2016 00:37:04 -0400
Message-ID: <20160420043704.GA12667@sigill.intra.peff.net>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
 <1461079290-6523-3-git-send-email-sbeller@google.com>
 <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
 <20160420041827.GA7627@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 06:37:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asjt4-0003pI-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 06:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbcDTEhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 00:37:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:52626 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754256AbcDTEhH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 00:37:07 -0400
Received: (qmail 16869 invoked by uid 102); 20 Apr 2016 04:37:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 00:37:07 -0400
Received: (qmail 23536 invoked by uid 107); 20 Apr 2016 04:37:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Apr 2016 00:37:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2016 00:37:04 -0400
Content-Disposition: inline
In-Reply-To: <20160420041827.GA7627@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291980>

On Wed, Apr 20, 2016 at 12:18:27AM -0400, Jeff King wrote:

> My earlier tests with the perl script were all done with "git log -p",
> which will not show anything at all for merges (and my script wouldn't
> know how to deal with combined diffs anyway). But I think this new patch
> _will_ kick in for combined diffs (because it is built on individual
> diffs). It will be interesting to see if this has any effect there, and
> what it looks like.
> 
> We should be able to see it (on a small enough repository) with:
> 
>   git log --format='commit %H' --cc --merges
> 
> and comparing the before/after.

Add in "-p" if you are testing the tip of jk/diff-compact-heuristic. It
is based on the older maintenance track in which "--cc" does not imply
"-p".

Looking over the results, it's about what you'd expect (comment blocks
shifted by one as we want, and then there happens to be a one-line
conflict resolved later in the hunk).

The most interesting thing I found was db65f0fc3b1e. There we have two
functions being added in the same spot, and the resolution obviously is
to put one after the other. So both sides do the usual comment-block
thing, and the resulting combined diff carries through that improvement
as you'd expect.

-Peff
