From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Mon, 2 Feb 2015 19:45:08 -0500
Message-ID: <20150203004507.GA31946@peff.net>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
 <1422919650-13346-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 01:45:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIRcD-0001tk-9X
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 01:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358AbbBCApM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 19:45:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:44327 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755292AbbBCApL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 19:45:11 -0500
Received: (qmail 28448 invoked by uid 102); 3 Feb 2015 00:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 18:45:11 -0600
Received: (qmail 4557 invoked by uid 107); 3 Feb 2015 00:45:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 19:45:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 19:45:08 -0500
Content-Disposition: inline
In-Reply-To: <1422919650-13346-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263297>

On Mon, Feb 02, 2015 at 03:27:27PM -0800, Junio C Hamano wrote:

> By default, a patch that affects outside the working area is
> rejected as a mistake (or a mischief); Git itself does not create
> such a patch, unless the user bends backwards and specifies a
> non-standard prefix to "git diff" and friends.
> 
> When `git apply` is used without either `--index` or `--cached`
> option as a "better GNU patch", the user can pass `--unsafe-paths`
> option to override this safety check.  This cannot be used to escape
> outside the working tree when using `--index` or `--cached` to apply
> the patch to the index.
> 
> The new test was stolen from Jeff King with slight enhancements.

I notice that this includes the symlink-crossing tests, marked as
failures. Reading the series, I know what is going to happen later, but
do you want to leave a note like:

  Note that we also add tests for leaving the working directory by
  crossing symlink boundaries, which is not addressed in this patch.
  That is a separate issue caused following symlinks, which will come
  later.

or something to help later readers of "git log"?

> +--unsafe-paths::
> +	By default, a patch that affects outside the working area is
> +	rejected as a mistake (or a mischief); Git itself never
> +	creates such a patch unless the user bends backwards and
> +	specifies nonstandard prefix to "git diff" and friends.

Minor wordsmithing: the usual idiom is "bend over backwards", and you
probably want s/specifies/& a/.

> ++
> +When `git apply` is used without either `--index` or `--cached`
> +option as a "better GNU patch", the user can pass `--unsafe-paths`
> +option to override this safety check.

Similarly, probably every instance of "foo option" would read better as
"the foo option".

> This cannot be used to escape
> +outside the working tree when using `--index` or `--cached` to apply
> +the patch to the index.

I had trouble figuring out what this meant. Would it be simpler to just
say:

  This option has no effect when `--index` or `--cached` is in use.

Or is there some other subtlety that you are trying to convey that I am
missing?

-Peff
