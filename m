From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 22:46:21 -0800
Message-ID: <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 13 07:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgp6-00006W-F8
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbWCMGqa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCMGqa
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:46:30 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44518 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751772AbWCMGq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 01:46:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060313064504.CBLN3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 01:45:04 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 12 Mar 2006 22:26:34 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17557>

Linus Torvalds <torvalds@osdl.org> writes:

> The "score" calculation for diffcore-rename was totally broken.
>
> It scaled "score" as
>
> 	score = src_copied * MAX_SCORE / dst->size;
>
> which means that you got a 100% similarity score even if src and dest were 
> different, if just every byte of dst was copied from src, even if source 
> was much larger than dst (eg we had copied 85% of the bytes, but _deleted_ 
> the remaining 15%).

Your reading of the code is correct, but that is deliberate.

>  	/* How similar are they?
>  	 * what percentage of material in dst are from source?
>  	 */

I wanted to say in such a case that dst was _really_ derived
from the source.  I think using max may make more sense, but I
need to convince myself by looking at filepairs that this change
stops detecting as renames, and this change starts detecting as
renames.
