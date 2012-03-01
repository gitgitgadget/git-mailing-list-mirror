From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Thu, 1 Mar 2012 04:10:38 -0500
Message-ID: <20120301091038.GB16033@sigill.intra.peff.net>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <20120228191514.GD11260@sigill.intra.peff.net>
 <4F4D2AAD.3040107@vilain.net>
 <20120228193443.GB11725@sigill.intra.peff.net>
 <4F4E01EB.3070707@seap.minhap.es>
 <20120229210816.GB628@sigill.intra.peff.net>
 <4F4F47EF.40405@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S322F-0006IF-Db
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 10:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085Ab2CAJKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 04:10:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34004
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758715Ab2CAJKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 04:10:41 -0500
Received: (qmail 2656 invoked by uid 107); 1 Mar 2012 09:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 04:10:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 04:10:38 -0500
Content-Disposition: inline
In-Reply-To: <4F4F47EF.40405@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191910>

On Thu, Mar 01, 2012 at 10:57:03AM +0100, Nelson Benitez Leon wrote:

> > And I take back what I said about environment precedence, based on the
> > discussion. Also, I don't think there is a need to strdup the results of
> > getenv here, is there? So I think the code you want is just:
> > 
> >   if (!curl_http_proxy)
> >           curl_http_proxy = getenv("http_proxy");
> 
> but curl_http_proxy gets freed in http_cleanup as follows:
> 
> free((void *)curl_http_proxy);
> 
> Is it ok to free strings returned by getenv() ? I thought nope, so I
> used strdup which existent code was already using..

Ah, you're right. I was worried more about lifetime issues (i.e., would
the string still be valid) and didn't check to see whether we freed it
(and we should, because if it comes from config, then it will be
allocated). So yes, you should duplicate it.

-Peff
