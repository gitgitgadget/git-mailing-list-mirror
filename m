From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Wed, 29 Feb 2012 16:08:16 -0500
Message-ID: <20120229210816.GB628@sigill.intra.peff.net>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <20120228191514.GD11260@sigill.intra.peff.net>
 <4F4D2AAD.3040107@vilain.net>
 <20120228193443.GB11725@sigill.intra.peff.net>
 <4F4E01EB.3070707@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Wed Feb 29 22:08:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2qlD-00085P-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 22:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab2B2VIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 16:08:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33403
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990Ab2B2VIS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 16:08:18 -0500
Received: (qmail 27389 invoked by uid 107); 29 Feb 2012 21:08:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 16:08:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 16:08:16 -0500
Content-Disposition: inline
In-Reply-To: <4F4E01EB.3070707@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191857>

On Wed, Feb 29, 2012 at 11:46:03AM +0100, Nelson Benitez Leon wrote:

> > Good point. We sometimes follow this order:
> > 
> >   1. git-specific environment variables (i.e., $GIT_HTTP_PROXY, if
> >      it existed)
> >   2. git config files (i.e., http.proxy)
> >   3. generic system environment (i.e., $http_proxy).
> > 
> > So thinking about it that way, the original patch makes more sense.
> 
> So, in PATCH 2/3, apart from expanding the commit message.. do we want
> to support HTTP_PROXY or only http_proxy ? HTTP_PROXY seems to not be
> very used by existent programs, but support it it's only a gentenv call..

If HTTP_PROXY is not in wide use, I don't see a reason to support it.
And I take back what I said about environment precedence, based on the
discussion. Also, I don't think there is a need to strdup the results of
getenv here, is there? So I think the code you want is just:

  if (!curl_http_proxy)
          curl_http_proxy = getenv("http_proxy");

and the justification for the commit message is that we need to know the
proxy value outside of curl, because the next patch will do some
extra processing on the value.

-Peff
