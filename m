Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C4FC433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 17:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiDWRPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiDWRPq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 13:15:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751EF1FC0CF
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 10:12:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AF2E1153CB;
        Sat, 23 Apr 2022 13:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WYqZSQOdhqqW
        HLcEWCjFnWeAoHYQE5RA9eEYVrg2htA=; b=Oxt+7Ee313C0fEKJWuaH91LJqGUm
        MFAq6DtMie8+oSpgy71vXMf9NIskzxk5ssi9eQBvudVlwqd1gPD9/1eNoKX5Br8m
        EpePp3Qhq7tuNQT1qRXfrzst7L2f3i4vRZyBxFjXHBkVtrvMp4cC3CXm6c7VQ7JW
        NI3GyH7ycwPPoJw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50FD11153CA;
        Sat, 23 Apr 2022 13:12:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 00F6C11486D;
        Sat, 23 Apr 2022 12:16:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] fixup! CI: use https, not http to download binaries
 from perforce.com
References: <0220423142559.32507-5-carenas@gmail.com>
        <20220423154420.32885-1-carenas@gmail.com>
Date:   Sat, 23 Apr 2022 09:16:31 -0700
In-Reply-To: <20220423154420.32885-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sat, 23 Apr 2022 08:44:20 -0700")
Message-ID: <xmqq8rrv3hcw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BDAC61C6-C320-11EC-B9E6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> Not sure why this is suddently faiing, but this proposed fixup also
> makes both server names consistent and would be easier to clean up
> later.

Yeah, I was wondering why the other one uses a fully hardcoded URL
that these variables do not know about.

Would it make sense to rename LINUX_P4_VERSION to P4_AT_PERFORCE_VERSION
or something and set it also in the macOS section in ci/lib.sh?  We have

	# The Linux build installs the defined dependency versions below.
	# The OS X build installs much more recent versions, whichever
	# were recorded in the Homebrew database upon creating the OS X
	# image.
	# Keep that in mind when you encounter a broken OS X build!
	export LINUX_P4_VERSION=3D"16.2"

which if I am reading your series correctly has become stale; we no
longer rely on brew/cask, and do this for macOS identically to what
we do here for Linux.


> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 98444821729..b8ace0355e2 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -5,7 +5,7 @@
> =20
>  . ${0%/*}/lib.sh
> =20
> -P4WHENCE=3Dhttps://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
> +P4WHENCE=3Dhttps://cdist2.perforce.com/perforce/r$LINUX_P4_VERSION
>  LFSWHENCE=3Dhttps://github.com/github/git-lfs/releases/download/v$LINU=
X_GIT_LFS_VERSION
>  UBUNTU_COMMON_PKGS=3D"make libssl-dev libcurl4-openssl-dev libexpat-de=
v
>   tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-p=
erl
