Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDEC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhKVSDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhKVSDE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:03:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D73BC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:59:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g14so80781878edb.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QdeQH+J7w4Ao01vdc+WcW1TQ3F3dXFfgihlo6voAZ0=;
        b=b5WZbcnpKDIUkWEZjJfhmiRR2h+29jR++p7C0CH2mQqhSOHO0a+OdrF6oyVu25FvoM
         IHfbYINA+iRKBGIjzEMvu3RsnvgsAGDolRBdIlFB7OdS5i0MnMIOm1R4nK2qWoPyeUnr
         /gt7CYmM53GgHN5bgUeOr0/t2scIIDkIJ83+jUWz1zZnhZBHNI8xiqdbNOKHGbTE0LGm
         teqGs+zS7+mIE61MLNQM8NiyVr9tnNroNmcnkb8WFZqTBzfGkGq4ubJZil+EYDTTBcA4
         yOSFjMJn9AzY4A3IhsFpUpgMaHSqQa1E+8vy5LWRB+cCubWErR4NgJfhrDbcEBT4+Pfr
         zp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QdeQH+J7w4Ao01vdc+WcW1TQ3F3dXFfgihlo6voAZ0=;
        b=F/CHQFMoU7tCXQN1oOG7ZMe5obIsT9IYdg/Kz8eSNeGD0L5yysJ9jECsINsytaH0ef
         Q3ViIV0V5rxgLj3dCW37CJPrltt6bTRQT+gpPsXS8CtRQHvdIG0yWfyW0oum1QEYBliz
         IBHpZ82ZyzWZInnswkponZZvGFX1mlNYnv3s3cFsSqV7OWkwZkJAWiUAm8KvrQBM919A
         4GB5epR+kSIn0WYLxgx0Zre0TdobuUXJWmqMLt6CxR3m+i3P/3B6QtGGBWYlV1yrWHaG
         pbiMeH4GvRrEDb3DQo9Isoz7BDSd6QPOokAcW0AS44YbwWpTIk+uFKUx6wRhZ/Ip7BVn
         MPHw==
X-Gm-Message-State: AOAM533cZXRUECX3rJBYaLCEfZtD2Fil/xtHydJNlymG1v5AqkXrYKBR
        j31NPvUyFHwZqKtxCpx5X+lnBXDjyIcgpWif/cBo6sgZ
X-Google-Smtp-Source: ABdhPJxEfG01nhaWDDvbjTofWsUZ+adu0EA1ycRgTbHlLyLKPLAJLfRedrQqFjcQqnE/NBGXrOmf72P/qfoiLDtoYTY=
X-Received: by 2002:a17:907:1c9d:: with SMTP id nb29mr44524279ejc.74.1637603995726;
 Mon, 22 Nov 2021 09:59:55 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g>
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 09:59:44 -0800
Message-ID: <CABPp-BGdhwcVhGPeY+09MMv+0384TY+OOimtBUgFE0Wv09riDA@mail.gmail.com>
Subject: vd/sparse-sparsity-fix-on-read (Was: Re: What's cooking in git.git
 (Nov 2021, #05; Fri, 19))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 11:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * vd/sparse-sparsity-fix-on-read (2021-10-27) 3 commits
>  - sparse-index: update do_read_index to ensure correct sparsity
>  - sparse-index: add ensure_correct_sparsity function
>  - test-read-cache.c: prepare_repo_settings after config init
>
>  Ensure that the sparseness of the in-core index matches the
>  index.sparse configuration specified by the repository immediately
>  after the on-disk index file is read.
>
>  Will merge to 'next'?

I spotted two minor things with the commit message of the final patch
(which don't necessarily need to block the series, but would be nice
to see fixed)[1].  Otherwise the series looks ready to me, and Stolee
also put his stamp of approval on the series[2].  Perhaps wait to see
if Victoria wants to fix up those two small things I pointed out
before merging down?

[1] https://lore.kernel.org/git/CABPp-BGU=HHeydt3arF=RF2P81cFbe3NfX6tqiBHb8xkhOALgg@mail.gmail.com/
[2] https://lore.kernel.org/git/e1c6fe43-ebd1-7c6f-c5b6-c528fb4e6774@gmail.com/
