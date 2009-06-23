From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Tue, 23 Jun 2009 06:57:47 +0200
Message-ID: <200906230657.48627.chriscool@tuxfamily.org>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <alpine.DEB.1.00.0906212354030.26154@pacific.mpi-cbg.de> <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 06:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIy4q-0007OF-Qg
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 06:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbZFWE5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 00:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbZFWE5i
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 00:57:38 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:49525 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbZFWE5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 00:57:37 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1491B8180D0;
	Tue, 23 Jun 2009 06:57:30 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0D603818072;
	Tue, 23 Jun 2009 06:57:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7v1vpdqiv2.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 22 June 2009, Junio C Hamano wrote:
>
> rebase -i: AUTHOR_{NAME,EMAIL,DATE} are already available in HEAD; use
> it.
>
> This only changes the codepath of "rebase -i --continue" that auto-amends
> the HEAD commit with the change user made but forgot to "commit --amend".
>
>  git-rebase--interactive.sh |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index f96d887..b8608be 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -522,8 +522,7 @@ first and then run 'git rebase --continue' again."
>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"
>  			fi
> -			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -			git commit --no-verify -F "$DOTEST"/message -e || {
> +			git commit --no-verify -c HEAD || {
>  				test -n "$amend" && git reset --soft $amend
>  				die "Could not commit staged changes."
>  			}

This patch would use the message from HEAD instead of "$DOTEST"/message, but 
it looks like we are changing "$DOTEST"/message sometimes with 
the "make_squash_message" function.

Best regards,
Christian.
