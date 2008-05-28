From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Wed, 28 May 2008 08:53:40 -0700
Message-ID: <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
References: <200805281608.02000.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 28 17:55:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1NzD-0001f6-7I
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 17:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbYE1Pxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 11:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYE1Pxz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 11:53:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYE1Pxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 11:53:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D908324B;
	Wed, 28 May 2008 11:53:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AE9263246; Wed, 28 May 2008 11:53:48 -0400 (EDT)
In-Reply-To: <200805281608.02000.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Wed, 28 May 2008 16:08:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4517386E-2CCE-11DD-BD5C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83103>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> When you get a conflict during interactive rebase the next
> thing to do is not to amend, but to continue the rebase.
> With this change you get a reminder in the prompt.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  contrib/completion/git-completion.bash |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> I got a couple of broken rebases. Hence this fix.
>
> -- robin
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1698463..a606328 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -82,7 +82,12 @@ __git_ps1 ()
>  			b="$(git symbolic-ref HEAD 2>/dev/null)"
>  		elif [ -f "$g/.dotest-merge/interactive" ]
>  		then
> -			r="|REBASE-i"
> +			if [ -f "$g/.dotest-merge/amend" ]
> +			then
> +				r="|REBASE-i-amend"
> +			else
> +				r="|REBASE-i-continue"
> +			fi
>  			b="$(cat "$g/.dotest-merge/head-name")"
>  		elif [ -d "$g/.dotest-merge" ]
>  		then
> -- 
> 1.5.5.1.178.g1f811

Hmm.  The "|REBASE-blah" prefix is already too long for my liking and this
makes it even longer X-<

Does this mean that it would help reduce mistakes if "git commit --amend"
noticed the presense of .dotest-merge but absense of .dotest-merge/amend
and refused to operate, I have to wonder?
