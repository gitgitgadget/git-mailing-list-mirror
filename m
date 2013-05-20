From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-subtree: Use /bin/sh interpreter instead of /bin/bash
Date: Mon, 20 May 2013 15:36:58 -0700
Message-ID: <7vsj1hth11.fsf@alter.siamese.dyndns.org>
References: <20130520202434.GA3151@hades.panopticon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Marakasov <amdmi3@amdmi3.ru>
X-From: git-owner@vger.kernel.org Tue May 21 00:37:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeYhZ-0006MI-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 00:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab3ETWhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 18:37:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab3ETWhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 18:37:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3A7C20B36;
	Mon, 20 May 2013 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yVsXvU2xAVIAWWaaMu6p2jIaTis=; b=YsYz+Z
	hrj8mAhcvon7DBvzdzBmq1fOB9AuI+vponzaDDz9Fu1SPMhLs1CfMIDMI7TB+pxd
	oLIiijDxJdB8iLqn1Npm4Vx/S1Woo9w7BbO5y1vH/r7EgVoYSMgLY3uFN9z9esFz
	UMo/3NgSWaJ6HSnVYZBkaPNLQnsI2vuwLLzNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcYEyzkeHF8e0SDvbZMFyRGli1CYVy+R
	HU9NGgsHwQuqY/4A6cj0iOrEfhPuDlvydvd8JmyB7RrNojbCKhWOQexvxJvwwwWC
	HVoCImAE3q0Q6uyihUo5uNaxHdq3ZdnqewJeVoQCu2+ZnBjaqwIJfTlCGs6Zw/MT
	KMxa/GBa3H4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A974C20B35;
	Mon, 20 May 2013 22:37:00 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03F8120B33;
	Mon, 20 May 2013 22:36:59 +0000 (UTC)
In-Reply-To: <20130520202434.GA3151@hades.panopticon> (Dmitry Marakasov's
	message of "Tue, 21 May 2013 00:24:34 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8F7FB3C-C19D-11E2-8519-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224989>

Dmitry Marakasov <amdmi3@amdmi3.ru> writes:

> Use /bin/sh interpreter instead of /bin/bash for contrib/git-subtree:
> it's required for systems which don't use bash by default (for example,
> FreeBSD), while there seem to be no bashisms in the script (confirmed
> by looking through the source and tesing subtree functionality with
> FreeBSD's /bin/sh) to require specifically bash and not the generic
> posix shell.

Has anybody audited to make sure that the script itself is free of
bash-isms?

I somehow had an impression that in the past it was littered with
bash-isms like function local variables and array variables and
assumed that the #!/bin/bash was necessary.  I did a quick
eyeballing and did not see anything glaringly bash-only, but I may
have missed something (the coding style is so different from the
core part of Git Porcelains and distracting for me to efficiently
do a good job of scanning).

>
> Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
> ---
>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 8a23f58..5701376 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/bin/sh
>  #
>  # git-subtree.sh: split/join git repositories in subdirectories of this one
>  #
