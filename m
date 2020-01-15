Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433BC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8252077B
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tQKiGvm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgAOXSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 18:18:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51172 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOXSV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 18:18:21 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC5542EC95;
        Wed, 15 Jan 2020 18:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OD4NjPI7Dx3psduBfp7ABcorXbA=; b=tQKiGv
        m13t3AYo15oRtwvQiHyGCbiqHUZ1b5rwccZUBftmlg7QNHRRk8CB2qzxSLN5XjHI
        wNhF/oGMPqq7BExIlWtguCSi5Np8m4PNk4dwjIuTqhEVS13JUjy5RKBlVHl5zPyW
        JrE9vHclHJnqD84wETDcdNC973Pbww/6tKOFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z07hqn0WIS8iimEks4KfjPGQEm0kfzq3
        J1OS5ZKRkZ2LNfbefWBujauCSs562FiBO7OBcy4P+mWiooySsuunuOH7en9YGuCR
        NTcTT+34fbfzXEh+NYn4LKQrY50h17J80R6aKmySqf4kl+XBsB9riqOYvcS5X0nN
        VfjUlvBu7Rg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C45A02EC94;
        Wed, 15 Jan 2020 18:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 356AA2EC91;
        Wed, 15 Jan 2020 18:18:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
References: <pull.527.git.1579129054234.gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 15:18:14 -0800
In-Reply-To: <pull.527.git.1579129054234.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 15 Jan 2020 22:57:34
        +0000")
Message-ID: <xmqqmuaoia15.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E8597D8-37ED-11EA-8D25-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> With the upgrade, the library names changed from libeay32/ssleay32 to
> libcrypto/libssl.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
>     
>     It was reported [https://github.com/git-for-windows/git/issues/2474] 
>     that the vcpkg project (which we use for MSVC/Visual Studio builds of
>     Git) upgraded [https://github.com/microsoft/vcpkg/pull/8566] OpenSSL
>     from v1.0.x to v1.1.x, including the change of the library names. We
>     need to adjust for that.

The patch text makes me wonder if there needs to be a way to use
either version that happens to be available, so that the version of
Git with this change can work with older vcpkg and vice versa, but
what would I know ;-)

Should this patch directly go to 'master' (or even 'maint' for v2.25
maintenance track)?  I do not see much point in cooking it in 'next'
for an extended period of time.

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-527%2Fdscho%2Fvcpkg-upgraded-to-openssl-v1.1.x-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-527/dscho/vcpkg-upgraded-to-openssl-v1.1.x-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/527
>
>  compat/vcbuild/scripts/clink.pl | 4 ++--
>  contrib/buildsystems/engine.pl  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
> index ec95a3b2d0..d9f71b7cbb 100755
> --- a/compat/vcbuild/scripts/clink.pl
> +++ b/compat/vcbuild/scripts/clink.pl
> @@ -45,9 +45,9 @@
>  	} elsif ("$arg" eq "-liconv") {
>  		push(@args, "libiconv.lib");
>  	} elsif ("$arg" eq "-lcrypto") {
> -		push(@args, "libeay32.lib");
> +		push(@args, "libcrypto.lib");
>  	} elsif ("$arg" eq "-lssl") {
> -		push(@args, "ssleay32.lib");
> +		push(@args, "libssl.lib");
>  	} elsif ("$arg" eq "-lcurl") {
>  		my $lib = "";
>  		# Newer vcpkg definitions call this libcurl_imp.lib; Do we
> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index fba8a3f056..070978506a 100755
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -343,9 +343,9 @@ sub handleLinkLine
>          } elsif ("$part" eq "-lz") {
>              push(@libs, "zlib.lib");
>          } elsif ("$part" eq "-lcrypto") {
> -            push(@libs, "libeay32.lib");
> +            push(@libs, "libcrypto.lib");
>          } elsif ("$part" eq "-lssl") {
> -            push(@libs, "ssleay32.lib");
> +            push(@libs, "libssl.lib");
>          } elsif ("$part" eq "-lcurl") {
>              push(@libs, "libcurl.lib");
>          } elsif ("$part" eq "-lexpat") {
>
> base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
