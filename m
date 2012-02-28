From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy config option is not set
Date: Tue, 28 Feb 2012 13:19:00 +0100
Message-ID: <878vjn8823.fsf@thomas.inf.ethz.ch>
References: <4F4CCE8A.4010800@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <peff@peff.net>,
	<sam.vilain@catalyst.net.nz>, <sam@vilain.net>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 13:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2M1R-0003jP-SN
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 13:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab2B1MTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 07:19:05 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:22632 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab2B1MTE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 07:19:04 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 13:18:59 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 13:19:00 +0100
In-Reply-To: <4F4CCE8A.4010800@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 28 Feb 2012 13:54:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191725>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> +	if (!curl_http_proxy) {
> +		const char *env_proxy;
> +		env_proxy = getenv("HTTP_PROXY");
> +		if (!env_proxy) {
> +			env_proxy = getenv("http_proxy");
> +		}
> +		if (env_proxy) {
> +			curl_http_proxy = xstrdup(env_proxy);
> +		}
> +	}

Admittedly I'm mostly clueless about curl, but while investigating the
NTLM login thing I noticed this bit in curl(1):

ENVIRONMENT
       The environment variables can be specified in lower case or upper
       case. The lower case version has precedence. http_proxy is an
       exception as it is only available in lower case.

Which raises the questions:

* Why is this needed?  Does git's use of libcurl ignore http_proxy?  [1]
  seems to indicate that libcurl respects <protocol>_proxy
  automatically.

* Why do you (need to?) support HTTP_PROXY when curl doesn't?


[1] http://curl.haxx.se/libcurl/c/libcurl-tutorial.html, "Environment Variables"

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
