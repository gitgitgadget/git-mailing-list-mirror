From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 1/2] t5304-prune: demonstrate bug in pruning alternates
Date: Mon, 2 Feb 2015 13:41:16 -0500
Message-ID: <20150202184115.GA25421@peff.net>
References: <0BD44E44-686B-44B2-A4C0-9E14A99BA96B@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:41:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILw3-0007KR-2f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbbBBSlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:41:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:44153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753984AbbBBSlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 13:41:18 -0500
Received: (qmail 12862 invoked by uid 102); 2 Feb 2015 18:41:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 12:41:18 -0600
Received: (qmail 10607 invoked by uid 107); 2 Feb 2015 18:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 13:41:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 13:41:16 -0500
Content-Disposition: inline
In-Reply-To: <0BD44E44-686B-44B2-A4C0-9E14A99BA96B@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263274>

On Mon, Feb 02, 2015 at 10:33:02AM -0800, Jonathon Mah wrote:

> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---
> Adjust prune test directly, much nicer.

Agreed, this is much nicer. A few comments:

> +test_expect_success 'prune: handle alternate object database' '

This test fails, so we either need expect_failure here, or it just needs
to be squashed in with the fix (I generally prefer the latter).

> +	test_create_repo A && cd A &&

We generally prefer to chdir in a subshell, so that a failure in the
test does not leave further tests in a confusing spot. Like:

  test_create_repo A &&
  (
	cd A &&
	... do stuff in repo ...
	# no need to cd ..
  ) &&
  .. do stuff outside repo ...

> +	echo "Hello World" > file1 &&

Style nit: we prefer ">file1" with no space.

> +	git add file1 &&
> +	git commit -m "Initial commit" file1 &&
> +	cd .. &&
> +	git clone -l -s A B && cd B &&

"-l" is a noop these days. I don't think it is hurting, but I'd prefer
not to propagate bad habits in our tests.

> diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
> index 5a6e49d..d82844a 100755
> --- a/t/t5710-info-alternate.sh
> +++ b/t/t5710-info-alternate.sh

We can drop this change, then, right?

-Peff
