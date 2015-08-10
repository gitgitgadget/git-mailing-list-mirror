From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 17/17] memoize common git-path "constant" files
Date: Mon, 10 Aug 2015 08:30:34 -0400
Message-ID: <20150810123034.GB32371@sigill.intra.peff.net>
References: <20150810092731.GA9027@sigill.intra.peff.net>
 <20150810093857.GQ30981@sigill.intra.peff.net>
 <55C8937A.3080206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 10 14:30:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOmDz-0004I9-R7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 14:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbbHJMaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 08:30:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:42959 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751464AbbHJMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 08:30:39 -0400
Received: (qmail 9357 invoked by uid 102); 10 Aug 2015 12:30:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 07:30:38 -0500
Received: (qmail 4918 invoked by uid 107); 10 Aug 2015 12:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Aug 2015 08:30:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Aug 2015 08:30:34 -0400
Content-Disposition: inline
In-Reply-To: <55C8937A.3080206@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275612>

On Mon, Aug 10, 2015 at 02:05:14PM +0200, Michael Haggerty wrote:

> I was wondering whether this memoization could interact badly with
> update_common_dir(). For example, if any of the memoized functions were
> called before git_common_dir is initialized, then the pre-git_common_dir
> value would continue to be used even if git_common_dir is changed
> afterwards. But I believe it is taboo to call git_path() before
> setup_git_env(), so I think this is not a problem.

Calling git_path() actually ends up in setup_git_env(), because we
lazily call it from get_git_dir(). So if somebody tries to tweak
common_dir stuff too late, we could in theory cache a bogus value; but
the real problem is generating the bogosity in the first place.

-Peff
