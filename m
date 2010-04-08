From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 (resend)] ls-remote: fall-back to default remotes
 when no remote specified
Date: Thu, 8 Apr 2010 03:16:39 -0400
Message-ID: <20100408071639.GJ30473@coredump.intra.peff.net>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
 <1270710427-6680-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzlzE-0001qU-Nn
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495Ab0DHHRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:17:00 -0400
Received: from peff.net ([208.65.91.99]:47109 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758446Ab0DHHQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:16:59 -0400
Received: (qmail 17199 invoked by uid 107); 8 Apr 2010 07:16:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:16:59 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:16:39 -0400
Content-Disposition: inline
In-Reply-To: <1270710427-6680-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144340>

On Thu, Apr 08, 2010 at 03:07:07PM +0800, Tay Ray Chuan wrote:

>  	remote = remote_get(dest);
> +	if (!remote)
> +		usage(ls_remote_usage);

I don't see an update to ls_remote_usage, but shouldn't it now be:

  git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]
    [repository] [<refs>...]

or something now (while we're at it, maybe we can wrap it better as it's
larger than 80 characters).

But once that is done, shouldn't the (!remote) case say something like
"you don't have a default remote". The user didn't invoke ls-remote
incorrectly (as the usage message shows), but rather there was a
configuration problem.

> +test_expect_success 'use branch.<name>.remote if possible' '
> +
> +	# Remove "origin" so that we know that ls-remote is not using it.
> +	#
> +	# Ideally, we should test that branch.<name>.remote takes precedence
> +	# over "origin", but that is another matter altogether.
> +	#
> +	git remote rm origin &&
> +	git config branch.master.remote self &&
> +	git ls-remote >actual &&
> +	test_cmp expected.all actual
> +
> +'

Wouldn't your "ideally" just be:

  git clone . other-remote &&
  git push other-remote HEAD:unique-ref &&
  git config branch.master.remote other-remote &&
  ...

and check for "unique-ref" in the output?

-Peff
