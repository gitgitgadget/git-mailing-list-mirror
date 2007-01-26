From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore-pickaxe: fix infinite loop on zero-length needle
Date: Thu, 25 Jan 2007 23:56:40 -0500
Message-ID: <20070126045639.GA9260@coredump.intra.peff.net>
References: <20070126044858.GA8653@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 05:56:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAJ8n-0006bF-8A
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 05:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030739AbXAZE4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 23:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030740AbXAZE4m
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 23:56:42 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2689 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030739AbXAZE4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 23:56:41 -0500
Received: (qmail 10075 invoked from network); 25 Jan 2007 23:57:04 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 25 Jan 2007 23:57:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Jan 2007 23:56:40 -0500
Content-Disposition: inline
In-Reply-To: <20070126044858.GA8653@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37797>

On Thu, Jan 25, 2007 at 11:48:58PM -0500, Jeff King wrote:

> has zero length. The loop could be modified to handle this, but it makes
> more sense to simply have an empty needle return no matches. Thus, a
> command like
>   git log -S
> produces no output.
> 
> We place the check at the top of the function so that we get the same
> results with or without --pickaxe-regex. Note that until now,
>   git log -S --pickaxe-regex
> would match everything, not nothing.

My assumption is that nobody is really depending on this behavior
(since, after all, without --pickaxe-regex it caused an infinite loop!).
If you want to maintain consistency, the conditional should simply
return 1 instead of 0 (no callers of contains() actually care about the
count value).

-Peff
