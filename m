From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] t/t5505-remote: test url-with-# in branches-file
Date: Fri, 21 Jun 2013 15:28:40 -0700
Message-ID: <7vwqpnjdyf.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:28:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9p1-0001vJ-Gu
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423461Ab3FUW2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:28:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422881Ab3FUW2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:28:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1272AC49;
	Fri, 21 Jun 2013 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=38SW8/VDzvMvXFHce0m1+L0HkkQ=; b=nTiJ3F
	qb6KABvKXfmYEdlJL3Xkn/SE9tauIc5FzTUx5xzbE/V3pevLD0BWQfJL0aHzSSdi
	N4Ix+CTPwodzNL4KEKz768mub+pVaxkIL9pT2eqix7YF6xU0MnMZNyZKjcK9c05S
	4nHR2j9hw9YFsJRZ+TRcPmSSG6vl8qqtNiyVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ubr4vnZJQnAB8QnilExDcMIFuMlBOVcR
	gWv064368HG36gIqc85CmElczkyMwkv3eepZkI7doP3YHcOguSkRkCmExd1n/POG
	g2YnuTUQUUHr08WprePHV2oCDdPvDiRMG8DPiQxFPl1cU+gxANG25ltT5/6BdKLN
	w5T30t2mMyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73D522AC48;
	Fri, 21 Jun 2013 22:28:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3CED2AC47;
	Fri, 21 Jun 2013 22:28:41 +0000 (UTC)
In-Reply-To: <1371813160-4200-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:30 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED4466AA-DAC1-11E2-977E-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228664>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Add one more test similar to "migrate a remote from named file in
> $GIT_DIR/branches" to check that a url with a # can be used to specify
> the branch name (as opposed to the constant "master").
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5505-remote.sh | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index fd0a81e..93e11c8 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -702,27 +702,42 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
>  	)
>  '
>  
> -test_expect_success 'remote prune to cause a dangling symref' '
> +test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
>  	git clone one seven &&
> +	origin_url=$(pwd)/one &&

The variable assigned here does not seem to get used.  Is this needed?

> +	(
> +		cd seven &&
> +		git remote rm origin &&
> +		echo "quux#foom" > .git/branches/origin &&
> +		git remote rename origin origin &&
> +		test_path_is_missing .git/branches/origin &&
> +		test "$(git config remote.origin.url)" = "quux" &&
> +		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin"
> +		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
> +	)
> +'
> +
> +test_expect_success 'remote prune to cause a dangling symref' '
> +	git clone one eight &&
>  	(
>  		cd one &&
>  		git checkout side2 &&
>  		git branch -D master
>  	) &&
>  	(
> -		cd seven &&
> +		cd eight &&
>  		git remote prune origin
>  	) >err 2>&1 &&
>  	test_i18ngrep "has become dangling" err &&
>  
>  	: And the dangling symref will not cause other annoying errors &&
>  	(
> -		cd seven &&
> +		cd eight &&
>  		git branch -a
>  	) 2>err &&
>  	! grep "points nowhere" err &&
>  	(
> -		cd seven &&
> +		cd eight &&
>  		test_must_fail git branch nomore origin
>  	) 2>err &&
>  	grep "dangling symref" err
