From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] t7503/4: Add failing testcases for revert/cherry-pick --no-verify
Date: Wed, 03 Sep 2014 12:28:58 -0700
Message-ID: <xmqqbnqwy03p.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-2-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?= <larsbj@gullik.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 21:29:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPGEu-0000Z4-4L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbaICT3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 15:29:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57624 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548AbaICT3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 15:29:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF438372D4;
	Wed,  3 Sep 2014 15:29:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rq3/FU9pcJRtnuCLF8P/ULOGR04=; b=L9BzAz
	ifzyWHTYpILkn+MJzmUHJ1BUq6xD+Wt0Xp9Mez1/GPMSEosl0jK0m7RfyIrsFYke
	di+aa4QyfWKYH/RvK41+DSGncuI0HjrTLNrmVu+aQnshjq/+SkRYNDb8WGpvYprG
	P9lN3SBIAKMi/qhPjO4uJRV4pSgfWQNeFEnDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLy081gIImSR/aQqw/MKhE1z9yXfg5Ms
	g/acSDyWcOHSPRic/B/51vgSh+FrlWGHyancB05CFklkaJIqDAaI4yelR7xivCBM
	iBavEZESEozODkw039fNFcD4XW3SCuuKqaVB8eGEFaLybWQ8UJufjSEvkU+MdnIx
	AivAG2hVSC0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ADFFF372D3;
	Wed,  3 Sep 2014 15:29:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 237B5372CD;
	Wed,  3 Sep 2014 15:29:00 -0400 (EDT)
In-Reply-To: <1409753034-9459-2-git-send-email-johan@herland.net> (Johan
	Herland's message of "Wed, 3 Sep 2014 16:03:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E34C0A4-33A0-11E4-AE21-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256405>

Johan Herland <johan@herland.net> writes:

> The revert/cherry-pick machinery currently exercises the pre-commit
> and commit-msg hooks. However, where commit accepts a --no-verify
> option to temporarily disable these hooks, the revert and cherry-pick
> commands have no such option.
>
> This patch adds some testcases demonstrating how the --no-verify
> option is supposed when it is added to revert and cherry-pick
> (in the next patch).
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

The added test looks OK; will queue.

We may want to update its style of testing (the shell scripting
style is also bad, but they assume and depend on that the previous
steps have all passed to take the history and the repository into a
certain state without explicit "reset --hard" to allow some previous
steps to fail), though.

Also, do we already test these commands with the --allow-empty
option and/or the --allow-empty-message option, which I think share
the same issue, somewhere in the test suite?  If not, we may want to
while we remember the issue.

Thanks.

>  t/t7503-pre-commit-hook.sh | 24 ++++++++++++++++++++++++
>  t/t7504-commit-msg-hook.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 984889b..adc892b 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -60,6 +60,18 @@ test_expect_success 'with failing hook' '
>  
>  '
>  
> +test_expect_success 'revert with failing hook' '
> +
> +	test_must_fail git revert HEAD
> +
> +'
> +
> +test_expect_success 'cherry-pick with failing hook' '
> +
> +	test_must_fail git cherry-pick --no-verify HEAD^
> +
> +'
> +
>  test_expect_success '--no-verify with failing hook' '
>  
>  	echo "stuff" >> file &&
> @@ -68,6 +80,18 @@ test_expect_success '--no-verify with failing hook' '
>  
>  '
>  
> +test_expect_failure 'revert --no-verify with failing hook' '
> +
> +	git revert --no-verify HEAD
> +
> +'
> +
> +test_expect_failure 'cherry-pick --no-verify with failing hook' '
> +
> +	git cherry-pick --no-verify HEAD^
> +
> +'
> +
>  chmod -x "$HOOK"
>  test_expect_success POSIXPERM 'with non-executable hook' '
>  
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 1f53ea8..4f8b9fe 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -109,6 +109,18 @@ test_expect_success 'with failing hook' '
>  
>  '
>  
> +test_expect_success 'revert with failing hook' '
> +
> +	test_must_fail git revert HEAD
> +
> +'
> +
> +test_expect_success 'cherry-pick with failing hook' '
> +
> +	test_must_fail git cherry-pick --no-verify HEAD^
> +
> +'
> +
>  test_expect_success 'with failing hook (editor)' '
>  
>  	echo "more another" >> file &&
> @@ -126,6 +138,18 @@ test_expect_success '--no-verify with failing hook' '
>  
>  '
>  
> +test_expect_failure 'revert --no-verify with failing hook' '
> +
> +	git revert --no-verify HEAD
> +
> +'
> +
> +test_expect_failure 'cherry-pick --no-verify with failing hook' '
> +
> +	git cherry-pick --no-verify HEAD^
> +
> +'
> +
>  test_expect_success '--no-verify with failing hook (editor)' '
>  
>  	echo "more stuff" >> file &&
