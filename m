Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22D420899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbdHKWLS (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:11:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56921 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753791AbdHKWLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:11:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D26DE93CEE;
        Fri, 11 Aug 2017 18:11:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=edaSgRBHoUwa7nqaqAzexEFIYdE=; b=lFb5fz
        n2DFV1zLpbO7riRuZS2jZuhS+vK5C8pYlXQLCE8KUoTg5jBgOat5KTdJMxKrUq33
        ctFEKUnG5MMgxouhPKXtWCTTCXQKQH58PfK4XPx+gLmnwyZ/jqSBiwZDrzPwhAoX
        fCxoNSZIQw3PV4HXQ684Na664SHjPyJbPqUaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v1249ZZ0o2lnKeZ34/fAHOc/9rqFAG9Q
        edK2CboWf1Q4LzymnBrVB99dvCf/QYwbHvmByKYKk6Z32Nb8o4ZcnT5mlXHBOvSm
        vbsAmszOzjtqDn8oV0Bf2tgk4w4aFR4fD8qTg4MznpL6p7SZYMD+i6/4m+Ou9Tn+
        ay0jQKDQM1E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB1FD93CED;
        Fri, 11 Aug 2017 18:11:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37BF093CEA;
        Fri, 11 Aug 2017 18:11:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <sam@whiteoctober.co.uk>
Subject: Re: [PATCH] stash: clean untracked files before reset
References: <CAPuLQgNq_7Kdeio-59cbDjZ5mWC1VRd_1_KK33Gbka9KJ13vfQ@mail.gmail.com>
        <b87007d1-eb5a-f092-9e03-5c6549044b42@morey-chaisemartin.com>
Date:   Fri, 11 Aug 2017 15:11:14 -0700
In-Reply-To: <b87007d1-eb5a-f092-9e03-5c6549044b42@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Fri, 11 Aug 2017 19:14:43
        +0200")
Message-ID: <xmqq60dtzrel.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE030FA0-7EE1-11E7-9245-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> If calling git stash -u on a repo that contains a file that is not
> ignored any more due to a current modification of the gitignore file,
> this file is stashed but not remove from the working tree.
> This is due to git-stash first doing a reset --hard which clears the
> .gitignore file modification and the call git clean, leaving the file
> untouched.
> This causes git stash pop to fail due to the file existing.
>
> This patch simply switches the order between cleaning and resetting
> and adds a test for this usecase.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> Reported-by: Sam Partington <sam@whiteoctober.co.uk>

These two lines are the other way around; a report/finding was made
and then you wrote a fix, which is signed-off by you.

I tried to think of a scenario where it is more desirable to use the
contents of the .gitignore file before modification gets stash away,
but I came up empty, so let's hope that this change will not make
50% people happier while making the other 50% sadder.

> ---
>  git-stash.sh                       | 11 ++++++-----
>  t/t3905-stash-include-untracked.sh | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index 9b6c2da7b..39083b4d9 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -300,6 +300,12 @@ push_stash () {
>  
>  	if test -z "$patch_mode"
>  	then
> +		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> +		if test -n "$untracked"
> +		then
> +			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
> +		fi
> +
>  		if test $# != 0
>  		then
>  			git reset -q -- "$@"
> @@ -309,11 +315,6 @@ push_stash () {
>  		else
>  			git reset --hard -q
>  		fi
> -		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
> -		if test -n "$untracked"
> -		then
> -			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
> -		fi
>  
>  		if test "$keep_index" = "t" && test -n "$i_tree"
>  		then
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 193adc7b6..c1f84d3d5 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -211,4 +211,22 @@ test_expect_success 'stash push with $IFS character' '
>  	test_path_is_file bar
>  '
>  
> +cat > .gitignore <<EOF
> +ignored
> +ignored.d/*
> +EOF
> +
> +test_expect_success 'stash previously ignored file' '
> +which git &&

I will remove this line while queuing, though.

> +	git reset HEAD &&
> +	git add .gitignore &&
> +	git commit -m "Add .gitignore" && 
> +	>ignored.d/foo &&
> +	echo "!ignored.d/foo" >> .gitignore &&
> +	git stash save --include-untracked &&
> +	test_path_is_missing ignored.d/foo &&
> +	git stash pop &&
> +	test_path_is_file ignored.d/foo
> +'
> +
>  test_done

Will queue.  Thanks.

