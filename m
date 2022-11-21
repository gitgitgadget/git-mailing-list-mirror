Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878FCC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 07:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKUHiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 02:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKUHip (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 02:38:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F84248FE
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 23:38:44 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13561826pjs.4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 23:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUzqkBzGck2vAgfRkOyogkB8avHuVaqa1gsMOKaq9dA=;
        b=c2VJuK4OD5LAT3n3MH0bpIfGFf8H8rtHB46q2FDozV5Qij5/53ZhMEPnEZMoJIAIJc
         pcQzj6QNeEGC+l58sERFCItoJ4CqvHY3lvLp+5GT0p0iSKdQmcdwWwn3J11pttB3I5+v
         dTS8b/mIFaRWXj5YmBbqMrTjsvXVnTOgcH2D2Gw9qFx/dITfIfeIEK/4WtpEbjEdVRSz
         pkNGPBDf2s/HOEKkPb7qSBalB89XUCUqdPghfW1QaBWOlmOhKvjsdCDNXQgNV86Rc8Yd
         cEp+wCgWIhaKIL4EbWzp57cnEDjJ7Dy6o7kFkNaz+5MsrdDQG2zTswJcNiGG1vsadkfo
         wkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fUzqkBzGck2vAgfRkOyogkB8avHuVaqa1gsMOKaq9dA=;
        b=SOf7PKrlq3l52RZe2KQXrwc3Daje5uQZa4UuDs9J4sxAhdO+i5Q1NnUsqoXTcI5PwN
         JEi3XyoxWX6w+qNBTCR6JPK4EvtlkdGPUNjUZGsZgHMBgk8RmPcZ31douaLJY0KqDxWR
         VPX/QRXguT5+Lg8yTfmAA6MLwoWLpJC5C6em2z318Jp8ovQVKAbDvmCFYZWIDPEqR9KG
         FtDww/J2FQ4wsNz2SYmG13PgqD3OhIPcoGbTBSro5bvScaatDS1rc5Vx2zoLtu6OXIAo
         VPbiITbw+0TKwF5gPdsm7QVGg8gegJWeRM7eQB2XsU5L4RugQoSQhxTzVgKDkxfDC8sa
         JVsw==
X-Gm-Message-State: ANoB5pmowbEIp/1k0uDCjDdP3g5FAVTjoutbHyFlPlbvG35Kr4VZLBJ4
        GYHllrNwg9MY/35mvgLAhNIx1xS8vejZlw==
X-Google-Smtp-Source: AA0mqf6xn2wqbI07f+HYQ6fSYV8UqoGpuxHS8cfrnXKWe/Wdd9JpJC3FFCbOac8jnKX7a+SlHg24EA==
X-Received: by 2002:a17:90a:4313:b0:212:e24e:16b3 with SMTP id q19-20020a17090a431300b00212e24e16b3mr24873072pjg.69.1669016324088;
        Sun, 20 Nov 2022 23:38:44 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b00180033438a0sm8966659plg.106.2022.11.20.23.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:38:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        me@ttaylorr.com
Subject: Re: [PATCH v5 2/2] cat-file: add mailmap support to --batch-check
 option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-1-siddharthasthana31@gmail.com>
        <20221120074852.121346-3-siddharthasthana31@gmail.com>
Date:   Mon, 21 Nov 2022 16:38:43 +0900
In-Reply-To: <20221120074852.121346-3-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sun, 20 Nov 2022 13:18:52 +0530")
Message-ID: <xmqqbkp0wyd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 87b77fc5c9..21ba6bc278 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -1047,4 +1047,36 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	commit_size=`git cat-file commit HEAD | wc -c` &&

We prefer $(command substitution) over `command substitution`.  

When "cat-file" segfaults and dumps core, having it upstream of a
pipe would mean its crashing will be hidden.

Note that some implementations of "wc" pads its output with SP.  The
implication will be seen in a few paragraphs below.

> +	commit_sha=`git log --pretty=format:'%H' -n 1` &&

These single quotes are not doing what you think they are doing.
The body of the test is inside a pair of single quotes, and the one
after format: makes you step outside the single quote, take two
bytes %H literally, and the other single quote opens a new singly
quoted string segment.  Which is not wrong per-se, because there is
no special meaning attached to the sequence %H in the shell language,
but then you'd be better off writing format:%H without any quotes,
as that is more direct way to write what you are writing.

Also, --pretty=format:<something> is almost always a mistake.
Unless you have a good reason to use it, you'd most likely want to
use --format=<something> instead.

In any case, don't abuse "log" when you mean

    commit_object_name=$(git rev-parse HEAD) &&

> +	echo "$commit_sha commit $commit_size" >expect &&

As $commit_size here may have extra and unwanted SP before it, this
may break with the implementation of "wc" on certain platforms.  In
this particular instance, losing quoting, i.e.

	echo $commit_sha commit $commit_size >expect

may be a good workaround.

> +	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&

Exactly the same set of comments as above apply to this side, too.

> +	echo "$commit_sha commit $commit_size" >>expect &&
> +	echo "HEAD" >in &&
> +	git cat-file --batch-check <in >actual &&
> +	git cat-file --use-mailmap --batch-check <in >>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-\EOF &&
> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	commit_size=`git cat-file commit HEAD | wc -c` &&
> +	commit_sha=`git log --pretty=format:'%H' -n 1` &&
> +	echo "$commit_sha commit $commit_size" >expect &&
> +	commit_size=`git cat-file --use-mailmap commit HEAD | wc -c` &&
> +	echo "$commit_sha commit $commit_size" >>expect &&
> +	echo "info HEAD" >in &&
> +	git cat-file --batch-command <in >actual &&
> +	git cat-file --use-mailmap --batch-command <in >>actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
