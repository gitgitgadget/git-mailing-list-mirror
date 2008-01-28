From: Jeff King <peff@peff.net>
Subject: Re: git-revert is a memory hog
Date: Mon, 28 Jan 2008 00:59:33 -0500
Message-ID: <20080128055933.GA13521@coredump.intra.peff.net>
References: <20080127172748.GD2558@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 07:00:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJN2P-0001Mx-J3
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 07:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYA1F7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 00:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbYA1F7i
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 00:59:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4141 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbYA1F7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 00:59:38 -0500
Received: (qmail 24421 invoked by uid 111); 28 Jan 2008 05:59:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 28 Jan 2008 00:59:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2008 00:59:33 -0500
Content-Disposition: inline
In-Reply-To: <20080127172748.GD2558@does.not.exist>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71850>

On Sun, Jan 27, 2008 at 07:27:48PM +0200, Adrian Bunk wrote:

> <--  snip  -->
> 
> $ git-revert d19fbe8a7
> Auto-merged drivers/input/input.c
> CONFLICT (content): Merge conflict in drivers/input/input.c
> Auto-merged include/linux/input.h
> CONFLICT (content): Merge conflict in include/linux/input.h
> Automatic revert failed.  After resolving the conflicts,
> mark the corrected paths with 'git add <paths>' and commit the result.
> $ 
> 
> <--  snip  -->
> 
> In top you can see that this took > 800 MB of RAM !

I tried to reproduce this, but my peak heap allocation was only around
20MB. Is your repository fully packed? Not packed at all? Can you use
valgrind/massif to figure out where the memory is going?

> I don't know how easy it would be to implement, but shouldn't git-revert 
> be able to be as fast and less memory consuming as
>   git-show d19fbe8a7 | patch -p1 -R

In your case, the patch doesn't apply cleanly, so we end up doing a
3-way merge (in my tests, it is git-merge-recursive which ends up taking
up the memory).

-Peff
