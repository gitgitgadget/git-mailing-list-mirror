Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2B5C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4DD23117
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 19:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392944AbhALTyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 14:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392852AbhALTyW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 14:54:22 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FDC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 11:53:36 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so2421368qtq.12
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cS1Wk2kwHEE/m43Jke5pJZMp+QAsQGGN6gEYOEE32sQ=;
        b=G1jvrrvCJZ+lk+d0FVu4BnN+t5QXDX7e+K84jCUDBWPFsJgTTgjXZdS8A0ahtzmBtz
         ai6LTfs5+AnOrBSbRhLyZ7z1X4lNKJrpm3SOsWebntr6SFW68f8GdoaVoidaq0ecN+JA
         eh1MI5VdLk8wDr7fvPac6ZAFIqeClu2rsG6R7RPN4dNDbE+MXNeBAL1/8e7Av165Uyue
         7+yBi7cehRnyTLCss0xEVAlnHkQXf2pArFrhfuXfuCPaogxmqjR3M+8s2gR8+WS0fk4Z
         bKhMXy4pKgX/jw2eNqA6TWVVyMCKqPQmqJhd9tADanKiz3kY6nGmv5USNhvmkPIFUVWn
         LbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cS1Wk2kwHEE/m43Jke5pJZMp+QAsQGGN6gEYOEE32sQ=;
        b=tj2wijR3ZM56bpTWu+feBAXE8wG2m7QtIMNBQHSiK1VgTmwkKzBmDXhMaNzdPcbcNU
         veI8XNXfXoM99c+P7KQGBQ94CK/nhhCyXhsw1bTTvpWwDAS83LxhAH7wyz2xFi8vqXXH
         pTBp36FsZtMdLRni4H1/mC8TfeIj0zl4jxQIb0TWb/Q6+PRE/Thoi7lWodwrs8YYRqq1
         yStqJQTtOv8lJbWawJDMvIOJX1wCwMn45TV+r+WlADBGcgxP+zwh1uK+2dF7fkgkVvWU
         pKyfXi7DwIR0SlwvfZ9ssiP0uyNGRlnN8kVlEfqlZ2mIgmlPmfUGqX7hVfHpGnrm7wdO
         YHtg==
X-Gm-Message-State: AOAM533jdVbrKlssA88bbU9oT2LzTf6fvtZPx/5n536GXAeNjUaq5vWR
        RUYfYIG9ZXTnmoWXDlzOyig2zrUtVEjF/g==
X-Google-Smtp-Source: ABdhPJzNCuKaTSlAouuPOZ+szpRJkQElXzXR6YeJQZYX5399RZK5Y/OGZtOh2UCZQ75Zjg6Di3EAaw==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr679341qtu.105.1610481215254;
        Tue, 12 Jan 2021 11:53:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id 60sm1687090qth.14.2021.01.12.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:53:34 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:53:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: test-tool: bloom: generate_filter for multiple string?
Message-ID: <X/3+PG2hi71tj/UA@nand.local>
References: <20201231035438.22533-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201231035438.22533-1-congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 31, 2020 at 10:54:38AM +0700, Đoàn Trần Công Danh wrote:
>
> Hello,
>
> I'm reading the code for Bloom Filter to see if arXiv:2012.00472
> could be an improvement.

I'm late to the party, but I'm curious to hear which part of this
article you think would help out the Bloom filter implementation.

(I skimmed the article you're referencing during my time off, but
haven't come back to read it in detail since, so it's possible that the
part I'm missing is just totally obvious.)

> I'm not sure if I'm missing something or it's our test-bloom generate_filter
> doesn't really support testing for multiple inputs.

The rest of this discussion downthread seems sane to me.

Thanks,
Taylor
