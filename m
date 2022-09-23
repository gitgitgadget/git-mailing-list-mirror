Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C7FC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 18:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbiIWS3i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiIWS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 14:29:36 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE410F3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:29:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d8so577307iof.11
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=C0XOvG4wiCzbUtxS6pzjMyUMwG0J2+Chhmxv4KxoS3A=;
        b=TAGpqDx4mEe5e6O4bQSCWu6goV7g3GZwKyJco1PgrKcHWSwmfSJzbrRftU40iJ0DUD
         mY+q0Nl+waZTsv1mD6PAroJ6fawvggcsRcsWjrl4oVG6npuLTeBeg2C/FGmfeJFRgc70
         2B8fjOBgA5IxN/Bd9t8V562ZvUE6UOtiwGUsvrLkmu24KG17YgItAXDh2bqZuuk//VRi
         0JQPCmIr4zseSoGuypUvSCz26lRrZn6uVUraFu7CwHoQnHdW2VmeZXN94YsaYsdihToM
         I9We8USYGTQGPkkRMv8f43pXOH9xtlQYbfBunq4jaNha5BnKbZg++Wf4nQnILsbvJ3ZK
         o5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=C0XOvG4wiCzbUtxS6pzjMyUMwG0J2+Chhmxv4KxoS3A=;
        b=QqteG6AcXA5NW/Dq0q8rhMEmbdxuzHSjjAJimyHWNWRTHeCoqEdy2wGqnr/NkB7PBx
         dqsAMB0KT8nPRoV+UBxtwXXFmGlUisZ92uJhOLHVu2fK4u/E5kis+ZvKX18DHBjNFZeS
         2tZUgAgZ4qf9PoqhuTx2WA6d/CJTsZY1eCnUHDHhhAoFCrjow1+bnbkhyZ/SwLeA1rmJ
         RPI7sr8mRSnL9SWf0nMOn4J8Ew5p3wkJsUh6xZzKvWkrvDSPUJJaE5cyXaRx8eDwPqBG
         dlPx6OsEBr39flcoR/rL8d5akN6FxX2SIOkfO4Rw4ZUiApmjNPtm2WshiIaV/zF8Aljm
         BO0A==
X-Gm-Message-State: ACrzQf0bxC3F2/OvatVGryC967afdm1j2dvZwlp531Vz6k0EJ1XKKeRX
        uagFdzHUV2EhLH1yy5zJyhBe0Q==
X-Google-Smtp-Source: AMsMyM66m+kOED6u8CjxFwu5yS7mpfDKSzj5yUgodM0P4FIx/6eET4srLOXK0J8gjkIbvOEekQ6XBg==
X-Received: by 2002:a05:6638:1487:b0:35a:ba3d:ba16 with SMTP id j7-20020a056638148700b0035aba3dba16mr5477126jak.188.1663957773056;
        Fri, 23 Sep 2022 11:29:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bm4-20020a05663842c400b0034294118e1bsm3658580jab.126.2022.09.23.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:29:32 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:29:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        derrickstolee@github.com, peff@peff.net
Subject: Re: [PATCH v2 0/3] midx: use `--stdin-packs` to implement `repack`
Message-ID: <Yy37C/tHg5Quto30@nand.local>
References: <YyokIf%2FSd7SYztKQ@nand.local>
 <cover.1663706401.git.me@ttaylorr.com>
 <xmqq35ck35p0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35ck35p0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 12:09:31PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here's a few patches that replace the existing "feed each OID
> > one-by-one" approach to implement the `repack` sub-command of the
> > `multi-pack-index` builtin with one that uses `pack-objects`'s
> > `--stdin-packs` option.
>
> One question.  How is this series expected to interact with the
> 7-patch series about ignoring cruft pack while "midx repack" etc.?

The first round merges cleanly, but the second round will have a slight
conflict. I'll send you a new version of this series based on whatever
is in `master` following the release.

Thanks,
Taylor
