Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4E1C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5643860EC0
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhIPUDE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbhIPUDD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 16:03:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E5C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 13:01:42 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id b15so7819558ils.10
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=25vEwCbr8Q7YRJsEBZRihx5H4XTtDyT10xgNDzVEwPc=;
        b=GaAeCGnbkG4+ta2UHI+MT8htdIylHQ2vs5Avg+q8HwwIBdK4aCgXcxzXbJr5ks/Ly8
         xgvg3LmwWm5Icb2wbkvD2oEEsaNxE8+lgVH4NsipBu9CtlpLrBIXRpq85qPS3mTif/SN
         EjP18CK5/5VzRE42eOaAtC9CJda9D9SflXGZitJiE7vpfTuZnizbzdeT+q5CcoJjpUvR
         HUvEO3RwwVb+sqjljKUDEYPeG5PtAO7i4X+t/Hf3KVRCiT4+1QsAC1HXdGZgPFsCEo5w
         syRmjQsUHDwX+/QaPslRTdoJq7w5SJmb61uexBxn6SUTXI8VtQ5eelsTCubmqs6R2q7J
         5Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=25vEwCbr8Q7YRJsEBZRihx5H4XTtDyT10xgNDzVEwPc=;
        b=fGo77Ko/3X+j2r2g8AsPeUBb108Lktzexzn4SMs6ie+G0Mwz03b2CwWs0UZ2sHdHay
         4wjODcZlo5FAuv+CVOKcj+ZbC2BrcWGPDcKPSGVqZc3uKBv0WCcASEbM8yaCpEOdWZMO
         M6RVgR3vZ/xN76OBZMg7nYN/NXvoqba1SAazVWrJfj9G3s+sDU+OMZXFvzn4Fog7pbv2
         yxlgV2qbOzZX3OBcmgaNkndMfbxma54CaguPIjnIjpXjx+P/lh1YJoP9Y1PdLiTSWpoB
         sQ/ajY3N9RTMK/jKLVBL2MtFOajWWjMOhVcMrMMnwDP9702OHOaBUjEBVgiDcsNjsGKD
         /5dg==
X-Gm-Message-State: AOAM531tEO0n8TqItQy8uGpQ5qJb3nfrEmzOC5zc0F/KpQtlgNcqZdCR
        fq+mv3NUlxrcN3IUKvC4wvscDg==
X-Google-Smtp-Source: ABdhPJwS+ai8vbgI/eFFPJeiM5eUm9F8bF2k3GFeWCbHBYAvREr8pP+NV+5NFkegxoFgGAFw34ZPVw==
X-Received: by 2002:a92:d491:: with SMTP id p17mr5358594ilg.107.1631822502269;
        Thu, 16 Sep 2021 13:01:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a21sm2238769iot.43.2021.09.16.13.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:01:41 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:01:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 03/22] cat-file tests: test for missing object with -t
 and -s
Message-ID: <YUOipZRE8tu+n8H6@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-03.22-d442a309178-20210907T104559Z-avarab@gmail.com>
 <YUOhqnj7vwr00Qap@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUOhqnj7vwr00Qap@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 03:57:30PM -0400, Taylor Blau wrote:
> On Tue, Sep 07, 2021 at 12:57:58PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Test for what happens when the -t and -s flags are asked to operate on
> > a missing object, this extends tests added in 3e370f9faf0 (t1006: add
> > tests for git cat-file --allow-unknown-type, 2015-05-03). The -t and
> > -s flags are the only ones that can be combined with
> > --allow-unknown-type, so let's test with and without that flag.
>
> I'm a little skeptical to have tests for all four pairs of `-t` or `-s`
> and "with `--allow-unknown-type` and without `--allow-unknown-type`".

Ah. Reading the next patch makes me feel even more certain of this
advice. Consider squashing this and the next patch with my suggestion
to use a loop below?

Thanks,
Taylor
