From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix tail option problem in test
Date: Mon, 23 Apr 2007 17:09:38 -0700
Message-ID: <7v4pn6d459.fsf@assigned-by-dhcp.cox.net>
References: <462D47CA.7010806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 24 02:09:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8bJ-0001gP-Pf
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 02:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030840AbXDXAJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 20:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030881AbXDXAJm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 20:09:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42227 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030840AbXDXAJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 20:09:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070424000939.MZGZ1266.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 20:09:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qo9e1W00A1kojtg0000000; Mon, 23 Apr 2007 20:09:39 -0400
In-Reply-To: <462D47CA.7010806@gmail.com> (A. Large Angry's message of "Mon,
	23 Apr 2007 19:56:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45387>

A Large Angry SCM <gitzilla@gmail.com> writes:

> The tail command on my system complains:
>
> 	tail: cannot open `8192' for reading: No such file or directory
>
> if there is any whitespace between the '-c' option and the byte count.
>
> Signed-off-by: A Large Angry SCM <Gitzilla@gmail.com>
> ---
>
>  t/t5302-pack-index.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index 232e5f1..b7870a8 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -16,7 +16,7 @@ test_expect_success \
>           test-genrandom "$i" 8192 >>file_$i &&
>           git-update-index --add file_$i || return 1
>       done &&
> -     echo 101 >file_101 && tail -c 8192 file_100 >>file_101 &&
> +     echo 101 >file_101 && tail -c8192 file_100 >>file_101 &&
>       git-update-index --add file_101 &&
>       tree=`git-write-tree` &&
>       commit=`git-commit-tree $tree </dev/null` && {

I do not like using tail to do a byte-oriented thing like this
to begin with.  How about using the plain old trustworthy and
portable program, "dd", instead?
