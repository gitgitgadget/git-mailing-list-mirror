Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E319C04A94
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 21:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGaVta (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGaVt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 17:49:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037C9F
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 14:49:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C8DB1A72C4;
        Mon, 31 Jul 2023 17:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3NluCS/dxTapC1JfIfmnabTMQk6MVvgYaEy/F+
        rGdEA=; b=CFYhkZHFycbHyWw5Wry0dpMMqP6Xfwxf6zUEBMBYnrIsuGi3HKmM6E
        ZOydRTTqOKH1gtSpyLqDiWN3tXCdDCqz/8EYfcXoYgMOf+LoTvD/o9Cb2k33lwSH
        Lk5QQi+SrhF5jD8yCFZrvwGg3jiJnBAMFwmySAtghZRcagTlhHBxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13BB61A72C3;
        Mon, 31 Jul 2023 17:49:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FDF91A72C2;
        Mon, 31 Jul 2023 17:49:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Thomas J. Faughnan Jr." <thomas@faughnan.net>,
        "Daniel P." <danpltile@gmail.com>
Subject: Re: [PATCH] ident: don't consider trailing dot crud
References: <ZMghdgIaQB4L88WR@tapette.crustytoothpaste.net>
        <20230731214435.1462098-1-sandals@crustytoothpaste.net>
Date:   Mon, 31 Jul 2023 14:49:25 -0700
In-Reply-To: <20230731214435.1462098-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 31 Jul 2023 21:44:35 +0000")
Message-ID: <xmqqpm4721lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E6A4D1E-2FEC-11EE-B980-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we process a user's name (as in user.name), we strip all trailing
> crud from it.  Right now, we consider a dot trailing crud, and strip it
> off.

We consider a leading or trailing dot crud, I think (applies also to
the title of the patch).  Otherwise the change, together with the
test updates, all look good.

I wonder if this needs some credit to those involved in the original
thread?

Thanks.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  ident.c                       |  1 -
>  t/t4203-mailmap.sh            |  4 ++--
>  t/t7518-ident-corner-cases.sh | 11 ++++++++++-
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/ident.c b/ident.c
> index 08be4d0747..cc7afdbf81 100644
> --- a/ident.c
> +++ b/ident.c
> @@ -203,7 +203,6 @@ void reset_ident_date(void)
>  static int crud(unsigned char c)
>  {
>  	return  c <= 32  ||
> -		c == '.' ||
>  		c == ',' ||
>  		c == ':' ||
>  		c == ';' ||
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index fa7f987284..2016132f51 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -466,7 +466,7 @@ test_expect_success 'gitmailmap(5) example output: example #1' '
>  	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@laptop.(none)>
>  	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
>  
> -	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
> +	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@desktop.(none)>
>  	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
>  	EOF
>  	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
> @@ -494,7 +494,7 @@ test_expect_success 'gitmailmap(5) example output: example #2' '
>  	Author Jane Doe <jane@laptop.(none)> maps to Jane Doe <jane@example.com>
>  	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
>  
> -	Author Jane D <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
> +	Author Jane D. <jane@desktop.(none)> maps to Jane Doe <jane@example.com>
>  	Committer C O Mitter <committer@example.com> maps to C O Mitter <committer@example.com>
>  	EOF
>  	git -C doc log --reverse --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
> diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
> index fffdb6ff2e..9ab2ae2f3b 100755
> --- a/t/t7518-ident-corner-cases.sh
> +++ b/t/t7518-ident-corner-cases.sh
> @@ -20,10 +20,19 @@ test_expect_success 'empty name and missing email' '
>  '
>  
>  test_expect_success 'commit rejects all-crud name' '
> -	test_must_fail env GIT_AUTHOR_NAME=" .;<>" \
> +	test_must_fail env GIT_AUTHOR_NAME=" ,;<>" \
>  		git commit --allow-empty -m foo
>  '
>  
> +test_expect_success 'commit does not strip trailing dot' '
> +	author_name="Pat Doe Jr." &&
> +	env GIT_AUTHOR_NAME="$author_name" \
> +		git commit --allow-empty -m foo &&
> +	git log -1 --format=%an >actual &&
> +	echo "$author_name" >expected &&
> +	test_cmp actual expected
> +'
> +
>  # We must test the actual error message here, as an unwanted
>  # auto-detection could fail for other reasons.
>  test_expect_success 'empty configured name does not auto-detect' '
