From: Jeff King <peff@peff.net>
Subject: Re: Overlong lines with git-merge --log
Date: Fri, 2 Nov 2012 06:05:19 -0400
Message-ID: <20121102100519.GC30221@sigill.intra.peff.net>
References: <50932227.3090401@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tim Janik <timj@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:05:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUE87-0002MV-1r
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 11:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072Ab2KBKFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 06:05:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54223 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2KBKFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 06:05:21 -0400
Received: (qmail 2336 invoked by uid 107); 2 Nov 2012 10:06:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 06:06:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 06:05:19 -0400
Content-Disposition: inline
In-Reply-To: <50932227.3090401@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208917>

On Fri, Nov 02, 2012 at 02:30:15AM +0100, Tim Janik wrote:

> Using git-merge --log to merge commit messages that spawn multiple lines
> will produce overlong summary lines.
> That's because each summary line for a commit includes the entire commit
> message (all lines concatenated).
> 
> According to git-fmt-merge-msg(1), --log should 'populate the log
> message with one-line descriptions' instead of using the entire commit
> messages.
> Which would make a lot of sense, it's just not working as advertised.

The "subject" or "first line" is not actually the first line; these days
it is typically the "first paragraph". The reason is that git always
expected commit messages to look like:

  one line describing the change

  more detailed explanation
  that might go on for several lines

  or even several paragraphs

However, as people imported commits from previous systems, they ended up
with a lot of commit messages where the closest thing to a subject was
split across several lines like:

  here's a description of the commit that is probably overly long,
  but that's how we did it back in CVS days

Taking just the first line of those often cuts off the useful part. It
was deemed less bad to show the whole message as a subject rather than
cut it off arbitrarily.

If you are developing with git and not splitting the subject out with a
blank line, there are a lot of tools that are going to look ugly (e.g.,
format-patch will generate overly long subjects, "log --oneline" will be
ugly, and browsers like "tig" and "gitk" may be overwhelmed).

-Peff
