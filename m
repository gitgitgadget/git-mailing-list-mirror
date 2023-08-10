Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99424C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHJVZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHJVZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:25:09 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D557C5
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:25:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d6265142e21so1259340276.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691702706; x=1692307506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLE8g59SFHk3cdtrE2wOU8xHCYgulIpGn/OA9p10kBc=;
        b=wypPNjjkrpxV9Ge+mEyCmBPYnqiQEVJ+r0BxtE4lbF1t43RnnGT5MhE8MWS/1lGPw2
         IFNw5phnWUO1skAGwGvZedTyQPdXPJ8ChTesIhZ4/VFu1DK4kmSKxtx9jYVc5f1gc4Tv
         YjPJvDiTfziEquL2dXyd7lmuKbLYzgWyXBBlYJcbJkZtwYHGYu4RNVf5+TC3n/aIAmjD
         P8iUZ8tAEew3QvoV3zed0ivUISK6EnpsiW0zuByO/PP4fZnde4unV8p5t+VYUfs8R7Gc
         64nqm8YKEwrnVvYGQlruU6aRtNk6Qoj++dBRKQGFalRNLmkiOYs5GH2p6VuEeQUqhD9R
         hRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702706; x=1692307506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLE8g59SFHk3cdtrE2wOU8xHCYgulIpGn/OA9p10kBc=;
        b=FZ99cetfWeeGGPKXmeEJ8Bubhd9/jhE7JgwcW9psRjMeGC9e3ITw6hRLPyV33S2iza
         KmC3EeUz5Zqif+dQyxEWS1sTNlkT55LhlWoCazN8uxdDsaVRC6Ake77DtUEYcNEOCyaf
         cY63ZbDyAm4H/cIM0TATNlfGuUqU1+d0OVGOxJOQUcgDTxMLDBLFoA13t3uHEwtrdoSN
         G5xQF7kxg2LM3wGwsfz+1FDoVagktLtCExXGz4Vwp4U7rHLPAftjV1nBaHnTcaApWvLy
         7tor7y89H/STaqI/fdfcqGr8hlONOElZ77MYzVPiSL4bM60bt+jQkyF+yZOwCD5xiSHq
         uhgg==
X-Gm-Message-State: AOJu0YyjcIv9Cb6lXeW+VxKWujhRmyBYuRqerGVQ4SibasCFpr2DiyfC
        +Iwu9iXz4QDOcl/ciGtZp3Syhg==
X-Google-Smtp-Source: AGHT+IGui4TXFVfPnvwL0saORQYfT2KBmV9yqgO5P8O3NAV15S3N1mI4Rt3NmtUKUzilCVvdhRxS5w==
X-Received: by 2002:a25:b203:0:b0:cad:347e:2c8f with SMTP id i3-20020a25b203000000b00cad347e2c8fmr3798133ybj.39.1691702705759;
        Thu, 10 Aug 2023 14:25:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u10-20020a25ab0a000000b00d16445dc37fsm570318ybi.12.2023.08.10.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:25:05 -0700 (PDT)
Date:   Thu, 10 Aug 2023 17:25:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] maintenance: add get_random_minute()
Message-ID: <ZNVVsAPfwDNIkjVk@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <pull.1567.v2.git.1691699987.gitgitgadget@gmail.com>
 <edc08023ed51890f0390aacf783d7213e82704a7.1691699987.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edc08023ed51890f0390aacf783d7213e82704a7.1691699987.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 08:39:40PM +0000, Derrick Stolee via GitGitGadget wrote:
> ---
>  builtin/gc.c | 10 ++++++++++
>  wrapper.c    | 10 ++++++++++
>  wrapper.h    |  6 ++++++
>  3 files changed, 26 insertions(+)

Very nice, this patch LGTM. Thanks for working on it!

Thanks,
Taylor
