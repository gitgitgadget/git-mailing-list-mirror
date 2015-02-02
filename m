From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t5710-info-alternate: demonstrate bug in unpacked
 pruning
Date: Mon, 2 Feb 2015 12:56:22 -0500
Message-ID: <20150202175622.GB24025@peff.net>
References: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 18:56:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILEb-0005Mg-Ew
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 18:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbbBBR4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 12:56:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:44106 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932119AbbBBR4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 12:56:25 -0500
Received: (qmail 10951 invoked by uid 102); 2 Feb 2015 17:56:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 11:56:24 -0600
Received: (qmail 10031 invoked by uid 107); 2 Feb 2015 17:57:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 12:57:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 12:56:22 -0500
Content-Disposition: inline
In-Reply-To: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263266>

On Sun, Feb 01, 2015 at 01:55:00PM -0800, Jonathon Mah wrote:

> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> ---
>  t/t5710-info-alternate.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
> index 5a6e49d..d82844a 100755
> --- a/t/t5710-info-alternate.sh
> +++ b/t/t5710-info-alternate.sh
> @@ -18,6 +18,7 @@ reachable_via() {
>  
>  test_valid_repo() {
>  	git fsck --full > fsck.log &&
> +	git prune &&
>  	test_line_count = 0 fsck.log
>  }
>  
> @@ -47,8 +48,7 @@ test_expect_success 'preparing third repository' \
>  'git clone -l -s B C && cd C &&
>  echo "Goodbye, cruel world" > file3 &&
>  git add file3 &&
> -git commit -m "one more" file3 &&
> -git repack -a -d -l &&
> +git commit -m "one more without packing" file3 &&
>  git prune'

Modifying a test like this makes me a little nervous because now the old
test is not checking the same thing (pruning when we are packed), and
it's not obvious whether the packing was important to the original test.

And it's not clear that this change is testing a totally unrelated
thing.  I haven't looked closely, but would it be hard to introduce a
new test that more explicitly checks for the breakage?

-Peff
