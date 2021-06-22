Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25796C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A79360FEB
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhFVP3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhFVP3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:29:19 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE9C061756
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:27:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id v3so14717027ioq.9
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x44WpEgY/kWaOrebSBMqm5L7w7nrgEVdyBm2LAU/TPs=;
        b=dDnRw23O7+p89nZRn9pHmyq5sciKVzKyb5YryHAMjLwGPkXvzxZmtMkOnCs7JBChl5
         LBNXQhWrOMwJI4cLWrjMAMO+6eIceU42RfY/5rj+ckrhJGdv0WoAYiOPD8vSyhY5Co+0
         cC+wkjqz9+NL72NAkjCEKa280WuY1aDmkhf+AetOrOXyShb72gUMM2F3HjV/TJCbvzgD
         +wsbRkW5rrkraEcSJdtJ9i93n3dKpUT7XALmv/JE94ifXSx6vE1vLHeR9OgVi+nqYXmT
         d1Zbnkts1BmkYTjGdx8WR497gLyj0OsxDWGGxFqUmB/tvChfzmxVoREy9BwLhPS8LkpH
         u1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x44WpEgY/kWaOrebSBMqm5L7w7nrgEVdyBm2LAU/TPs=;
        b=rWJvqI4rpexkzsWAOD4SYZDIm+OnODKqehHlVuUUrUjLG3kDFJPi/bFckW8PIk5AT3
         vENJiYQWT9v9tVqM5NIgJuR329dXRbO15fpLcR/aaSbIey9mKDndbVvbvuLmGCfYy8Lc
         Cvf4ecW6p0aLCV77Gg23pZxFFt62Xby9FTh78IKZRCEwMDn4xTNf9nCHwu7uyafDbyIO
         k930aphAnUv3qkUzEQ8lzUUoAbik9kn3ZsufvSCMvX9ELjpKNl96zXae2npFL95A6FZo
         6WKkPTc3WAIfTJxJb8D69l2zWcivtjz4Gg76ZDyWmvqy+PDcrCSKGxEZRZgM4V5rkhOr
         c53Q==
X-Gm-Message-State: AOAM533WhpZ1pi9tUcRWa7W9euDG0Wgn+Ot+psY5oI4hU68uThN4j4Gc
        sZc9m2eeTDrpruhfEy+gFC+Z4Q==
X-Google-Smtp-Source: ABdhPJwEWSrj2HPNkWrMrGE2WqPw02DHb0H9uF6d2N1D9a20obyJiEBSE+yWRPF0cSKst9u0b0u51A==
X-Received: by 2002:a6b:3b16:: with SMTP id i22mr369788ioa.36.1624375623154;
        Tue, 22 Jun 2021 08:27:03 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id c22sm11695187ioz.24.2021.06.22.08.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:27:02 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:27:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Makefile: add and use the ".DELETE_ON_ERROR" flag
Message-ID: <YNIBRboFiCRAq3aA@nand.local>
References: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-9420448e74f-20210622T141100Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 04:13:13PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Use the GNU make ".DELETE_ON_ERROR" flag in our main Makefile, as we
> already do in the Documentation/Makefile since db10fc6c09f (doc:
> simplify Makefile using .DELETE_ON_ERROR, 2021-05-21).

This all looks quite reasonable to me. I would be happy to see us use
.DELETE_ON_ERROR instead of the "write to a temporary file and the move
it into place" pattern, but my only reservation is nicely summarized by
Peff in [1].

I do think that .DELETE_ON_ERROR is less robust when running "make" in
one terminal and inspecting the result in another, but I'm also not sure
how much we should be concerned about that. On the other hand, we lose
a nice property of our existing Makefile which is that you can always
run ./git and get a working binary. The new state is that you might see
a half-written binary.

That makes me a little sad, but it does leave us with a much cleaner
Makefile as a result. So, I'm not really sure how to feel about it. I
think in general I would be happy overall to see this picked up.

[1]: https://lore.kernel.org/git/YGQdpkHAcFR%2FzNOx@coredump.intra.peff.net/

> Before this change we'd leave the file in place in under this
> scenario.
>
> As in db10fc6c09f this allows us to remove patterns of removing
> leftover $@ files at the start of rules, since previous failing runs
> of the Makefile won't have left those littered around anymore.
>
> I'm not as confident that we should be replacing the "mv $@+ $@"
> pattern entirely, since that means that external programs or one of
> our other Makefiles might race and get partial content.

I agree with all of this. Everything below looks good, too.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
