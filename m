From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] t/t4018: test whether the word_regex patterns
 compile
Date: Thu, 9 Sep 2010 15:23:31 -0400
Message-ID: <20100909192331.GD32508@sigill.intra.peff.net>
References: <rRj7JpFIk_D_n7-wGkkucFJE0330IabsqMoSzalswHpjT-Z1HCuOFaIgMsaPgIuQSp0KUMW97Wo@cipher.nrlssc.navy.mil>
 <rRj7JpFIk_D_n7-wGkkucC32o5VKAledjObzc1bFHX8SBUchsp6UDflVKjnjY9xKm9Q48ir5iu8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtmiS-0006Kr-LA
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0IITXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:23:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53197 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab0IITXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:23:19 -0400
Received: (qmail 21047 invoked by uid 111); 9 Sep 2010 19:23:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:23:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:23:31 -0400
Content-Disposition: inline
In-Reply-To: <rRj7JpFIk_D_n7-wGkkucC32o5VKAledjObzc1bFHX8SBUchsp6UDflVKjnjY9xKm9Q48ir5iu8@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155889>

On Thu, Sep 09, 2010 at 02:02:47PM -0500, Brandon Casey wrote:

> From: Brandon Casey <drafnel@gmail.com>
> 
> Previously (e3bf5e43), a test was added to test whether the builtin
> xfuncname regular expressions could be compiled without error by regcomp.
> Let's do the same for the word_regex patterns.  This should help catch any
> cross-platform incompatibilities that exist between the pattern creator's
> system and the various platforms that the test suite is commonly run on.

Definitely something we should be doing, but one nit:

> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 61de8a2..620cd02 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -40,6 +40,11 @@ do
>  		! ( git diff --no-index Beer.java Beer-correct.java 2>&1 |
>  			grep "fatal" > /dev/null )
>  	'
> +	test_expect_success "builtin $p wordRegex pattern compiles" '
> +		! ( git diff --no-index --word-diff \
> +			Beer.java Beer-correct.java 2>&1 |
> +			grep "fatal" > /dev/null )
> +	'

Why the subshell? Shouldn't just testing the pipeline outcome work?

-Peff
