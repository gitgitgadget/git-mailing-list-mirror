From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] git-checkout: Handle relative paths containing "..".
Date: Thu, 08 Nov 2007 00:30:20 -0800
Message-ID: <7v4pfx3zs3.fsf@gitster.siamese.dyndns.org>
References: <1194489192-20021-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2mh-00030s-1q
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbXKHIa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbXKHIa1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:30:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42356 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545AbXKHIa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:30:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AE4E32F0;
	Thu,  8 Nov 2007 03:30:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1A74D916E8;
	Thu,  8 Nov 2007 03:30:43 -0500 (EST)
In-Reply-To: <1194489192-20021-1-git-send-email-dsymonds@gmail.com> (David
	Symonds's message of "Thu, 8 Nov 2007 13:33:12 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63965>

David Symonds <dsymonds@gmail.com> writes:

> diff --git a/git-checkout.sh b/git-checkout.sh
> index 8993920..b2c50aa 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -134,9 +134,10 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
>  	fi
>  
>  	# Make sure the request is about existing paths.
> -	git ls-files --error-unmatch -- "$@" >/dev/null || exit
> -	git ls-files -- "$@" |
> -	git checkout-index -f -u --stdin
> +	git ls-files --full-name --error-unmatch -- "$@" >/dev/null || exit
> +	git ls-files --full-name -- "$@" |
> +		(cd "$(git-rev-parse --show-cdup)" &&
> +		 git checkout-index -f -u --stdin)

Have you tested this patch from the toplevel of any tree, where
"git-rev-parse --show-cdup" would yield an empty string?

I also wonder how this patch (with an obvious fix to address the
above point) would interact with GIT_DIR and/or GIT_WORK_TREE in
the environment.
