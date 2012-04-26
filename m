From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Try an uppercase version of $prot_proxy env var
Date: Thu, 26 Apr 2012 09:08:54 -0400
Message-ID: <20120426130854.GC27785@sigill.intra.peff.net>
References: <xmqq8vhmhzpk.fsf@junio.mtv.corp.google.com>
 <4F966F0C.6090504@seap.minhap.es>
 <xmqqipgpgdpl.fsf@junio.mtv.corp.google.com>
 <4F994AC3.2070708@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Thu Apr 26 15:09:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNORR-00027s-OP
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 15:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519Ab2DZNI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 09:08:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47158
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab2DZNI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 09:08:56 -0400
Received: (qmail 15938 invoked by uid 107); 26 Apr 2012 13:09:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 09:09:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 09:08:54 -0400
Content-Disposition: inline
In-Reply-To: <4F994AC3.2070708@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196368>

On Thu, Apr 26, 2012 at 03:16:51PM +0200, Nelson Benitez Leon wrote:

> Try an uppercase version of $prot_proxy env var when thelowercase version 
> is not found.
> [...]
> diff --git a/http.c b/http.c
> index 6a98195..bf9c20e 100644
> --- a/http.c
> +++ b/http.c
> @@ -329,6 +329,13 @@ static CURL *get_curl_handle(const char *url)
>  		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
>  		env_proxy_var = strbuf_detach(&buf, NULL);
>  		env_proxy = getenv(env_proxy_var);
> +		if (!env_proxy) {
> +			char *p;
> +			for (p = env_proxy_var; *p; p++) {
> +				*p = toupper(*p);
> +			}
> +			env_proxy = getenv(env_proxy_var);
> +		}

Don't we explicitly not want to do this when the protocol is http? Curl
doesn't respect HTTP_PROXY.

-Peff
