From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/12] t7406: use "git pull" instead of "git pull --rebase"
Date: Thu, 07 May 2015 10:24:24 -0700
Message-ID: <xmqqfv78qp13.fsf@gitster.dls.corp.google.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-10-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 19:24:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPXE-000713-6M
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbbEGRY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:24:28 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750907AbbEGRY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 13:24:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 466A24EF23;
	Thu,  7 May 2015 13:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mUIFa4pZL083U1qxTvgz9ZUjBto=; b=eCgIZ1
	C5QKvEt9m4kt7fXl4PHupCAaNeeS0t4FWjfWE9ci8XSXolNr0fWFIszTd/YJkFnZ
	hK+jNFoFS6SvHkEEbBPWwwwY+IYcxTvjtT9pVjzh+JursKD1Uj0OfTRGfjW5azc1
	eROKNZnIIFh7pFl2QdVPSo+eHUxHmPXvpPnfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D6KAofBT9OdwN3tJ5yi9TqEBFQi1Eqaa
	wuR+vJxPf9ynD5AZQ0IBtwK0UZgZjDK65bEkN2Pi7LgkQ1hotfXiLFTVlgzx1jES
	aBTWErn+V8+1FVqmVXZ5wRWe4SQaJxHXhU8EL2lAZCa8GYdjptcsFTxBo5b5NIFl
	xPu5EBj+1xY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CE6B4EF22;
	Thu,  7 May 2015 13:24:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DFCA4EF21;
	Thu,  7 May 2015 13:24:25 -0400 (EDT)
In-Reply-To: <1430988248-18285-10-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Thu, 7 May 2015 16:44:05 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8A423D2-F4DD-11E4-9FBC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268556>

Paul Tan <pyokagan@gmail.com> writes:

> At this point, the HEAD of super/submodule/ is a direct descendent of
> submodule/ and thus a fast-forward merge can occur. There is no need to
> rebase.
>
> Call "git pull" instead of "git pull --rebase" in order to reduce
> dependence on git-pull's functionality, and thus prevent the whole test suite
> from failing when git-pull is rewritten to C.

Almost the same comment as 07/12 applies here.  "when the pull would
result in fast-forward, 'pull' and 'pull --rebase' results in
exactly the same history" is something we would want to have in the
test suite for 'git pull', and it is perfectly fine to lose the
invocation of 'pull --rebase' from here.

Having said all that.

If 'git pull' gets broken, it will break this test _anyway_.  Unless
the operating assumption is "it is OK to break 'git pull --rebase',
as long as we do not break 'git pull', while rewriting it", I am not
sure the value of the change in this patch.  We'd need to keep both
form working, no?

>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>     * This is a new patch in the patch series.
>
>  t/t7406-submodule-update.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index dda3929..e38d830 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -44,7 +44,7 @@ test_expect_success 'setup a submodule tree' '
>  	) &&
>  	(cd super &&
>  	 (cd submodule &&
> -	  git pull --rebase origin
> +	  git pull origin
>  	 ) &&
>  	 git add submodule &&
>  	 git commit -m "submodule update"
