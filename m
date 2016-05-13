From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 29/33] refs: resolve symbolic refs first
Date: Fri, 13 May 2016 08:58:22 -0400
Message-ID: <20160513125822.GB24031@sigill.intra.peff.net>
References: <5735C990.8080502@alum.mit.edu>
 <e87d7f0f441a9094d75cae7a39aac1e8760426e9.1463140520.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 13 14:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1Cg5-0000lz-3s
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 14:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbcEMM6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 08:58:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:39141 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752640AbcEMM60 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 08:58:26 -0400
Received: (qmail 27313 invoked by uid 102); 13 May 2016 12:58:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 08:58:25 -0400
Received: (qmail 18732 invoked by uid 107); 13 May 2016 12:58:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 08:58:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 08:58:22 -0400
Content-Disposition: inline
In-Reply-To: <e87d7f0f441a9094d75cae7a39aac1e8760426e9.1463140520.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294530>

On Fri, May 13, 2016 at 02:35:40PM +0200, Michael Haggerty wrote:

> +	if (read_raw_ref(refname, lock->old_oid.hash, referent, type)) {
> +		if (errno == ENOENT) {
> +			if (mustexist) {
> +				/* Garden variety missing reference. */
> +				strbuf_addf(err, "unable to resolve reference '%s'",
> +					    refname);
> +				goto error_return;
> +			} else {
> +				/*
> +				 * Reference is missing, but that's OK. We
> +				 * know that there is not a conflict with
> +				 * another loose reference because
> +				 * (supposing that we are trying to lock
> +				 * reference "refs/foo/bar"):
> +				 *
> +				 * - We were successfully able to create
> +				 *   the lockfile refs/foo/bar.lock, so we
> +				 *   know there cannot be a loose reference
> +				 *   named "refs/foo".
> +				 *
> +				 * - We got ENOENT and not EISDIR, so we
> +				 *   know that there cannot be a loose
> +				 *   reference named "refs/foo/bar/baz".
> +				 */
> +			}

Thanks for this comment, I think it makes the logic easier to follow.

I re-ran t5551 and confirmed that the timings look good (though I
imagine you might have already done that, too :) ).

-Peff
