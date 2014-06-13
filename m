From: Jeff King <peff@peff.net>
Subject: Re: [PATCH alt-v3] Improve function dir.c:trim_trailing_spaces()
Date: Fri, 13 Jun 2014 19:25:38 -0400
Message-ID: <20140613232537.GB23078@sigill>
References: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
 <xmqqoaxw1ru4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pasha Bolokhov <pasha.bolokhov@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:25:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvaqz-0007M0-RK
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 01:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbaFMXZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 19:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:43883 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbaFMXZm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 19:25:42 -0400
Received: (qmail 1307 invoked by uid 102); 13 Jun 2014 23:25:42 -0000
Received: from mobile-166-198-031-023.mycingular.net (HELO sigill.intra.peff.net) (166.198.31.23)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 18:25:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 19:25:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoaxw1ru4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251650>

On Fri, Jun 13, 2014 at 01:23:47PM -0700, Junio C Hamano wrote:

> This passes with your shell set to dash but fails with bash.
> 
> Let's fix it up like so.

Thanks, I should have been more suspicious of the combination of backslashes
and echo during review. :)

> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> index 5ef5ad3..39e55a1 100755
> --- a/t/t0008-ignores.sh
> +++ b/t/t0008-ignores.sh
> @@ -816,12 +816,14 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
>  	>"whitespace/trailing 5 \\ \\ " &&
>  	>"whitespace/trailing 6 \\a\\" &&
>  	>whitespace/untracked &&
> -	echo "whitespace/trailing 1 \\    " >ignore  &&
> -	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
> -	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
> -	echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
> -	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
> -	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
> +	sed -e "s/Z$//" >ignore <<-\EOF &&
> +	whitespace/trailing 1 \    Z
> +	whitespace/trailing 2 \\\\Z
> +	whitespace/trailing 3 \\\\ Z
> +	whitespace/trailing 4   \\\    Z
> +	whitespace/trailing 5 \\ \\\   Z
> +	whitespace/trailing 6 \\a\\Z
> +	EOF

The end result is much more readable, too, IMHO.

-Peff
