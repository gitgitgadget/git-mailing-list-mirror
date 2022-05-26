Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E146EC433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 20:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346528AbiEZUQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 16:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiEZUQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 16:16:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CFC5DB9
        for <git@vger.kernel.org>; Thu, 26 May 2022 13:16:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 202D1138229;
        Thu, 26 May 2022 16:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WDjgg8au581c
        BvygvxIkptMWzpAD+fzIZT635QfNJwY=; b=DtpdgIEUPptJ7kLwU2GJmlo/ZfM3
        fcEyb1axy9sjvX/tBVR244GqVcjmaIA83pAhz+foWfQSmWzShns3VRY5mPG2TK7K
        aLD674BiY2jmZYSO4rwX32FP3waq1NHcU+nrXXvn+nwtujhhA4t09QuUn15Krmtl
        bhj+eDGq8In4w1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16661138228;
        Thu, 26 May 2022 16:16:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08C96138225;
        Thu, 26 May 2022 16:16:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 1/7] archive: optionally add "virtual" files
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
        <xmqqfskx5ndd.fsf@gitster.g>
        <7815a07a-da2f-d348-4179-6dc5b1d5fee6@web.de>
        <xmqqee0g1aoz.fsf@gitster.g>
        <ed95b26a-2fa3-d1f7-3142-05719a44a8f7@web.de>
Date:   Thu, 26 May 2022 13:16:04 -0700
In-Reply-To: <ed95b26a-2fa3-d1f7-3142-05719a44a8f7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 May 2022 20:57:49 +0200")
Message-ID: <xmqqfskwxd6j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC4E096E-DD30-11EC-9960-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.=
txt
> index bc4e76a783..10a48ab5f8 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -49,7 +49,9 @@ OPTIONS
>  	Report progress to stderr.
>
>  --prefix=3D<prefix>/::
> -	Prepend <prefix>/ to each filename in the archive.
> +	Prepend <prefix>/ to each filename in the archive.  Can be
> +	specified multiple times; the last one seen when reading from
> +	left to right is applied.

That can be read to mean that we will use C consistently,

$ cmd --prefix=3DA other-args --prefix=3DB other-args --prefix=3DC other-=
args

which was what I am worried to be a source of confusion.

>  -o <file>::
>  --output=3D<file>::
> @@ -58,8 +60,8 @@ OPTIONS
>  --add-file=3D<file>::
>  	Add a non-tracked file to the archive.  Can be repeated to add
>  	multiple files.  The path of the file in the archive is built
> -	by concatenating the value for `--prefix` (if any) and the
> -	basename of <file>.
> +	by concatenating the current value for `--prefix` (if any) and
> +	the basename of <file>.

"the current value for `--prefix` (if any)" would work well once we
somehow make the reader form a mental model that there is "the
current" for the "prefix", which starts with an empty string, and
gets updated every time the "--prefix=3D<prefix>/" option is given.

So, perhaps with

	--prefix=3D<prefix>/::
		The paths of the files in the tree being archived,
		and untracked contents added via the `--add-file`
		and `--add-virtual-file` options, can be modified by
		prepending the "prefix" value that is in effect when
		these options or the tree object is seen on the
		command line.  The "prefix" value initially starts
		as an empty string, and it gets updated every time
		this option is given on the command line.

or something like that, with something like

> +	by concatenating the current value for "prefix" (see `--prefix`
> +	above) and the basename of <file>.

here, it might make it less misunderstanding-prone, hopefully?

> +`git archive -o latest.tar --prefix=3Dbuild/ --add-file=3Dconfigure --=
prefix=3D HEAD`::
> +
> +	Creates a tar archive that contains the contents of the latest
> +	commit on the current branch with no prefix and the untracked
> +	file 'configure' with the prefix 'build/'.

Great to have this example.

Thanks.
