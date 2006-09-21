From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 22:35:13 -0700
Message-ID: <7vzmctdbou.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060920234548.GA20461@coredump.intra.peff.net>
	<Pine.LNX.4.63.0609210206320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 07:35:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQHDX-00049x-0B
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 07:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIUFfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 01:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWIUFfS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 01:35:18 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37548 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751239AbWIUFfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 01:35:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921053513.OZCN13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 01:35:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qtaz1V0071kojtg0000000
	Thu, 21 Sep 2006 01:34:59 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210206320.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 02:07:19 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27453>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 20 Sep 2006, Jeff King wrote:
>
>> Memory leak on 'bases'. It shouldn't matter much because the program is
>> short-lived, but I couldn't remember if we have a policy on such things
>> with increasing lib-ification.
>
> True. How about this:
>
> -- snip --
>
> +		backup = get_merge_bases(old_commit, new_commit, 1);
> +		for (bases = backup;
>  				bases; bases = bases->next)
>  			if (!hashcmp(old_sha1, bases->item->object.sha1))
>  				break;
>  		if (!bases)
>  			return error("denying non-fast forward;"
>  					" you should pull first");
> +		free_commit_list(backup);

Still leaking on the error path ;-).

Will fixup and apply; no need to resend.
