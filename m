Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8453FC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKHUyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKHUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:54:16 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6C25C6F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:54:14 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 63so12457452iov.8
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCCpkxcP8pwwoYV9b9VH+qbXlZjRsAZGdj9/g4hdLEw=;
        b=ZeDY/DuRnFsHrXd8NRXzMD4DXk32yXzHeEEte3y7CVoXiHz+n8/Cuh1Nc+afxd+97O
         1I27d2jo4DjYspw3sOz0qXbprvQAWEdsb40ToYUjxiNlCtZ4C5QKOpwingz7FmnraXH4
         BqgM51+fH/JFHcnb14zBPEATrVIOfSF8joLyScFweP7ns7HmFKT6JO3u6l+Rjo32nQg8
         1vi5p4xFNbdVOpeeUec1kaY6MtQGxrRL2fsoglu1mumU78eBMYJqtKJ9qp5wNKfEEE7E
         zYANRwFBj6nNdiZEyTkJBszwy8miFHqGXNlUEepYV4yt/nWNFj83clD7GfaNKbVYNnxV
         tO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCCpkxcP8pwwoYV9b9VH+qbXlZjRsAZGdj9/g4hdLEw=;
        b=6KtGqYHSZteWcIBem8IQBrnUkFxlwFCGhNmNmRLCUKWbgsb08kceGhHJVPp6W2kCAA
         r1X8pcMd1HFpvpIY2NpUQSfSD+m5xvkvBQ3SwYCy0NwGeNhIff99k+VmyCwWyfUzLEVm
         E6tohRFpRTgy9SmSAwfhlxWGUjZ9U/jE8WFmaOFTAACfo9XeSiNfv5aDiFESadC+5n8x
         DzO4O3Fc5392kIJGwMcEe3eQKC1Rj8VreE+EGy/9p/a7DrmhK0gg79E+9ydw6lvjOfn3
         VPb3KrM80qVVEInpxicACXIxvS9cY8EM8jYFbCkDINrocVr0DkJYKWfTmEsJnLg3hQ0b
         YUbA==
X-Gm-Message-State: ACrzQf3iGqEf1eykn0foAbbBTvBucVhykzGwBN/al9aQz5gdKptVtMEG
        FkdVip9jtpqBLj4g+5eeUg4tOQ==
X-Google-Smtp-Source: AMsMyM7HSRNmrjw7tcKiYdoC3KwPwBVziByZ0k5Mrb77dExR+Mv6IyyzoUu3S2XgNeG04sf3pnajdw==
X-Received: by 2002:a02:cc76:0:b0:373:4f6d:3c66 with SMTP id j22-20020a02cc76000000b003734f6d3c66mr987355jaq.73.1667940854245;
        Tue, 08 Nov 2022 12:54:14 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r11-20020a02aa0b000000b00363c1d1ac05sm4148797jam.27.2022.11.08.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:54:13 -0800 (PST)
Date:   Tue, 8 Nov 2022 15:54:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 00/15] leak fixes: use existing constructors & other
 trivia
Message-ID: <Y2rB9Ol7307mrw4r@nand.local>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 07:17:36PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This is a bag of simple leak fixes, mostly one-line additions where we
> use existing destructors. See [1] for v1.
>
> Changes since v1:
>
>  * Rebased on pw/rebase-no-reflog-action, per [2].
>  * It'll merge just fine without pw/rebase-no-reflog-action, but some
>    of the tests marked as leak-free will still leak then. So, in
>    practice they can be staged independently, as long as
>    pw/rebase-no-reflog-action is merged down first.
>  * The 10/15 here has an updated explanation about why we were leaking
>    that value. see also[3].

Looking good. I did a --no-ff merge of 'pw/rebase-no-reflog-action' into
this topic, and pushed out the result.

Let's start merging it down.

Thanks,
Taylor
