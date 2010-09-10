From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Thu, 09 Sep 2010 17:21:26 -0700
Message-ID: <7vy6bajvnd.fsf@alter.siamese.dyndns.org>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Jens.Lehmann@web.de, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Sep 10 02:21:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtrNO-00059w-9l
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 02:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab0IJAVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 20:21:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0IJAVk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 20:21:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B47FED46DB;
	Thu,  9 Sep 2010 20:21:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YTjtGfZPlNaTbcgV3il7YqoqC3g=; b=dhiFZm
	Y3+SV8b8CFqHkfnGP1QJgJWwicvNscujPqefN32ZKffvhQZGY0tnEhUisMw5/nuI
	d+3w9gWQB3XtPLES5eg9OG7P3lTSmq9uq7HqQJBDLMicSlz/0HHqRJS0sWlR2CYJ
	wxC+u+yhg3JfKSy/beyf2rYo/nUgETjMePgRM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=djWNa4Vd16miB6H7eVLJGGMV5oi7bIpa
	Uv0nH3QuMPHbqx3U+9Id29FFmcF/ybTxlsqFiXuc+5FWuP/MZMQUnSRRw4qlazQT
	gtYRe2U/haqt8shY5nCd1joVhCGplDUtlMFI/pVwJNSmtT5EZo+1davkEsmabShu
	7Md23peCslo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C9E1D46DA;
	Thu,  9 Sep 2010 20:21:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B904D46D7; Thu,  9 Sep
 2010 20:21:28 -0400 (EDT)
In-Reply-To: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\,  9 Sep 2010 14\:12\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E485202-BC71-11DF-A67C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155914>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Since 'git describe' does not append -dirty to the version string it
> produces when untracked files exist in the working directory of the main
> repository, it should not do so for submodules either.
>
> Add --ignore-submodules=untracked to the call to diff-index which is used
> to decide whether or not the '-dirty' string is necessary.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---

Hmm, this changes the behaviour in a big way but it probably is for the
better.  At least it is consistent with the recent fixes to the
interaction between diff and submodules.

Objections from submodule users?

>  builtin/describe.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 43caff2..6c4f15b 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -29,7 +29,8 @@ static const char *dirty;
>  
>  /* diff-index command arguments to check if working tree is dirty. */
>  static const char *diff_index_args[] = {
> -	"diff-index", "--quiet", "HEAD", "--", NULL
> +	"diff-index", "--quiet", "--ignore-submodules=untracked", "HEAD",
> +	"--", NULL
>  };
>  
>  
> -- 
> 1.7.2.1
