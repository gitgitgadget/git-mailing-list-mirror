Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51405C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A2E22CA1
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mkQnw8vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHCTnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:43:33 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57327 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 15:43:33 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E569BF518E;
        Mon,  3 Aug 2020 15:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ErOKWAD5HaWIH2/TW6K+U9GZpKo=; b=mkQnw8
        vPrGfKWO/othXcc73Wq89lcdGib0N9tdy7hJurLKdL6x2TuY5DxwxiidxarEqtqk
        vNAj+mC07BkqORV3+mz1FGGSHLgT/oriUBTmWfuQOSmRFZCqna7+whI+OAdWX/PZ
        48mSc5wwoO9mk2jaKq04gz+4rfBL8lwYGXcYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CLhlbrqv/KQ58Y5BrEgYTx0xVOUMOO4Y
        9T+cy9H0g8FN0+nSsvhPQ1Jj2fioAE3l0JW2OJnvrYbQ/jqJv712gFiY1ll2uO+g
        BX6TQMqRre7Nz2ZHngWkLIUg4X10teVA2fOUaoSY8q+P8uqI+dFfjdVjDj/LF6se
        ugIqhpX2wEE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDAD1F518D;
        Mon,  3 Aug 2020 15:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D42DF518C;
        Mon,  3 Aug 2020 15:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Subject: Re: [PATCH] Revert "contrib: subtree: adjust test to change in fmt-merge-msg"
References: <20200803185749.1441344-1-emilyshaffer@google.com>
Date:   Mon, 03 Aug 2020 12:43:25 -0700
In-Reply-To: <20200803185749.1441344-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 3 Aug 2020 11:57:49 -0700")
Message-ID: <xmqqlfivv7ky.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99AEA278-D5C1-11EA-8E1A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> This reverts commit 508fd8e8baf3e18ee40b2cf0b8899188a8506d07.
>
> In 6e6029a8 (fmt-merge-msg: allow merge destination to be omitted again)
> we get back the behavior where merges against 'master', by default, do
> not include "into 'master'" at the end of the merge message. This test
> fix is no longer needed.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>
> I don't think anybody else sent this yet. Because the default value of
> merge.suppressDest suppresses 'master', the commit messages are wrong
> again for these tests. Noticed during a release for $DAYJOB. Thanks -
> looks like Linus was right that we get to remove lots more instances of
> 'master' from codebase with that config patch.

I as many others personally do not care about subtree and normally
do not run its tests, so it is understandable that this was missed.
Thanks for catching.

I wonder if it makes more sense to move this (or other tests in
contrib/ if any) in the normal test suite so that we'd notice its
breakage, though.

>  contrib/subtree/t/t7900-subtree.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 53d7accf94..57ff4b25c1 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -196,8 +196,7 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
>  		cd "$subtree_test_count" &&
>  		git fetch ./"sub proj" master &&
>  		git subtree merge --prefix="sub dir" FETCH_HEAD &&
> -		check_equal "$(last_commit_message)" \
> -			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> +		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
>  	)
>  '
>  
> @@ -274,8 +273,7 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
>  		cd "$test_count" &&
>  		git fetch ./subproj master &&
>  		git subtree merge --prefix=subdir/ FETCH_HEAD &&
> -		check_equal "$(last_commit_message)" \
> -			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
> +		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
>  	)
>  '
