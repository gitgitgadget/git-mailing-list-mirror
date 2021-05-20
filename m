Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA1DC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D39B60C41
	for <git@archiver.kernel.org>; Thu, 20 May 2021 15:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhETPwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhETPwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 11:52:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F373EC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:51:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so26049225ejc.10
        for <git@vger.kernel.org>; Thu, 20 May 2021 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ZVxumOo379R2+uLvKlhNt3ZkMiNqJ0F2YPejYyfcXBQ=;
        b=HWnFVa9zoJdqQASEIuXxdfgCIQhmKfAczB7UawgNOhbPZLNOq+ZMoFJWKVeOMbhhKb
         5fmey3fERTwRuZQzfJJkOFry82kheQH19L43KZiQmIxIuYvLbrzXUmhnAjZZ75Zp0kQo
         fz1TB6wTFYrP1SbsYLPbxUVfpYq74Iw4s4oOxRbV0IG2gksp5wOMSOhItzl/sk2f4D0W
         HgyVMkm/UJPq6skc71qkyU82TADg2qrpku24l8JI4HQ8GgGli+iPlRUpPndEYeBRFCEF
         H/ZLa7StAnVy+XbRETRyKKKljvO58c60L4UAvP23BMCXDo+ilVFj+dqG+pX35Yv9noeu
         wZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ZVxumOo379R2+uLvKlhNt3ZkMiNqJ0F2YPejYyfcXBQ=;
        b=KMj/xr9cwd0UpIg4HQOozEKghAIExM3x+hJO3ulPaXFIoKp4MI1oXypdz+nLgbCvQ8
         6tIDcRkrfzeSIYDUK45RXxlcLzFJcADzNPpUyEGcUifjaUC9DfEvCw+SskLQIH5qPq2/
         lVD7GRDZgAbHYeRfkO8Ss2f51YrzXt3vp8Hlobzd80O+iY8NAoi5TkSdO+p/jb6VqTMg
         9NWZfxAwmNutc7TBC7YpANH5mw3X6mfQxNrCGT2W35xrsmGk/0iPHwzSA6yW40wlVRSk
         hPcCDd2RYKefeTtmXyBB0NxuJ9B9cqNuiIyOJ3yXSmvx8tGxf0WQdv89ymcG8LVVBdEd
         oT/w==
X-Gm-Message-State: AOAM531jfk0kU8A6IXR2GFGoFZkD8dwMU9NRsmQJoU5LnSKt+z1b6Zbn
        ysxUI9eS+bZ0f80zezjw9yVaGKb+x/cvWQ==
X-Google-Smtp-Source: ABdhPJzAt85NPR8hqCAB6OXxa+hnTUuGDXGn+c3NO/R+qockixqPa/BjM5v8XegLzLL3f6meR1TPCw==
X-Received: by 2002:a17:906:28d4:: with SMTP id p20mr5432762ejd.552.1621525879243;
        Thu, 20 May 2021 08:51:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d11sm1579557ejr.58.2021.05.20.08.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:51:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 21/21] t1415: set REFFILES for test specific to
 storage format
Date:   Thu, 20 May 2021 17:50:37 +0200
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
 <d7e5de8dba465098afa421d162df5ca7b0fb1a33.1619519903.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <d7e5de8dba465098afa421d162df5ca7b0fb1a33.1619519903.git.gitgitgadget@gmail.com>
Message-ID: <87bl95pfnt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Packing refs (and therefore checking that certain refs are not packed) is a
> property of the packed/loose ref storage. Add a comment to explain what the test
> checks.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  t/t1415-worktree-refs.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> index 7ab91241ab7c..d6e6e523bbba 100755
> --- a/t/t1415-worktree-refs.sh
> +++ b/t/t1415-worktree-refs.sh
> @@ -16,7 +16,10 @@ test_expect_success 'setup' '
>  	git -C wt2 update-ref refs/worktree/foo HEAD
>  '
>  
> -test_expect_success 'refs/worktree must not be packed' '
> +# The 'packed-refs' files is stored directly in .git/. This means it is global
> +# to the repository, and can only contain refs that are shared across all
> +# worktrees.
> +test_expect_success REFFILES 'refs/worktree must not be packed' '
>  	git pack-refs --all &&
>  	test_path_is_missing .git/refs/tags/wt1 &&
>  	test_path_is_file .git/refs/worktree/foo &&

Nit but also chicken & egg: Let's keep the "pack-refs --all" though
under reftable in its own test, and do the test_path_* assertions just
under REFFILES, i.e. does/should pack-refs warn/error under reftable as
redundant, succeed silently?
