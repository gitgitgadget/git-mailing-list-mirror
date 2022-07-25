Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37558C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiGYXjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiGYXjR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:39:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF5624F16
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:39:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id e16so9886538qka.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gx3TUUKSTXq5QY/aOB6nBhwHOzNVRFuVLODhn+R0/Qw=;
        b=jXYgQ8uVG3WRjSMhaNKW6uYm6GtoFvNEGDsoNitvG+7Rtgf2Exmcf53TQpVmrT2QRu
         rXN87Pz1gU1FWUWeLE1A0FeL66euaZNmJ7sHkBAHln1K0d9pCUdvS2yJFU2IIAcQpIFA
         VDZbmoPdN6pzVLTdLbnXnIgjqyWmD5snGECAo6DwLIzcRk3RJKhgGKSq6OoLC7f3kaiW
         ogWt3XsSVeOD9mVlQvqNhacrVt9isu6Ifx9GNa+/6AO3sScbAVExPBVITmEWdoJJY7Oo
         AySNL4UBfPtobCs0v/yUc+mNilK/i0saUp9ralQR8dfYoX9tcsXU4MwohTZ592dSKfHq
         uIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx3TUUKSTXq5QY/aOB6nBhwHOzNVRFuVLODhn+R0/Qw=;
        b=NM06+eKQoXCLbxrDS3g5gkbwid56F71PQsYIYaACFLvldzLrsMwrMiN3vEXCb/IZoB
         A4ooKWlRsN6dtNi3j7JAdUb3/VnHK3tcjQbSp5no4MLReQonDLfHszfqLmwS/QUGSTVT
         fPZoLCdgPCh0Kfk+Hf0MHGOZV5/5vxGwkH5XEuVH/aRIoygCo9dQuu4y0ZkEherfdAv4
         mbRHw5Rku/oOEn7OM3XalOMhJooKiJxkcVftwQfkTt/cISJ8HG+uxjSj1Owl4YPcevWg
         z0JvhUBW81Xp2h2TWTaXaQ8OxmHfL/eHWWVa2Lrv2ZRQNd2XIwFA/Mteey49T9Qtm8F5
         dm6g==
X-Gm-Message-State: AJIora9iuUtjRi85RWZ+wkEDz5Xy8NZEfpmurwJWkMOYVUR8JTXPxPeN
        mIXnYxHg5BJPkaiT5eSO9TpC00GH37129Q==
X-Google-Smtp-Source: AGRyM1ufNWbAy2oFMI/OF4BgCbeTFAPV4qsKdidIr49o6d0pz5zEEycF45BdLFGX8hVgfdqBUwPTew==
X-Received: by 2002:a05:620a:561:b0:6b6:1b3a:5379 with SMTP id p1-20020a05620a056100b006b61b3a5379mr11076420qkp.111.1658792355534;
        Mon, 25 Jul 2022 16:39:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id de21-20020a05620a371500b006b5a12eb838sm10139580qkb.31.2022.07.25.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:39:15 -0700 (PDT)
Date:   Mon, 25 Jul 2022 19:39:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with
 `-z`
Message-ID: <Yt8pohJWhhnDrG1c@nand.local>
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
 <CAPx1GvecmCD1bJDuEks0edu_dwcH92MN4A2Lyj_Tb5W=WtzKig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1GvecmCD1bJDuEks0edu_dwcH92MN4A2Lyj_Tb5W=WtzKig@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 04:41:54PM -0700, Chris Torek wrote:
> > It's tempting to think that we could use `strbuf_getwholeline()` and
> > specify either `\n` or `\0` as the terminating character. ...
>
> How about:
>
>     int (*get)(struct strbuf *, FILE *);
>     get = opt->nul_terminated ? strbuf_getline_nul : strbuf_getline;
>     while (get(&buf, stdin) != EOF)
>
> or similar?

I thought about it, but it seemed cleaner to lift the ternary out to
capture the result, too, leading to the if/else-statement I sent in the
patch above.

If we wanted to change it, I'd probably suggest a more general-purpose
strbuf function that implemented this behavior through a single call.
But it sounds like supporting the carriage return character was a
mistake from the beginning, which simplifies this direction quite a bit,
anyways.

Thanks,
Taylor
