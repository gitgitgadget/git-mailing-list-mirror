Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73038C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 21:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjD0VaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0VaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 17:30:20 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E421FFF
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:30:19 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-18665c1776dso6509782fac.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682631018; x=1685223018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoUOga1jd6YcjY+1GcryRawn6QQZ4s+anP7Epxdnd5Y=;
        b=mlR/EZhAiWxOw9FA1yEKBJAjWx0xyR12lbmEThZFxTnAh+YxeY6UQ/VJqUamjcQNAC
         /uLRgh6kcFe3+rmapEVSnSNpedfuvP6IG7+jw+NMbmv87uZt8//Wz5PbDbIFZBT4Xbf8
         GNZb7lZnc6jM2THbVVKcDnwEbPAL95+4r7qxqUpwilNno5N20GzGTouwI+nvUXp/T30j
         l1KFStdSaMNxRH5hz0TX1SBdLtOexenWnkH1zbHpMxt6CY2fN+WyzRa1f7LN3ZbRldMy
         4XAs8sEPnN9JE8wFeHUIsAh2h6yLNzp+tH6aW3QVzdHAfewCEXXWTS62hCRi/Miz7z24
         PNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682631018; x=1685223018;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yoUOga1jd6YcjY+1GcryRawn6QQZ4s+anP7Epxdnd5Y=;
        b=Gbwdcy6Znp9geyK3fW+pONQyBdyM5BGyhMJHh9qfFDG9/zQJCfN/O/YSTg2l4Oyynx
         KwKZMAlG1ijY7WH7HRwb/gElPDcSVh7Zatyj8ofS3xJKKp4N3JKy9hsi9URl/l553AB1
         kg8WqJNTec5xqXvMWeLQHO4JqVAzNu6jwe+Qc+kfpq9gvFqGBmtWjRID0nrXwJkTpquF
         0yCl8b7ymINgaOEuNsgWtd/Uelt4mdpRoDiZwJAj32IbCKwwUhfTMOWW7U75tMY0+oEP
         DoOqQ/21cISUQ5qS3kKIYizHLzW/lfifBR/sfqIA66e0gC3NN9UKH2w+MU4CYEoDTPwz
         hbKw==
X-Gm-Message-State: AC+VfDwTv2HC4e51nMcSu+MSS4h4ZeykbuWRRLa1QMbtltzcU3lSPBtM
        2EpsO0nMU5H4mhMwP8Ga28o=
X-Google-Smtp-Source: ACHHUZ7mBSZmcwgz/pLSbVGMhFKWP730dpz0bZ+NcrOD9ek2kHb4nzRg1pGOBQBrST7jTu0U+zDpqw==
X-Received: by 2002:a05:6870:a701:b0:18e:b91c:7038 with SMTP id g1-20020a056870a70100b0018eb91c7038mr1744403oam.48.1682631018352;
        Thu, 27 Apr 2023 14:30:18 -0700 (PDT)
Received: from localhost ([2806:230:6026:c32c:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o16-20020a4a2c10000000b0054574f35b8esm8818887ooo.41.2023.04.27.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 14:30:17 -0700 (PDT)
Date:   Thu, 27 Apr 2023 15:30:16 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Message-ID: <644ae968769f2_7f4f2942d@chronos.notmuch>
In-Reply-To: <xmqq8reg96cu.fsf@gitster.g>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > No, it's for the formatting machinery.
> >
> > The fact that both asciidoc and asciidoctor happen to understand our quircky
> > formatting in this particualr situation doesn't mean it isn't quirky.
> >
> > In this particular case the parsers do understand what we are trying to do,
> > because we just just pepper list continuations (`+`) everywhere and it happens
> > to work.
> 
> I'll stop at pointing out that the first "no" sounds much stronger
> than the text that tries to substantiate it, which says that the
> machinery works fine without the changes.

The question was if this patch was done *purely* for the benefit of human
readers:

> > > Am I correct to understand that this patch is done purely for the benefit
> > > of human readers, and not for formatting machinery?

Even if the conclusion was that it was done primarily for the benefit of human
readers and secondarily for machine parsers (it shouldn't), that's still a
"no".

> > This discrepancy confused Jeff in [1].
> 
> And this is a good reason to add this change for humans.
> 
> > It's simply a good practice to follow the format asciidoctor documentation:
> 
> That one I would agree with 100%.

---

To draw a parallel with a situation the git dev community is much more familiar
with: we can think of asciidoc as the shell language. AsiiDoc is trying to be a
specified language [1], just like POSIX shell.

The fact that some syntax happens to work on all the *current* shells does not
mean it is specified, and it does not mean that it must work on future shells.

Similarly, the fact some asciidoc syntax happens to work on the current
transformers doesn't mean it will work on all future ones. Moreover,
transformers are not the only consideration, as text editors trying to parse
the same text also matter.

Not to mention blurry lines like human-like-machines like LLMs helping humans
with the code, and machine-like-humans because apparently the way I read the
asciidoc code is different than my fellow humans (I'm thinking of how a parser
could interpret it).

Either way, if the question was about *my* motivation for the patch, it was
just consistency, which helps both humans and machines.

Cheers.

[1] https://asciidoc-wg.eclipse.org/

-- 
Felipe Contreras
