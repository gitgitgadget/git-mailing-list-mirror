Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373FEC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D566127B
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 02:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbhHYCN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 22:13:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C9C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:13:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id j18so28828871ioj.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 19:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LfNq+IW9zFitzaqfiC/G44/drg1qK2h4RO4ScZ9ZOPM=;
        b=zpykByS+ivVVCtg3nHVk4Coe5K5LHMIQmuOnihtGlTz/Cyvyy0YYlgzmb+cwrWygH0
         /KlB5NRjQLxISFc4V/Lanw7Ot8rNoVzvEHk7sY6RhyyDVGFJ0bJkJaaKdmwZLoiM2/sP
         k/S1BOCE0fVj22+xVrPfMeuWf3olTckZNOpVBd/5tIUmYphMmsZ8tfORL5/C1Izc78ea
         8yJHLC94c1LS41mlLpgXaLIVnga5tYks9+hEhkN+z/wWhZ6LVkdZCf6m/WWj5Qvjv9bm
         Q78gr41iYb7A94Kam0jIe3XqAjS70Z+fF1VkjiaueMZQJZ9QexrU1HJ1iJlYF+G2+ZPA
         5ecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfNq+IW9zFitzaqfiC/G44/drg1qK2h4RO4ScZ9ZOPM=;
        b=YuUlYndK5pIfL5SczQYlTDhCmNjlzeadqbmTlWbSSyljXNMZU8bJwbfsRvydRWHIXT
         akMs0x9ADsc52QTefje1HvGjkBj9Zt2mgGLdYC+mo/x36MGRczt0dnTJtGiXZH6qG761
         H0TBbhSWqCpP0bqhX1K6gGO+kZRfrKCBuejeER+X6iCpdxajtzoseGxi56nM6//+dG7N
         piNivrnHn89rDxfZU+NwkogG62sBJ9GEYupjjmjwelxfq5WytA572HLZUt10S590KVQF
         JDFH9rZ997DKSv0rz7se2yQqk4TvtFsI+OBpfueAKyP55BQxiY6Dk2XhMQbIPY8rhYy/
         O97A==
X-Gm-Message-State: AOAM532xSpAf6KEMmolaGInB6/l/ivTPpy2lWH4KcomVQWkCC5e8Ye/l
        C735O46ETgrpjZud/WRCu+y32g==
X-Google-Smtp-Source: ABdhPJz356CE+O3PzvhATa3e4Txn28mvgIbO5LwNYBBsfl+3XR8lMTKPLNYgnc4qt+32EX1Hy6efHg==
X-Received: by 2002:a6b:296:: with SMTP id 144mr33628441ioc.114.1629857589185;
        Tue, 24 Aug 2021 19:13:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l15sm11568806ilt.45.2021.08.24.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 19:13:08 -0700 (PDT)
Date:   Tue, 24 Aug 2021 22:13:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/25] multi-pack reachability bitmaps
Message-ID: <YSWnNP09G2wF0gd1@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
 <YSWOtNoxirDdmBXG@coredump.intra.peff.net>
 <YSWmhMID1hGs7Yp1@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSWmhMID1hGs7Yp1@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 10:10:12PM -0400, Taylor Blau wrote:
> My recommendation would be to do the following things, all in a reroll
> of this series:

For what it's worth, the substantive changes (which I have not figured
out how to include in a range-diff since they are entirely new patches)
are these:

  - Replacing Johannes' patch with:
    https://github.com/ttaylorr/git/commit/2b1afbd516a75bb43a8aae6ff1cac6a83ed7f589,

  - and then adding another patch immediately after it:
    https://github.com/git/git/commit/0a2d4d8dbf3c50eb3e2b659d1dcdf432d3b4d223

...and otherwise keeping the remainder of the series unchanged.

Thanks,
Taylor
