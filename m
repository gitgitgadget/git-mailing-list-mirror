From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Fri, 29 Apr 2016 09:35:27 -0400
Message-ID: <20160429133527.GC30931@sigill.intra.peff.net>
References: <20160428153902.GF31063@sigill.intra.peff.net>
 <CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
 <20160428165031.GA31421@sigill.intra.peff.net>
 <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
 <20160428191038.GA10574@sigill.intra.peff.net>
 <xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
 <xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
 <20160428210342.GB12268@sigill.intra.peff.net>
 <xmqqwpnh2w0t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:35:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw8a3-0003n7-DB
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 15:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbcD2Nfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 09:35:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:59076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753427AbcD2Nfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 09:35:30 -0400
Received: (qmail 6270 invoked by uid 102); 29 Apr 2016 13:35:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:35:29 -0400
Received: (qmail 21770 invoked by uid 107); 29 Apr 2016 13:35:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 09:35:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 09:35:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwpnh2w0t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292997>

On Thu, Apr 28, 2016 at 03:44:50PM -0700, Junio C Hamano wrote:

> > I do not think "fetch" should grow submodule-specific
> > options,...
> 
> The updated "git fetch" needs to grow submodule-specific options to
> at least either enable or disable "recurse into submodules", and
> that is true even if the default behaviour in the future were to
> recurse into submodules in a top-level project repository that has
> submodules (i.e. you must have "git fetch --no-recurse-submodules"
> option).  "Please use these configuration when you do recurse into
> them" options are very much submodule specific in the same way.

I suppose so. I actually think it might be useful / convenient to have a
global "do not recurse" environment variable (and possibly a matching
"git --recurse" command-line flag to set it). Otherwise we end up with
annoying propagation problems for command-line options when scripts call
other programs, etc.

It's one of the reasons I think "-c" is so useful. Because it Just Works
for the whole environment of the command you are invoking, without
having to worry about whether it's "git fetch" itself, or "git remote"
calling "git fetch", or a script calling "git fetch", or whatever.

Of course there are downsides, too. If you're a script who really
_doesn't_ want to propagate that option to your children, you have to
take an explicit step to prevent it. But I think it helps more often
than hurts.

I think there are other options that would benefit, too. For example,
the way we handle "--progress", "--verbose", and "--quiet" is a bit of a
mess. All of our programs understand these concepts to some degree, and
there have been numerous bugs involve in propagating their values to
sub-programs. Having "$GIT_VERBOSITY_LEVEL" in the environment would
probably make this simpler and more consistent.

But you'll note that this email isn't accompanied by any patches. This
is philosophical, and I'm not sure it's worth the effort to transition
things like verbosity at this point. So you may take it with the
appropriate grain of salt.  And especially I don't actually care all
that much about submodules myself, so I am fine with whatever people who
_are_ actively using and developing them decide.

-Peff
