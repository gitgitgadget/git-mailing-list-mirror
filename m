Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F339FC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69276135A
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhETPZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhETPYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:24:37 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201EC06175F
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:23:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k14so22461516eji.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ScNNXgPf4I0v4szd8BoyLZpFB3aiSoprRrqToLv6DhM=;
        b=M721ZXCORvvoecu5HKeyTfeqrJLjnIMEM6zO+DFFsK+184oIRf4WgobaS9l1heRHZw
         XTN8hW+mrFaifjY96VpOr/DOc4rct6v7glNxQSSY80A5ei2Kx0k2PZNC3xEygOsDNZFr
         UytHrDzAMvrKgwQl2hMTaXsWnWvBOOI1aj+cRr06Enb/4IDxLCEEp4G4pfhnt1BBsUL4
         q3FOdZVg2ywuvlxdWTVhROweZB0BqZlJnoMskr/mjs79lxMpT/1e2xSbaLcGPeExxiYx
         Jj8R+5cJT0HlI02ro02s+JktzmyDvxZuRSevguNK/PXRRHKB08N5RxyMukiTBzKQuywj
         ULtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ScNNXgPf4I0v4szd8BoyLZpFB3aiSoprRrqToLv6DhM=;
        b=tFoJSOuFlMnjmyRyoVIgjF5nmh2zbp4k9eQSJr/qnuxQGGDxGxtaVEvEeYGm+7K4kZ
         hM7TN58NJB3Oj/73WkyCWoTpM9FB+HDwb4mP5UgUoDi8U69OGGXU7zeH+xoTmsXw16zn
         gUivvmR5b69bP0b8xRBApk1U9MgoNM++mbvHQgSzAA+PEVXeeKfqQyQxC30Os+4zjycQ
         vjSlXfB1goyuKnPvJoADrOv5X6KrZy3S4qqxsZCsm0IJ+huR0EuqLMrzOxcD/frhr6/J
         ldbP1JLNp3u4+UwQfSxeiqFe0mpzZLJEi3C6AglSyTrYjMz7wkmMvdVGmCWit0KNHU8i
         eisQ==
X-Gm-Message-State: AOAM530oOADQf0LkzBa2dMFCHOcLQNHag2+XLx44P16VBYWB7+dnWxX5
        L2gUyLu8XumfN1rtGcnYznRJ+u4MQlIfBQ==
X-Google-Smtp-Source: ABdhPJy1O8dZSwmaFOtHGDX+aKLoEGlo5VX2gIheRnZcb2OZqY5kDrv6NyIiBafuQszymrB01K3RRw==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr5224649ejh.31.1621524194027;
        Thu, 20 May 2021 08:23:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id by3sm1809412edb.38.2021.05.20.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:23:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 06/21] t1413: use tar to save and restore entire .git
 directory
Date:   Thu, 20 May 2021 17:22:12 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <e4e8fc1d4b4f450d46dd320ffc2398515044b28a.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <e4e8fc1d4b4f450d46dd320ffc2398515044b28a.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87y2c9pgym.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This makes the test independent of the particulars of the storage formats.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1413-reflog-detach.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1413-reflog-detach.sh b/t/t1413-reflog-detach.sh
> index bde05208ae6a..934688a1ee82 100755
> --- a/t/t1413-reflog-detach.sh
> +++ b/t/t1413-reflog-detach.sh
> @@ -7,8 +7,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  . ./test-lib.sh
>  
>  reset_state () {
> -	git checkout main &&
> -	cp saved_reflog .git/logs/HEAD
> +	rm -rf .git && "$TAR" xf .git-saved.tar
>  }
>  
>  test_expect_success setup '
> @@ -17,7 +16,7 @@ test_expect_success setup '
>  	git branch side &&
>  	test_tick &&
>  	git commit --allow-empty -m second &&
> -	cat .git/logs/HEAD >saved_reflog
> +	"$TAR" cf .git-saved.tar .git
>  '
>  
>  test_expect_success baseline '

So what I said in 05, but also didn't the commit messages of 05 and 06
get mixed up / bad fixup in a WIP version? I.e. the first commit says
"use symbolic ref", but it's mostly about introducing the use of this
tar/untar pattern.

Whereas this continues the tarring pattern, and doesn't start using it,
and (presumably) is the mis-squashed commit that should have added this
whole tar thing after the first commit does the isolated
s/echo/symbolic-ref/ fix.
