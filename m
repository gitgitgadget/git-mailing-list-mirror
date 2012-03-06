From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/4] http: try http_proxy env var when http.proxy
 config option is not set
Date: Tue, 6 Mar 2012 06:27:45 -0500
Message-ID: <20120306112745.GA6733@sigill.intra.peff.net>
References: <4F54D91C.6080905@seap.minhap.es>
 <7v4nu32bwp.fsf@alter.siamese.dyndns.org>
 <4F560196.8070500@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4sYc-000082-6N
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267Ab2CFL1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 06:27:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42039
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965164Ab2CFL1t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 06:27:49 -0500
Received: (qmail 8386 invoked by uid 107); 6 Mar 2012 11:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 06:27:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 06:27:45 -0500
Content-Disposition: inline
In-Reply-To: <4F560196.8070500@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192335>

On Tue, Mar 06, 2012 at 01:22:46PM +0100, Nelson Benitez Leon wrote:

> > Also I thought the conclusion from the other thread was that even if
> > we were to do this, we should apply the http_proxy environment only
> > when we are talking to http:// and for https:// we would instead
> > read HTTPS_PROXY or something?
> 
> Ok I completely miss this, can this be added in a later patch?

Hmm. Your current series munges the curl_http_proxy variable in order to
put the username and password in, and therefore needs to know what is in
the proxy variable.

But if you switch patch 4/4 to set CURLOPT_PROXYUSERPWD, then we won't
need to care what's in curl_http_proxy, no? We will get a 407 from curl
because curl detected the proxy (either from the environment, or because
we actually told it via curl_http_proxy), and then we will fill in the
username and password without touching the actual proxy URL.

So this patch can just be dropped at that point, right?

-Peff
