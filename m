From: Jeff King <peff@peff.net>
Subject: Re: Why does send-pack call pack-objects for all remote refs?
Date: Mon, 14 Dec 2015 17:37:18 -0500
Message-ID: <20151214223717.GA20167@sigill.intra.peff.net>
References: <4766c8518c2a46afb88fc0a2dd9a1688@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <xmqqvb89lw5f.fsf@gitster.mtv.corp.google.com>
 <20151207225714.GA3785@sigill.intra.peff.net>
 <8712f730fb4c414ebc2b1168ca7948b8@EXCHANGE1U.uunet.arlington.PredictiveTechnologies.com>
 <20151210041941.GA4056@sigill.intra.peff.net>
 <d0a39b03e49d41e685cf61398c0d1102@EXCHANGE2U.uunet.arlington.PredictiveTechnologies.com>
 <20151214210429.GC14788@sigill.intra.peff.net>
 <20151214223155.GA6594@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Koverman <dkoverman@predictiveTechnologies.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Nasser Grainawi <nasser@codeaurora.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8bkI-0006Qa-5M
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbbLNWhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:37:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:41609 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932725AbbLNWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:37:21 -0500
Received: (qmail 25847 invoked by uid 102); 14 Dec 2015 22:37:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:37:20 -0600
Received: (qmail 750 invoked by uid 107); 14 Dec 2015 22:37:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 17:37:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 17:37:18 -0500
Content-Disposition: inline
In-Reply-To: <20151214223155.GA6594@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282433>

On Mon, Dec 14, 2015 at 02:31:55PM -0800, Jonathan Nieder wrote:

> > I suspect there's room for improvement in the way we select commits to
> > store bitmaps for (so that the average walk is smaller). But it's rather
> > tricky; there's not a single constant to change to make it work better.
> 
> Git gc and JGit GC differ here.  JGit partitions the commits being
> packed by branch and then runs a selection algorithm on each part.
> Git runs a selection once on a list of all commits.
> 
> Some effects:
> - JGit selects more bitmaps, so the gc takes longer and the resulting
>   bitmap file is larger (bad)
> - JGit is more likely to have bitmaps for the commits involved in
>   pushes and fetches (good)
> 
> The commit selection code, for reference:
> 
> https://eclipse.googlesource.com/jgit/jgit/+/86af34e1/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/pack/PackWriterBitmapPreparer.java#151
> https://kernel.googlesource.com/pub/scm/git/git/+/ed1c9977/pack-bitmap-write.c#383
> 
> Thoughts?

My thought is it would be great if somebody wanted to work on this. :)

My understanding is that JGit's approach has some problems, too. Terry's
message doesn't seem to have made it to the list, but you can see in the
quoted bits he mentions some OOM problems during the bitmap write:

  http://article.gmane.org/gmane.comp.version-control.git/281476

That may not be a big deal to work around. I really just haven't looked
at it at all. Vicent did the original bitmap selection code for C Git,
and I don't think it has been touched since then.

-Peff
