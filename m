From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t/t5516-fetch-push: use test_config()
Date: Fri, 21 Jun 2013 15:32:52 -0700
Message-ID: <7vobazjdrf.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:32:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9t5-0006Kh-Ba
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423633Ab3FUWcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:32:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422881Ab3FUWcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:32:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99CE12AD84;
	Fri, 21 Jun 2013 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P6lTWuFvLnxUOsKHEzdkyr+HrYQ=; b=ANYZ+O
	FyOAO6Q2GNmcxGXw2Fmw7qRD67AVAi9J/rsKXXrVarANrvVZgxsi9IGuZMshajFQ
	aF8m7XWb1RgOsfYdXBsZNr7W7qqilO/MfJP8w+Cm0wvUyElEaCpyhM9OeIciXKY0
	cE6jxyDqkCY27EixVabPi2HeeoAcnO4csvE1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0iiXLTL48gbK+zxeUfRSGgKGevZgu/l
	+D6QEBsH4RnWrLN7uMaFykFYl3pJAs6ZEjC1zrgCR5J6+0dGMF27Vceulifib8nc
	tkyWxelEnYSf1sexlahd0sTQ9rvKGCc1c1oA07T9MkCVjPqvIyDkFsNfScXN5hRL
	ldn3FJN7XCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F02B2AD83;
	Fri, 21 Jun 2013 22:32:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5FB52AD82;
	Fri, 21 Jun 2013 22:32:53 +0000 (UTC)
In-Reply-To: <1371813160-4200-9-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 836615D4-DAC2-11E2-85F4-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228666>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Replace the 'git config' calls in tests with test_config for greater
> robustness.

That may be a good thing in principle, but I _think_

	mk_empty testrepo &&
        (
        	cd testrepo &&
                do whatever to its config &&
                run test
	)

sequence is used so that we do not even have to worry about what
leftover configuration values are in the testrepo/.git/config; so
does it really matter?

