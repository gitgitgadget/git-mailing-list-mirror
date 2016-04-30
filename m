From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] xdiff: implement empty line chunk heuristic
Date: Fri, 29 Apr 2016 23:06:20 -0400
Message-ID: <20160430030620.GB25719@sigill.intra.peff.net>
References: <1461079290-6523-1-git-send-email-sbeller@google.com>
 <1461079290-6523-3-git-send-email-sbeller@google.com>
 <CA+P7+xoqn3fxEZGn02ST1XV-2UpQGr3iwV-37R8pakFJy_9n0w@mail.gmail.com>
 <20160420041827.GA7627@sigill.intra.peff.net>
 <xmqqa8kcxip9.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xpFCBU1xYbtcX8jtmDDyY8p0CiJJ=bexTmi=_vwWRZi0Q@mail.gmail.com>
 <xmqqwpngukin.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 30 05:06:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awLEi-00020H-UO
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 05:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbcD3DGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 23:06:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59597 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752379AbcD3DGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 23:06:24 -0400
Received: (qmail 17045 invoked by uid 102); 30 Apr 2016 03:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 23:06:23 -0400
Received: (qmail 28529 invoked by uid 107); 30 Apr 2016 03:06:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 23:06:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 23:06:20 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZu=keNaCbt4T=CzH3i9qr+BxXw6AiWR-q1Cs4U80Jzng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293120>

On Fri, Apr 29, 2016 at 03:35:54PM -0700, Stefan Beller wrote:

> > -- >8 --
> > diff: enable "compaction heuristics" and lose experimentation knob
> >
> > It seems that the new "find a good hunk boundary by locating a blank
> > line" heuristics gives much more pleasant result without much
> > noticeable downsides.  Let's make it the new algorithm for real,
> > without the opt-out knob we added while experimenting with it.
> 
> I would remove the opt-out knob much later in the game, i.e.
> 
>     1) make a patch that removes the documentation only
>        before the next release (i.e. before 2.9)
>     2) make a patch to remove the actual (unlabeled) knobs,
>         merge into master before 2.10 (i.e. just after the 2.9 release)

Yeah, I think it might be a good idea to keep some sort of undocumented
safety valve in the release, at least for a cycle or two. The heuristic
won't _really_ see wide use until it is in a released version of git, as
much as we would like it to be otherwise.

So I am anticipating a possible conversation where somebody reports that
the new output looks bad, and it would be nice to say "try it with this
flag (or environment variable, or whatever) and see if that looks
better".  And then based on that conversation we can decide what the
right next is (a real user-visible flag, or reversion, or deciding the
user's case isn't worth it). Or maybe if we're lucky that conversation
never happens.

The "whatever" in the instructions can obviously be "build with this
patch" or "try with an older version of git", but we're a lot more
likely to get a good response if it's easy for the user to do.

-Peff
