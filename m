From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use a hashmap to make remotes faster
Date: Tue, 29 Jul 2014 04:09:49 -0400
Message-ID: <20140729080949.GC4114@peff.net>
References: <305063.319715799-sendEmail@debian>
 <vpqoaw8ha12.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "patrick.reynolds@github.com" <patrick.reynolds@github.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:09:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2Tu-0003d2-9i
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 10:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaG2IJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 04:09:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:42307 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751281AbaG2IJw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 04:09:52 -0400
Received: (qmail 2234 invoked by uid 102); 29 Jul 2014 08:09:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 03:09:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 04:09:49 -0400
Content-Disposition: inline
In-Reply-To: <vpqoaw8ha12.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254405>

On Tue, Jul 29, 2014 at 09:57:45AM +0200, Matthieu Moy wrote:

> "patrick.reynolds@github.com" <patrick.reynolds@github.com> writes:
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> It seems you mixed your name and email address in your config file. I
> guess your name is "Patrick Reynolds", not
> "patrick.reynolds@github.com".

Also, Patrick, please sign-off your patch ("format-patch -s").

> > Remotes are stored as an array, so looking one up or adding one without
> > duplication is an O(n) operation.  Reading an entire config file full of
> > remotes is O(n^2) in the number of remotes.  For a repository with tens of
> > thousands of remotes, the running time can hit multiple minutes.
> 
> Just being curious: in which senario do you have tens of thousands of
> remotes?
> 
> (not an objection, it's a good thing anyway)

Whenever you fork a repository at GitHub, we give you a leaf repository
that points its info/alternates to a master "network.git" repository for
the fork network.  The network.git repo contains all of the objects, and
has a remote configured for each of the child repositories. You would
never want to gc in that repository without doing a "fetch --all" first.

Most networks have only a few dozen forks, but a few have a large number
(torvalds/linux has ~5K, and homebrew is close to 10K).  And then
sometimes a MOOC instructor tells an entire 50K-person class to fork a
hello-world project all at once. :)

-Peff
