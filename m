From: Jeff King <peff@peff.net>
Subject: Re: Keep original author with git merge --squash?
Date: Fri, 13 Feb 2015 02:10:41 -0500
Message-ID: <20150213071041.GA26775@peff.net>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net>
 <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
 <CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
 <xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
 <CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
 <xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
 <20150212225003.GA20763@peff.net>
 <xmqqwq3mogdm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMAOn-0003kp-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 08:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbBMHKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 02:10:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:48551 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752023AbbBMHKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 02:10:44 -0500
Received: (qmail 27978 invoked by uid 102); 13 Feb 2015 07:10:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 01:10:44 -0600
Received: (qmail 31697 invoked by uid 107); 13 Feb 2015 07:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 02:10:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2015 02:10:41 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq3mogdm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263798>

On Thu, Feb 12, 2015 at 03:32:37PM -0800, Junio C Hamano wrote:

> > and using "Author: " (with no text) does a reset.
> 
> no (I do not think it is wrong per-se, but I do not think such a
> good idea).

Fair enough. It is probably a minority use case, and one that is likely
to cause confusion.

> > Also, on the topic of "merge --squash". I never use it myself, but
> > having experimented with it due to this thread, I found the template it
> > sticks into COMMIT_EDITMSG to be horribly unfriendly for munging. For
> > example, with two simple commits, I get:
> [...]
> I think it should show exactly the same thing as "rebase -i" squash
> insn would give you.  People already know how to munge that, right?

Yeah, that was exactly what I expected to see (but didn't). They should
probably have the same format, though we may want to enhance both to
contain more information (like author names).

> > It also raises a question for the proposal in this thread: if there are
> > multiple "Author:" lines, which one do we take? The first, or the last?
> 
> I was siding with David's "pay attention to in-buffer Author: only
> when all of them agree".  When squash-merging a branch with two or
> more authors, we would attribute the authorship silently and
> automatically to you if you do not do anything special otherwise.

That's probably reasonable. I was thinking more of a case where you made
some fixups on top of somebody else's branch, and then used "git rebase
-i" to squash them together. But I think we already use the authorship
for the root of the squash in that case.

This case collapses nicely if we make a slight tweak to your proposed
behavior (or maybe this is what you meant). If there are multiple
authors listed, we behave as if none was listed. That would leave the
authorship as it behaves today (with the author of the first commit) if
you do nothing, or you can override it by dropping all but one.

-Peff
