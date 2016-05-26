From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] log: add "--no-show-signature" command line
 option
Date: Thu, 26 May 2016 12:32:42 -0400
Message-ID: <20160526163241.GC18210@sigill.intra.peff.net>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
 <20160526130647.27001-3-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 18:33:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5yDa-0007I9-29
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbcEZQcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:32:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:44661 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754551AbcEZQcp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:32:45 -0400
Received: (qmail 5010 invoked by uid 102); 26 May 2016 16:32:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:32:44 -0400
Received: (qmail 19971 invoked by uid 107); 26 May 2016 16:32:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 12:32:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 12:32:42 -0400
Content-Disposition: inline
In-Reply-To: <20160526130647.27001-3-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295664>

On Thu, May 26, 2016 at 06:36:47PM +0530, Mehul Jain wrote:

> If "log.showsignature=true", then there is no way to override it using
> command line switch.
> 
> Teach "git log" and "git show" about "--no-show-signature" command line
> option.

I think this is teaching all of the revision machinery about it (which
is a good thing).

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 36be9a1..ea24259 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -901,6 +901,13 @@ test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
>  	test_i18ngrep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
> +	git config log.showsignature true &&
> +	git log -1 --no-show-signature signed >actual &&
> +	test "$(test_i18ngrep "gpg: Signature made" actual)" = "" &&
> +	test "$(test_i18ngrep "gpg: Good signature" actual)" = ""
> +'

Perhaps it would be more robust to simply grep for "gpg:". We should not
be seeing any gpg-related lines in the output. It probably isn't that
big a deal in practice, though. If the output from gpg changes, this
test could report a false success, but all of the other nearby tests
would show a breakage, so somebody would probably notice.

-Peff
