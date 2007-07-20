From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Print an error when falling back to vi on a dumb terminal
Date: Thu, 19 Jul 2007 17:15:24 -0700
Message-ID: <7vfy3k2an7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707191944560.14781@racer.site>
	<11848794193942-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 02:15:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBg9h-0003Q9-Bh
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbXGTAP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbXGTAP0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:15:26 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42116 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXGTAPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:15:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070720001524.YTLS1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 20:15:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RcFP1X00f1kojtg0000000; Thu, 19 Jul 2007 20:15:24 -0400
In-Reply-To: <11848794193942-git-send-email-aroben@apple.com> (Adam Roben's
	message of "Thu, 19 Jul 2007 14:10:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53039>

Adam Roben <aroben@apple.com> writes:

> Here you go. I'm not terribly happy with the error message, though. I tried to
> be as clear as possible and to keep some of the nice information that was in
> the git-commit error message. Please improve upon it if you can.
>
>  git-am.sh                  |    4 ++--
>  git-commit.sh              |   11 +----------
>  git-rebase--interactive.sh |    2 +-
>  git-sh-setup.sh            |   15 +++++++++++++--
>  git-tag.sh                 |    2 +-
>  5 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index a5de0a1..dd517f4 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -7,7 +7,6 @@ USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
>    or, when resuming [--skip | --resolved]'
>  . git-sh-setup
>  set_reflog_action am
> -set_editor
>  require_work_tree
>  
>  git var GIT_COMMITTER_IDENT >/dev/null || exit
> @@ -365,7 +364,8 @@ do
>  		[yY]*) action=yes ;;
>  		[aA]*) action=yes interactive= ;;
>  		[nN]*) action=skip ;;
> -		[eE]*) "$GIT_EDITOR" "$dotest/final-commit"
> +		[eE]*) set_editor
> +		       "$GIT_EDITOR" "$dotest/final-commit"
>  		       action=again ;;
>  		[vV]*) action=again
>  		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;

Sounds sane.

Could you please re-diff to make this into a single patch
without intermediate "Oh, doing it this way is cleaner", and
also with Dscho's Ack?  I do not think we would need to have 3
commits for this topic --- it is not like wide userbase tested
each iteration.
