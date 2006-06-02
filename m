From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] handle concurrent pruning of packed objects
Date: Fri, 02 Jun 2006 09:10:24 -0700
Message-ID: <7vk67zbksv.fsf@assigned-by-dhcp.cox.net>
References: <20060602153223.GA4223@coredump.intra.peff.net>
	<7vwtbzblkf.fsf@assigned-by-dhcp.cox.net>
	<20060602160456.GA8957@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 18:10:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmCEO-0001Zo-It
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 18:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWFBQK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWFBQK0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 12:10:26 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47299 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932077AbWFBQK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 12:10:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602161025.WMSK19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 12:10:25 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060602160456.GA8957@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 2 Jun 2006 12:04:56 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21169>

Jeff King <peff@peff.net> writes:

> That shouldn't make a difference for correctness, even if the old packs
> are still there. If you have an object in two packs, then it doesn't
> matter which one you pull it from. The main impacts I can think of are:
>   1. The old pack may already be mapped, and it would be more efficient
>      to use it. However, the new pack will be mapped on first use, so it
>      will be used from then on.
>   2. The pack list can grow without bound. However, for this to matter,
>      you'd have to do many prunes during the course of a single git
>      command.

I agree 100% on "shouldn't" part.  What I wonder is if everybody
works correctly if we mmap the same file (all available .idx are
mapped all the time, and we map .pack LRU) twice.  But I realize
we have NO_MMAP configuration for unfortunate platforms to work
it around so that wouldn't be a big deal.
