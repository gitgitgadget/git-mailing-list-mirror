From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Tue, 19 Jan 2016 14:12:35 -0500
Message-ID: <20160119191234.GA17562@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 19 20:12:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLbhq-0005Eo-77
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 20:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbcASTMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 14:12:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:56381 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754824AbcASTMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 14:12:37 -0500
Received: (qmail 31956 invoked by uid 102); 19 Jan 2016 19:12:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 14:12:37 -0500
Received: (qmail 25718 invoked by uid 107); 19 Jan 2016 19:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 14:12:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 14:12:35 -0500
Content-Disposition: inline
In-Reply-To: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284374>

On Tue, Jan 19, 2016 at 10:24:29AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use the Travis-CI cache feature to store prove test results and make them
> available in subsequent builds. This allows to run previously failed tests
> first and run remaining tests in slowest to fastest order. As a result it
> is less likely that Travis-CI needs to wait for a single test at the end
> which speeds up the test suite execution by ~2 min.

Thanks, this makes sense, and the patch looks good.

> @@ -18,7 +22,7 @@ env:
>      - P4_VERSION="15.2"
>      - GIT_LFS_VERSION="1.1.0"
>      - DEFAULT_TEST_TARGET=prove
> -    - GIT_PROVE_OPTS="--timer --jobs 3"
> +    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"

Have you tried bumping --jobs here? I usually use "16" on my local box.

I also looked into the Travis "container" thing. It's not clear to me
from their page:

  https://docs.travis-ci.com/user/workers/container-based-infrastructure/

whether we're using the new, faster container infrastructure or not. It
depends on when Travis "recognized" the repo, but I'm not quite sure
what that means. Should we be adding "sudo: false" to the top-level of
the yaml file?

-Peff
