From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/6] t5541-http-push.sh: add test for unmatched,
 non-fast-forwarded refs
Date: Tue, 5 Jan 2010 01:35:46 -0500
Message-ID: <20100105063546.GB19368@coredump.intra.peff.net>
References: <20091224154057.33611ae7.rctay89@gmail.com>
 <20091224154005.a642c8ec.rctay89@gmail.com>
 <20091224154158.15ba580f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 07:35:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS31F-0002LU-TE
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 07:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848Ab0AEGft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 01:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923Ab0AEGft
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 01:35:49 -0500
Received: from peff.net ([208.65.91.99]:39056 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab0AEGft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 01:35:49 -0500
Received: (qmail 28247 invoked by uid 107); 5 Jan 2010 06:40:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 05 Jan 2010 01:40:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jan 2010 01:35:46 -0500
Content-Disposition: inline
In-Reply-To: <20091224154158.15ba580f.rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136168>

On Thu, Dec 24, 2009 at 03:41:58PM +0800, Tay Ray Chuan wrote:

> Test that when non-fast-forwarded refs cannot be matched without an
> explicit refspect, the push fails with a non-fast-forward ref status and
> help message.

I don't understand what you're testing here. If it's not matched, then
how is it a non-fast-forward? Isn't it simply unmatched?

Your test:

> +test_expect_failure 'push fails for non-fast-forward refs unmatched by remote helper' '
> +	# create a dissimilarly-named ref so that git is unable to match the refs
> +	git push origin master:retsam
> +
> +	echo "change changed" > path2 &&
> +	git commit -a -m path2 --amend &&
> +
> +	# push master too. This ensures there is at least one '"'push'"' command to
> +	# the remote helper and triggers interaction with the helper.
> +	!(git push -v origin +master master:retsam >output 2>&1) &&
> +
> +	grep "^ + [a-z0-9]\+\.\.\.[a-z0-9]\+[ ]*master -> master (forced update)$" output &&
> +	grep "^ ! \[rejected\][ ]*master -> retsam (non-fast-forward)$" output &&

Looks like you're just testing the usual "master -> retsam is not a
fast-forward" case. I don't understand how this is different from the
previous tests. Can you elaborate?

-Peff
