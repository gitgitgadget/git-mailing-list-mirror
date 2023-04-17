Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76516C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQVdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDQVd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 17:33:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D084C558A
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:33:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-247399d518dso364781a91.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 14:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681767195; x=1684359195;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBHVwSqpylZdFTgKVeNqezZu19vp8Z6H/JgF2b/32fk=;
        b=XaUWtHV6z7ecN8Hu295xKOZI31b5sNcZbPLMdh3eiuseBoo5a2LmIkKhzV8EmBbrKH
         DdttpOo7wtd2n9fMlDI5AS9Uj2bxTKigvs7xpeBisdFcyKyNmNW+wfXYn3p2sStW0VSW
         EZobxnYVCAbctltx+GD0izDVOhqNpv/b8GbKrVlzcbJp2CrwrIGz1rkWoHVuHIWpyMkX
         DQ2W6z4BxFUPb3o6u239LoXXK0WqxzKJxM7Ab7hOYg3myZxQRYtoz8dCxw98GihPt7xh
         CIMlS00iwk/H35lAiyNKi1tC2NUtBrVligWKtEjQlZwunNuSQQ5anDZdXtioEWSoGmLO
         WuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681767195; x=1684359195;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dBHVwSqpylZdFTgKVeNqezZu19vp8Z6H/JgF2b/32fk=;
        b=Nr76+OCUB32QAu+q1ayyvSfOHmWNBJf90A/E+jmkWmvwRfkwZAxGgq/iismlSuHuIi
         U2VRt7jssSnj6vswYYdn0hAHDQcL88FnKiychDAjYGiTANPgPlUkd8a2scZQEw6JiIFg
         fiYmKznEj0eOxdI2VBfOSAz0TIOvzIzv/UmazfC4Un9rkJWpTJstLBt8cjhvYs29rfOX
         CVAjf4o4hd52q+hvUv6boSUapF7gPwOMm9gvCzbK1FJE28TtrPVfHkCb7vHtJYYhQ/2z
         MlswUPwzOP4BKQBrUEldgdtXu66ojrxV2mFoNb88XZZR3lndlvPB5DNtrCNJlx486Bio
         parA==
X-Gm-Message-State: AAQBX9d/G+puZE1IqBQA4HnYxsxTL/u+rbvCO5mm5A7DRdxQE6JnwWLA
        VyGr2SGoAnSOYkMwc5gV5Uo=
X-Google-Smtp-Source: AKy350Yt7JmCC87qZMxK8p3DQ9lKepN0v9BC7pNXKxlpRHYsAXwO2l1FzIqrtQtsBMtoK2FVmdTPuA==
X-Received: by 2002:a05:6a00:2313:b0:639:c88b:c3e0 with SMTP id h19-20020a056a00231300b00639c88bc3e0mr22839906pfh.22.1681767195161;
        Mon, 17 Apr 2023 14:33:15 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b0063d2bb0d10asm1452091pfh.113.2023.04.17.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 14:33:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 4/8] t2400: add tests to verify --quiet
References: <20230417093255.31079-1-jacobabel@nullpo.dev>
        <20230417093255.31079-5-jacobabel@nullpo.dev>
Date:   Mon, 17 Apr 2023 14:33:14 -0700
In-Reply-To: <20230417093255.31079-5-jacobabel@nullpo.dev> (Jacob Abel's
        message of "Mon, 17 Apr 2023 09:34:01 +0000")
Message-ID: <xmqqfs8yjisl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> +test_expect_success 'add --quiet -b' '
> +	test_when_finished "git branch -D quietnewbranch" &&
> +	test_when_finished "git worktree remove -f -f another-worktree" &&
> +	test_when_finished cat actual >&2 &&
> +	git worktree add --quiet -b quietnewbranch another-worktree 2>actual &&
> +	test_must_be_empty actual
> +'

It is good to test the --quiet option.  It is not good to have the
ineffective "cat actual" when test_must_be_empty is already used.
Probably the same comment applies to the rest of the patch.

Thanks.
