Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A66AC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CB46008E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhH3Xzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238914AbhH3Xzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 19:55:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE455C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 16:54:56 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id f6so22571450iox.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YQ/6l+GI+deb5EtuRcqfYJYgQi0H9l/fqurhbhR1JLs=;
        b=onRg3xpdspI4miK+8gR9NtOFpivAf9cP241PY5k529Vu3CCZXxVaZBi2bb9ulpq0YE
         aPzMlbKl3eNhMz6Bs2GzX9ppkSRCbGLsVzgMuUSIDB1mGR9137DyDyblmsRBQnYmuIBd
         2wCKVcDqgmrasUwU2MV0hpruYipdTDwX90e6LeaGtuLB/rx+qxEOyyw7ZnqBGHmoVQIu
         Wnd9+JKClf8VVp4iX10tKVZcvQFBHkQX4dbLDAu7KW+YoT1kDhg9teYZzYzfe+z/Jxr7
         iDCwEAEHTyvvFOi78SkK6loL8lkJ+HAHO5027CUTe/OarVVi3DbXMMhedo+OFDCQhzTy
         acNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YQ/6l+GI+deb5EtuRcqfYJYgQi0H9l/fqurhbhR1JLs=;
        b=rk8gtCNFuIOmSmzvC12lj/4jiUD+5ikyDRTpB9G3vq+2XkOXH6zb4S5FbbswKcNXlE
         P2CQotk2RazSMW9sLkueohG7mBgof/zBhXHKuMFBDzXs29exWqkcfYHbUBUFP9mI2YSB
         jWuA0h9KWP4n0DCkkPYyYHJlQ5bRLmsZhyJByN5pzliiGQuAbDw0Dq/WSsU7FMEOb9h/
         kXiUIIOKv/neGjzD2agVcSfJoMs6cnIFfNZiUlmbpywyuir/zmOWdsobAXkaiEDn3jjK
         Ccbs5d5M7VVpC+Xc7fgAXME4rE9zRWU7ViuodBZw+hJDIn/FSLX2W4MumWzZWbhOU5rz
         HIUQ==
X-Gm-Message-State: AOAM5312JoDInZFcvKiI78yX7AVLYvDDpasIl2p6Z01F+v3D0q3tMKZr
        Ccb1gnnD2DGo3VXi28WvEr92Yg==
X-Google-Smtp-Source: ABdhPJwlgwtRJNSgmPZsMNDbUhKDzq60ss/Xl+YfMt9ZghpuVDv0hkR9VuOQt3ao7gzE6W5bpjxENw==
X-Received: by 2002:a05:6638:2493:: with SMTP id x19mr145839jat.57.1630367696260;
        Mon, 30 Aug 2021 16:54:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i18sm9304256ilk.84.2021.08.30.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 16:54:55 -0700 (PDT)
Date:   Mon, 30 Aug 2021 19:54:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/7] commit-graph: usage fixes
Message-ID: <YS1vz16wOyj2GPHP@nand.local>
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
 <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 02:30:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> A re-roll of v3 which should fix all outstanding issues &
> feedback. Thanks SZEDER & Taylor:
> https://lore.kernel.org/git/cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com/
>
> I dropped this myself because per
> https://lore.kernel.org/git/87im14unfd.fsf@evledraar.gmail.com/ I was
> under the impression that Taylor was intending to pick up these
> patches as part of some more generale usage() fixes of his (which also
> touched multi-pack-index.c), but his recent changes to fix
> multi-pack-index.c didn't pick this up, so here it is as a re-roll instead.

Thanks, and sorry for totally dropping this on the floor even though I
said that I would pick it up. Since it had been a while, I re-read
through the patches and they all look good to me.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
