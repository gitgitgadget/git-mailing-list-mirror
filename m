From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Mon, 3 Nov 2008 02:14:20 -0500
Message-ID: <20081103071420.GD10772@coredump.intra.peff.net>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net> <20081102123519.GA21251@atjola.homenet> <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 08:15:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwtf0-0004ZW-I0
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 08:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYKCHOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 02:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYKCHOW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 02:14:22 -0500
Received: from peff.net ([208.65.91.99]:3687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbYKCHOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 02:14:22 -0500
Received: (qmail 29266 invoked by uid 111); 3 Nov 2008 07:14:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 02:14:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 02:14:20 -0500
Content-Disposition: inline
In-Reply-To: <7vljw2yo93.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99910>

On Sun, Nov 02, 2008 at 10:30:16AM -0800, Junio C Hamano wrote:

> > Looking at --cached/--index we have basically three things:
> >
> >   --cached to refer to the state of the index (diff, grep, [stash], ...)
> >   --cached to _work on_ the index only (rm, apply, ...)
> >   --index to _work on_ both the index and the working tree (apply, ...)
> 
> I think the earlier two are the same thing.  The only difference between
> them is that in the first one, the definition of your "work on" happens to
> be a read-only operation.  Am I mistaken?

I think that is somewhat the case for "grep", for example. But the
confusion is that diff is really a different beast, because you are
comparing two _different_ locations.

So "git diff --staged", while it makes sense to us (since we are asking
"what is staged"), is not consistent with the discussed rules. In
particular:

  1. It operates on just the "stage" and not the working tree, so it
     should be "--staged-only". But the only there is nonsensical.

  2. The default is _already_ operating on the staging area, so you are
     really switching up the working tree for the HEAD in what you are
     diffing. So in that sense, it doesn't convey the change in
     operation very well.

And I am not proposing a change here (except to perhaps "git diff
--staged" instead of "--cached"). Just pointing out that it does not
follow the "--staged operates on both, --staged-only operates on just
the index" rule.

Hrm. For that matter, grep is a bit different, too. Since I would expect
"git grep --staged" to find only staged things, not things in both the
working tree and the index. So perhaps there is a difference between
commands that modify and commands that inspect.

-Peff
