From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no
 password, ask for password
Date: Fri, 2 Mar 2012 08:52:37 -0500
Message-ID: <20120302135237.GB23846@sigill.intra.peff.net>
References: <4F4FBE6C.5050507@seap.minhap.es>
 <4F4FB69C.7000708@vilain.net>
 <20120301215812.GG17631@sigill.intra.peff.net>
 <4F50CC41.5020307@seap.minhap.es>
 <20120302124538.GA10637@sigill.intra.peff.net>
 <4F50D39D.5040806@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Mar 02 14:52:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Sua-0006nP-Im
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 14:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344Ab2CBNwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 08:52:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35404
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab2CBNwj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 08:52:39 -0500
Received: (qmail 24363 invoked by uid 107); 2 Mar 2012 13:52:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Mar 2012 08:52:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Mar 2012 08:52:37 -0500
Content-Disposition: inline
In-Reply-To: <4F50D39D.5040806@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192042>

On Fri, Mar 02, 2012 at 03:05:17PM +0100, Nelson Benitez Leon wrote:

> > I think you'll still need to read the env var, because you'll need to
> > know the proxy URL when getting the password (to ask credential helpers
> > properly, and to prompt the user).
> 
> Ok, but I can read it after receiving the 407 (and in case we were not
> using http.proxy) so discarding PATCH 2/3 still applies, ok? or we need
> to read it first-hand for the http_proactive_auth you mention below?

You will need it for proactive_auth.

> > Also, I think you'll need to call credential_fill() when
> > http_proactive_auth is set. Otherwise http-push will not be able to do
> > proxy auth.
> 
> I still don't get what proactive_auth is about, will ask you when I get
> to that part of the patch.

It is a flag that, when true, instructs the http code to do auth if we
have a non-NULL username, even before we get an http 401. It is only set
for http-push, because the http-push-over-dav code does not properly
detect and retry on a 401 (and I don't expect it will be easy to
properly detect and retry on a 407, either). Whereas the smart-http code
and the dumb http fetch code properly detect the 401.

-Peff
