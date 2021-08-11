Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE0C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC11061058
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhHKVaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhHKVaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:30:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE33C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:29:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b7so4455173plh.7
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUjlxkmy21IQBJbwUlxAQ08DoMlb4wNbWpIL7L8B9xw=;
        b=CtqUJEsj0+YkDGlEErH5cY76mHtGyGgnXAZEZmfkASGpxq8noqzBZ3QA9BwFcFU5kj
         7nbMd2H9HfRvPvEDUzZYip9EkacuZs7BJOzRlVIJuudNZgQBWMQg0Js7uct+Ie9M+OB5
         XdFhjiVzX5UiQYIrUCEq3VLPCSwDS2avN6AU7GNzXCSTi7V7Bz08z4zBWxD+y+hQYWzX
         mSxFy5kZaDa+9V1c2N/xCXvc4IRUkL1pkI0rstBWiRhPI4SCthuD6X1ubO4TuKH1GW23
         koBlhst7dbcjY918ZfKBPPnnk3dvyxVSp1rc5yZJ9fi6ptQ3uuBa2EpUPOu1cUD5zQUR
         A1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUjlxkmy21IQBJbwUlxAQ08DoMlb4wNbWpIL7L8B9xw=;
        b=Sr4xwAhuzK4xI+TNKZ4+fZMdOCGR+KMn4NY0jzrl0dkBhaXneg1uf+tzaPPKrVLH7D
         Zx5MqZgD4BxLfniLmlOmiFEMjBvpf5D4IUpkVy7il8EjIAU476Qifo5GhQUQCi4U5mb5
         1t+/dRQ1VmKqjtU5cHAfTaAez+Ueheon6rg/Z3qElZTqez0iYvktqXtG+C4GSoJNu6yK
         BT6+5u9ZEjgpS/3m35nldNqI5NrtgfPU2DHT/MX/iP6WXZA7/Ll/TYVfy6U9MSshcLWF
         ibgCUACQRw2vdtV+9mquXMvsThh5ulLpZBfmjV810UqQ/qcFzkD7PwXi5VZSwc6R9vLc
         RVyA==
X-Gm-Message-State: AOAM5314DMc3RaE5spfwXMdRyU4qE04t9fHk6Hmm2XA2rRjuUhkWKfiZ
        8tJtBlQ5RqnZMSJ5jVcuLfDMSlGUEKxddA==
X-Google-Smtp-Source: ABdhPJwEUwf7/Xsg/lxjcn5h1BlkVxhBVnC8RrhROXe8hNOnl/q1/dw+gQIiK7mOS2/bJYNDM+RM0g==
X-Received: by 2002:a17:902:6ac8:b029:12d:632:ffcf with SMTP id i8-20020a1709026ac8b029012d0632ffcfmr767715plt.28.1628717378517;
        Wed, 11 Aug 2021 14:29:38 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1377:1116:63ab:bf4b])
        by smtp.gmail.com with ESMTPSA id w186sm523945pfw.78.2021.08.11.14.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:29:37 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:29:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] In grep, no adding submodule ODB as alternates
Message-ID: <YRRBOkqQSvhwsgrC@google.com>
References: <cover.1628618950.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 11:28:38AM -0700, Jonathan Tan wrote:
> 
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

One note - I liked this tip, I think that is a useful thing for
reviewers to see. Thanks.

 - Emily
