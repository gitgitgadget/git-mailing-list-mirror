Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A28C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354253AbiE0TB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344647AbiE0TBV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:01:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737DD5F99
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:01:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B18213F1F2;
        Fri, 27 May 2022 15:01:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ggVScXbjDXJH
        X/BWAyeTSe6ala/Qc1cOhrLmGDhhrS8=; b=lYN2fpAMYhev4cro+5Mk/RzS8MWp
        R8vR1Y0q18E6s99IYWyX+LacViFXhrXqRg8EF1HCm77XpWYFbAfLmDkwPMmpKGL3
        uY/lO4LqWHP44E+OYdWDBnLlZ+v5T/mWlJy378WtsFZO7gH0IBKbvek9bzDaCeCv
        UYIggCpH77JuFwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F12C913F1F1;
        Fri, 27 May 2022 15:01:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2834213F1F0;
        Fri, 27 May 2022 15:01:16 -0400 (EDT)
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
        <xmqqfskwxd6j.fsf@gitster.g>
        <71ae5983-6ef8-fe28-46ab-1675e819ce8b@web.de>
Date:   Fri, 27 May 2022 12:01:15 -0700
In-Reply-To: <71ae5983-6ef8-fe28-46ab-1675e819ce8b@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 27 May 2022 19:02:09 +0200")
Message-ID: <xmqqh75a3imc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 628ACDFC-DDEF-11EC-8DB3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>  --prefix=3D<prefix>/::
> -	Prepend <prefix>/ to each filename in the archive.
> +	Prepend <prefix>/ to paths in the archive.  Can be repeated; its
> +	leftmost value is used for all tracked files.  See below which
> +	value gets used by `--add-file`.

Doesn't "the last one wins" take the rightmost one?

> @@ -58,8 +60,9 @@ OPTIONS
>  --add-file=3D<file>::
>  	Add a non-tracked file to the archive.  Can be repeated to add
>  	multiple files.  The path of the file in the archive is built
> -	by concatenating the value for `--prefix` (if any) and the
> -	basename of <file>.
> +	by concatenating the value of the leftmost `--prefix` option to
> +	the right of this `--add-file` (if any) and the basename of
> +	<file>.

It is not what archive.c::add_file_cb() seems to be doing, though

It is passed the pointer to "base" that is on-stack of
parse_archive_args(), which is the same variable that is used to
remember the latest value that was given to "--prefix".  Then it
concatenates the argument it received after that base value, so

    by concatenating the value of the last "--prefix" seen on the
    command line (if any) before this `--add-file` and the basename
    of <file>.

probably.  I always get my left and right mixed up X-<.

> @@ -194,6 +197,12 @@ EXAMPLES
>  	commit on the current branch. Note that the output format is
>  	inferred by the extension of the output file.
>
> +`git archive -o latest.tar --prefix=3Dbuild/ --add-file=3Dconfigure --=
prefix=3D HEAD`::
> +
> +	Creates a tar archive that contains the contents of the latest
> +	commit on the current branch with no prefix and the untracked
> +	file 'configure' with the prefix 'build/'.
> +
>  `git config tar.tar.xz.command "xz -c"`::
>
>  	Configure a "tar.xz" format for making LZMA-compressed tarfiles.

Thanks.

This patch probably needs to come before the "scalar diagnose"
series, which we haven't heard much about recently (no, I am not
complaining---we all heard that Dscho is busy).


