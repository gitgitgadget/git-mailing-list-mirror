From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove empty ref directories that prevent creating a ref.
Date: Mon, 25 Sep 2006 22:27:28 -0700
Message-ID: <7vlko7rydb.fsf@assigned-by-dhcp.cox.net>
References: <20060926072337.39dbb9f4.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 07:27:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS5Th-0002E5-Dc
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 07:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWIZF1a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 01:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWIZF1a
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 01:27:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17573 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751138AbWIZF1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 01:27:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926052729.TADJ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 01:27:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id StTS1V00K1kojtg0000000
	Tue, 26 Sep 2006 01:27:27 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060926072337.39dbb9f4.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 26 Sep 2006 07:23:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27776>

Christian Couder <chriscool@tuxfamily.org> writes:

> +LF='
> +'
> +
> +if [ -d "$GIT_DIR/refs/heads/$branchname" ]
> +then
> +	OLD_IFS="$IFS"
> +	IFS="$LF"
> +	for refdir in `find "$GIT_DIR/refs/heads/$branchname" -type d | sort -r`
> +	do
> +		rmdir "$refdir" || \
> +		    die "Could not delete '$refdir'," \
> +		    "there may still be a ref there."
> +	done
> +	IFS="$OLD_IFS"
> +fi

I was sort of expecting that you would do something like:

	for refdir in `cd "$GIT_DIR" &&
		        find "refs/heads/$branchname" -type d |
		        sort -r`
	do                        
		rmdir "$GIT_DIR/$refdir" ...

wihtout mucking with IFS ;-). 
