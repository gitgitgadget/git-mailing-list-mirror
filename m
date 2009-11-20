From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive: point the user to commit when file
 would be overwritten.
Date: Fri, 20 Nov 2009 10:05:11 -0800
Message-ID: <7vskc9vzqg.fsf@alter.siamese.dyndns.org>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
 <1258732767-12741-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Nov 20 19:05:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBXrL-0002ny-VT
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 19:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbZKTSFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 13:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbZKTSFO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 13:05:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbZKTSFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 13:05:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDAAEA01B3;
	Fri, 20 Nov 2009 13:05:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1horGtMkMjVX6sf0xWWEk4QEc4=; b=r+Tb2J
	CAg9yGGBkABOYuWBRJYhPG9cwDlTOQ2CNFB/Y1cK3zYK2R/TyAQQ2nAc7plP8kcR
	avPR8MctVDnauszh5cqP/ohkErL7rRaDxHa+LBZ7yXlIzBzXFtGtd+/NGpmKpEX8
	/RFRB7hoyOOav3fGiUaJOKrJGpyc2lgmSM1zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcH2lITCyV+Ka3SFMOEmtHlqEL7ICyfW
	kz9V5QSxxvEem40o50SwXJp+KtvO6+penl9YgUVj3TEvsFYDDVnCV+AeA6Zxa8RQ
	n1XVrgJpTvyzTRSIlnhq0j70OyAGBpE7ZA0ZNmbEiNwuk9GBPAlZmC1uiqkeWp4p
	+cFn8q/MvBI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC59FA01B2;
	Fri, 20 Nov 2009 13:05:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EAE6A01B1; Fri, 20 Nov 2009
 13:05:13 -0500 (EST)
In-Reply-To: <1258732767-12741-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 20 Nov 2009 16\:59\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41E577EC-D5FF-11DE-98C6-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133362>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The commit-before-pull is well accepted in the DVCS community, but is
> confusing some new users. This should get them back in the right way when
> the problem occurs.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Don't these extra lines warrant "advice.*" option?

> ---
>  merge-recursive.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index f55b7eb..d5e0819 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -172,9 +172,11 @@ static int git_merge_trees(int index_only,
>  	struct unpack_trees_options opts;
>  	static const struct unpack_trees_error_msgs msgs = {
>  		/* would_overwrite */
> -		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
> +		"Your local changes to '%s' would be overwritten by merge.  Aborting:\n"
> +		"Please, commit your changes or stash them before you can merge.",
>  		/* not_uptodate_file */
> -		"Your local changes to '%s' would be overwritten by merge.  Aborting.",
> +		"Your local changes to '%s' would be overwritten by merge.  Aborting:\n"
> +		"Please, commit your changes or stash them before you can merge.",
>  		/* not_uptodate_dir */
>  		"Updating '%s' would lose untracked files in it.  Aborting.",
>  		/* would_lose_untracked */
> -- 
> 1.6.5.3.435.g5f2e3.dirty