If this conversion had something more than "s/git config/test_config/"
replacement, that would indicate that you uncovered a bug in the
existing test and found a good fix, but that does not seem to be the
case for this particular patch.

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5516-fetch-push.sh | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 6e9fa84..afb25c4 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -142,8 +142,8 @@ test_expect_success 'fetch with wildcard' '
>  	mk_empty testrepo &&
>  	(
>  		cd testrepo &&
> -		git config remote.up.url .. &&
> -		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
> +		test_config remote.up.url .. &&
> +		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
>  		git fetch up &&
>  
>  		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
> @@ -157,9 +157,9 @@ test_expect_success 'fetch with insteadOf' '
>  	(
>  		TRASH=$(pwd)/ &&
>  		cd testrepo &&
> -		git config "url.$TRASH.insteadOf" trash/ &&
> -		git config remote.up.url trash/. &&
> -		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
> +		test_config "url.$TRASH.insteadOf" trash/ &&
> +		test_config remote.up.url trash/. &&
> +		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
>  		git fetch up &&
>  
>  		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
> @@ -173,9 +173,9 @@ test_expect_success 'fetch with pushInsteadOf (should not rewrite)' '
>  	(
>  		TRASH=$(pwd)/ &&
>  		cd testrepo &&
> -		git config "url.trash/.pushInsteadOf" "$TRASH" &&
> -		git config remote.up.url "$TRASH." &&
> -		git config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
> +		test_config "url.trash/.pushInsteadOf" "$TRASH" &&
> +		test_config remote.up.url "$TRASH." &&
> +		test_config remote.up.fetch "refs/heads/*:refs/remotes/origin/*" &&
>  		git fetch up &&
>  
>  		echo "$the_commit commit	refs/remotes/origin/master" >expect &&
> @@ -780,7 +780,7 @@ test_expect_success 'mixed ref updates, deletes, invalid deletes trigger hooks w
>  
>  test_expect_success 'allow deleting a ref using --delete' '
>  	mk_test testrepo heads/master &&
> -	(cd testrepo && git config receive.denyDeleteCurrent warn) &&
> +	(cd testrepo && test_config receive.denyDeleteCurrent warn) &&
>  	git push testrepo --delete master &&
>  	(cd testrepo && test_must_fail git rev-parse --verify refs/heads/master)
>  '
> @@ -809,7 +809,7 @@ test_expect_success 'warn on push to HEAD of non-bare repository' '
>  	(
>  		cd testrepo &&
>  		git checkout master &&
> -		git config receive.denyCurrentBranch warn
> +		test_config receive.denyCurrentBranch warn
>  	) &&
>  	git push testrepo master 2>stderr &&
>  	grep "warning: updating the current branch" stderr
> @@ -820,7 +820,7 @@ test_expect_success 'deny push to HEAD of non-bare repository' '
>  	(
>  		cd testrepo &&
>  		git checkout master &&
> -		git config receive.denyCurrentBranch true
> +		test_config receive.denyCurrentBranch true
>  	) &&
>  	test_must_fail git push testrepo master
>  '
> @@ -830,8 +830,8 @@ test_expect_success 'allow push to HEAD of bare repository (bare)' '
>  	(
>  		cd testrepo &&
>  		git checkout master &&
> -		git config receive.denyCurrentBranch true &&
> -		git config core.bare true
> +		test_config receive.denyCurrentBranch true &&
> +		test_config core.bare true
>  	) &&
>  	git push testrepo master 2>stderr &&
>  	! grep "warning: updating the current branch" stderr
> @@ -842,7 +842,7 @@ test_expect_success 'allow push to HEAD of non-bare repository (config)' '
>  	(
>  		cd testrepo &&
>  		git checkout master &&
> -		git config receive.denyCurrentBranch false
> +		test_config receive.denyCurrentBranch false
>  	) &&
>  	git push testrepo master 2>stderr &&
>  	! grep "warning: updating the current branch" stderr
> @@ -918,7 +918,7 @@ test_expect_success 'push into aliased refs (consistent)' '
>  		cd child1 &&
>  		git branch foo &&
>  		git symbolic-ref refs/heads/bar refs/heads/foo
> -		git config receive.denyCurrentBranch false
> +		test_config receive.denyCurrentBranch false
>  	) &&
>  	(
>  		cd child2 &&
> @@ -940,7 +940,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
>  		cd child1 &&
>  		git branch foo &&
>  		git symbolic-ref refs/heads/bar refs/heads/foo
> -		git config receive.denyCurrentBranch false
> +		test_config receive.denyCurrentBranch false
>  	) &&
>  	(
>  		cd child2 &&
> @@ -1006,7 +1006,7 @@ test_expect_success 'push --porcelain rejected' '
>  	git push testrepo refs/heads/master:refs/remotes/origin/master &&
>  	(cd testrepo &&
>  		git reset --hard origin/master^
> -		git config receive.denyCurrentBranch true) &&
> +		test_config receive.denyCurrentBranch true) &&
>  
>  	echo >.git/foo  "To testrepo"  &&
>  	echo >>.git/foo "!	refs/heads/master:refs/heads/master	[remote rejected] (branch is currently checked out)" &&
> @@ -1020,7 +1020,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
>  	git push testrepo refs/heads/master:refs/remotes/origin/master &&
>  	(cd testrepo &&
>  		git reset --hard origin/master
> -		git config receive.denyCurrentBranch true) &&
> +		test_config receive.denyCurrentBranch true) &&
>  
>  	echo >.git/foo  "To testrepo"  &&
>  	echo >>.git/foo "!	refs/heads/master^:refs/heads/master	[rejected] (non-fast-forward)" &&
> @@ -1052,7 +1052,7 @@ do
>  		mk_test testrepo heads/master hidden/one hidden/two hidden/three &&
>  		(
>  			cd testrepo &&
> -			git config $configsection.hiderefs refs/hidden
> +			test_config $configsection.hiderefs refs/hidden
>  		) &&
>  
>  		# push to unhidden ref succeeds normally
> @@ -1078,7 +1078,7 @@ test_expect_success 'fetch exact SHA1' '
>  	git push testrepo master:refs/hidden/one &&
>  	(
>  		cd testrepo &&
> -		git config transfer.hiderefs refs/hidden
> +		test_config transfer.hiderefs refs/hidden
>  	) &&
>  	check_push_result testrepo $the_commit hidden/one &&
>  
> @@ -1098,7 +1098,7 @@ test_expect_success 'fetch exact SHA1' '
>  		# the server side can allow it to succeed
>  		(
>  			cd ../testrepo &&
> -			git config uploadpack.allowtipsha1inwant true
> +			test_config uploadpack.allowtipsha1inwant true
>  		) &&
>  
>  		git fetch -v ../testrepo $the_commit:refs/heads/copy &&
> @@ -1126,8 +1126,8 @@ test_expect_success 'fetch follows tags by default' '
>  	(
>  		cd dst &&
>  		git remote add origin ../src &&
> -		git config branch.master.remote origin &&
> -		git config branch.master.merge refs/heads/master &&
> +		test_config branch.master.remote origin &&
> +		test_config branch.master.merge refs/heads/master &&
>  		git pull &&
>  		git for-each-ref >../actual
>  	) &&
