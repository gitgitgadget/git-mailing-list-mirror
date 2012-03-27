From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4052: unset $COLUMNS inherited from environment
Date: Tue, 27 Mar 2012 01:17:14 -0400
Message-ID: <20120327051714.GB20897@sigill.intra.peff.net>
References: <20120326234549.GA10172@sigill.intra.peff.net>
 <1332825003-2288-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:17:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCOmd-0006UO-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab2C0FRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 01:17:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60441
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab2C0FRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:17:19 -0400
Received: (qmail 30756 invoked by uid 107); 27 Mar 2012 05:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 01:17:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 01:17:14 -0400
Content-Disposition: inline
In-Reply-To: <1332825003-2288-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194008>

On Tue, Mar 27, 2012 at 07:10:03AM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> $COLUMNS must be unset to not interfere with the tests. The tests
> already ignore the terminal size because output is redirected to a
> file, but $COLUMNS overrides terminal size detection and changes the
> test output away from the standard 80 even if not on a terminal.
>=20
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
> Stupid omission. Please apply.

Thanks. I had a feeling it was something like this, but when I went to
test again, I couldn't reproduce! It seems that COLUMNS is not exported
by default, but somehow I must have exported it accidentally.

> diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
> index 328aa8f..1f47f1d 100755
> --- a/t/t4052-stat-output.sh
> +++ b/t/t4052-stat-output.sh
> @@ -17,6 +17,7 @@ test_expect_success 'preparation' '
>  	git commit -m message &&
>  	echo a >"$name" &&
>  	git commit -m message "$name"
> +	sane_unset COLUMNS
>  '

Should we perhaps just unset it in test-lib.sh, along with the other
variables that cause an inconsistent test environment? This is the only
test script that breaks now, but there's no reason not to protect all o=
f
the scripts.

-Peff
