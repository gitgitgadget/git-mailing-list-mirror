Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E7920FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 08:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbcGAIKQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 04:10:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:53272 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbcGAIEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 04:04:55 -0400
Received: from virtualbox ([37.24.143.238]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lubnw-1bRrig0o8e-00zkmM; Fri, 01 Jul 2016 10:04:46
 +0200
Date:	Fri, 1 Jul 2016 10:04:44 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] add an extra level of indirection to main()
In-Reply-To: <20160701055858.GA4593@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607010953440.12947@virtualbox>
References: <20160701055532.GA4488@sigill.intra.peff.net> <20160701055858.GA4593@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VN4nG9yI98l+qpIxLVEfbmifC53cgcOIJHEidDSA39W7fxeyUyC
 03VOc2J2P2LM9YmykOjkydbNmwtN4RI6pyEiZ43ARhshIvit3Q9tazs/689viYB4nAf+ikg
 h8s3GBHj9IT3Bqk9X/vnCcD3AO/x8z1Ul9TcNflJl+AlvHPk+aR6FGx53OL0qe5J9iZSo5t
 E4Jpc825NwzWDStCYi0PA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EyCXDNpeBTc=:PxiO7qcAj1LOkO4nIClGNH
 YUGbJ6GtCz0hvcaSAlRJ42Dj9DFw3dhLOWzr2og8UPXjjaVqdQ4fJIyDyIUYSylkhOwogY4zz
 vJABqf2f9Y912aYzTt+wHJruSyX3PpEzZTcZchjEZIOyCLoSpbuwby6ppX3ofe+aPLR2/dOF+
 ksXkq8X4u1WR57LpHKVjsfHzYrTw/cs3TYdbhcLgApVfxkFNFUo6eJfmxO0DCCdWT2eGwCsjb
 EWlrmWHVALXdxNs3MZG6q6kDH1hfVdy6bNt/TBhZZACrQAqS/x7lwjq6VDWvR39E3UAt1V/EM
 SDm/tRycthn9p241TEgZW+wPKKhDiB3GdMvn+hTWDqAbbhRUTDZ9AnxpFoPrwjOfzlSQ3uaH3
 85crgZd/F9Swuo+6WM8hQZUK7Ebf9CyC7vm7kQpUOEp+GUy2HxKagQt/aRLbneUYcAmNRrlVL
 KwdFdYNSKXZWZp98olra1CNkmypTbz5lLAsVSRdoew5/kh3Wit0qcDskO31eGQxdugZwAF0x9
 Z3ZmfyF7qi+OQw7d4EihckHsFQfTWOGh9ArEnno05Gx4xqWo4KUvW6jhSXEZ9EEgCbnd4kXEj
 Cezw4Eos4G40UmPeLDP35UU6mMfoZhVRQoIwwkw0o44TTTJJyMm0ZKK2hwvlRqSAu8xCVB+tz
 yR9LaGyEu7zNI2w7JUxiiUFj7So4H1NaXtUzyIJdUuTz1BW7M/LdyK2UemKwhRhox7dovuXG1
 dJV2WYDGoyno/NYxdRvVjpI7rC9BTiZaTIp5KlxWgV4PqP1U45lpioNYBT2Qxd8rxeW6rA2Op
 NKJV+Xl
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Fri, 1 Jul 2016, Jeff King wrote:

> I waffled between the two mechanisms. Opinions welcome.

I am happy you took the cmd_main() approach: we do have to play some
tricks on Windows, in particular in some upcoming changes that support
building with MS Visual C++ (we want to ensure that `argv` is in UTF-8,
which means that we actually have to use the UTF-16 versions and convert
them manually lest argv has the current Windows encoding of strings).
Which means that we still have to use that mingw_startup() trick you
mentioned, and which would have interfered had you chosen a similar
method.

> diff --git a/common-main.c b/common-main.c
> new file mode 100644
> index 0000000..2b96bbf
> --- /dev/null
> +++ b/common-main.c
> @@ -0,0 +1,12 @@
> +#include "git-compat-util.h"
> +
> +int main(int argc, char **av)
> +{
> +	/*
> +	 * This const trickery is explained in
> +	 * 84d32bf7678259c08406571cd6ce4b7a6724dcba

This commit message says that mingw_main() is declared with char **argv,
and that is the reason why we have to convert. Maybe spell that out here,
and then in a subsequent commit, we can fix the mingw_main() declaration?

> +	 */
> +	const char **argv = (const char **)av;
> +
> +	return cmd_main(argc, argv);
> +}

Ciao,
Dscho
