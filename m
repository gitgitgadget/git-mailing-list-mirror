From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 20 Apr 2012 18:45:34 +0200
Message-ID: <4F9192AE.5050304@kdbg.org>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Shezan Baig <shezbaig.wk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLGxr-0002bS-Im
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab2DTQpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 12:45:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15363 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2DTQpi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 12:45:38 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B796513004A;
	Fri, 20 Apr 2012 18:45:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1A2D119F449;
	Fri, 20 Apr 2012 18:45:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196007>

Am 20.04.2012 17:05, schrieb Thomas Rast:
> The command
> 
>   git rebase [-i] [--onto $onto] $base $branch
> 
> is defined to be equivalent to
> 
>   git checkout $branch && git rebase [-i] [--onto $onto] $base
> 
> However, we do not have to actually perform the checkout.  The rebase
> starts building on top of $base (or $onto, if given).  The tree
> _state_ (not diff) of $branch is irrelevant.  Actually performing the
> checkout has some downsides: $branch may potentially be way out of
> touch with HEAD, and thus e.g. trigger a full rebuild in a timestamp-
> based build system, even if $base..$branch only edits the README.

Thanks, this is very much appreciated. I like it (because it would
prevent lots of unneeded rebuilds in my use-cases).

>  cp "$todo" "$todo".backup
>  git_sequence_editor "$todo" ||
> -	die_abort "Could not execute editor"
> +	die_abort_with_checkout "Could not execute editor"

I don't think that we want to checkout here, even if the docs say we do.

-- Hannes
