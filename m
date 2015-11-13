From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/subtree: unwrap tag refs
Date: Fri, 13 Nov 2015 00:01:24 -0500
Message-ID: <20151113050123.GA29708@sigill.intra.peff.net>
References: <1447388144-23806-1-git-send-email-git@rob.dqd.com>
 <87h9kqwm67.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rob Mayoff <mayoff@dqd.com>, git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Nov 13 06:01:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx6UO-0002KN-Rw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 06:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbKMFB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 00:01:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:56881 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751987AbbKMFB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 00:01:26 -0500
Received: (qmail 12011 invoked by uid 102); 13 Nov 2015 05:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Nov 2015 23:01:26 -0600
Received: (qmail 20754 invoked by uid 107); 13 Nov 2015 05:01:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 00:01:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 00:01:24 -0500
Content-Disposition: inline
In-Reply-To: <87h9kqwm67.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281234>

On Thu, Nov 12, 2015 at 10:36:16PM -0600, David A. Greene wrote:

> > +				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"
> 
> This seems like odd quoting.  Would not this do the same?
> 
> 				sub="$(git rev-parse $b^0)" || die "could not rev-parse split hash $b from commit $sq"
> 
> Perhaps I am missing something.

The former is quoting "$b" against whitespace splitting in the
sub-command. Given that the value just came from a "read" call, I think
by definition it cannot contains IFS. Still, quoting here is a good
habit.

It is actually the _outer_ quotes that are unnecessary, as variable
assignment does not do extra splitting. So:

  foo=$(echo one two)

will put the full "one two" into $foo. But the quotes do not hurt
anything, and it is a reasonable style to use them to avoid this
discussion. :)

It also matches style-wise with nearby assignments, like:

  main="$b"

-Peff
