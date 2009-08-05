From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: consistent error messages for staged and
 unstaged changes.
Date: Wed, 05 Aug 2009 10:24:13 -0700
Message-ID: <7vws5i9nsy.fsf@alter.siamese.dyndns.org>
References: <1249485221-10510-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:24:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkDy-0002hm-6d
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934749AbZHERYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934566AbZHERYR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:24:17 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934540AbZHERYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 13:24:17 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F2AF421617;
	Wed,  5 Aug 2009 13:24:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4EB9C21616; Wed, 
 5 Aug 2009 13:24:15 -0400 (EDT)
In-Reply-To: <1249485221-10510-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\,  5 Aug 2009 17\:13\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE3561D6-81E4-11DE-9365-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124927>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Previous version expose the output of the plumbing update-index to the
> user, which novice users have difficulty to understand.

Can't -q(uiet) option of update-index be used for this?

>
> We still need to run update-index to refresh the cache (if
> diff.autorefreshindex is false, git diff won't do it).
> ---
>  git-rebase.sh |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 18bc694..3555d17 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -382,8 +382,10 @@ else
>  fi
>  
>  # The tree must be really really clean.
> -if ! git update-index --ignore-submodules --refresh; then
> -	die "cannot rebase: you have unstaged changes"
> +if ! git update-index --ignore-submodules --refresh > /dev/null; then
> +	echo >&2 "cannot rebase: you have unstaged changes"
> +	git diff --name-status -r --ignore-submodules -- >&2
> +	exit 1
>  fi
>  diff=$(git diff-index --cached --name-status -r --ignore-submodules HEAD --)
>  case "$diff" in
> -- 
> 1.6.4.18.g07a4a.dirty
