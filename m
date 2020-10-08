Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502A1C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8D9221F1
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oelFbleW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgJHQmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgJHQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:42:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216BC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 09:42:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s7so7634347qkh.11
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS7Sac0SnVVGFGbZw1qjX9VNmf6gKputC9MCCvFbjpg=;
        b=oelFbleWhVxdGMEr1wOZUC+M6rpQTwQd66i42u657LWYe6xHc+cCWbDbImyQ2x02on
         Ge43Fq6v711m/wZ/hRlrrSlUJabr1moMU/lZdkTwPMZ6hqcZpn+kb70EFGoj06t7uhgC
         3ScEsFOa410zNueELnZVRcNVslPBMaXlAWhJ4uzmJDUj73bGdlNDZWCM6C5tjr3Gjl9L
         weJPLKf8FOck8QchIOKDAcCSLCuYpmQZsKSgPdVUwycLul1mU2aS2NIe64+A4GSTKStj
         Tiy9K7acTeOJlRZWn0yaADH7fvd8BXkjSy7wFp2W5nZvNl/Y/12iQxZPKMFPdnLMEMMl
         8HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS7Sac0SnVVGFGbZw1qjX9VNmf6gKputC9MCCvFbjpg=;
        b=e3CcrZq2+c2LXts4g9EF3c/4F22L5elNB6UUp0r420JU68867eVwXl1313L+rFSlLi
         PnKUT1OVvfnJgOqmjIAjH5RvVfZm+UctzGbnfCrX5cZOuTAVhASumw2hb7xcZZXXmctK
         ElsV7QxLmBPHU6fL/jgwJKVloney2U0LH8EQQiwEzEI0H+v2meTa5MQcsQuUbWPHEPQs
         Mo4iCc9uyv6BtTJ9dsZxIdL4LKhjnXWg1uMTWF1sw75RgxfuxJ0kWj/JLLKhVvZ/MBq+
         uxcKL257f9agNZgey9KWzpX490eHqGk5obVKidSCjeWMB62T2dhdPNV2cg1jCH8CrOOT
         wXlA==
X-Gm-Message-State: AOAM531rQrlbyVbRGjgIAatia7TGWlSne98MAl9c/JC42Y2oiLxHujMq
        5N2pJjPa7+L20uXQrRj5lQZZGg==
X-Google-Smtp-Source: ABdhPJzj5CJeBuxWZYeVJ++EH/XAWQ2LYG876zgA6zIgEIYUQtwv9iTt6btELdZ6ZI35MA08LNvsNA==
X-Received: by 2002:ae9:ed13:: with SMTP id c19mr8825543qkg.196.1602175365356;
        Thu, 08 Oct 2020 09:42:45 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fc6e:d5fb:44be:a174])
        by smtp.gmail.com with ESMTPSA id p5sm2470949qtu.13.2020.10.08.09.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 09:42:44 -0700 (PDT)
Date:   Thu, 8 Oct 2020 12:42:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] commit-graph: ignore duplicates when merging layers
Message-ID: <20201008164243.GA358741@nand.local>
References: <pull.747.v2.git.1602169145625.gitgitgadget@gmail.com>
 <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
 <20201008155304.GA2823778@coredump.intra.peff.net>
 <e1d4c427-b9a7-261a-6297-4a4768e8dbc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1d4c427-b9a7-261a-6297-4a4768e8dbc0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 12:26:29PM -0400, Derrick Stolee wrote:
> At this point, any disagreement between rows would be corrupt data
> in one or the other, and it should be caught by the 'verify'
> subcommand. It definitely would be caught by 'verify' in the merged
> layer after the 'write' completes.

Yeah, I'm fine with assuming that this data is correct here, since we
would have already "checked" it after we wrote it.

Of course, that means that if we find another commit-graph bug that
writes bad data and fix it in a future version, old commit-graphs with
duplicate objects have a chance to persist their data.

But, we again have 'git commit-graph verify' as a last resort there, so
I think it's OK.

> At this point, we don't have any evidence that whatever causes the
> duplicate rows could possibly write the wrong data to the duplicate
> rows. I'll keep it in mind as we look for that root cause.

Thanks.

Taylor
