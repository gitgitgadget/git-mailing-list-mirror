From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] t4030: demonstrate behavior of show with textconv
Date: Sat, 20 Apr 2013 00:04:00 -0400
Message-ID: <20130420040400.GA24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <a3162a9df3055532a818db264f43abc994325049.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTP2E-0004Bm-Bc
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab3DTEEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:04:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:44571 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724Ab3DTEEF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:04:05 -0400
Received: (qmail 6960 invoked by uid 102); 20 Apr 2013 04:04:09 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:04:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:04:00 -0400
Content-Disposition: inline
In-Reply-To: <a3162a9df3055532a818db264f43abc994325049.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221832>

On Fri, Apr 19, 2013 at 06:44:44PM +0200, Michael J Gruber wrote:

> "git show <commit>" obeys the textconc setting while "git show <blob>"
> does not. Demonstrate this in the test.

s/textconc/textconv

> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index 53ec330..f314ced 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -58,6 +58,12 @@ test_expect_success 'diff produces text' '
>  	test_cmp expect.text actual
>  '
>  
> +test_expect_success 'show commit produces text' '
> +	git show HEAD >diff &&
> +	find_diff <diff >actual &&
> +	test_cmp expect.text actual
> +'

Makes sense.

> +test_expect_success 'show blob produces binary' '
> +	git show HEAD:file >actual &&
> +	printf "\\0\\n\\1\\n" >expect &&
> +	test_cmp expect actual
> +'

I think this is probably the right thing. I can see instances where one
would want the converted contents, but we have "cat-file --textconv" for
that.

-Peff
