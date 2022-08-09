Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A89C25B08
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 22:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiHIWCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 18:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHIWBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 18:01:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB282DE6
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660082490;
        bh=qu/I8zrGjZDqHWsOHhW93OtVqPkY3pzpOKm8jqq2Jcs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ELwAgkOzOUJ9EJF49H4hDFGfTn09UOIFGqYKfhFm9LtpV8RFj3cskSmKg77bvds7E
         Q+iaEZiUTZygXO/5LOZOGzNpPR7EskqyOQl3HP9LrF5i6rt9jOQUgPF9770Xaspnil
         U8ANkleDIInY+n1AVXmnqWWVsBqz612GNMIc68LM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWAOQ-1nsKVk18xO-00XgSM; Wed, 10
 Aug 2022 00:01:30 +0200
Date:   Wed, 10 Aug 2022 00:01:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 07/14] merge-one-file: rewrite in C
In-Reply-To: <20220809185429.20098-8-alban.gruin@gmail.com>
Message-ID: <2r992r19-or36-733r-1139-4575n9o6o23s@tzk.qr>
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com> <20220809185429.20098-8-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SDrqZJa+hNdLFZsYLbrZsoeC/NdRdKncMt01kYQogfCYZjaYmRx
 WJyIFpXTfc+IXh0cma0LfUTyXYeXfrbMQiB+PXKCZpZ+sobhtTcOoPmkmMt6sv82EXPiitk
 vw1Pw5MTT0mc01x+pl83Ny93Ra7197ZfpqT36zcX7OtnrH+AmbuF89YXT7Qh1QtUislB0Rr
 q7w2acEueoIADa+gV9S3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mkz0KT3mgx0=:S3YxDtyzsB62VTV/Ml64pI
 jIUKG8VK8s4itV+8qkEbNifW1Som1e4B802i0IFpBCQIVVT2vARHb9hTxPEa3D3IZTwDCy1Qh
 ElYSUD+7+g6l8t9nv/yN2SaHwMSSoDWA+u3UZ+06FTw0Xs9HthJmAIOGsCi5LccOkEtkppmSp
 0keS8EWZUXS7oU5FVJQqWBOj6SXeQH2re2SpRvOaJLAyQgfZK3flR5d9CW0VAlS0JlZaFd01z
 GpOVKIn538nj/0JO8Idj9vmorUYyycp7YaWOv6OGmsSzsPxTgApELRa5j0fT0cNCAw0BOGgxE
 4WcI9q1Xx+kUCn41LwoToacchmIgXWG/7QL2QIX+3YwivQ+UEYg5fKhvRVR7RgtJ/y/+gDZdM
 yG74NoZVqHop2NtpCIi4kL5GKucY7xjJZrbvdoKlyaaFSNu81cyRjBfCECz1B4IcUeJprInFQ
 YMOfRYauEu+UvVsR1VtuSgzVqWnU4M5HB791mfNLBdo6BjQZvLEEWPNrKJLa+HQNwUjz4bbwn
 n4bT/Pv+l3AE8vnxy24svqz/PSdwPFSyK9z24Ti2mRZHcoHlIoz/nQ8pL79TBai2tp21870S+
 mUqBkgbjf642OVNcbz8vP2UxUGX3z2vULZKEvlc97Z3JiXl16tHMFum/Lf9gmUl3jBhlelJAV
 f/0Y7HpXEfdaa/wYDgaUCHCEShAJwMYcso/XXcC6bXDW0dUz9ydR9lXETdVbdJOdDyF/AarXd
 wPUx4GnZZRqROql46SHpH5qxMWg03krHINo6L0N3TBg8iscxvhbwOyeCAcq6BmRK6IAQsclHl
 xg+WVsiqYqqlry41+g+GlSHcUCVaJFE6LrIE/SFUvNlNpxkzwIecGG/4G0e6PLP5+s/DOiRPI
 wlYgLUvzxDGqaw55vp2LKVFlFHWjohxd+QO3dcuVCdNtMOi+1zmyVmoWKrCpJkZbWCKWhfgY7
 pQExgb0cy+3FQWrjtHcMi+f1KCl1lHOLBYlprY9QmN5UKwncgkV4QTLx+8I9afahVb2gwZ6Ki
 0yhxRAY3xBKklkSSmCzZTPwGhX6pI3ctfk9Rqxx+KuFIiF0Z3uB2CcjNxMKp2sugfBcBaooOA
 C2F7KX/JweZEj/lWB3yeyu3is1QGyHhB68iGXP7YIGa5g+RJ/+BUnzsCw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

