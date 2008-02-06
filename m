From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.sh: Read $git_am_opt user setting inside --continue option
Date: Tue, 05 Feb 2008 18:26:32 -0800
Message-ID: <7vmyqe6crr.fsf@gitster.siamese.dyndns.org>
References: <d4rbzevi.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 03:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMa0X-0002uZ-RK
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 03:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761052AbYBFC0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 21:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbYBFC0z
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 21:26:55 -0500
Received: from rune.pobox.com ([208.210.124.79]:46046 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759733AbYBFC0y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 21:26:54 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 9E5FB19401F;
	Tue,  5 Feb 2008 21:27:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1013619401D;
	Tue,  5 Feb 2008 21:27:11 -0500 (EST)
In-Reply-To: <d4rbzevi.fsf@blue.sea.net> (Jari Aalto's message of "Tue, 05 Feb
	2008 15:56:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72748>

Jari Aalto <jari.aalto@cante.net> writes:

> Honor user settable --whitespace=<control>
>
> Signed-off-by: Jari Aalto <jari.aalto AT cante.net>
> ---
>  git-rebase.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index bdcea0e..ec052c4 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -174,7 +174,8 @@ do
>  		head_name=$(cat .dotest/head-name) &&
>  		onto=$(cat .dotest/onto) &&
>  		orig_head=$(cat .dotest/orig-head) &&
> -		git am --resolved --3way --resolvemsg="$RESOLVEMSG" &&
> +		git am $git_am_opt --resolved --3way \
> +		    --resolvemsg="$RESOLVEMSG" &&
>  		move_to_original_branch
>  		exit
>  		;;

Actually this is a bug in git-am.  am is supposed to remember
the original command line options.

8c31cb8 (git-am: --whitespace=x option) does it correctly, but
later 67dad68 (add -C[NUM] to git-am) broke it and other changes
inherited the breakage.
