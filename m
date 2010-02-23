From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 19:53:45 -0500
Message-ID: <20100223005345.GA3254@coredump.intra.peff.net>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
 <20100222105203.GB16531@coredump.intra.peff.net>
 <7viq9paunm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njj27-0005s5-18
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab0BWAxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:53:46 -0500
Received: from peff.net ([208.65.91.99]:57718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab0BWAxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:53:45 -0500
Received: (qmail 3985 invoked by uid 107); 23 Feb 2010 00:54:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 19:54:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 19:53:45 -0500
Content-Disposition: inline
In-Reply-To: <7viq9paunm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140759>

On Mon, Feb 22, 2010 at 12:21:33PM -0800, Junio C Hamano wrote:

> > True, though most of those pathspecs for tracked files are when viewing
> > diffs. It seems more inconsistent here because "git add foo" complains
> > but "git add -u foo" does not. So I think this one is definitely worth
> > fixing.
> 
> One problem is that it would be adding a new inconsistency.
> 
> "git diff" does not complain but "git add -u" will complain if we make
> this change, but "add -u" is about updating the path that "git diff"
> reports as different.

I see. Personally I don't mind that inconsistency as much, as it is
between two commands, rather than between flags within one command. But
that is perhaps a subjective evaluation.

But:

> Making "add -u" complain before fixing "diff-files" will have another
> issue.  It will expose a bigger inconsistency that you omitted from my
> message ;-) The pathspec "git add" without "-u" takes are processed by
> pathspec match logic of "ls-files" family, but "git add -u" uses pathspec
> match logic of "diff" family.  They have different semantics.
> 
> You can say "git add 'frotz/*.c'" but not "git add -u 'frotz/*.c'"; that
> also needs to be fixed.

That is a more worrisome inconsistency to me (and now I get what you
were saying in your earlier message).

> Making "add -u" alone complain using a separate throw-away logic that we
> are sure we will have to discard when we make things consistent throughout
> the system did not sound very attractive to me.  And that is why I was
> unhappy about the solution.

OK, now I am unhappy about it, too, and I agree it should be addressed
in the long term. But that is a large-ish project that will not happen
immediately. What is the best thing in the meantime?

I am still tempted by the patch. Even though it trades one inconsistency
for another, I find a false sense of success from "git-add" to be one of
the more ugly errors (and even though "git add -u 'frotz/*.c'" would
still not work with it, at least you would be informed of such).

-Peff
