From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Fri, 13 Apr 2012 16:56:50 -0400
Message-ID: <20120413205649.GC7919@sigill.intra.peff.net>
References: <4F5F53CA.7090003@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sam@vilain.net
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Apr 13 22:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SInY9-0008Vr-MV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 22:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab2DMU4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 16:56:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33494
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756662Ab2DMU4w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 16:56:52 -0400
Received: (qmail 12739 invoked by uid 107); 13 Apr 2012 20:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 16:56:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 16:56:50 -0400
Content-Disposition: inline
In-Reply-To: <4F5F53CA.7090003@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195445>

On Tue, Mar 13, 2012 at 03:03:54PM +0100, Nelson Benitez Leon wrote:

> Also take care that CURLOPT_PROXY don't include username or
> password, as we now set them in the new set_proxy_auth() function
> where we use their specific cURL options.

Did you test that this is necessary? We don't do it for the regular URL
case, and it makes the code much simpler if we can avoid munging what we
hand to curl.

> +static void set_proxy_auth(CURL *result)
> +{
> +	if (proxy_auth.username && proxy_auth.password) {
> +#if LIBCURL_VERSION_NUM >= 0x071901
> +		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME, proxy_auth.username);
> +		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD, proxy_auth.password);
> +#else

Is that version check right? You are giving a hexadecimal number, so
7.19.1 would be 071301.

-Peff
