From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-log: tracking deleted file in a repository with
 multiple "initial commit" histories
Date: Tue, 16 Feb 2016 17:29:42 -0500
Message-ID: <20160216222942.GA9014@sigill.intra.peff.net>
References: <20160216202442.GH21465@google.com>
 <20160216204557.GB27484@sigill.intra.peff.net>
 <20160216212429.GA39536@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:30:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVo8P-0000jY-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148AbcBPW3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:29:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:43639 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756115AbcBPW3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:29:45 -0500
Received: (qmail 6368 invoked by uid 102); 16 Feb 2016 22:29:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 17:29:44 -0500
Received: (qmail 31686 invoked by uid 107); 16 Feb 2016 22:29:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 17:29:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 17:29:42 -0500
Content-Disposition: inline
In-Reply-To: <20160216212429.GA39536@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286444>

On Tue, Feb 16, 2016 at 01:24:29PM -0800, Brian Norris wrote:

> On Tue, Feb 16, 2016 at 03:45:57PM -0500, Jeff King wrote:
> > See the section on History Simplification in git-log. But basically,
> > when you specify a pathspec, git does not traverse side branches that
> > had no effect on the given pathspec.
> 
> Thanks for the pointer. Is this done primarily for performance reasons,
> or for UI simplicity (e.g., to avoid some kinds of double-counting)?
> Seems like it generates unintuitive behaviors, but if it's helping block
> other unintuitive behaviors, then maybe it can't be resolved easily.

Both, I think. Try looking at "--full-history" and you will see that it
has a lot of cruft that is probably not that interesting. But
simplifying further (e.g., with "--simplify-merges") doesn't tell much
of the whole story (or maybe it does; we do see the final deletion
there, which is the end state).

But it's been a long time since I've thought hard on simplification like
this. Most of these issues were resolved many years ago; you'd have to
dig in the list archives to get the full story.

> FWIW, I quite often use git-log to look at the history of a deleted
> file. Seems like a pretty big hole if the default behavior is going to
> prune away the entire history of the file.

It doesn't normally. What happened is that you had two parallel
histories, and the final state of the file could be explained by
following the simpler of the two histories (the one where it never
existed in the first place).

> > If you want to see the full history, you can with "--full-history"
> > (there are some other simplification possibilities, but I don't think
> > any of them are interesting for your particular case).
> 
> --full-history gives me what I want (I'll admit, I didn't read through
> all the other "History Simplification" documentation). Can I make this
> the default somehow?

No, but you can make an alias that includes it.

-Peff
