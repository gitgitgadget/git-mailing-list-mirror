From: Jeff King <peff@peff.net>
Subject: Re: POSIX woes in t7810.87: dash bash or bash dash?
Date: Mon, 20 Jun 2011 19:24:25 -0400
Message-ID: <20110620232425.GA617@sigill.intra.peff.net>
References: <4DFF19C4.5070003@drmicha.warpmail.net>
 <7voc1sb2hr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 01:24:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYnpa-0007OM-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 01:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab1FTXY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 19:24:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48728
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064Ab1FTXY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 19:24:28 -0400
Received: (qmail 29130 invoked by uid 107); 20 Jun 2011 23:24:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jun 2011 19:24:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2011 19:24:25 -0400
Content-Disposition: inline
In-Reply-To: <7voc1sb2hr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176109>

On Mon, Jun 20, 2011 at 02:46:08PM -0700, Junio C Hamano wrote:

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 69bd576..6379ad6 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -658,9 +658,9 @@ test_expect_success LIBPCRE 'grep -P -v pattern' '
>  '
>  
>  test_expect_success LIBPCRE 'grep -P -i pattern' '
> -	{
> -		echo "hello.c:	printf(\"Hello world.\n\");"
> -	} >expected &&
> +	cat >expected <<-EOF &&
> +	hello.c:	printf("Hello world.\n");
> +	EOF

Do you need to quote EOF to suppress expansion in the here document?
Both bash and dash seem to pass unknown backslash-escapes like "\n"
through unharmed, but I don't know if that is portable (they do both
munge known escapes like "\\", of course).

-Peff
