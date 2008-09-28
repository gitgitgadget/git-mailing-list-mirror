From: Jeff King <peff@peff.net>
Subject: Re: Implementation of a "textconv" filter for easy custom diff.
Date: Sun, 28 Sep 2008 00:10:40 -0400
Message-ID: <20080928041040.GA24214@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 28 06:16:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjnhj-0005iF-1G
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 06:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbYI1EKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 00:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbYI1EKn
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 00:10:43 -0400
Received: from peff.net ([208.65.91.99]:2433 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751AbYI1EKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 00:10:43 -0400
Received: (qmail 3175 invoked by uid 111); 28 Sep 2008 04:10:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 00:10:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 00:10:40 -0400
Content-Disposition: inline
In-Reply-To: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96941>

On Sun, Sep 28, 2008 at 04:06:53AM +0200, Matthieu Moy wrote:

> This patch serie give an implementation of a "textconv" filter for
> "git diff", that allows one to diff anything that can easily be
> converted to text with just a few lines in ~/.gitconfig and
> .gitattributes.
> 
> The really cool thing in comparison with GIT_EXTERNAL_DIFF is that one
> gets all the cool things of "git diff" (colors & cie) for free.

Neat. I started on something like this quite a while ago, and have been
meaning to clean it up for some time (and I somehow missed your other
prototype, too). I agree that it matches my goals much better: the
filters are easier to write, and you get the benefit of a nice colorized
diff (or even --color-words!).

We have one major difference in our approaches. In yours, there is a
new "textconv" attribute that can be used. In mine, I subtly changed the
meaning of the "diff=foo" attribute to be "use the diff driver named by
diff.foo.*", and you would set diff.foo.textconv to your command. This
is a bit simpler to implement, and it provides a better path forward for
defining sets of diff tweaks.

For example, one of the limitations of the current syntax is that you
can't say "Choose automatically whether this is binary or text, but if
it is text, use this hunk header." But with my scheme it is easy to do:

  in attributes:
    file diff=foo

  in config:
    [diff "foo"]
    xfuncname = "some regex"
    binary = auto

Is there a particular reason you chose the route you did?

-Peff
