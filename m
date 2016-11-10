Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8348F20229
	for <e@80x24.org>; Thu, 10 Nov 2016 23:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935061AbcKJXxr (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 18:53:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51462 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932739AbcKJXxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 18:53:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3704F87C;
        Thu, 10 Nov 2016 18:53:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fcdaZJNWoqggOxSlXztjySPoBBo=; b=Ipb9W+
        ygVaQeJOhaC8IDB0rYlIJdJ2T8CfjS76y006ELLXcXVAnLtX5C+cwXBSFPmBBitD
        F5tSlJf91aSuzUpRKL4cd34zDecYjzgaY6uQYVPxTrWxODgPxQbbe5wQCEZCoWhm
        31ISsd8hv7NTEJHCuLD6skspu5fEF2u4lmbxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hgX/Fbz7BcuSUaSkvjlpriQgwCUHz9hT
        v0N/68cp7ntGPtyRkN4RR1ZZrvqA9sLgaw42ISmiBgfn9IiuF0SoqQxm5DHkoO76
        eReeE2rFyrjUuntALLpIjRkN4Gz25F9SHBN5jPPNuxUc4ShMoOkgMH4Xu+Kv+4nZ
        7urZzk9gq3I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23E824F87B;
        Thu, 10 Nov 2016 18:53:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 994394F87A;
        Thu, 10 Nov 2016 18:53:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] t6026: ensure that long-running script really is
References: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
Date:   Thu, 10 Nov 2016 15:53:43 -0800
In-Reply-To: <16dc9f159b214997f7501006a8d1d8be2ef858e8.1478699463.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 9 Nov 2016 14:51:22 +0100
        (CET)")
Message-ID: <xmqqfumy51tk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA310612-A7A0-11E6-B177-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When making sure that background tasks are cleaned up in 5babb5b
> (t6026-merge-attr: clean up background process at end of test case,
> 2016-09-07), we considered to let the background task sleep longer, just
> to be certain that it will still be running when we want to kill it
> after the test.
>
> Sadly, the assumption appears not to hold true that the test case passes
> quickly enough to kill the background task within a second.
>
> Simply increase it to an hour. No system can be possibly slow enough to
> make above-mentioned assumption incorrect.
>
> Reported by Andreas Schwab.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/t6026-sleep-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git t6026-sleep-v1

OK, I think this is a much better option.  Assuming 3600 is long
enough for everybody (and if not, we have a bigger problem ;-),
it will ensure that the stray process will be around when we run the
'git merge' test, and by not adding "|| :" after the kill, we check
that the stray process is still there, i.e. we tested what we wanted
to test.

Will revert the two patches that were queued previously and then
queue this one.

Thanks.

>
>  t/t6026-merge-attr.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
> index 7a6e33e..348d78b 100755
> --- a/t/t6026-merge-attr.sh
> +++ b/t/t6026-merge-attr.sh
> @@ -183,16 +183,16 @@ test_expect_success 'up-to-date merge without common ancestor' '
>  
>  test_expect_success 'custom merge does not lock index' '
>  	git reset --hard anchor &&
> -	write_script sleep-one-second.sh <<-\EOF &&
> -		sleep 1 &
> +	write_script sleep-an-hour.sh <<-\EOF &&
> +		sleep 3600 &
>  		echo $! >sleep.pid
>  	EOF
>  	test_when_finished "kill \$(cat sleep.pid)" &&
>  
>  	test_write_lines >.gitattributes \
> -		"* merge=ours" "text merge=sleep-one-second" &&
> +		"* merge=ours" "text merge=sleep-an-hour" &&
>  	test_config merge.ours.driver true &&
> -	test_config merge.sleep-one-second.driver ./sleep-one-second.sh &&
> +	test_config merge.sleep-an-hour.driver ./sleep-an-hour.sh &&
>  	git merge master
>  '
>  
>
> base-commit: be5a750939c212bc0781ffa04fabcfd2b2bd744e
