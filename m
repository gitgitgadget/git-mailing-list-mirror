Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF583EE7FF4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 10:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjIJKA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjIJKAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 06:00:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C7CCD
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 03:00:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40078c4855fso36917515e9.3
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694340019; x=1694944819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DrwQZ85zK8yAmbmp+V6b+Qbpc7k9COeCA/sUnx49dwQ=;
        b=MtjWu+PAEZJeBm82nZi4149+3yTkETCfr0bTETxh2DFzqC3BVIXa/VVaOwcmA1UcKN
         bf1WG0HnulOzobS8gefN6jLqtBm2qpKAug7fQVtxLqJFq5cELJDmK2wK6SeRdMyq7bWx
         2P77CpTOOpM4ltoLxPcD03rUne3xMqhBCfaxx5DNS5PMg8TmR1ih1fQjFUvd3/qV/6kS
         hPNfXSiL+Vw91bYD8gmMCp8BKKz935IjTE4mJzrinJFOEUQfmidY6Ayhe1AyUo580bil
         EPD4DwuHVOKoJgoaRBBQdHyPBPmcpKCUH3CvWWBU5uPQ011rCg6U17TcfmVJ0UpUfZK6
         DsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694340019; x=1694944819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrwQZ85zK8yAmbmp+V6b+Qbpc7k9COeCA/sUnx49dwQ=;
        b=qkjmvGxgiJoFAgqWxwbi+3ohClVl+5ptt19QAjtyLdXQ//LGOtat9ffYarPy4dXVsp
         /o2KO1nVxfxGZWQ4TovRp7TY5tHJMuAiuTabKL6IAC1EYNUM+jZf+kdEPTUo4qXjuwQs
         JuDZu7WBDqFi0PD2GFRJGoxy+rbyTGMPERwhkbERox+2iu1iAlzVQ7GoF8zS+uvYteD8
         F7zimwLm5N6V1M7/gUSV3goqmdg5DuJaH4hmZtU8jOisaDjbLnkC5wy5yQckq+B2fXTD
         rbZJa1IAInwhK4yJeQRtupQPucXHr7Pl9aNQ1/b3A0nBFl9aBXai3f4K+HGFRX0KMPKb
         oscA==
X-Gm-Message-State: AOJu0YxKxsqMQBh9YygvIfki1DDcM8m66qrWn3ZmEBrLLoYAJB4qwfx/
        jeoKKLi0XER8AuyiEm1HGPg=
X-Google-Smtp-Source: AGHT+IFSZWBKt7d8/vsHqt1fOFN4u/yc6+BYkjSbvyB+GMq3OuIMImeAJijDHr12wxdhuXMIisnb9A==
X-Received: by 2002:a05:600c:22d8:b0:401:bcb4:f128 with SMTP id 24-20020a05600c22d800b00401bcb4f128mr6078737wmg.35.1694340018848;
        Sun, 10 Sep 2023 03:00:18 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00317df42e91dsm6970652wri.4.2023.09.10.03.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 03:00:18 -0700 (PDT)
Message-ID: <fe550a42-4d78-4e57-a0bc-cb558e8ac1ab@gmail.com>
Date:   Sun, 10 Sep 2023 11:00:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff --no-index: fix -R with stdin
Content-Language: en-US
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_Storsj=C3=B6?= <martin@martin.st>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <d42579a0-f438-9b4c-97e4-58724dbe4a4@martin.st>
 <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <22fdfa3b-f90e-afcc-667c-705fb7670245@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/09/2023 23:12, René Scharfe wrote:
> When -R is given, queue_diff() swaps the mode and name variables of the
> two files to produce a reverse diff.  1e3f26542a (diff --no-index:
> support reading from named pipes, 2023-07-05) added variables that
> indicate whether files are special, i.e named pipes or - for stdin.
> These new variables were not swapped, though, which broke the handling
> of stdin with with -R.  Swap them like the other metadata variables.
> 
> Reported-by: Martin Storsjö <martin@martin.st>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Great bug report, thank you!

Yes thank you Martin for reporting this and thank you to René for fixing 
it - I saw the report just before I went to bed and it was already fixed 
by the time I got up! The patch looks good and thanks for adding a test.

Best Wishes

Phillip

>   diff-no-index.c          |  1 +
>   t/t4053-diff-no-index.sh | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8aead3e332..e7041b89e3 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -232,6 +232,7 @@ static int queue_diff(struct diff_options *o,
>   		if (o->flags.reverse_diff) {
>   			SWAP(mode1, mode2);
>   			SWAP(name1, name2);
> +			SWAP(special1, special2);
>   		}
> 
>   		d1 = noindex_filespec(name1, mode1, special1);
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 6781cc9078..5f059f65fc 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -224,6 +224,25 @@ test_expect_success "diff --no-index treats '-' as stdin" '
>   	test_must_be_empty actual
>   '
> 
> +test_expect_success "diff --no-index -R treats '-' as stdin" '
> +	cat >expect <<-EOF &&
> +	diff --git b/a/1 a/-
> +	index $(git hash-object --stdin <a/1)..$ZERO_OID 100644
> +	--- b/a/1
> +	+++ a/-
> +	@@ -1 +1 @@
> +	-1
> +	+x
> +	EOF
> +
> +	test_write_lines x | test_expect_code 1 \
> +		git -c core.abbrev=no diff --no-index -R -- - a/1 >actual &&
> +	test_cmp expect actual &&
> +
> +	test_write_lines 1 | git diff --no-index -R -- a/1 - >actual &&
> +	test_must_be_empty actual
> +'
> +
>   test_expect_success 'diff --no-index refuses to diff stdin and a directory' '
>   	test_must_fail git diff --no-index -- - a </dev/null 2>err &&
>   	grep "fatal: cannot compare stdin to a directory" err
> --
> 2.42.0
