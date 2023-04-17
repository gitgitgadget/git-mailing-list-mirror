Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743E0C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDQVaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDQVaL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:30:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F593
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:30:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v9so32695880pjk.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681767010; x=1684359010;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7ks2yABbbUHkPE9sJ7psDYY+arO5fb8JKY598bLO5w=;
        b=CkxJJCdZK+TgKgTugdw7NCG5/A6lIXWJgPew3kIEoiRgmczlwEuu3nf3dFYPasKplI
         eRkzLfP+6Ng5PfOw0nXiiTX3Fbdni5xAe9NuAhSc+wTu2bIeVy35UwRnvo2m2CdP3QZX
         iY2ZGG+TobtkMIgUCppnLRUhZSs5REL5daibeaTDePovvBN4Jr4+X1CANUjVx0swbfSh
         0M9T0QoRZMWCIXvMK8GRH1Kfq/qmTVB/iDEj7nw8F61mVEyepl0VC+2fzyj0NnHR9f5V
         6dUL1Jy4lNZ8ZRqeovRpq3otc0tGz+46rSZ+2m81ysLS3TakeUfFzQ0od68oGdsl0ZAH
         NrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681767010; x=1684359010;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m7ks2yABbbUHkPE9sJ7psDYY+arO5fb8JKY598bLO5w=;
        b=WOJksPODsXYGy0ZyU8hHOt3H6smLBUokcIFpzOs4mWvVhdiV4ddxHs1l88Hl/FZpFc
         tM23V3v5WcctVEyqeMqKKgXVy99fSK75fe1NAeMi5rxMfhZvdh8tFjHGXZKjZBK3p6NP
         LJOXv2ATgWIfN0Kzhh6BtsAXhKxl0jxMF4n6zYHkhTjMrqysKe3RQq4f74qs7gOdc9h/
         IHq/4PjocZ6hDRJpuVDds36E3hsz8GKKG9gC8PMfbNAiYZw8QLJOmmXe6gfzqGefeY+N
         zHiQPf6KElWnJuQiS9jyanus+3x5qgVA2sXRTM/+fq7pkdA8T2TYdaTvVN34FCrks8/u
         X4xg==
X-Gm-Message-State: AAQBX9e6jd0CybhoHqzv0C1FI8pSYQw6Wxtb3Dwb2jaTN/Ajic/8ubF9
        9hOrjDt3QbEofFC2/fxjC4E=
X-Google-Smtp-Source: AKy350ae+Y/l9a/Qetmy8xjxAL05CQjXLEsdKkNvKK7tFxmNvdUnRmteNSQhjnpTe+uaCGbhQrQ+IA==
X-Received: by 2002:a05:6a21:7893:b0:f0:93d9:9c03 with SMTP id bf19-20020a056a21789300b000f093d99c03mr277566pzc.15.1681767009536;
        Mon, 17 Apr 2023 14:30:09 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0063a04905379sm7994576pfe.137.2023.04.17.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:30:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 3/8] t2400: refactor "worktree add" opt exclusion tests
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <20230417093255.31079-4-jacobabel@nullpo.dev>
Date:   Mon, 17 Apr 2023 14:30:08 -0700
In-Reply-To: <20230417093255.31079-4-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Mon, 17 Apr 2023 09:33:52 +0000")
Message-ID: <xmqqmt36jixr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> +# Helper function to test mutually exclusive options.
> +#
> +# Note: Quoted arguments containing spaces are not supported.

Good to have this note here.

> +test_wt_add_excl () {
> +	local opts="$*" &&
> +	test_expect_success "'worktree add' with '$opts' has mutually exclusive options" '
> +		test_when_finished cat actual >&2 &&

Again, I do not think this sends output to the standard output at
the end of this test piece.

> +		test_must_fail git worktree add $opts 2>actual &&
> +		grep -E "fatal:( options)? .* cannot be used together" actual
> +	'
> +}

I do not think this patch is needed (I'd rather see people learn the
trick of running with "-i" and rely on the fact that the trash
directory is left intact to be inspected), but if you must, it may
make more sense to add test_must_contain to make a failed 'grep
"$@"' easier to see, similar to the way that test_must_be_empty
helps a failing 'test !  -s "$1"', something along the lines of ...

	test_must_contain () {
		if ! grep "$@"
		then
			echo "'grep $*' fails; the file contains"
			while test $# != 1
			do
				shift
			done
                        cat "$1"
			return 1
		fi
	}

Thanks.
