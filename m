From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7300: fix broken && chains
Date: Mon, 31 Aug 2015 14:54:14 -0400
Message-ID: <20150831185414.GB20555@sigill.intra.peff.net>
References: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUDn-0005Wl-0t
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbbHaSyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 14:54:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:52507 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753973AbbHaSyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:54:17 -0400
Received: (qmail 14496 invoked by uid 102); 31 Aug 2015 18:54:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 13:54:17 -0500
Received: (qmail 25227 invoked by uid 107); 31 Aug 2015 18:54:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 14:54:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 14:54:14 -0400
Content-Disposition: inline
In-Reply-To: <1440926289-5899-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276910>

On Sun, Aug 30, 2015 at 11:18:09AM +0200, Erik Elfstr=C3=B6m wrote:

> While we are here, remove some boilerplate by using test_commit.

Darn, I thought we were done finding these after flipping on
GIT_TEST_CHAIN_LINT. :)

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 27557d6..86ceb38 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -432,9 +432,7 @@ test_expect_success 'nested git work tree' '
>  	(
>  		cd foo &&
>  		git init &&
> -		>hello.world
> -		git add . &&
> -		git commit -a -m nested
> +		test_commit nested hello.world
>  	) &&

Unfortunately CHAIN_LINT cannot reach inside a nested subshell. I canno=
t
think of a way to make it do so, and besides, that is also the way to
override the &&-chain precedence. So I think it is not really possible
to get better coverage here. And such cases as these are not really ver=
y
interesting (e.g., here we exclude only minor minor setup steps from th=
e
&&-chain).

-Peff
