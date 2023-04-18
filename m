Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94647C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 14:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDROx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjDROxY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:24 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3CA271
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:53:17 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe82d8bf5so147331307b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681829596; x=1684421596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3G10eq3yJTh/SokhElttax/0msG7ICJGyS+5kBR1Ey4=;
        b=iPpEAFpjsVSCA/rB+qztOZ9BEQpy57BB/zvswxSvmgZ4vdawx/agui8dcGYn2AFvcU
         l6EXew8TGV4W/dFFBLKBZx6SuK8iKIHQ3v+SI/rg5HCMB7H9PmOSVlLlsqvdEFsKiLUX
         lhdAKDJG+U35PCkZdW4r/BoXZ0DNzpGfzPL9ZoHC02HLCRD1Mwzto+4YiuNDfBEgfPc1
         Mo6xFxs4WeZI2A4A5ShukV4FVPvvp0aSxJnRbhYOJkmUgQmBWsNGIZf/s3dx0N77puCJ
         0WT5P5/kNbf/B2fqJcgvZqHC26cgLcbm3vFlr8fc/VVW0v3Ux8a6i4D0dG8na8e0VyTk
         BvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681829596; x=1684421596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G10eq3yJTh/SokhElttax/0msG7ICJGyS+5kBR1Ey4=;
        b=fVN8WAYWPfmxOyxhq6v60KUYc5JMdZ7huXqYQ3UjRd97D/QdKIh71XNogNtTa9M8ot
         8YMSxSaS3M649WyeOkbPhDQNJRXce/rDbJ9KrfN6y9ElOmWYox2ztehKfRxkSajeTJRF
         LUpNbbU3eK4LiaVjNrxgqZIv3t0/31VGzNkx8ZK4xZHabugEGJ3Nu/nZaBp/mFa3+sqB
         T4FA+3H83wWTRYjSugbGF3E+tzOHO4yaUUboUfDPGl9Oh9X6vU2upZlFXZQ6bcB9+Z69
         OjIFeDpIanUbFhjRDRnsjHLlHux5w4+o4htqf8cmu6SKG/yA6XwwskUiB61JHgRASlOU
         MEnA==
X-Gm-Message-State: AAQBX9cPYlbKjdV53b90+Ka/GtM5Bc9EqpyH3GQmCpkmRuF7U2ecv71f
        DHU+MpOQWeo9QH8dABHRQL07qg==
X-Google-Smtp-Source: AKy350ZhAXBmYteoIcWPp2auS7POd7mejy9HNB3xMFO1mp6Kjkb/ih90m4a/h5Pq7MudZK9iD+fT+w==
X-Received: by 2002:a0d:fe06:0:b0:54f:8171:38db with SMTP id o6-20020a0dfe06000000b0054f817138dbmr79376ywf.32.1681829596690;
        Tue, 18 Apr 2023 07:53:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a206-20020a814dd7000000b00545a081847bsm3859461ywb.11.2023.04.18.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 07:53:16 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:53:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: tb/pack-revindex-on-disk (was: Re: What's cooking in git.git (Apr
 2023, #05; Mon, 17))
Message-ID: <ZD6u24OqvgoeIcBl@nand.local>
References: <xmqqfs8xfw25.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfs8xfw25.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 01:12:34AM -0700, Junio C Hamano wrote:
> * tb/pack-revindex-on-disk (2023-04-13) 7 commits
>  - t: invert `GIT_TEST_WRITE_REV_INDEX`
>  - config: enable `pack.writeReverseIndex` by default
>  - pack-revindex: introduce `pack.readReverseIndex`
>  - pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
>  - pack-revindex: make `load_pack_revindex` take a repository
>  - t5325: mark as leak-free
>  - pack-write.c: plug a leak in stage_tmp_packfiles()
>  (this branch is used by ds/fsck-pack-revindex.)
>
>  The on-disk reverse index that allows mapping from the pack offset
>  to the object name for the object stored at the offset has been
>  enabled by default.
>
>  Will merge to 'next'?
>  source: <cover.1681338013.git.me@ttaylorr.com>

Yeah, this one has been reviewed thoroughly by Stolee. We made some
minor tweaks in v2, which he reviewed and said were ready to merge.

Thanks,
Taylor
