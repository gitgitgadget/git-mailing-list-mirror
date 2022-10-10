Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF364C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJJSOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJJSOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:14:16 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BFD6CD3B
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:14:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i65so2214154ioa.0
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUj12G2yWKXycC3YGJCmkdHqX5jBGvDjGvbemkZ0Heg=;
        b=VKMG1wwst9vLPmwNDbgR2sqKE2D6u3SA8F9Nhfw7lErWHIY5+J/dNa+a0S7SR5Tsh+
         CfvKmHdIWp9T5E2Agzal9EVmjRUCymhdxNaf0xTRlSSPR4scDnnd67cr33H3qLK0A+cV
         +CGcDmB46Y6pgE9qxLE3dz2FM27QaEFopvIMdmLENuUrDAvaslr6OHN60lBK2QryW56K
         vSu0MFTXkmFf8fs5TIShnfJXnaD1k8aAnXmQpapswYK7w+w6F85bO/y3Cf0XMmpBjZ5M
         Fx/opFuEjZbvDkZ/98VBf2xlmO2lC2sMnghODn3Jv20ND9g2rzEj79LYCjop3+AB0L4O
         FKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUj12G2yWKXycC3YGJCmkdHqX5jBGvDjGvbemkZ0Heg=;
        b=QFDW4/uTpLVGKiXJKXLjJ9/dHFKm571ovoLuurPjGiyFeduSkezPV/xTGp2VavmLng
         MN2g8s9eOsAQv2ATny0xAt2Oq3fQjMQ/kf/pPjt1WyCRsMsUjb5jkyndP1X6i8T/0kkR
         ewXhnnVGQaKdGoLywxycxyxYXWEgvWTRA8gj8oDHEtbO/Maef00kCZ7WvVHBBRvSnTrk
         9fjUbmqw+7+kMoaekZANdKfaSoXWQfWpSGdRPCS1F3aSqilTUkethj859umWnbUbKNmH
         oi65Rr4EAT0znHxX3NeEtsuIkkPBFbIEDLmfcrsmYjxx0TlrRS2YEddlg+vIMmz5jVro
         hGSA==
X-Gm-Message-State: ACrzQf0b9+OiA1TgGoaq7HKoP1dlALFqJ8syT7wZsEhtXtt5FLVFs1+y
        to+EYngjJU/KwzFbj6/7QncZyw==
X-Google-Smtp-Source: AMsMyM6PffceHYlzLDTh6icemEnwfmqJJWwUg8n95UlJfxtjutmgVviy1lkCG3eHeG4altyNgz3fhg==
X-Received: by 2002:a05:6638:2414:b0:35a:b7f0:492a with SMTP id z20-20020a056638241400b0035ab7f0492amr10637178jat.78.1665425653778;
        Mon, 10 Oct 2022 11:14:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h4-20020a02cd24000000b003635a42d653sm4187650jaq.134.2022.10.10.11.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:14:13 -0700 (PDT)
Date:   Mon, 10 Oct 2022 14:14:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        orygaw@protonmail.com, rsbecker@nexbridge.com
Subject: Re: [PATCH 2/2] grep.c: tolerate NULL grep_expr in
 free_pattern_expr()
Message-ID: <Y0Rg9My2EaWl/WCU@nand.local>
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <cover.1665423686.git.me@ttaylorr.com>
 <7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com>
 <xmqqy1tn36pc.fsf@gitster.g>
 <xmqqsfjv35xi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfjv35xi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2022 at 11:11:05AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> So I think the right thing to do may be to allow free_pattern_expr()
> to take and ignore NULL silently?  Ah, that is already what you are
> doing in the first hunk.  Is this second hunk even necessary?

Right. The fix in my patch is to have `free_pattern_expr()` treat its
arguments like `free()` does, where NULL is a silent noop.

We could do with or without the second hunk. I dropped it to avoid
confusion, but it seems to have had the opposite effect ;-). I'll keep
the if-statement there and instead drop the latter hunk.

> I wonder how calls to grep.c::match_line() with opt->extended true
> and opt->pattern_expression NULL, though.  It should die() at the
> beginning of match_expr_eval(), which probably is OK, but somehow
> feels unsatisfactory.

It does, and we can thank Linus for that: c922b01f54 (grep: fix segfault
when "git grep '('" is given, 2009-04-27).

Thanks,
Taylor
