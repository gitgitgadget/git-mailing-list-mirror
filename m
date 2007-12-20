From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reallow git-rebase --interactive --continue if commit is unnecessary
Date: Wed, 19 Dec 2007 23:15:20 -0800
Message-ID: <7vzlw5rg53.fsf@gitster.siamese.dyndns.org>
References: <87r6hias5s.fsf@gollum.intra.norang.ca>
	<20071220071212.GA20534@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 08:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Fdm-0006SR-3j
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 08:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbXLTHP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 02:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbXLTHP7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 02:15:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbXLTHP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 02:15:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB5A878A;
	Thu, 20 Dec 2007 02:15:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 502888789;
	Thu, 20 Dec 2007 02:15:22 -0500 (EST)
In-Reply-To: <20071220071212.GA20534@spearce.org> (Shawn O. Pearce's message
	of "Thu, 20 Dec 2007 02:12:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68978>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> During git-rebase --interactive's --continue implementation we used
> to silently restart the rebase if the user had made the commit
> for us.  This is common if the user stops to edit a commit and
> does so by amending it.  My recent change to watch git-commit's
> exit status broke this behavior.
>
> Thanks to Bernt Hansen for catching it in 1.5.4-rc1.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  git-rebase--interactive.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 47581ce..39f32b1 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -372,8 +372,9 @@ do
>  			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
>  		} &&
>  		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
> -		git commit --no-verify -F "$DOTEST"/message -e ||
> +		if ! git commit --no-verify -F "$DOTEST"/message -e
>  			die "Could not commit staged changes."
> +		fi

This looks like a syntax error to me.
