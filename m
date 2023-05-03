Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DA1C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 22:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjECWId (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 18:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECWIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 18:08:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44783D7
        for <git@vger.kernel.org>; Wed,  3 May 2023 15:08:31 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9a879cd49cso8247434276.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683151711; x=1685743711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btgGy5vXO5Um57pR7bQPV2e+4m1XHRoq1T1GYXwksX8=;
        b=dV3gIBB31HfUenwltsB98AQoQTz4RtGfgihkr/2LoTDUMefSmYdD1gScWUaUQQQAyH
         SlQR9P9NVDwvEn1WOrwp+CVraYHSW/sfdR6zuuhRlZQjaxhghz1TVvkroX80LV/Nu9vW
         0o9va/aiVGGP9meoW/mk5kGkan5x5ZpA+2X2C5cjK4WF6+gG5Opq4yq8f+aVfeYNo7vD
         9A0cL35FPW/5ndLtyAtKTQOQXaDfCDjccDBrxW1ZIfuOb4lY7CTKw1M5GqY6UfJDA726
         t+xe4AxjMKlLp/2qwcP43WuyMuKj/HMLiMSQiAW2faw1qAoZet1J9G1Pw/d13hdJxSWX
         8Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683151711; x=1685743711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btgGy5vXO5Um57pR7bQPV2e+4m1XHRoq1T1GYXwksX8=;
        b=MeY9aHzf5kWaYH43Fx4x9Ul65ZcnlRo61eQiRhSZrkclvbME1C0VwpSwRUdt2lxPtg
         G1tK/D2FsDLLAb3sj233SONw/LJX4T+hbiOuaDmee1+QW2kDC2H4zLYhsPoDCL8N9voh
         9PaLoXcS30dtXKPqW/VmpvX+yWrk0lonXp/+MUgZsBCtSe7RajR0bQxfqahq/96CeoJj
         Q6iN2raX/u17KCf2xGKnShEGZm4rzIRWiqnQbepkXMr38P+OazAbjZYDLQNEQ4wzKDq4
         rrS5Fegt5rS/oyXXuv19S+pTXyZ92/eaeoI3mRb+yBczooRmHq83gf/Bu1u4GdXk7kRl
         9Npg==
X-Gm-Message-State: AC+VfDypKTXm7Ap4oqKjj6q9HbnsNv8cVA/zhOOF/cORwl/abz2B8Hwq
        7sj08JJXQXjZO63j6C4w8AO3SwUMovXCfquuQOKldA==
X-Google-Smtp-Source: ACHHUZ4Kvyz6NWCwLSIuPVvETELJdzVydga85SU/kPL5PpLOJpsWTdf1gcpXuGrkY6eb34cSBt0FVw==
X-Received: by 2002:a25:d891:0:b0:b9d:c98b:5650 with SMTP id p139-20020a25d891000000b00b9dc98b5650mr15433770ybg.49.1683151711005;
        Wed, 03 May 2023 15:08:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d4-20020a251d04000000b00b9a80b9e08esm3928480ybd.12.2023.05.03.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:08:30 -0700 (PDT)
Date:   Wed, 3 May 2023 18:08:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Message-ID: <ZFLbXTKOK6KTEy7q@nand.local>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 02:15:49PM -0400, Derrick Stolee wrote:
> I know that the walking code in builtin/pack-objects.c does
> this same computation, but it's muddled with other checks and
> the trees are marked as UNINTERESTING at the same time. It
> doesn't seem like we can reuse anything directly out of there,
> but it did give me the idea to try a callback.

Interesting idea. When you say callback, do you mean a function that we
invoke in place of where we currently call `add_object_array()`? Or do
you mean something else? Curious.

Thanks,
Taylor
