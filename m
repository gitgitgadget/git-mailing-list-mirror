Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A212C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKHSaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKHSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:30:23 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA21E3EE
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:30:22 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id q5so7882283ilt.13
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYxxGljs/JoQ7H4ybYEs7x/pIKRb3FHbKbMAGH2TDho=;
        b=aSnY14uzI99rNfyqVZM4VokN3xL02P6J1Yil0ZYew7o2NXt1su0RUwGwOTTiDOC7Uo
         WUGQ4L9+4x44dWVk2EgapvpvLguFhvdAHLq0jnZ1BgrsuSU6KLEcjDavrHBrZlp8L8r/
         eJUPahuRIO1UagMCjqvqDnxFSfpKfC7Wn5f7Rmsd58QCvdjpOiQ/Tm5HUYx3KaxJWjRg
         uzHJ/DtB3WkcZEqsYFStSHx0obTk7CZbEX2Jkld/MvS/i+x3JyWwEDo2i0h/HHzkL6Ce
         aJ/wfAWb2AYsfjJ+mhLWXxJsw8ABogsWOLC4qenYxLbPv25WueQnJZjT4nH5hZaouLXL
         l7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYxxGljs/JoQ7H4ybYEs7x/pIKRb3FHbKbMAGH2TDho=;
        b=hcOs2irBhY2W/hqmPZkybvZu0Lyq6nrdddPiSqCsyqAxsJe/Xcn866X2An4bjQ3kT7
         yB6BfapeuX/HNAVOj4FAU4lRc+b/NqdLUR92SQFiHT4oZAxVLLDdAlUCmMqEHQHj6D4L
         CAv4XAGT/YuZPvQkN53e/77RUffO4bGFYv4kanqYFa0MqurUTlCxzxv195F1er40xHLK
         iZHBjZY5cSmuukxpB3FUksQ2Hk/94lpnMpl6rNWhFd/XYzwn+tgGrsOXKXPOec04madr
         gRV0t7DVAwWtTV303pnHwTBejvGLjoiVZAWNIxm1bva3f7Lr7LP4WzStbVcMdtKTIhRm
         WxPQ==
X-Gm-Message-State: ANoB5pkf1oElDuZ3iWZfnJymhFgI/PDp0BuCXuAfPz0tlmSrTgSM23Ta
        NL3QpyBEz900SiYAMmg8bfS/WA==
X-Google-Smtp-Source: AA0mqf5URC2rY8RCGSdtA8priOeJLW9V1XTBUecSf1L+masr5rBozsUVpmNm4StMyASBWBxkB8GT1w==
X-Received: by 2002:a92:600a:0:b0:302:de:6926 with SMTP id u10-20020a92600a000000b0030200de6926mr10621288ilb.67.1667932222014;
        Tue, 08 Nov 2022 10:30:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g12-20020a056638060c00b003755aa71fffsm4036847jar.105.2022.11.08.10.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:30:21 -0800 (PST)
Date:   Tue, 8 Nov 2022 13:30:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2qgPKRW1+9BNkIp@nand.local>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
 <Y2liOzOFLyz4uzd0@nand.local>
 <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
 <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
 <114d4a72-1a75-71f3-8af6-6e82cd4fd54b@github.com>
 <Y2mKY+rE6X/Lu4pb@nand.local>
 <75ono097-16nr-nno4-rqoq-rrn79spps249@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75ono097-16nr-nno4-rqoq-rrn79spps249@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 09:18:21AM +0100, Johannes Schindelin wrote:
> > I played around with the following, but I can't quite get Actions to
> > like it. The error message I get (ref[1]) is something like:
> >
> >     The workflow is not valid. .github/workflows/main.yml (Line: 96, Col:
> >     27): Unexpected value 'needs.ci-config.outputs.skip_concurrent == 'yes''
> >     .github/workflows/main.yml (Line: 123, Col: 27): Unexpected value
> >     'needs.ci-config.outputs.skip_concurrent == 'yes''
>
> The reason is that what you are trying to do simply cannot work.

I was surprised that I couldn't get this to work, because to me it
seemed like the sort of thing that *should* be possible to do.

Indeed, it is, and I made a couple of mistakes in writing the workflow
file:

  - The expression for 'skip-in-progress' needed to be enclosed in
    '${{}}' markers.

  - It also needed to take into account the job name (and matrix
    information!) where relevant. And here we can't just use
    ${{github.job}}, since that is only available inside of the job
    steps.

To the last bullet point there, we unfortunately have to copy and paste
the job name, which seems like a limitation of the Actions workflow
parser to me.

I posted an alternative approach to this patch in [1], and I would be
very curious to hear your thoughts, if you have time!

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1667931937.git.me@ttaylorr.com/T/#t
