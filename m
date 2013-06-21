From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/16] t/t5516-fetch-push: don't use branches-file
Date: Fri, 21 Jun 2013 15:29:58 -0700
Message-ID: <7vsj0bjdw9.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:30:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9qL-0003RX-GD
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423615Ab3FUWaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:30:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422881Ab3FUWaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:30:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1BA2AC9B;
	Fri, 21 Jun 2013 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iq93RK3zOqO0e7wjILj0jKMqagY=; b=FEtikP
	uRwq0Ka+TQYdgroCysKPKekMUYgB43APFgaOdc9PnHmnci0FxaovGQJNqCCyoS8f
	TMmxPRryvJ0cGq4vdYGSa2e/+0w55l338fgOvWuMqklU9Vd04XeJ9fkhNN1KhqUa
	9Vk6W4d1pIXACjoC60LyH5TxDQpBMdYBHn0sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6JnweiI00eXTKZBWngr+67rGz/AJ4cy
	Q3l82EtnHZkKXdcq0Cc98G2FXkiZnPnTnfqKfxCiLT7xqDfC1pR6B+gocEI5FK/F
	Nwew3Wb3lrZhKv2qEHwxtWYSv11xzKw6BKK9vfWMteKVOW6Y2/vsgj2NZxa9DUBf
	JwTx4F+Y/6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E9602AC99;
	Fri, 21 Jun 2013 22:30:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CA512AC98;
	Fri, 21 Jun 2013 22:30:00 +0000 (UTC)
In-Reply-To: <1371813160-4200-8-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C1068E4-DAC2-11E2-8AB4-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228665>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Four tests exercising fetch and push functionality unnecessarily depend
> on $GIT_DIR/branches files.  Modern Git does not encourage the use of
> those files, and the parser remote.c:read_branches_file() is only
> provided for backward compatibility with older repositories.  We already
> have tests in t/t5505-remote to verify that the parser works: so,
> substitute the $GIT_DIR/branches configuration with an equivalent
> gitconfig-style configuration, using the results of those tests.

As we are not deprecating, I think we agree we would prefer to keep
these working.  If we need tests using remotes/ or config, they
should be added as their own tests, not by removing branches/ one.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4691d51..6e9fa84 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -852,9 +852,11 @@ test_expect_success 'fetch with branches' '
>  	mk_empty testrepo &&
>  	git branch second $the_first_commit &&
>  	git checkout second &&
> -	echo ".." > testrepo/.git/branches/branch1 &&
>  	(
>  		cd testrepo &&
> +		test_config remote.branch1.url ".."  &&
> +		test_config remote.branch1.fetch "refs/heads/master:refs/heads/branch1"  &&
> +		test_config remote.branch1.push "HEAD:refs/heads/master"  &&
>  		git fetch branch1 &&
>  		echo "$the_commit commit	refs/heads/branch1" >expect &&
>  		git for-each-ref refs/heads >actual &&
> @@ -865,9 +867,11 @@ test_expect_success 'fetch with branches' '
>  
>  test_expect_success 'fetch with branches containing #' '
>  	mk_empty testrepo &&
> -	echo "..#second" > testrepo/.git/branches/branch2 &&
>  	(
>  		cd testrepo &&
> +		test_config remote.branch2.url ".."  &&
> +		test_config remote.branch2.fetch "refs/heads/second:refs/heads/branch2"  &&
> +		test_config remote.branch2.push "HEAD:refs/heads/second"  &&
>  		git fetch branch2 &&
>  		echo "$the_first_commit commit	refs/heads/branch2" >expect &&
>  		git for-each-ref refs/heads >actual &&
> @@ -879,7 +883,9 @@ test_expect_success 'fetch with branches containing #' '
>  test_expect_success 'push with branches' '
>  	mk_empty testrepo &&
>  	git checkout second &&
> -	echo "testrepo" > .git/branches/branch1 &&
> +	test_config remote.branch1.url testrepo &&
> +	test_config remote.branch1.fetch "refs/heads/master:refs/heads/branch1" &&
> +	test_config remote.branch1.push "HEAD:refs/heads/master" &&
>  	git push branch1 &&
>  	(
>  		cd testrepo &&
> @@ -891,7 +897,9 @@ test_expect_success 'push with branches' '
>  
>  test_expect_success 'push with branches containing #' '
>  	mk_empty testrepo &&
> -	echo "testrepo#branch3" > .git/branches/branch2 &&
> +	test_config remote.branch2.url testrepo &&
> +	test_config remote.branch2.fetch "refs/heads/branch3:refs/heads/branch2" &&
> +	test_config remote.branch2.push "HEAD:refs/heads/branch3" &&
>  	git push branch2 &&
>  	(
>  		cd testrepo &&
