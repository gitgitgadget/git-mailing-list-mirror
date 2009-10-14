From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Tue, 13 Oct 2009 22:13:39 -0700
Message-ID: <7vr5t6lfr0.fsf@alter.siamese.dyndns.org>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 14 07:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxwE9-0001J1-OO
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 07:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbZJNFOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 01:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbZJNFOa
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 01:14:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZJNFO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 01:14:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A55E158376;
	Wed, 14 Oct 2009 01:13:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pQNwk+A+FKb46eElfFZO82diz9c=; b=FlYPBW
	6MH4q0OMyGvxDlHqs5roX/3RQoaR7Hm0UPNpOy5RTrdPkAYudyExsAHu6D3EzjUp
	O8+a6//YS4UIyl736pRiu4DjzC9YKmZM3JvZMo2d+1YwhdMgl9IjPcr8968lkqi0
	H8yCuPvYnCcTBbRBpNGOecObZA+IJ5mIat5pg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UpHq4y/k5NFJ1aJK5FiT+dVKXdADRwny
	ogsbKVuN/hGp7debUhsCcHBw4glv5dLTbFXq+kwqRjU36tckFFW0nQ5l+agwzuWN
	wbs3BCDEhtDWFkAwJ7bSS1/PEAhEtkxc3S5ElBgf/vhzlFckwiXcNbB+b+Y9wpyT
	8hneekSNifU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E44458375;
	Wed, 14 Oct 2009 01:13:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8A6258374; Wed, 14 Oct
 2009 01:13:40 -0400 (EDT)
In-Reply-To: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
 (Sam Vilain's message of "Wed\, 14 Oct 2009 17\:45\:25 +1300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 585400F8-B880-11DE-9F93-B3E4ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130252>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Add a simple hook that will run before checkouts.
>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>  Documentation/githooks.txt |   20 +++++++++++++++-----
>  builtin-checkout.c         |   25 ++++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 06e0f31..8dc3fbf 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -143,21 +143,31 @@ pre-rebase
>  This hook is called by 'git-rebase' and can be used to prevent a branch
>  from getting rebased.
>  
> +pre-checkout
> +-----------
>  
> -post-checkout
> -~~~~~~~~~~~~~
> -
> -This hook is invoked when a 'git-checkout' is run after having updated the
> +This hook is invoked when a 'git-checkout' is run after before updating the

"after before"?

>  worktree.  The hook is given three parameters: the ref of the previous HEAD,
>  the ref of the new HEAD (which may or may not have changed), and a flag
>  indicating whether the checkout was a branch checkout (changing branches,
>  flag=1) or a file checkout (retrieving a file from the index, flag=0).
> -This hook cannot affect the outcome of 'git-checkout'.
> +This hook can prevent the checkout from proceeding by exiting with an
> +error code.
>  
>  It is also run after 'git-clone', unless the --no-checkout (-n) option is
>  used. The first parameter given to the hook is the null-ref, the second the
>  ref of the new HEAD and the flag is always 1.
>  
> +This hook can be used to perform any clean-up deemed necessary before
> +checking out the new branch/files.
> +
> +post-checkout
> +-----------

This is not about your patch, but the patch text shows that our diff
algorithm seems to have a room for improvement.  I expected to see a
straight insersion of block of text, not touching anything in the original
section on post-checkout hook.
