From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5801 (remote-helpers): cleanup environment sets
Date: Sun, 20 Apr 2014 15:15:43 -0700
Message-ID: <7vy4yzk5ps.fsf@alter.siamese.dyndns.org>
References: <1398019417-8520-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc005-0008LW-FV
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 00:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbaDTWOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 18:14:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaDTWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 18:14:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE3167EF4E;
	Sun, 20 Apr 2014 18:14:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhKbyigwoXEjBDuf0jhOxA06vzI=; b=ECYyjg
	OFo6W6HSzlQVgEMo94a9EmyA/cbKISS55cmcA7hTy0vJ50xPh+qLb0hO3bkF7qPT
	HuA+dOPxygdcp0Wx7SrKE3BpLQgzdMYyxuyTXlsobXQ2EMxXaSDWv0kkkmKXKiFh
	c2rgTfOkqrxeFbvAVs64kZawe1c/4OKUV4uLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHA/aAIxvBijJ2GLB/yzIOKZB27S55Kq
	UJV0aHGSpAlnHBReHlmiqv4yR5Rd/yixmITiDGQgYz6dU/eibae+Ifmmkq0Je4OL
	n2wVZ+L/PMF7dDJVs/s1N2Ssx/G0e/6gKn9zpxyEj7N5OZaUv7ElB3REtb07zc8R
	1YD39WMLbyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8AAC7EF4D;
	Sun, 20 Apr 2014 18:14:07 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CD9B7EF41;
	Sun, 20 Apr 2014 18:14:05 -0400 (EDT)
In-Reply-To: <1398019417-8520-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sun, 20 Apr 2014 13:43:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 166DA414-C8D9-11E3-8BFD-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246597>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit 512477b (tests: use "env" to run commands with temporary env-var
> settings) missed some variables in the remote-helpers test. Also
> standardize these.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Good.  I was wondering about these myself when juggling some series
that touched this file the other day.

Will queue.  Thanks.


> ---
>  t/t5801-remote-helpers.sh | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
> index 25fd2e7..42d1c66 100755
> --- a/t/t5801-remote-helpers.sh
> +++ b/t/t5801-remote-helpers.sh
> @@ -212,19 +212,17 @@ test_expect_success 'push update refs failure' '
>  	echo "update fail" >>file &&
>  	git commit -a -m "update fail" &&
>  	git rev-parse --verify testgit/origin/heads/update >expect &&
> -	GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" &&
> -	export GIT_REMOTE_TESTGIT_PUSH_ERROR &&
> -	test_expect_code 1 git push origin update &&
> +	test_expect_code 1 env GIT_REMOTE_TESTGIT_FAILURE="non-fast forward" \
> +	git push origin update &&
>  	git rev-parse --verify testgit/origin/heads/update >actual &&
>  	test_cmp expect actual
>  	)
>  '
>  
>  test_expect_success 'proper failure checks for fetching' '
> -	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
> -	export GIT_REMOTE_TESTGIT_FAILURE &&
> -	cd local &&
> -	test_must_fail git fetch 2> error &&
> +	(cd local &&
> +	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 \
> +	git fetch 2> error &&
>  	cat error &&
>  	grep -q "Error while running fast-import" error
>  	)
> @@ -232,7 +230,8 @@ test_expect_success 'proper failure checks for fetching' '
>  
>  test_expect_success 'proper failure checks for pushing' '
>  	(cd local &&
> -	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all
> +	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 \
> +	git push --all
>  	)
>  '
