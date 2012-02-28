From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 28 Feb 2012 14:34:43 -0500
Message-ID: <20120228193443.GB11725@sigill.intra.peff.net>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <20120228191514.GD11260@sigill.intra.peff.net>
 <4F4D2AAD.3040107@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	sam.vilain@catalyst.net.nz
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 20:34:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Sp1-0001oG-CC
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab2B1Teq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:34:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60423
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755541Ab2B1Teq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:34:46 -0500
Received: (qmail 13786 invoked by uid 107); 28 Feb 2012 19:34:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 14:34:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 14:34:43 -0500
Content-Disposition: inline
In-Reply-To: <4F4D2AAD.3040107@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191774>

On Tue, Feb 28, 2012 at 11:27:41AM -0800, Sam Vilain wrote:

> On 2/28/12 11:15 AM, Jeff King wrote:
> >Usually we would prefer environment variables to config. So that:
> >
> >   $ git config http.proxy foo
> >   $ HTTP_PROXY=bar git fetch
> >
> >would use "bar" as the proxy, not "foo". But your code above would
> >prefer "foo", right?
> 
> Apparently I'm the author of the http.proxy feature, though I barely
> remember what problem I was actually solving at the time.  At the
> time I justified it on the grounds that a user might want to use a
> different proxy for git and/or a particular remote.  The "http_proxy"
> environment variable is likely to be a global system default, or
> perhaps a desktop setting, and therefore I'd say probably less and
> not more specific than a git configuration variable.

Good point. We sometimes follow this order:

  1. git-specific environment variables (i.e., $GIT_HTTP_PROXY, if
     it existed)
  2. git config files (i.e., http.proxy)
  3. generic system environment (i.e., $http_proxy).

So thinking about it that way, the original patch makes more sense.

-Peff
