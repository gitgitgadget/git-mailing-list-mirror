Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC8C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD629207E8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikI81CR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE0VLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgE0VLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:11:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB50C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:11:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e1so25663924wrt.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 14:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sMkZ8CAOesFNl3apPz+dxvdim0U04buYE65CvwRoCuA=;
        b=ikI81CR0CrL/KO8LVZGdyN13XGYT2VfV6srmAU00uN9hvi26vjskxubWHH0hB1oofW
         iloTX5kRv3OYWbG9R30f0R+UAVzO8MiuU7pGjrDXaJd5iQltonAuLodptU6Fg13lMGPc
         zx7nxykJAhVSKz6ALITj+Z6etbOjQTqvfCaIMMPdh4ACToV3VsGarWDxoI2ePZwAEdeS
         ySTCXmxmE1CxTDk+4N2cf5cZ6EF0U3gWL6TH3oOUC+OP73DPeU91+gTSd0YPBklgA7yy
         /FO5tpQx3a4Z6O4Mb/RlCle8LKB0HKuvPXibd7nLzjgadEEI89rXdXoVAbQX7RJPp8ZQ
         xllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sMkZ8CAOesFNl3apPz+dxvdim0U04buYE65CvwRoCuA=;
        b=k72wbQqJ3+LyLn3S5f26GQgKlJZ7sH3jl2rWSSmuh0Nzv77xMcJvtUPLEH6OoSB1aZ
         BbEjlPXHjJwEzdJBZBzGPrJMnSg4Blk2UbjvZDUIuliOr/6a/TgbQiQ6gcQ8M6/cVbG6
         FSHWDg2i31y1IrI3RgB6IvnKyXew0hKSc6qencKMvJqOTEfuXnT//cO/vD3i3pdG/tEl
         5dFHIRGrPsmcSp5i3HH+otp2actRzHHSB0lht2KyZ8A4pt5rw+7lr0Sah3J6L6ibw76h
         w02DxI7NiiM/Hg3ueEUbWtmFoc39Bwvtxm4yOJ0a2j84DYSqqa9ZHUmJr4kk3ypeuyHl
         GYow==
X-Gm-Message-State: AOAM5324sMovV+JOs8c2Z4lFi6nqd65NcTrjPUIWN97KjB7Pif/FZ1S/
        QriEIO4yysbYa047JFq6hDygzbpBwxiz1Q==
X-Google-Smtp-Source: ABdhPJyaaE3/zBIRI3gRwLRWQZFCrdQ+vBWUtpD0UZg3QHZwCRBJ+BS8cTfP6sz0r4qHjCsWPB//VQ==
X-Received: by 2002:adf:a4d6:: with SMTP id h22mr204362wrb.300.1590613903552;
        Wed, 27 May 2020 14:11:43 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 5sm3829865wmz.16.2020.05.27.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:11:42 -0700 (PDT)
Date:   Wed, 27 May 2020 23:11:40 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Hariom verma <hariom18599@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Draft of Git Rev News edition 63
Message-ID: <20200527211140.qbgbbitoxr4mx7gk@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Wed, 27 May 2020 22:52:31 +0200
References: <CAP8UFD3MvaAPMUwc=hW-bayDbNpxSX3jtMiPQro4b2Ai17GkNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3MvaAPMUwc=hW-bayDbNpxSX3jtMiPQro4b2Ai17GkNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Christian Couder, Tue 26 May 2020 at 19:10:32 (+0200) :
> A draft of a new Git Rev News edition is available here:
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-63.md

> # Reviews
> remote.c: fix handling of push:remote_ref

Wow! I don't know who was motivated enough to go through the history of this
series, but I am impressed. I just sent a pull request with some
suggestions.

This series was a complete mess, a lesson learned is that I should stay
focused on the original scope of the series, rather than try to extend it
mid-way when I find other bugs in adjacent areas. And instead fix the new
uncovered bugs in other series.

> This led to some release confusion as Junio then had merged the 2 patches to the next branch, while Damien had sent a version 8 that contains only his patch without the triangular workflow fixes and test cases.

> This last version is now merged in the pu branch, and will is likely to find its way to master, while hopefully the fixes related to triangular workflows will be re-sent separately.

In "What's cooking in git", the series is marked as stalled, so I think Junio
is waiting for a reroll. I haven't forgotten about this series, but with
the current situation I did not have time to rework on it.

Meanwhile, the version v8 in 'pu' does not detect triangular workflows (since
I ejected that patch).

The version v6 in 'next' does, but there it has the corner case of
a branch 'foo' which has a pushRemote=foobar but no remote and 'origin'
does not exists. In this case %(push:remote_ref) detects a triangular
workflow but `git push` does not.

So this is really a minor corner case (and I actually think its `git push` which
should be fixed here), so it is not too bad that this version is
in 'next', especially since there are still other bugs in the ref-filter
machinery anyway
(see eg
https://public-inbox.org/git/20200418173651.djzriazxj5kbo6ax@doriath/ and
https://public-inbox.org/git/20200416152145.wp2zeibxmuyas6y6@feanor/).

Best regards,
Damien
