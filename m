Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B46C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 00:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiLEA07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 19:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLEA05 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 19:26:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A0101C8
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 16:26:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id a9so9367673pld.7
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 16:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKhjVME74uZI8PBjW5p4hTUJKVmFqXRQe0zxGA8amt8=;
        b=BxOWYD979syfvLy1YJH1Dy/TEELOBT6g70DRUpSgY1DNNHtyKnC3wT3cRQLGc4AAZK
         MzIcRDSTdagITKKb7zBZuOcmgcP9Xhs/ynvETI0b3Qq+voZBqK4UqrifOWyGO4tUIftK
         Xe2zJ/vk8yPy8aKgLKEdQ4qgAvrwerEHGmRJMZ6kk3lbZr9xUt4EfI3NBchzvzJO8kjp
         5BJS8yDpt9t5nTKPmNSsROWxLgWyRhfdgtb/kQGgp7FSs7Y4rxP09z0wY6okP6TF5sjH
         el5i7DiZAvx3c79WczYJNLKJvOcAdKdYuOeNvnKbz8oUx90mnF7oeoFOfsb1ChkWEqjc
         mKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKhjVME74uZI8PBjW5p4hTUJKVmFqXRQe0zxGA8amt8=;
        b=v0WcNWvTbf6NEXpFArtuwCT4tOoDdlc1vuWE0UoP4YReEa6f3zzjGc7ly/B6+sPTlS
         b7gpKPNyk3O/825kX0s0kudSJLf5TOJec5fapR2tskZLelO3VBzmU7qVFxY6HmzDS78F
         yKyDXyyogmmol4bTdvIVWMISPZeY2ufRZ1hQjJl2ZBA0Hh40MQs8giy/jUua4+1dy4mT
         tzMb8gZbhLkIYcCn3pLFZ1U12NQkNj6lm1beK7YBDph1dHzKM64GjKqetp7C9GvNxJ1/
         rDTbY4MPpiEUveTmFQVOHp6DDD81IuUFLV04k99A+gx9sokZghlDtwSuCglWyVgr/ZqZ
         HzKA==
X-Gm-Message-State: ANoB5plOvy1e8ZLwyHJ/mJIs2nk2NJCCJMO1+oIravn5t1ImrEJQBj4Y
        n/tdlfVBp8riluGKnhN1wAg=
X-Google-Smtp-Source: AA0mqf4oxJfGWlQHaE9GY/V/JYDd9PuRb6IUys4IQUi8s+LWr6pXV6l3Tqn0Anyjuf1qfBUFl5M/QA==
X-Received: by 2002:a17:903:240a:b0:188:5d24:87e with SMTP id e10-20020a170903240a00b001885d24087emr63516493plo.87.1670200015573;
        Sun, 04 Dec 2022 16:26:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00000f00b0056b6d31ac8asm8836638pfk.178.2022.12.04.16.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 16:26:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 3/8] diff tests: fix ignored exit codes in t4023
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
        <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <patch-v3-3.8-4ec075689f6-20221202T114733Z-avarab@gmail.com>
Date:   Mon, 05 Dec 2022 09:26:54 +0900
In-Reply-To: <patch-v3-3.8-4ec075689f6-20221202T114733Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Dec
 2022 12:52:36
        +0100")
Message-ID: <xmqqlenmu241.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change a "git diff-tree" command to be &&-chained so that we won't
> ignore its exit code, see the ea05fd5fbf7 (Merge branch
> 'ab/keep-git-exit-codes-in-tests', 2022-03-16) topic for prior art.
>
> This fixes code added in b45563a229f (rename: Break filepairs with
> different types., 2007-11-30). Due to hiding the exit code we hid a
> memory leak under SANITIZE=leak.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t4023-diff-rename-typechange.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I already have this as 1ebeb849 (diff tests: fix ignored exit codes
in t4023, 2022-12-02) on ab/t4023-avoid-losing-exit-status-of-diff
topic.

Thanks.


>
> diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
> index 7cb99092938..25c31b0cb1b 100755
> --- a/t/t4023-diff-rename-typechange.sh
> +++ b/t/t4023-diff-rename-typechange.sh
> @@ -52,8 +52,8 @@ test_expect_success setup '
>  '
>  
>  test_expect_success 'cross renames to be detected for regular files' '
> -
> -	git diff-tree five six -r --name-status -B -M | sort >actual &&
> +	git diff-tree five six -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		echo "R100	foo	bar" &&
>  		echo "R100	bar	foo"
> @@ -63,8 +63,8 @@ test_expect_success 'cross renames to be detected for regular files' '
>  '
>  
>  test_expect_success 'cross renames to be detected for typechange' '
> -
> -	git diff-tree one two -r --name-status -B -M | sort >actual &&
> +	git diff-tree one two -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		echo "R100	foo	bar" &&
>  		echo "R100	bar	foo"
> @@ -74,8 +74,8 @@ test_expect_success 'cross renames to be detected for typechange' '
>  '
>  
>  test_expect_success 'moves and renames' '
> -
> -	git diff-tree three four -r --name-status -B -M | sort >actual &&
> +	git diff-tree three four -r --name-status -B -M >out &&
> +	sort <out >actual &&
>  	{
>  		# see -B -M (#6) in t4008
>  		echo "C100	foo	bar" &&
