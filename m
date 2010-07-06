From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] guilt: Make sure the commit time is increasing
Date: Tue, 6 Jul 2010 10:29:22 -0400
Message-ID: <20100706142921.GB6666@sigill.intra.peff.net>
References: <1278296639-25024-1-git-send-email-tytso@mit.edu>
 <20100705025900.GQ22659@josefsipek.net>
 <67D0ABD4-BD1A-4B7A-B3EC-F48F21B5DD01@mit.edu>
 <20100705185238.GS22659@josefsipek.net>
 <20100705192201.GI25518@thunk.org>
 <20100706080322.GA2856@burratino>
 <AANLkTinZ4UV9in60Y4myfUWv08Vx3OMvh-_YQl2BXSjC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, tytso@mit.edu,
	jeffpc@josefsipek.net, Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 06 16:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW99Q-00056Y-7N
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 16:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab0GFO3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 10:29:25 -0400
Received: from peff.net ([208.65.91.99]:41660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0GFO3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 10:29:25 -0400
Received: (qmail 30657 invoked by uid 107); 6 Jul 2010 14:30:20 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 06 Jul 2010 10:30:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jul 2010 10:29:22 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinZ4UV9in60Y4myfUWv08Vx3OMvh-_YQl2BXSjC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150353>

On Tue, Jul 06, 2010 at 03:53:56PM +0200, Erik Faye-Lund wrote:

> > At one point rev-list did require monotonic --- i.e., the committer
> > date of each commit had to be equal to or later than that of each of
> > its parents) with no clock skew but that was considered a bug and
> > fixed by v1.5.5-rc1~16 (Make revision limiting more robust against
> > occasional bad commit dates, 2008-03-17)
> >
> 
> This might be a stupid question, but I'm not entirely clear on why
> it's not a strict requirement; surely it would be easy to ensure that
> the commit-time is at least as big as the parents when generating the
> commit...?
> 
> Is it to avoid the case where a user commits with the clock set to
> some point (potentially far) in the future, so all subsequent commits
> would have the same, artificially high commit time? Or is there some
> other reason I can't think of?

You can have clock skew between distributed developers. So imagine you
commit at 5:00pm, then I pull at 5:01pm, but it turns out your clock is
two minutes fast, so it's actually 4:59pm.

What should my commit do? If I insist on monotonic increases, then my
clock gets pushed forward artificially by your fast, broken clock (which
is probably not the end of the world; in practice, if your clock is N
seconds fast, there will presumably be some N second period where I'm
not making a commit, and the clocks can "catch up" with each other).

-Peff
