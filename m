From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase -p: avoid grep on potentailly non-ASCII data
Date: Tue, 8 Mar 2016 19:11:57 -0500
Message-ID: <20160309001157.GB32669@sigill.intra.peff.net>
References: <alpine.DEB.2.10.1603080255030.2674@buzzword-bingo.mit.edu>
 <56DEC4B4.2000902@web.de>
 <56DED770.4050603@drmicha.warpmail.net>
 <20160308143556.GA10153@sigill.intra.peff.net>
 <xmqqio0wk151.fsf@gitster.mtv.corp.google.com>
 <xmqqegbkk0ed.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:12:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adRjR-0008EI-Kv
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 01:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbcCIAMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 19:12:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:56709 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbcCIAMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 19:12:00 -0500
Received: (qmail 5990 invoked by uid 102); 9 Mar 2016 00:11:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 19:11:59 -0500
Received: (qmail 9024 invoked by uid 107); 9 Mar 2016 00:12:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 19:12:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 19:11:57 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegbkk0ed.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288462>

On Tue, Mar 08, 2016 at 03:36:26PM -0800, Junio C Hamano wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index c0cfe88..4cde685 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1233,7 +1233,8 @@ then
>  	git rev-list $revisions |
>  	while read rev
>  	do
> -		if test -f "$rewritten"/$rev && test "$(sane_grep "$rev" "$state_dir"/not-cherry-picks)" = ""
> +		if test -f "$rewritten"/$rev &&
> +		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null

Looks better. I think "-q" might be nicer still (and more efficient,
though it almost certainly doesn't matter in practice).

-Peff
