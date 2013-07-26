From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: make sure the upstream remote is configured
Date: Fri, 26 Jul 2013 19:22:09 -0400
Message-ID: <20130726232208.GC12968@sigill.intra.peff.net>
References: <1374860377-17652-1-git-send-email-cmn@elego.de>
 <20130726184311.GA29799@sigill.intra.peff.net>
 <1374877787.2670.6.camel@centaur.cmartin.tk>
 <20130726231211.GB12968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Jul 27 01:22:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2rKx-0002Me-KK
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 01:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab3GZXWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 19:22:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:33347 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab3GZXWL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 19:22:11 -0400
Received: (qmail 14934 invoked by uid 102); 26 Jul 2013 23:22:11 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 18:22:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 19:22:09 -0400
Content-Disposition: inline
In-Reply-To: <20130726231211.GB12968@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231218>

On Fri, Jul 26, 2013 at 07:12:11PM -0400, Jeff King wrote:

> If that is what you want to prevent, I do not think checking for a named
> remote is sufficient. You can also be pushing to a branch on a named
> remote that is not part of your fetch refspec, in which case you do not
> have a tracking branch. I.e.:
> 
>   git clone $URL repo.git
>   cd repo.git
>   git push --set-upstream HEAD:refs/foo/whatever
> 
> For that matter, I wonder what "--set-upstream" would do if used with
> "refs/tags/foo". You would not do that in general, but what about:
> 
>   git push --set-upstream master:master master:v1.0
> 
> I didn't test.

Ah, nevermind. We already catch the case of non-heads (on both the local
and remote sides) and abort.

So that makes me more confident that your change is a reasonable one; we
are already disallowing a subset of what's possible via "--set-upstream"
in the name of preventing weird accidental configurations. This is just
fixing another such loophole.

-Peff
