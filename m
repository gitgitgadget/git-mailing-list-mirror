From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/5] "status --ignored"
Date: Sun, 11 Apr 2010 06:35:10 -0400
Message-ID: <20100411103510.GD20484@coredump.intra.peff.net>
References: <20100410040959.GA11977@coredump.intra.peff.net>
 <1270885256-31589-1-git-send-email-gitster@pobox.com>
 <20100410074430.GA12567@coredump.intra.peff.net>
 <7vd3y7ycgu.fsf@alter.siamese.dyndns.org>
 <20100410084007.GA16843@coredump.intra.peff.net>
 <7v633zxiw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Raymond <esr@snark.thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 12:35:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uWB-0002xp-Av
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 12:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab0DKKfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 06:35:38 -0400
Received: from peff.net ([208.65.91.99]:44948 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab0DKKfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 06:35:37 -0400
Received: (qmail 3262 invoked by uid 107); 11 Apr 2010 10:35:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Apr 2010 06:35:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Apr 2010 06:35:10 -0400
Content-Disposition: inline
In-Reply-To: <7v633zxiw4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144637>

On Sat, Apr 10, 2010 at 11:27:39AM -0700, Junio C Hamano wrote:

> > ... But finding every file means
> > we have to traverse areas that git otherwise wouldn't look at, which
> > might mean going to disk to pull in all of the "foo/" directory
> > structure (which is less likely to be cached, since the rest of git
> > isn't touching it), even though it may not even be of interest to us.
> 
> Yes, that is why it is adequate for us use COLLECT_IGNORED in "git add"
> and give "foo/ is outside---you as an intelligent human should be able to
> infer that your foo/bar is also" without double traversal.

It would be adequate here, too, if we want to know whether a specific
file is ignored. It just takes more work from the caller. But Eric has
already said he would prefer to just get all files, so let's go with
what you wrote.

If another caller wants a more restricted but efficient interface later,
we can add it as you suggest (or more likely, they want to check a
particular _set_ of files, so we don't want to do a full traversal
anyway. We would want to get their list of candidates and traverse just
enough of the .gitignore stack to get answers for their set).

-Peff
