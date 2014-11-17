From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Add git ignore as builtin
Date: Mon, 17 Nov 2014 15:59:57 -0500
Message-ID: <20141117205957.GB15880@peff.net>
References: <CA+mQAOXPZSv2B8tVfC=4eJ7X_2j8Di4BkuE=z43=U2+VNpdQQg@mail.gmail.com>
 <CA+mQAOU_UnPuSk0f9d1sUnxBj8M4zEX7bwa4Dw_z_PJV3Lp4LA@mail.gmail.com>
 <loom.20141117T010932-213@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ryan Jacobs <ryan.mjacobs@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 22:00:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqTP5-000330-Hx
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 22:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbaKQVAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 16:00:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:41278 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751297AbaKQVAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 16:00:00 -0500
Received: (qmail 1601 invoked by uid 102); 17 Nov 2014 20:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 14:59:59 -0600
Received: (qmail 1796 invoked by uid 107); 17 Nov 2014 21:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 17 Nov 2014 16:00:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Nov 2014 15:59:57 -0500
Content-Disposition: inline
In-Reply-To: <loom.20141117T010932-213@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 17, 2014 at 12:12:25AM +0000, Ryan Jacobs wrote:

> Alberto Fanjul Alonso <albertofanjul <at> gmail.com> writes:
> 
> 
> > git ignore <whatever> adds <whatever> to .git/info/exclude
> 
> This should be "git exclude" not "git ignore".
> Difference between the two: http://stackoverflow.com/questions/10066749/git-
> excludes-vs-ignores

I am not sure that the name difference is all that meaningful. Yes, we
call the repo-wide file .git/info/exclude and the in-tree ones
.gitignore, but I do not know if the distinction is more than historical
accident.

> I'd second the notion of a "git ignore", however it would have to modify the 
> `.gitignore` not `.git/info/exclude`.

And I think this is a good reason why we do not have a "git ignore" tool
to write such things. If I say "git ignore foo" should it go into
.git/info/exclude or .gitignore? If the latter, should it be "foo" to
match everywhere, or "/foo" to match only the single path at the root?
If the file is "subdir/foo", should it go as "/subdir/foo" into the
top-level ".gitignore", or as "foo" into "subdir/.gitignore"? If you
ignore "foo.o" and "bar.o", should we suggest that you ignore "*.o"
instead?

Trying to accomodate all of those possibilities in a command-line tool
is hard, and probably counter-productive. We already have a simple
domain-specific language for specifying .gitignore files.  You can just
try to cover a common case, like "always put the full slash-prefixed
path into the top-level .gitignore". But then I wonder if "git ignore"
is really adding much value, as it is just a thin wrapper around "echo".

-Peff

PS The more interesting case to automate (to me, anyway) is _checking_
   paths against the hand-written .gitignore rules, which is complicated
   to do by hand.  You can do that already with "git check-ignore".
