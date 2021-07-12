Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F9C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76E461178
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhGLQHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhGLQHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 12:07:42 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B027AC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:04:52 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 68-20020a4a00470000b0290258a7ff4058so4629562ooh.10
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 09:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Drz1M8iu27zKX20yEYoJVqJ2/qFVa2AGOo6mSIKEPOc=;
        b=HAzQcd3pNwqGKb5cgVUoj50+g8XwHW2a9q8Hw64gNGYuFtl/Ju4GMFoPj9ANPXBygq
         z2xDeW9+L+FTDIPWfQsunesIaJIn7Lnr0FGQPVRg4+UPFOwVDx6EJ8xS5WT/uDIjLNCn
         sEdHJhH5Gqu1Fh93fvG36MbS+/5n589V4eYNjBJSGieaI67h9y4TSMq1SoTywVlJxPvH
         htHAKm7Q49PKnGrR0r3e1VHOo2T/8oD2PkKqD1gMHt0ywNnQAz723KnfHZneAoHZi0wj
         hWTnRj5mmp7v07mcqNUQCGL4F1rmU8ugYJyNikuIV7PqUycEuVeQnNVcbV7LuncdS+q8
         y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Drz1M8iu27zKX20yEYoJVqJ2/qFVa2AGOo6mSIKEPOc=;
        b=s3lMWVidDNhWg8qdQYtEXX3aVJuvqYmBgSzjRDX9fz2qA64KiuP3kLyR4XHbuVu4Xf
         7csbyS5fdKRaSlOywATwocThOkUTMh6qpZaNuF3f7IFbMxehu+6Ye/DYkWOld3xqvaXC
         nE798JxsUHPIHaa6NeTt6opyQ7mvsluha6cMLJjbb0OP+PPLKvcJBVrDtspj23ZgS+43
         i3sVraTwqkyENM1l/rU2+6Cxh0FeiSw6kvsURuE+imMle/KY1BDA8Fh//aeYnFE2VhKr
         mVjXtxl7dPhZyq017VWiE4MScfLATuv05V/tXOtJU79lg4YOjWGNhukG9DFYYJmH+vqp
         53ww==
X-Gm-Message-State: AOAM532eXc5k9ZYQKaTpPd0CMuyUxqijRnMtzp3Sl6E2fEqx/pUUstpk
        eZEdlvZ8Al2kNe82KVJ/8OA=
X-Google-Smtp-Source: ABdhPJyIiQ5/zWqfY6QosMzol/ynApefs/BrV/iz7QziA/VtHIM/DYp+JwzmTxEmlpnXwsB77h1jXQ==
X-Received: by 2002:a4a:9644:: with SMTP id r4mr38730722ooi.52.1626105892048;
        Mon, 12 Jul 2021 09:04:52 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id f12sm2660910ooh.38.2021.07.12.09.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 09:04:51 -0700 (PDT)
Date:   Mon, 12 Jul 2021 11:04:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, felipe.contreras@gmail.com,
        newren@gmail.com
Message-ID: <60ec682262994_a452520837@natae.notmuch>
In-Reply-To: <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 11/07/2021 02:26, Alex Henrie wrote:
> > The warning about pulling without specifying how to reconcile divergent
> > branches says that after setting pull.rebase to true, --ff-only can
> > still be passed on the command line to require a fast-forward. Make that
> > actually work.
> 
> Thanks for revising this patch, I like this approach much better. I do 
> however have some concerns about the interaction of pull.ff with the 
> rebase config and command line options. I'd naively expect the following 
> behavior (where rebase can fast-forward if possible)
> 
>    pull.ff  pull.rebase  commandline  action
>     only     not false                rebase

Agreed. (pull.ff applies only for --merge)

>     only     not false   --no-rebase  fast-forward only

Agreed. (--no-rebase is --merge, and pull.ff applies)

>      *       not false    --ff-only   fast-forward only

Disagree. (--ff-only is for --merge)

We would need to change the documentation and the advice warning for
this to be correct.

>     only     not false    --ff        merge --ff

Disagree.

This is a rebase, --ff should be ignored.

Junio already proposed --ff and other options to imply a merge [1], but
I already explained why that is problematic [2].

>     only     not false    --no-ff     merge --no-ff

Disagree. (ditto)

>     only       false                  fast-forward only
>     only       false      --rebase    rebase
>     only       false      --ff        merge --ff
>     only       false      --no-ff     merge --no-ff

Agreed.

> I don't think enforcing fast-forward only for rebases makes sense unless 
> it is given on the command line.

But why? This is inconsistent.

Everywhere else in git the configuration is another way of specifying
the command line. This would be the first instance where it would not be
the case.

> If the user gives `--rebase` `--ff-only` on the command line then we
> should either error out or take the last one in which case `pull
> --rebase --ff-only` would fast-forward only but `pull --ff-only
> --rebase` would rebase.

Following the same logic `pull --ff-only --merge` would ignore the
previous --ff-only, wouldn't it?


This is a pretty significant semantic change and nowhere in this patch
it's explained who this is supposed to help, or what is the motivtion
behind it.

[1] https://lore.kernel.org/git/xmqqmtyf8hfm.fsf@gitster.c.googlers.com/
[2] https://lore.kernel.org/git/5fd8aa6a52e81_190cd7208c8@natae.notmuch/

-- 
Felipe Contreras
