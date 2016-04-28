From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config
 settings
Date: Thu, 28 Apr 2016 07:29:13 -0400
Message-ID: <20160428112912.GB11522@sigill.intra.peff.net>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
 <cover.1461837783.git.johannes.schindelin@gmx.de>
 <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 28 13:29:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avk8O-00029P-4x
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 13:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcD1L3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 07:29:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:58186 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752750AbcD1L3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 07:29:15 -0400
Received: (qmail 18741 invoked by uid 102); 28 Apr 2016 11:29:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 07:29:15 -0400
Received: (qmail 8452 invoked by uid 107); 28 Apr 2016 11:29:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 07:29:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 07:29:13 -0400
Content-Disposition: inline
In-Reply-To: <89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292865>

On Thu, Apr 28, 2016 at 12:03:47PM +0200, Johannes Schindelin wrote:

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3bd6883..b338f93 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -127,7 +127,9 @@ static int module_name(int argc, const char **argv, const char *prefix)
>   */
>  static int submodule_config_ok(const char *var)
>  {
> -	if (starts_with(var, "credential."))
> +	if (starts_with(var, "credential.") ||
> +			(starts_with(var, "http.") &&
> +			 ends_with(var, ".extraheader")))
>  		return 1;
>  	return 0;
>  }

Should we consider just white-listing all of "http.*"?

That would help other cases which have come up, like:

  http://thread.gmane.org/gmane.comp.version-control.git/264840

which wants to turn off http.sslverify. That would mean it turns off for
every submodule, too, but if you want to be choosy about your http
variables, you should be using the "http.$URL.sslverify" form, to only
affect specific servers (whether they are in submodules or not).

-Peff
