From: Jeff King <peff@peff.net>
Subject: Re: Default authentication over https?
Date: Wed, 13 Apr 2016 18:36:13 -0400
Message-ID: <20160413223613.GB10011@sigill.intra.peff.net>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Isaac Levy <isaac.r.levy@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:36:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTOY-0004XF-48
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbcDMWgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:36:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:49132 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754500AbcDMWgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:36:17 -0400
Received: (qmail 8157 invoked by uid 102); 13 Apr 2016 22:36:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:36:16 -0400
Received: (qmail 23479 invoked by uid 107); 13 Apr 2016 22:36:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Apr 2016 18:36:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Apr 2016 18:36:13 -0400
Content-Disposition: inline
In-Reply-To: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291504>

On Mon, Apr 11, 2016 at 12:04:02PM -0400, Isaac Levy wrote:

> I use a git server which requires authentication over https. Git seems
> determined to always try an unauthenticated request first, slowing
> down operations by a couple seconds.
> 
> Is there a way to configure git to default to authenticated requests?  Thanks!

No, there isn't. Very old versions of git would ask for the password if
you provided a username, but since v1.7.8 we only do so in response to
an HTTP 401. The code is still there to do the "proactive" asking, but
it's not wired up to any particular config option.

However, I don't think even that would give you what you want. Because I
think that even if we provide a credential, curl will make an initial
request (presumably to find out which auth type it should use, but that
is just a guess). I don't know if there is a way to convince curl to
stick the credential in the first request (if my guess is right, then
perhaps by setting the auth type explicitly, or even by sticking in our
own Authorization header).

So I think the answer for now is "no", but it might be possible (and not
even that hard) to do with a patch.

-Peff
