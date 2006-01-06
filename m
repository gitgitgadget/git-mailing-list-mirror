From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-tree: stop on broken output pipe
Date: Fri, 06 Jan 2006 14:36:50 -0800
Message-ID: <7vhd8ht24d.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:37:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Cp-0007S2-8g
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWAFWg6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbWAFWg6
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:36:58 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6840 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750998AbWAFWg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:36:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223507.IUDZ17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:07 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14214>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Without this, on my iBook git-whatchanged keeps running when I 
> 	quit "less". I have to interrupt the process a second time. No
> 	idea why it works on Linux.
>
> -		if (!no_commit_id)
> -			printf("%s%c", header, diff_options.line_termination);
> +		if (!no_commit_id && printf("%s%c", header,
> +				diff_options.line_termination) < 0)
> +			die("broken output pipe");
>  		header = NULL;

There are tons of output other than this printf() and catching
an output error only on this one and assuming that is a broken
pipe somehow feels doubly wrong to me.
