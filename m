From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch: fail gracefully when a filter fails
Date: Thu, 05 Jul 2007 09:52:35 -0700
Message-ID: <7vk5tedc8c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041535420.4071@racer.site>
	<20070705135824.GB5493@sigill.intra.peff.net>
	<Pine.LNX.4.64.0707051636240.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:52:40 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6UZL-0003jy-WC
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153AbXGEQwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756411AbXGEQwh
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:52:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48181 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705AbXGEQwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:52:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705165236.GFYI3098.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Jul 2007 12:52:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Kssb1X00H1kojtg0000000; Thu, 05 Jul 2007 12:52:35 -0400
In-Reply-To: <Pine.LNX.4.64.0707051636240.9789@racer.site> (Johannes
	Schindelin's message of "Thu, 5 Jul 2007 16:38:06 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51686>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 5 Jul 2007, Jeff King wrote:
>
>> status=`((cmd1; echo $? >&3) | cmd2) 3>&1`
>
> Cute.
>
> This is the replacement patch, then (I guess there are still some nits to 
> be had, so I did not redo the proper patch yet):
> ...
> +	(sed -e '1,/^$/d' <../commit |
> +		(eval "$filter_msg" ||
> +		 die "msg filter failed: $filter_msg" 2>&3) |
> +		(sh -c "$filter_commit" "git commit-tree" $(git write-tree) \
> +			$parentstr > ../map/$commit ||
> +		 die "commit filter failed: $filter_commit" 2>&3)) 3>&1 |
> +	 grep . && die

You certainly meant "grep >&2 ." at the end of that pipeline;
while I welcome people to be aware that it is possible with
esoteric shell redirection games, I personally feel this is not
worth it.
