From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 03:06:36 -0700
Message-ID: <7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 12:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJnrp-00077S-3Q
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 12:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755947AbXHKKGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754445AbXHKKGi
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 06:06:38 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34324 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbXHKKGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 06:06:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811100637.UJEE26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 06:06:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aa6c1X00j1kojtg0000000; Sat, 11 Aug 2007 06:06:37 -0400
In-Reply-To: <864pj74ay9.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Fri, 10 Aug 2007 18:21:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55599>

David Kastrup <dak@gnu.org> writes:

> If filter-branch is entered with an unset GIT_DIR, things are rather
> fragile.  The GIT_DIR variable setting then points to something like
> $(pwd)/../.. which is neither guaranteed to be a git directory

I think this comment refers to this part, ...

> -case "$GIT_DIR" in
> -/*)
> -	;;
> -*)
> -	GIT_DIR="$(pwd)/../../$GIT_DIR"
> -	;;
> -esac

... however, at the beginning of the script, it dot-includes
git-sh-setup, which sets (but not export) GIT_DIR for the rest
of the script to use (see the last if..then..else).

If you got an unset GIT_DIR when you reached that case statement
you are removing here, I suspect that there is something else
going on, but I do not see what it is...

Puzzled...
