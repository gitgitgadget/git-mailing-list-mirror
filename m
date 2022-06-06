Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B4DC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiFFTvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiFFTvE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:51:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081A65D1
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:51:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1064019FDB4;
        Mon,  6 Jun 2022 15:51:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZHRUk+WoBWze
        AAauidAMZWT67LWrLW4cLGcSqMO5fyk=; b=sHGNZPz4vTCWO1xMHLSI+L5F9CQB
        1+zKkhrxHAtaGeiQVMxSdBz8/jBEQzJqL5SwWXyFFTfG9+dF78tUUWyPz8RzTUtY
        gBN9nM/BtlMrFYb3JK5q7tjWfJMankxIsMoNxvYzxXFplMF4OJWLxNOCTAGcRrl3
        IaIHlOzzVjikF+I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F29F619FDB3;
        Mon,  6 Jun 2022 15:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 710B019FDAE;
        Mon,  6 Jun 2022 15:50:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v13 6/7] core doc: modernize core.bigFileThreshold
 documentation
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-6.7-5ed79c58b18-20220604T095113Z-avarab@gmail.com>
Date:   Mon, 06 Jun 2022 12:50:58 -0700
In-Reply-To: <patch-v13-6.7-5ed79c58b18-20220604T095113Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 4 Jun
 2022 12:10:27
        +0200")
Message-ID: <xmqqpmjl6065.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FCDAAAA0-E5D1-11EC-B689-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> So let's attempt to summarize 12 years of changes in behavior, which
> can be seen with:
>
>     git log --oneline -Gbig_file_thre 5eef828bc03.. -- '*.c'
>
> To do that turn this into a bullet-point list. The summary Han Xin
> produced in [1] helped a lot, but is a bit too detailed for
> documentation aimed at users. Let's instead summarize how
> user-observable behavior differs, and generally describe how we tend
> to stream these files in various commands.

Nicely studied.  Very much appreciated.

>  core.bigFileThreshold::
> -	Files larger than this size are stored deflated, without
> -	attempting delta compression.  Storing large files without
> -	delta compression avoids excessive memory usage, at the
> -	slight expense of increased disk usage. Additionally files
> -	larger than this size are always treated as binary.
> +	The size of files considered "big", which as discussed below
> +	changes the behavior of numerous git commands, as well as how
> +	such files are stored within the repository. The default is
> +	512 MiB. Common unit suffixes of 'k', 'm', or 'g' are
> +	supported.
>  +
> -Default is 512 MiB on all platforms.  This should be reasonable
> -for most projects as source code and other text files can still
> -be delta compressed, but larger binary media files won't be.
> +Files above the configured limit will be:
>  +
> -Common unit suffixes of 'k', 'm', or 'g' are supported.
> +* Stored deflated, without attempting delta compression.

"even in packfiles" (with or without "even") is better be there in
the sentence---loose objects are always stored deflated anyway.

> +The default limit is primarily set with this use-case in mind. With it
> +most projects will have their source code and other text files delta
> +compressed, but not larger binary media files.
> ++
> +Storing large files without delta compression avoids excessive memory
> +usage, at the slight expense of increased disk usage.

> +* Will be treated as if though they were labeled "binary" (see
> +  linkgit:gitattributes[5]). This means that e.g. linkgit:git-log[1]
> +  and linkgit:git-diff[1] will not diffs for files above this limit.

Good.  You can lose three words "This means that" and the sentence
means the same thing, so lose them (I always recommend people to
reread the sentence when they write "This means that" with an eye to
rewrite it better---it often is a sign that either the previous
sentence is insufficiently clear, in which case it can be discarded
and description after the three words can be enhanced to a better
result).

> +* Will be generally be streamed when written, which avoids excessive
> +memory usage, at the cost of some fixed overhead. Commands that make
> +use of this include linkgit:git-archive[1],
> +linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
> +linkgit:git-fsck[1].

Nice.  And this series adds unpack-objects to the mix.

>  core.excludesFile::
>  	Specifies the pathname to the file that contains patterns to

Excellent.

Thanks.
