From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] error_resolve_conflict: drop quotations around operation
Date: Tue, 03 Jun 2014 10:02:02 -0700
Message-ID: <xmqq8upex6yc.fsf@gitster.dls.corp.google.com>
References: <20140603071717.GA32038@sigill.intra.peff.net>
	<20140603072349.GA32206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 19:05:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrs9Q-0000Ly-7R
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 19:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958AbaFCRFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 13:05:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65091 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932714AbaFCRFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 13:05:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17B5A1B99D;
	Tue,  3 Jun 2014 13:05:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jhVVReEYFX/Mtv3P/SjeH89d1QU=; b=yI9VkV
	s4LXXYdiDww0eWPjZhT5TuQmLM0EhFfrm+2mJqSlQ2KuZMAk2JojhdSqhRtthHA1
	ryGUmeYS2wQ2Fys5J8FO+JEj9MhvU3TUDR353OEvTxJqM8VnuoZG1/CGMXWykuIP
	xttns4LYIA+XelMlHca0w2F3XqH62TSb6+FRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DxMdiCX5kJfPSVguRs1cshvD0G1fjz3f
	NnVRWfr7vfE3n2GvzNHU02Na7zXw00Ncnah750cNTVGj4iJdvmYK+1KhrD/nxUNt
	/ndlgm+x6aMj66eLwXrVRBhZEVkxlAJQ2aoHNKPxj9D9g9aI7XDmw0NrPcTT6xBM
	Faw+l5VZ3pA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C5511B997;
	Tue,  3 Jun 2014 13:05:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CE921B875;
	Tue,  3 Jun 2014 13:02:05 -0400 (EDT)
In-Reply-To: <20140603072349.GA32206@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Jun 2014 03:23:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CA132ABE-EB40-11E3-ABAC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250632>

Jeff King <peff@peff.net> writes:

> When you try to commit with unmerged entries, you get an
> error like:
>
>   $ git commit
>   error: 'commit' is not possible because you have unmerged files.
>
> The quotes around "commit" are clunky; the user doesn't care
> that this message is a template with the command-name filled
> in.  Saying:
>
>   error: commit is not possible because you have unmerged files
>
> is easier to read. As this code is called from other places,
> we may also end up with:
>
>   $ git merge
>   error: merge is not possible because you have unmerged files
>
>   $ git cherry-pick foo
>   error: cherry-pick is not possible because you have unmerged files
>
>   $ git revert foo
>   error: revert is not possible because you have unmerged files
>
> All of which look better without the quotes. This also
> happens to match the behavior of "git pull", which generates
> a similar message (but does not share code, as it is a shell
> script).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I realize this may just be a matter of taste, but I thought I'd put it
> forth as a possibility.

If the template were filled with 'git commit', 'git merge', etc.,
then the quotes around %s may make it clearer, but 'me' here is
designed to be a single subcommand name, so this change is good.

> I also considered switching the wording to:
>
>   error: cannot commit because you have unmerged files
>
> which I find a little more natural.

Perhaps.  As long as the subcommand name that can come here as 'me'
is always a verb, that would work (I didn't think about l10n, tho).

>  advice.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/advice.c b/advice.c
> index ef24733..c50ebdf 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -76,7 +76,7 @@ int git_default_advice_config(const char *var, const char *value)
>  
>  int error_resolve_conflict(const char *me)
>  {
> -	error("'%s' is not possible because you have unmerged files.", me);
> +	error("%s is not possible because you have unmerged files.", me);
>  	if (advice_resolve_conflict)
>  		/*
>  		 * Message used both when 'git commit' fails and when
