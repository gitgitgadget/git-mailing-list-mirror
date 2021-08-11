Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675FEC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DE16101E
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhHKWth (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbhHKWth (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 18:49:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916AC061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:49:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f3so4716590plg.3
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucm5UVzDXxmCA5pmoe6T0ZNV5P/O7WAGeCsotjKq0rg=;
        b=h0n1B1fxQ/oPaGzLoo1FOjF1MVNdMY2gyeMBe/9KCHY8tYd0YmcBdLtz8Jcy/4JUBv
         l1qAdigwOZO9LNzg6QuXDlrEeCbZe7eW8QwcwTrod8XCG/lj4qZqLv+9HUUyR/JbOoDF
         G5o17U7wP/s39inhE8wqWXFDdw/IRZ6uIS+mPwSpxHrIqI+jXuZvMyQnFq6tSfJLDSjQ
         dd+3Nu+195u9chwNz6Gm9cajUL4o4Y1KEoAwrO5dKoQELd5otP9Nf2RdoYxBuqDNVyx5
         wqfinkniUhkLP3dQOa7Y5Ho/3tAfQPwa0e6i048RzHohNTmxKbWqF6R28DJHZadwJXWs
         qgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ucm5UVzDXxmCA5pmoe6T0ZNV5P/O7WAGeCsotjKq0rg=;
        b=GfTmbYYLHT9bmMJGOB4cb2jWT3B4KDgM8UeEtdFvxl7G7JIcIdbCjiiibNWUyH/ero
         XUC3VFv3lWTj6J4DtFL1y6sboNPpNSFoti2gtQ88KA8nZUL9hpOfSIJ/j+ybsABKmkzb
         dDi+cNnVPGuV0pyg03YChaBzLzyJzjEcBR/RF7BwJTx8Beu7C9gUZMM1NuPSNBM8mzys
         deoIxWdxe/46ehw7t0OrywLdQdh3mWZw+YLZbrpFstneWcipRkaD0TbvQwnKHmTeqSDU
         IiSQv9Nh+rY+2horXUVKECBHE8/tD3xYpSLwTifmDdZNsR5rDkC38G916fl2VRXH5C01
         hzPw==
X-Gm-Message-State: AOAM531epfS230Hb0R78zSedO5opCAG5+2sDn0TDdO+rq54xoMj+C75/
        3hycSDFwPJOUzLbo1EhkPUa38uGR/eGKkg==
X-Google-Smtp-Source: ABdhPJx5dv/SJcezh2s9IS5bDDm8FXaKD0eUg9phjaszJyB3GcsL+N0BwXA+exzGN+t/EHOrvn9lXA==
X-Received: by 2002:a63:2152:: with SMTP id s18mr983516pgm.25.1628722152252;
        Wed, 11 Aug 2021 15:49:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ed93:f007:3c2:569f])
        by smtp.gmail.com with ESMTPSA id c12sm602317pfl.56.2021.08.11.15.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 15:49:10 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:49:04 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] In grep, no adding submodule ODB as alternates
Message-ID: <YRRT4I3MPoZXJZEl@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.10 11:28, Jonathan Tan wrote:
> This patch series removes the need to add submodule ODBs as alternates
> in all codepaths covered by t7814. I believe that that is also all the
> codepaths covered by "git grep", but if it isn't, the uncovered
> codepaths will still work - they will just not benefit from the
> performance improvements.
> 
> In doing this work of migrating away from adding submodule ODBs as
> alternates, I'm mainly motivated by the possibility of adding partial
> clone submodule support, but this has benefits even for those who do not
> use partial clones, as described in the documentation in patch 1.
> 
> To reviewers: you can cherry-pick the last patch onto one of the earlier
> ones to observe what happens when the code still accesses a submodule
> object as if it were in the_repository.

Thanks for this series. I am very excited to see steps toward enabling
partial clones for submodules! And having fewer implicit references to
the_repository is great as well.

I don't have any comments that other reviewers haven't already
mentioned, so I'll just add:

Reviewed-by: Josh Steadmon <steadmon@google.com>
