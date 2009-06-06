From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/3] Convert existing die(..., strerror(errno)) to die_errno()
Date: Sat, 6 Jun 2009 22:31:24 +0200
Message-ID: <200906062231.24184.j6t@kdbg.org>
References: <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch> <095b4af080c11b4ad3fcfaefc9cdf49d383cb714.1244299302.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Alexander Potashev <aspotashev@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:31:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD2YW-0008V8-Nc
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 22:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbZFFUb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 16:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbZFFUb2
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 16:31:28 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27856 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbZFFUb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 16:31:27 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 42831CDF8B;
	Sat,  6 Jun 2009 22:31:25 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D11B93BDFC;
	Sat,  6 Jun 2009 22:31:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <095b4af080c11b4ad3fcfaefc9cdf49d383cb714.1244299302.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120933>

On Samstag, 6. Juni 2009, Thomas Rast wrote:
> Change calls to die(..., strerror(errno)) to use the new die_errno().
>
> In the process, also make slight style adjustments: at least state
> _something_ about the function that failed (instead of just printing
> the pathname), and put paths in single quotes.

> @@ -428,8 +428,8 @@ static void merge_name(const char *remote, struct
> strbuf *msg)
>
>  		fp = fopen(git_path("FETCH_HEAD"), "r");
>  		if (!fp)
> -			die("could not open %s for reading: %s",
> -				git_path("FETCH_HEAD"), strerror(errno));
> +			die_errno("could not open %s for reading",
> +				  git_path("FETCH_HEAD"));

You said you added quotes, but you didn't do that here and in quite a few more 
other cases.

IMHO, the quotes are not an improvement anyway, but that's really only my 
personal taste.

> --- a/connect.c
> +++ b/connect.c
> @@ -256,7 +256,7 @@ static int git_tcp_connect_sock(char *host, int flags)
>  	freeaddrinfo(ai0);
>
>  	if (sockfd < 0)
> -		die("unable to connect a socket (%s)", strerror(saved_errno));
> +		die_errno("unable to connect a socket");

You cannot convert this: We want strerror(saved_errno), but die_errno would 
print strerror(errno).

> @@ -345,7 +345,7 @@ static int git_tcp_connect_sock(char *host, int flags)
>  	}
>
>  	if (sockfd < 0)
> -		die("unable to connect a socket (%s)", strerror(saved_errno));
> +		die_errno("unable to connect a socket");

Same here.

-- Hannes
