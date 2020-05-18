Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F3AC433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AF8207D4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lIPH1642"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgERXeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 19:34:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59704 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgERXeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:34:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF2AAC1C86;
        Mon, 18 May 2020 19:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kyxqM/6FAoaAhpw/k4WaUI6RbLg=; b=lIPH16
        42Kj2ziNO97ww1aV4yEKGj5176Ox5ELbnaMmx6yvkpcvmBh4NWxfTIHdHFe1ARzn
        js9OI4NYt/RuZFlIX/2WCc+UqX3DWlj9mCP/2LfWTNRAnwz/4PfQwBjV2Ex2htkr
        1AzEIp9UFKduXFyHtSVbqimDGWOFXrhRIaVYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=imj3VjJlbUnMS+kgAkoZSdSuvpXA7n6q
        xduVGodC87xUoPTPDoW7z+RSzRHE+hyNJoo9aOe1yJFwVSBMzXADwNfkv83vA0Ad
        5WNEuUxeYLtSNeAMLZCH9iDzwA93r/vhix/LSjj03Vq/t8FB2OrWU+FxTI4fzVwb
        naSaFY92Ss8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A826EC1C85;
        Mon, 18 May 2020 19:34:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE582C1C84;
        Mon, 18 May 2020 19:34:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 02/13] t: use update-ref and show-ref to reading/writing refs
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <dbf45fe8753c5782f1d1d87d2da47bf72b086506.1589226388.git.gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 16:34:08 -0700
In-Reply-To: <dbf45fe8753c5782f1d1d87d2da47bf72b086506.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:17 +0000")
Message-ID: <xmqq8sho24y7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12D2ABC0-9960-11EA-9BE1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Reading and writing .git/refs/* assumes that refs are stored in the 'files'
> ref backend.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t0002-gitfile.sh             |  2 +-
>  t/t1400-update-ref.sh          | 32 ++++++++++++++++----------------
>  t/t1506-rev-parse-diagnosis.sh |  2 +-
>  t/t6050-replace.sh             |  2 +-
>  t/t9020-remote-svn.sh          |  4 ++--
>  5 files changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 0aa9908ea12..960ed150cb5 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -62,7 +62,7 @@ test_expect_success 'check commit-tree' '
>  '
>  
>  test_expect_success 'check rev-list' '
> -	echo $SHA >"$REAL/HEAD" &&
> +	git update-ref "HEAD" "$SHA" &&
>  	test "$SHA" = "$(git rev-list HEAD)"
>  '
>  
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index e1197ac8189..27171f82612 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -37,15 +37,15 @@ test_expect_success setup '
>  
>  test_expect_success "create $m" '
>  	git update-ref $m $A &&
> -	test $A = $(cat .git/$m)
> +	test $A = $(git show-ref -s --verify $m)

All of the above looks good.  These were written long time ago, and
we should have cleaned them up much earlier, but we didn't.

> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index 52edcbdcc32..dbf690b9c1b 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -207,7 +207,7 @@ test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
>  	{
>  		# we do not want to use rev-parse here, because
>  		# we are testing it
> -		cat .git/refs/heads/foobar &&
> +		git show-ref -s refs/heads/foobar &&
>  		printf "%s\n" --

Likewise.

>  	} >expect &&
>  	git rev-parse foobar -- >actual &&
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index e7e64e085dd..c80dc10b8f1 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -135,7 +135,7 @@ test_expect_success 'tag replaced commit' '
>  test_expect_success '"git fsck" works' '
>       git fsck master >fsck_master.out &&
>       test_i18ngrep "dangling commit $R" fsck_master.out &&
> -     test_i18ngrep "dangling tag $(cat .git/refs/tags/mytag)" fsck_master.out &&
> +     test_i18ngrep "dangling tag $(git show-ref -s refs/tags/mytag)" fsck_master.out &&

Likewise; this has no excuse of being old code ;-)

>       test -z "$(git fsck)"
>  '
>  
> diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
> index 6fca08e5e35..9fcfa969a9b 100755
> --- a/t/t9020-remote-svn.sh
> +++ b/t/t9020-remote-svn.sh
> @@ -48,8 +48,8 @@ test_expect_success REMOTE_SVN 'simple fetch' '
>  '
>  
>  test_debug '
> -	cat .git/refs/svn/svnsim/master
> -	cat .git/refs/remotes/svnsim/master
> +	git show-ref -s refs/svn/svnsim/master
> +	git show-ref -s refs/remotes/svnsim/master
>  '

Looks good.

Thanks.
