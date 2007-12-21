From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull: don't complain about branch merge config if only fetching tags
Date: Fri, 21 Dec 2007 08:35:13 -0800
Message-ID: <7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 17:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5kqj-0000Ft-As
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 17:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236AbXLUQf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 11:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbXLUQf0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 11:35:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751091AbXLUQfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 11:35:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 760B85583;
	Fri, 21 Dec 2007 11:35:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8A895582;
	Fri, 21 Dec 2007 11:35:19 -0500 (EST)
In-Reply-To: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 21 Dec 2007 12:44:00 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69072>

Gerrit Pape <pape@smarden.org> writes:

> When running git pull with the -t switch, it properly fetches tags, but
> complains about missing information on how to merge.  Since there's
> nothing to merge, make git-pull simply exit after fetching the tags.
>
> The problem has been reported by Joey Hess through
>  http://bugs.debian.org/456035
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  git-pull.sh |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 698e82b..43be0bd 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -112,6 +112,11 @@ case "$merge_head" in
>  	     exit 1;;
>  	  *) exit $?;;
>  	esac
> +	# exit if only tags have been fetched
> +	not_for_merge=$(sed -e '/	not-for-merge	tag/d' \
> +			"$GIT_DIR"/FETCH_HEAD)
> +	test "$not_for_merge" != '' || exit 0
> +
>  	curr_branch=${curr_branch#refs/heads/}
>  
>  	echo >&2 "You asked me to pull without telling me which branch you"

I've seen this patch on this list in the past, but isn't "git
pull -t" a user-error?
