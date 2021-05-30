Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A5C47089
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A00610A8
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE3Dex (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 23:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE3Dev (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 23:34:51 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00EC061574
        for <git@vger.kernel.org>; Sat, 29 May 2021 20:33:07 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q7so2658342iob.4
        for <git@vger.kernel.org>; Sat, 29 May 2021 20:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgJHShwMcPCtAzkN0phqTWeU7+vxzttcr2OTHEB8aYQ=;
        b=dvUKAtxXJpH1ra3ej3MGRe7AOzWCSUFWzwpSzRdHuEfXu6VznN/7Gj8LbNug3Zj6sA
         dfDknm1a6EgE1qdleAXd7/7J/7yO4WCIO4GHe1K/zPlpAPEVV9KmT2vTnQesoL3+jrFV
         hrpikIlBHHLadrJez9fwN/CoX8aOJAwuu0xzhRjFn9Gqbnn8CDrC1ySGZwXmRYSKBEfm
         aK+320IXJH/7AZOt4QFvaNFqXxt3wXB5soCEmY1Wf7VJawaLLOQqceFBIlSZLXQttK/E
         ZjaSMkcdiMQpwzCCUo/pjeMD6bR668xQlWFanjLxG0mWtm5Exr4avQU4qDyw8RIT3MK3
         RgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgJHShwMcPCtAzkN0phqTWeU7+vxzttcr2OTHEB8aYQ=;
        b=XZCJHyoq8VI0jzu7KzB6atgHDRlj5VQ/fgzUAkirq39lalj4xwEpqlvLW/l75Gw1zh
         V4yq7csm2KDN/TD2g2giKAiZQyCdIuSMSWVIGAEe8lKqI2aeBSFTA8cTWBQUGQppTZhw
         KmZ9/UapkCqhiJbJEfsVFz5ies9nWBC00EsX/5VxgCSwlrq/8e1xlI341ZrMDMEZLgFv
         nAi4g7EmH0GJwEmT/mfC82p33r+nru0xgjjancdthMDJxvSFU7ug/UgIS6rsW4182u+2
         xPg+G08XOyOJBKpddIg4GydPpbu8gaMk3co5qxnNUhjaI8+NWQgGpxKRW9lRIRbCH0xP
         V/Pw==
X-Gm-Message-State: AOAM530MMgTOl3WSK33Ajtm6ME+INlNPYEKM49+cxu510GF+2tmDA72B
        EjUGgclYtFwDc3FPULP9hWv7sFDR60rIjVTdVgo=
X-Google-Smtp-Source: ABdhPJwffz9wsXBkv0viN2Ar3eBm9CnIzBqkWaGa+Eaw9tiSeU/d+PKSXCT6GUysSZBBmcroLXUV2OVhrA32emhwTnA=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr12357472iog.24.1622345586235;
 Sat, 29 May 2021 20:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210530024928.24158-1-davvid@gmail.com> <CAPig+cTOFySGeUKM2oa9nHmkGVaWUbq8ghcid0hHxxSbV6jAjg@mail.gmail.com>
In-Reply-To: <CAPig+cTOFySGeUKM2oa9nHmkGVaWUbq8ghcid0hHxxSbV6jAjg@mail.gmail.com>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 29 May 2021 20:32:30 -0700
Message-ID: <CAJDDKr4rVLYxPpwEg3K4Ok1XUeKhupthPehyKczhHYmFFMF_0Q@mail.gmail.com>
Subject: Re: [PATCH] contrib/completion: fix remote completion for "git push/remote"
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 8:12 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sat, May 29, 2021 at 10:49 PM David Aguilar <davvid@gmail.com> wrote:
> > If __git_cmd_idx is empty then zsh will silelntly fail to
> > complete remotes when doing "git push <tab>".
>
> s/silelntly/silently/


Thanks! I'm going to wait a bit for the completion experts to chime in
before I prepare a v2.

For v2, I'm thinking it might make sense to go ahead and squash both
of the completion changes into a single patch.

(sorry for the noisy resend -- I wasn't in text mode so vger dropped
the original reply)
-- 
David
