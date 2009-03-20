From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-am: teach git-am to apply a patch to an unborn
	branch
Date: Fri, 20 Mar 2009 00:37:52 -0400
Message-ID: <20090320043752.GA27160@coredump.intra.peff.net>
References: <20090320071231.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 05:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkWWB-0001yx-MY
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 05:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZCTEiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 00:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbZCTEiG
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 00:38:06 -0400
Received: from peff.net ([208.65.91.99]:42474 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736AbZCTEiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 00:38:05 -0400
Received: (qmail 6554 invoked by uid 107); 20 Mar 2009 04:38:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 00:38:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 00:37:52 -0400
Content-Disposition: inline
In-Reply-To: <20090320071231.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113892>

On Fri, Mar 20, 2009 at 07:12:31AM +0900, Nanako Shiraishi wrote:

> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>

Thanks for picking up this topic. It looks sane overall.

> -	parent=$(git rev-parse --verify HEAD) &&
> +	if parent=$(git rev-parse --verify -q HEAD)
> +	then
> +		pparent="-p $parent"
> +	else
> +		echo >&2 "applying to an empty history"
> +		parent= pparent=
> +	fi &&

Note that the '&&' here is now pointless, since one side of the
conditional will always be true. We are losing the ability to detect
errors besides "HEAD does not point to a valid object", but I don't
think there is a way to tell the difference from the exit code of
rev-parse.

-Peff
