Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83324C001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjHGVXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGVXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:23:06 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CBBE6A
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:23:04 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-585ff234cd1so54049817b3.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691443384; x=1692048184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib3bqC8ojirS7un9gUzYX45iqzlhLPlleQicOdX6txQ=;
        b=KsA3Kb0d6a1a1dt6J5xk34vOIbuk10KDdfkddFzWkkJKBROq59UoMaP64DdAW+W9Hs
         oZa+4tmg+LVfWKL+PEEMViXU60yRyzUAHKvyHqiJ/JcEKhTq677L39VGMnpayCTFfFmV
         zvUkyLO+IwfZ4Vz8u5rQfHt25vUItUxZ5hRqLgl2TmEzNOKooHx0M7m7Kjht77fuUbdc
         iT3M89ZQSLpfWsj6kZqXj/UNaP3Fq815G5SMLzi/03Ix2i1kwPEJSOVhM2m9r/OG0tyV
         xCsE7UcMZhO+jyRyMub3qv/N1qIzV+wKd5oORTYVMg15+PiNftAJjKLaFCjozXN2mAtz
         ZkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443384; x=1692048184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib3bqC8ojirS7un9gUzYX45iqzlhLPlleQicOdX6txQ=;
        b=Osz/DVTiZNA9+gdIJpWHSVVHLl0YgFxfWeU5yn70eGDfJcZuzaZuhQlJU4Eadupzgv
         jOndqq1YYz/c6wKOHgWUzb/aF3a9jkQScE7Hzwtj12HL9U5AT9EuDvUDQp0DUnKe0hqV
         gRtqLpuYxGnY684mzNzLim+UmhvgQV30ZYEACNfN3K/g0iW3an/CW4RjUKfpKbHR/Hfv
         PVAOlAFSaAZ6cf6W/jHlCS5BQ1JmpTVJjyctppFyppBf8jGWluzOTkXlE2KLmJLWw5Oq
         eZwxfPkgw/OaDFwiiSpGhOudSLK7lezXWN4sAUYwrT6aat9bATSaU5Ayviv+5l1AS+DR
         uOUQ==
X-Gm-Message-State: AOJu0YxW/2tzs8dTbLtCZ9aioZj5vqTdJr7f4ztmbdFLVJ0+w3fI1l67
        XlGVygw3Lv+hWhsqmHCmCQUJ1+ZYSB/5TH4NUXVL2Q==
X-Google-Smtp-Source: AGHT+IF5H5wadqmDlGm8kh447UDIvTqappJ5UKwmIsbx1vrqkjsBqVmFwrMlWH/dzrmBLryLC7reLw==
X-Received: by 2002:a81:9105:0:b0:577:257d:bf0e with SMTP id i5-20020a819105000000b00577257dbf0emr12798936ywg.22.1691443383814;
        Mon, 07 Aug 2023 14:23:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p204-20020a815bd5000000b00586a19a229dsm2942131ywb.60.2023.08.07.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:23:03 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:23:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] maintenance: use random minute in launchctl scheduler
Message-ID: <ZNFgttgDTVr4sr6I@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <babf62ec6d5181c65dd4b653ba9ae24e62a88830.1691434300.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <babf62ec6d5181c65dd4b653ba9ae24e62a88830.1691434300.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2023 at 06:51:36PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> The get_random_minute() method was created to allow maintenance
> schedules to be fixed to a random minute of the hour. This randomness is
> only intended to spread out the load from a number of clients, but each
> client should have an hour between each maintenance cycle.
>
> Use get_random_minute() when constructing the schedules for launchctl.
>
> The format already includes a 'Minute' key which is modified from 0 to
> the random minute.

All looks good. I was wondering if this is something that we'd want to
allow users to opt out of, but I think that the built-in schedules are
sufficiently vague that we can afford to have a fudge factor on the
exact minute.

Thanks,
Taylor
