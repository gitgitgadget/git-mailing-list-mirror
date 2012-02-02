From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Thu, 2 Feb 2012 03:30:09 -0500
Message-ID: <20120202083009.GA6933@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
 <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:30:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rss3y-0004QP-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab2BBIaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:30:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52908
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754061Ab2BBIaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:30:12 -0500
Received: (qmail 18094 invoked by uid 107); 2 Feb 2012 08:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:37:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:30:09 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189602>

On Thu, Feb 02, 2012 at 03:17:47AM -0500, Jeff King wrote:

> I implemented all of the other optimizations I mentioned except the
> "only stream the first few bytes when auto-detecting binary-ness" one.
> However, it should be easy to do on top of these changes. I need to
> re-visit the similar change to diff_filespec_is_binary, and I'll do both
> at the same time.

Oh, and I didn't even think about implementing streaming grep.  The
context-finding code relies on being able to backtrack through the file
in memory. We _could_ implement streaming only for binary files (i.e.,
when we will just print "Binary file foo matches"). However, I suspect
people with big binary files will want to be using "-I" anyway, so as to
avoid even pulling the data from disk at all.

We might eventually want to add a config-option version of "-I" for
people who have repositories of mixed source code and large binary
assets.

-Peff
