From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3/GSoC 4/5] test-lib.sh: unset all environment variables
 defined in xdg base dir spec[1]
Date: Fri, 25 Mar 2016 06:05:35 -0400
Message-ID: <20160325100535.GD8880@sigill.intra.peff.net>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
 <1458728005-22555-4-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 11:05:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajOch-0001Gq-4r
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 11:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcCYKFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 06:05:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:38122 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751904AbcCYKFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 06:05:38 -0400
Received: (qmail 6228 invoked by uid 102); 25 Mar 2016 10:05:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 06:05:38 -0400
Received: (qmail 22364 invoked by uid 107); 25 Mar 2016 10:05:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 25 Mar 2016 06:05:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2016 06:05:35 -0400
Content-Disposition: inline
In-Reply-To: <1458728005-22555-4-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289872>

On Wed, Mar 23, 2016 at 06:13:24PM +0800, Hui Yiqun wrote:

> Otherwise, on environments where these variables and set, an assignment
> to one of these variables will cause the variable being implicitly exported.

Yes, that's one problem, though I think the more general problem is
simply that they pollute the test environment (so git might actually be
touching your _real_ credential-cache socket, and not a fake test one).

I'd probably write:

  We try to clean the test environment of variables that may affect the
  outcome, so that the tests always start from a known state. We already
  clean XDG_CONFIG_HOME, but now that we support XDG_RUNTIME_DIR, we
  must clean that, too. While we're at it, let's simply cover all
  variables mentioned in the xdg spec[1] to future-proof and to cover
  any places where they might unexpectedly have an impact.

Feel free to use or adapt that as you see fit.

> +# Unset all environment variables defined in xdg base dir spec[1]
> +# to make sure that the test are running with a known state.
> +#
> +# [1] https://specifications.freedesktop.org/basedir-spec
> +#     /basedir-spec-latest.html
> +unset XDG_DATA_HOME
>  unset XDG_CONFIG_HOME
> +unset XDG_DATA_DIRS
> +unset XDG_CONFIG_DIRS
> +unset XDG_CACHE_HOME
> +unset XDG_RUNTIME_DIR

Thanks for being thorough here. This is much nicer than just adding
XDG_RUNTIME_DIR.

-Peff
