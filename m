From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 16:21:18 -0500
Message-ID: <20080226212118.GA32530@sigill.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <47C435DC.2070508@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7FR-00010w-Fd
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764221AbYBZVVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765214AbYBZVVX
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:21:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3678 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765381AbYBZVVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:21:21 -0500
Received: (qmail 6614 invoked by uid 111); 26 Feb 2008 21:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 26 Feb 2008 16:21:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 16:21:18 -0500
Content-Disposition: inline
In-Reply-To: <47C435DC.2070508@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75174>

On Tue, Feb 26, 2008 at 09:53:00AM -0600, Brandon Casey wrote:

> 	git config pack.thread 4
> 	git repack
> 
> The user would immediately know something was wrong when they saw the
> message "Using 1 pack threads" instead of the "4" they thought they

There are hundreds of ways the user can fail to configure git correctly;
I don't think it's worth printing output so verbose that the user can
manually check that every config option was respected.

At any rate, I think your reasoning is not a good guideline for user
output. You are making output to notice a mistake that happens one time
(the time of config), but you are showing the output to the reader many
times (every time they repack from here to eternity). But there are also
mistakes that could be made in the "many times" case, and you are taking
their attention away from that.

In the case of repack, it is probably not a big deal. But in the case of
'push', for example, I think we want as little output as possible taking
attention away from the useful information: which refs were pushed,
which were rejected, and so forth. That's why Nicolas made the
pack-objects output considerably more terse last November.

> configured. Also, since it's only printed in the THREADED_DELTA_SEARCH
> case, it's also a confirmation that this option was indeed used for a
> particular build of git.

Same reasoning as above. You configure THREADED_DELTA_SEARCH once; you
don't need to check that it was enabled every time you repack.

> I'd also say that if the message is too noisy in the "user explicitly
> assigned number of threads" case, then it's just as noisy in the "auto assign"
> case, so just remove the message completely.

I am not opposed to that; the "auto assign" case is nice to see the
first time you repack ("did it find all of my CPUs?"), but yes, it
probably will be the same every time after.

-Peff
