From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase -i: several cleanups
Date: Tue, 26 Jun 2007 18:09:55 -0700
Message-ID: <7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706251856300.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:10:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3M2h-0000ha-Ek
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbXF0BJ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbXF0BJ6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:09:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40727 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbXF0BJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:09:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627010955.IRGY22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 21:09:55 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GR9w1X0051kojtg0000000; Tue, 26 Jun 2007 21:09:56 -0400
In-Reply-To: <Pine.LNX.4.64.0706251856300.4059@racer.site> (Johannes
	Schindelin's message of "Mon, 25 Jun 2007 18:56:55 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50995>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Support "--verbose" in addition to "-v", show short names in the list
> comment, clean up if there is nothing to do, and add several "test_ticks"
> in the test script.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-rebase--interactive.sh    |   19 +++++++++++++++----
>  t/t3404-rebase-interactive.sh |    2 ++
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index ab36572..b95fe86 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -60,6 +60,11 @@ die_with_patch () {
>  	die "$2"
>  }
>  
> +die_abort () {
> +	rm -rf "$DOTEST" 2> /dev/null
> +	die "$1"
> +}

Why "2>/dev/null" here?

> @@ -264,8 +269,11 @@ do
>  		echo $ONTO > "$DOTEST"/onto
>  		test t = "$VERBOSE" && : > "$DOTEST"/verbose
>  
> +		SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
> +		SHORTHEAD=$(git rev-parse --short $HEAD)
> +		SHORTONTO=$(git rev-parse --short $ONTO)
>  		cat > "$TODO" << EOF
> -# Rebasing $UPSTREAM..$HEAD onto $ONTO
> +# Rebasing $SHORTUPSTREAM)..$SHORTHEAD onto $SHORTONTO

What is this close-paren about?  Is it a typo?
