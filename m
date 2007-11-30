From: Jeff King <peff@peff.net>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 19:48:05 -0500
Message-ID: <20071130004805.GA12185@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org> <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org> <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org> <20071129235253.GA10261@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291625580.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixu3n-00060c-Ug
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934086AbXK3AsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933290AbXK3AsK
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:48:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2719 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934086AbXK3AsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:48:09 -0500
Received: (qmail 30475 invoked by uid 111); 30 Nov 2007 00:48:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 19:48:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 19:48:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711291625580.8458@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66581>

On Thu, Nov 29, 2007 at 04:41:09PM -0800, Linus Torvalds wrote:

> It's not pretty, it's not smart, but it seems to work. There's something 
> to be said for keeping it simple and stupid.
> 
> And it should not be nearly as expensive as it may _look_. Yes, the loop 
> is "(i = 0; i < num_create * num_src; i++)", but the important part is 
> that the whole array is sorted by rename score, and we have a
> 
> 	if (mx[i].score < minimum_score)
> 		break;
> 
> in it, so uthe loop actually would tend to terminate rather quickly.

I think the slowdown is a non-issue. From the benchmarking I did in the
past, all of the time was spent _before_ even getting to the qsort of
scores. So even if you doubled the expense of that loop, it would have a
negligible impact.

But I haven't actually benchmarked this new patch, of course.

-Peff
