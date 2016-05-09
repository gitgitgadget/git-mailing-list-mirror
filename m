From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 2/3] t5551: make the test for extra HTTP headers more
 robust
Date: Mon, 9 May 2016 04:05:44 -0400
Message-ID: <20160509080544.GB14383@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <cover.1462774709.git.johannes.schindelin@gmx.de>
 <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 10:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azgCW-00019y-Kt
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 10:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcEIIFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 04:05:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:36151 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751670AbcEIIFr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 04:05:47 -0400
Received: (qmail 22820 invoked by uid 102); 9 May 2016 08:05:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:05:47 -0400
Received: (qmail 16987 invoked by uid 107); 9 May 2016 08:06:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:06:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 04:05:44 -0400
Content-Disposition: inline
In-Reply-To: <f29dac327aeac23677aec955f5b46a7a4702abfe.1462774709.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293991>

On Mon, May 09, 2016 at 08:19:00AM +0200, Johannes Schindelin wrote:

> To test that extra HTTP headers are passed correctly, t5551 verifies that
> a fetch succeeds when two required headers are passed, and that the fetch
> does not succeed when those headers are not passed.
> 
> However, this test would also succeed if the configuration required only
> one header. As Apache's configuration is notoriously tricky (this
> developer frequently requires StackOverflow's help to understand Apache's
> documentation), especially when still supporting the 2.2 line, let's just
> really make sure that the test verifies what we want it to verify.

Agreed, this makes sense.

>  test_expect_success 'custom http headers' '
> -	test_must_fail git fetch "$HTTPD_URL/smart_headers/repo.git" &&
> +	test_must_fail git -c http.extraheader="x-magic-two: cadabra" \
> +		fetch "$HTTPD_URL/smart_headers/repo.git" &&
>  	git -c http.extraheader="x-magic-one: abra" \
>  	    -c http.extraheader="x-magic-two: cadabra" \
>  	    fetch "$HTTPD_URL/smart_headers/repo.git"

This loses the 0-header check, but I don't think that is particularly
interesting to us (I had originally wanted to double-check that our
apache config worked at all in the absence of this feature, but I think
it is OK for the 1-header case to cover this; if our code is so buggy we
accidentally send 0 headers in the first command, we'll catch that,
too).

So looks good to me.

-Peff
