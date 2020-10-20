Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01492C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E4E223BF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 02:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ei8LO+tM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgJTCeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 22:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbgJTCeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 22:34:11 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0932C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:34:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q1so409704ilt.6
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RYMq676Sa7SeeZ9d+30oAlN3KaPy0KjcmgoFrFwxblU=;
        b=ei8LO+tM34cvg4FFGu5MSfslR0mE87i+pFrFfXsXItAX/dgXQ6BBXi1lJApe6li3JE
         F5NkvavnrshIXRq7FA8cE3XHvcBA2xgM2ejYOuM6eg5MSn761U7XJHI2YNwnNINgxPrJ
         CThtB1Etf7qRUPiZyL5f0HnIq/bMl2e0DTkFW/hag9Ue8UiDL3s3HTbfof18p0IldL40
         nrCNkMwdyIGhk9dPCqYEWNKhpagONzZ6pcRbgONgpYDbPpvN2WAwysxAlqwSHDYsOaPO
         2/PLOy6VKBvCqDit9jEcG5FktEap7oCIqXVdumfoQrxhsuTnrO+jMN3QOxmdoSpdW1tT
         IF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RYMq676Sa7SeeZ9d+30oAlN3KaPy0KjcmgoFrFwxblU=;
        b=rg8QDwGc2IafOKmv+wk5EroMpp6d5MI1C4g4il7RHdddPFi8aIU+f3SJEyD5oTt8aC
         oC5mpmyGQ4OEByCiBvU6m29vPZRoMxgrXwQbStVT3Uj3XAPu8enGWlDwwkWMqnRRug/R
         95zeSyDz6huSkhPaVbuR9T0Wk4TuFRrPGGGE0kGmdhYfrHkCi0yEQJHSfr7BthbkNxIB
         8x2clNz7oHj7J3zcn5DEWEIiMvtVF6GVv5SZORA3RgBn88rCUOY3Pk7s33RXbCVzMc4B
         5QZ4fXJoXPJdl24L+whTm2fu1vDR9eCTEg123IYV2povwRPVU0AlS6JmaJdrFp8imQzK
         W1bQ==
X-Gm-Message-State: AOAM531NejdPS4+ZFdpMr/3oxrKtfHDoukACAn9wb6bAlwrCpVVSGGRU
        AfY1DT7BJ+aX4Li8F7KiwC2Mvg==
X-Google-Smtp-Source: ABdhPJwdOVPLah+TDocrmJycJbERwv1XbHd0+au7MBTSIf2hJ9h3IJV5z1MsUmuekk6ufK/W1aw/SA==
X-Received: by 2002:a05:6e02:1386:: with SMTP id d6mr370933ilo.116.1603161249364;
        Mon, 19 Oct 2020 19:34:09 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:943f:d0f4:e8b9:b8f9])
        by smtp.gmail.com with ESMTPSA id e11sm409618ioq.48.2020.10.19.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:34:08 -0700 (PDT)
Date:   Mon, 19 Oct 2020 22:34:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clarify meaning of --signoff & related doc
 improvements in describing Signed-off-by
Message-ID: <20201020023407.GB54484@nand.local>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
 <20201018233136.GA4204@nand.local>
 <20201018194912.2716372-1-gitster@pobox.com>
 <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
 <cover.1603142543.git.bkuhn@sfconservancy.org>
 <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
 <20201019220214.GB49623@nand.local>
 <cover.1603155607.git.bkuhn@sfconservancy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1603155607.git.bkuhn@sfconservancy.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bradley,

On Mon, Oct 19, 2020 at 06:03:51PM -0700, Bradley M. Kuhn wrote:
> [ Note that there were competing v2's of this patch series, one from me and
>   one from Junio.  Sorry about that; I had missed Junio's from Sunday. ]
>
> I believe this patch series now addresses all the issues raised in the
> discussion.
>
>   * [1/4] is unchanged from Junio's v2 and is the preparatory cleanup.
>
>   * [2/4] remains unchanged textually since I originally posted it and Pfeff
>     signed off.
>
>   * [3/4] is unchanged from Junio's v2 and is his clarification for what
>      Git's --signoff means.
>
>   * [4/4] is a rework of a patch from *my* v2.  It takes into account Junio's
>     comments about preferring the word "trailer" and leaving off the ':'
>     whenever possible when discussing Signed-off-by.

Thanks; I think some of our emails crossed over one another, but this
version looks good to me.

I'd be happy to discard what's currently in seen (integrated as
1b98087e0f (Merge branch 'bk/sob-dco' into jch, 2020-10-19 at the time
of writing) in favor of what's here.

Thanks,
Taylor
