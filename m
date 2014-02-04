From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 4 Feb 2014 17:12:20 -0500
Message-ID: <20140204221220.GA5457@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
 <20140121054927.GD5878@sigill.intra.peff.net>
 <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoEN-0007UE-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935173AbaBDWMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:12:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:44604 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934755AbaBDWM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:12:26 -0500
Received: (qmail 15127 invoked by uid 102); 4 Feb 2014 22:12:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Feb 2014 16:12:26 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Feb 2014 17:12:20 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241564>

On Tue, Jan 21, 2014 at 11:23:30AM -0800, Junio C Hamano wrote:

> > does complicate the point of my series, which was to add more intimate
> > logic about how we handle LESS.
> > ...
> >                 return !x || strchr(x, 'R');
> [...]
> 
> I am not sure if it is even a good idea for us to have so intimate
> logic for various pagers in the first place.  I'd seriously wonder
> if it is better to take this position:
> 
> 	A platform packager who sets the default pager and/or the
> 	default environment for the pager at the build time, or an
> 	individual user who tells your Git what pager you want to
> 	use and/or with what setting that pager should be run under
> 	with environment variables. These people ought to know far
> 	better than Git what their specific choices do. Do not try
> 	to second-guess them.

Sorry for letting this topic lapse; I wanted to look at some possible
Makefile improvements, which I'll be posting in a moment. I did want to
address this point, though.

If we are just talking about packagers and defaults (e.g., setting
MORE=R on FreeBSD), then I agree that the right tool for the job is
empowering the packagers, and the Makefile knob we've discussed does
that.

But there's another set of people that I was intending to help with the
patch, which is people that have set up LESS, and did not necessarily
care about the "R" flag in the past (e.g., for many years before git
came along, I set LESS=giM, and never even knew that "R" existed). Since
git comes out of the box these days with color and the pager turned on,
that means people with such a setup see broken output from day one.

And I think it is Git's fault here, not the user or the packager. Our
defaults assume that the user's pager can handle color, and that is not
the default for many pagers, including our default "less"! The user did
not turn off "R" here; they simply set other options they cared about,
and our hacky workaround to auto-enable "R" did not kick in.

It seems a shame to me that we cannot do better for such users.
However, the level of intimacy with the pager is getting to be a bit too
much for my taste, and the saving grace is that not that many people set
LESS themselves (and git is widely enough known that "R" is a common
recommendation when people do). So it's probably the lesser of two evils
to ignore the situation, and let people who run into it find the answers
on the web.

So I think there is nothing to be done.  But I did want to mention it in
case somebody else can come up with some clever solution. :)

-Peff
