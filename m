From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] git log -g --pretty=format: learns about reflog
Date: Thu, 26 Feb 2009 05:55:27 -0500
Message-ID: <20090226105527.GC4226@coredump.intra.peff.net>
References: <cover.1235622145.git.deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdvJ-0004XA-2m
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbZBZKzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbZBZKzc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:55:32 -0500
Received: from peff.net ([208.65.91.99]:40738 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbZBZKzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:55:31 -0500
Received: (qmail 3890 invoked by uid 107); 26 Feb 2009 10:55:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Feb 2009 05:55:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Feb 2009 05:55:27 -0500
Content-Disposition: inline
In-Reply-To: <cover.1235622145.git.deskinm@umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111552>

On Wed, Feb 25, 2009 at 11:44:03PM -0500, Deskin Miller wrote:

> I'm a little leery of using commit->util to carry the reflog info, but I
> didn't see a much better way, without altering the signature of
> pretty_print_commit to take an optional reflog parameter.  The code

Personally I am not opposed to some refactoring of the pretty_print
code. A few months ago I wanted to add a new pretty-printing
feature (it was keeping count of the total and printed patches, so you
could say something "Patch %count/%total"). Passing information around
through all of the functions got quite burdensome, and I started a
refactoring to have a "pretty_print_context" that could be passed around
and contain a lot of the pseudo-global variables.

I didn't get very far before giving up and working on something else.
But my point is that any refactoring you do may end up helping other
features in the future.

As a side note, I also think figuring out what the formats look like by
reading the pretty-print code is insane, because it is a mass of special
cases and switch statements on format. I think it would be much more
manageable "inside-out": each format has its own primary function, and
the common stuff is factored out into helpers.

But that's just based on memory from a few months ago.

-Peff
