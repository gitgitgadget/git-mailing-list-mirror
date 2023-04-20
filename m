Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC1C77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjDTTUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjDTTTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:19:53 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C582719
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:19:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fa9da5e5bso56074457b3.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682018391; x=1684610391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkHOlq9tPmUtBq++kEx3gJQA06Jj2je4ORhtENNV1Xo=;
        b=gnYN9muXo59eJQb6I7sHqZbijIe304zP3fL9/MmbWvTRwIa1nwPO7vvGc1IN93IZyM
         h80gkIwS7zoukhopUYITxWBKZSK+CQvRZc5bpYvdk2pX9DwD7p0LpyZzi6iMVxvf5IDH
         BCLYYfX0DJ+Sf7zFdhI4sJI5xEnbZBOp5mU+KaeK4rzD/uQkO7KpeqS9aXf+S6qZ8pVZ
         qGcCKNx1VFbEHKhyxofT8JXQI8m0+bxvxiwNDleYmLsnPsdEp2kISgzco5x/ND3qUrgu
         t0yW/xM//b2g2A22x+wssNYccbxcDcmwtSzmQEXY1o4JkRb8gJ8CJHmW0W4vmJmVNERq
         cdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682018391; x=1684610391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkHOlq9tPmUtBq++kEx3gJQA06Jj2je4ORhtENNV1Xo=;
        b=ll3pxJUO57t9zApKKbrH7C3L/ck6+4gZy0db/+7CRWg9fz4Bpdme9Pdddz2fwPqSqx
         oDcmp1UEyF/+KfFXxndhYssaGtBmCdI+2nNlvVv926Bb7PxAcMBBq0rAbkLj+kVyt22r
         keDlbqlXhhON8vZsVF/Dmli35UAee2woVRCpuzPLGzw1yJR0vvGzmGbGhEoi7cglJA9H
         GVLalNyW3mBEDbj84JO480DCOgkh97MBBggjLzSu/NWQC3rjLP/8r1d/3LwMSkgDp9ER
         eU94pgSArS+QezMErL5jKr4ESlHuh1lvJzsouIUI3SPPtwKiz1AoZ+gu69PhHVnV9zZ2
         0byw==
X-Gm-Message-State: AAQBX9fBQGfgaTyO1GBPkfRUNOWjnsJsv+tsk6HZujW2gHxzuvqgeJ7f
        YEtFS3vIbeJBrtK2v0mrVPEt5vGePTt4WqTLaCQMlQ==
X-Google-Smtp-Source: AKy350Zb96dkWEtHsVc/tw0fwpf9dp7/cRrzCDJM7FzAzZ6qbMXsILIuOahqXYX6P7HAru1WviP/qw==
X-Received: by 2002:a81:6641:0:b0:54f:752e:9b09 with SMTP id a62-20020a816641000000b0054f752e9b09mr1398740ywc.15.1682018391080;
        Thu, 20 Apr 2023 12:19:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y73-20020a81a14c000000b0054f52b73ea8sm503431ywg.26.2023.04.20.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:19:50 -0700 (PDT)
Date:   Thu, 20 Apr 2023 15:19:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 09/10] builtin/gc.c: make `gc.cruftPacks` enabled by
 default
Message-ID: <ZEGQVcblWdmdN+9j@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
 <b6784ddfe2906f7c04b3050bd9ba63a884ddb047.1681850424.git.me@ttaylorr.com>
 <xmqqh6tb7bsa.fsf@gitster.g>
 <ZEF1MSwtSl7KdjMi@nand.local>
 <xmqq5y9q1mwb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y9q1mwb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 10:31:00AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> Being listed here is a definite sign that a feature behind a
> >> configuration variable is considered experimental.  Do we have (and
> >> if not, do we want to establish) a procedure to mark and announce a
> >> feature that used to be experimental no longer is?  If it is enough
> >> to mention it in the release notes, then I can take care of it, of
> >> course.
> >
> > I am not aware of such a procedure. But personally I think it would be
> > fine to mention it in the release notes for the next release.
>
> OK.  I updated the entry for the topic in the draft "What's cooking"
> report to read:
>
>     * tb/enable-cruft-packs-by-default (2023-04-18) 10 commits
>      - ...
>
>      When "gc" needs to retain unreachable objects, packing them into
>      cruft packs (instead of exploding them into loose object files) has
>      been offered as a more efficient option for some time.  Now the use
>      of cruft packs has been made the default and no longer considered
>      an experimental feature.
>
>      Will merge to 'next'.
>      source: <cover.1681850424.git.me@ttaylorr.com>

Thanks, I think that summarizes/announces the change well. I always
appreciate your effort into concisely summarizing the topics being
queued.

> and the per-topic description text is usually what is copied
> verbatim to the release notes, so even if I forget, the procedure
> will remember it for us ;-)

;-).

Thanks,
Taylor
