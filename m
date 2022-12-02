Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CCFC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 02:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiLBCTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 21:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiLBCTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 21:19:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193AD7546
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 18:19:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so6982362pjs.4
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2SCIY7EbXyH3VhCqmQ956PG+LYiwfZAoE1Lmj5CQDA=;
        b=GOAOJS6dyhgAAQPTVZ+7ZmcLES8TMmVs0cTf5UELOpWEETkKymlup2ccnUQFUVO5qG
         hvYpCNdRCJJy/XqT/yLG6VRwP+l5ChWk8emS0u+Tdv5i20magqlxMQM/RKWdertKgGMP
         JNWX/+cKMFo2ncCEY1vFC4nm1GpIGaJ5miVeNxUOphCpsN5NiNazxxvDeFa5g66AQARN
         lV9UKBderiuuwvQgHAALfrjU4L8g+JhnGBSwGuCT8gK+aaZEw/+3dSPXlAEuKVJSIUDG
         9gDQuYpXi9aazwINLvHN05bLhKwjPtRFXY9lth5lzA3KYNOrlGqjSOoYAF0l4raigSfm
         ES+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2SCIY7EbXyH3VhCqmQ956PG+LYiwfZAoE1Lmj5CQDA=;
        b=2x0SqSlTEymVNSaePbpXOd+CzCaFiHbGDFZz2rNNmEBCoQdtFLza3B6pQWWSAGt5Xl
         W4K0LZ/gOZYKngwlJsaMy/1XrLck8OcGyMC5Y64Rlhfm1zJzR/5rlKKKnchK1RsC2Ks0
         3a5y+xkZ1xNNvp08Pa72I5GC5Gd9FFqjjKwqDXVSvkeeN7DsfhTfUC0rueFN9h5le2Ph
         k9U4PcinSmsGk1oU9vKROL7CFAdJNxTS5EX3EAZlXalmInNo63tx1b1UcL/WRn9aNADa
         8h1hO5LIOGBI4IE3vwcSL4KfSux7+PeD9ptgqPv+DJjz/iXeJH7ZOjRvi2/47EY1SWzQ
         xWDQ==
X-Gm-Message-State: ANoB5ploTlenRVsOpY05TgKePQIhJ2F7h1/2FWd/M1wfBlaI6+l4PPxF
        91oL+VY+8Yp0SAOz4qqWF4Y=
X-Google-Smtp-Source: AA0mqf6cNh8Q1xIgdLaf6JTxMhycEFlCc0Ter6KBsixrv9KFLans1PPvl2EF+3S1mRdPpUZfnCPl0w==
X-Received: by 2002:a17:90a:460b:b0:218:8a84:aeca with SMTP id w11-20020a17090a460b00b002188a84aecamr66691705pjg.63.1669947564005;
        Thu, 01 Dec 2022 18:19:24 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id lj14-20020a17090b344e00b002139459e121sm5528924pjb.27.2022.12.01.18.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 18:19:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 8/8] tests: use "test_cmp_cmd" in misc tests
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <patch-v2-8.8-979a7f003f8-20221202T000227Z-avarab@gmail.com>
Date:   Fri, 02 Dec 2022 11:19:22 +0900
In-Reply-To: <patch-v2-8.8-979a7f003f8-20221202T000227Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Dec
 2022 01:06:34
        +0100")
Message-ID: <xmqqiliupmxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change a few miscellaneous tests to use "test_cmp_cmd" to avoid losing
> the exit code of "git".

The step might have started out to do so, but many of them do not
seem to anymore, perhaps because you allowed the scope of the step
to drift and the focus to be lost while developing more?

>  test_expect_success 'symbolic-ref refuses bare sha1' '
> -	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
> +	rev=$(git rev-parse HEAD) &&
> +	test_must_fail git symbolic-ref HEAD "$rev"

This is not a test_cmp_cmd user.  The update is good.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 5841f280fb2..3e59ffd18a0 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -296,9 +296,12 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>  	echo content >>file &&
>  	chmod +x file &&
>  	printf "y\\ny\\n" | git add -p &&
> -	git diff --cached file | grep "new mode" &&
> -	git diff --cached file | grep "+content" &&
> -	test -z "$(git diff file)"
> +	git diff --cached file >out &&
> +	grep "new mode" <out &&
> +	git diff --cached file >out &&
> +	grep "+content" <out &&

No need to run the same "diff --cached file" twice.  No need to
redirect into "grep"; giving the file on the command line is more
natural.

> +	git diff file >out &&
> +	test_must_be_empty out
>  '

Other than that, the above is an improvement, but again, it is not a
test_cmp_cmd user.

> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
> index f2ce14e9071..2d38a16480e 100755
> --- a/t/t7516-commit-races.sh
> +++ b/t/t7516-commit-races.sh
> @@ -10,7 +10,8 @@ test_expect_success 'race to create orphan commit' '
>  	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
>  	git show -s --pretty=format:%s >subject &&
>  	grep hare subject &&
> -	test -z "$(git show -s --pretty=format:%P)"
> +	git show -s --pretty=format:%P >out &&
> +	test_must_be_empty out
>  '

Likewise.

I guess only half of the tests updated are test_cmp_cmd users, so
this step was about half as big when it was originally written?