what an incredible amount of careful work. Thank you for doing this.

A few minor comments:

On Tue, 9 Aug 2022, Alban Gruin wrote:

> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
> new file mode 100644
> index 0000000000..ec718cc1c9
> --- /dev/null
> +++ b/builtin/merge-one-file.c
> @@ -0,0 +1,92 @@
> +/*
> + * Builtin "git merge-one-file"
> + *
> + * Copyright (c) 2020 Alban Gruin

There have been claims that it is still March 2020 (see e.g.
https://ismarchoveryet.com/), but I believe that those are jokes and that
we're really in the year 2022 now. It should be safe to adjust the text
accordingly.

:-)

> [...]
> +int merge_three_way(struct index_state *istate,
> +		    const struct object_id *orig_blob,
> +		    const struct object_id *our_blob,
> +		    const struct object_id *their_blob, const char *path,
> +		    unsigned int orig_mode, unsigned int our_mode, unsigned int their=
_mode)
> +{
> [...]
> +}
> +
> +int merge_one_file_func(struct index_state *istate,
> +			const struct object_id *orig_blob,
> +			const struct object_id *our_blob,
> +			const struct object_id *their_blob, const char *path,
> +			unsigned int orig_mode, unsigned int our_mode, unsigned int their_mo=
de,
> +			void *data)
> +{
> +	return merge_three_way(istate,
> +			       orig_blob, our_blob, their_blob, path,
> +			       orig_mode, our_mode, their_mode);
> +}

I have only read the patch series until this point (and plan on continuing
with the remaining patches tomorrow), so I might be wrong, but... is there
any other user of `merge_three_way()` left? If not (and I suspect this is
the case), then the `merge_three_way()` code could be moved into
`merge_one_file_func()`.

> [...]
> diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
> index 3845a9d3cc..9976996c80 100755
> --- a/t/t6060-merge-index.sh
> +++ b/t/t6060-merge-index.sh
> @@ -70,7 +70,7 @@ test_expect_success 'merge-one-file fails without a wo=
rk tree' '
>  	(cd bare.git &&
>  	 GIT_INDEX_FILE=3D$PWD/merge.index &&
>  	 export GIT_INDEX_FILE &&
> -	 test_must_fail git merge-index git-merge-one-file -a
> +	 test_must_fail git merge-index --use=3Dmerge-one-file -a

This hunk probably wanted to live in [PATCH v8 05/14] merge-index: add a
new way to invoke `git-merge-one-file', but as I pointed out in my reply
to that patch: I do not think that we have to introduce that `--use=3D<...=
>`
option at all.

>  	)
>  '
>
> diff --git a/t/t6415-merge-dir-to-symlink.sh b/t/t6415-merge-dir-to-syml=
ink.sh
> index 2655e295f5..10bc5eb8c4 100755
> --- a/t/t6415-merge-dir-to-symlink.sh
> +++ b/t/t6415-merge-dir-to-symlink.sh
> @@ -99,7 +99,7 @@ test_expect_success SYMLINKS 'a/b was resolved as syml=
ink' '
>  	test -h a/b
>  '
>
> -test_expect_failure 'do not lose untracked in merge (resolve)' '
> +test_expect_success 'do not lose untracked in merge (resolve)' '

Very, very nice.

Thank you!
Dscho

>  	git reset --hard &&
>  	git checkout baseline^0 &&
>  	>a/b/c/e &&
> --
> 2.37.1.412.gcfdce49ffd
>
>
