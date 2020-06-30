Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98910C433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F8320781
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 01:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQJtltD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgF3BGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgF3BGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 21:06:31 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E29CC061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:06:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gc9so2274025pjb.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 18:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z0L03Jv/KMgmfk0eKOEkfCryHGFGBlXyVF/TNRqkoto=;
        b=lQJtltD0Taw7GM+atGfyVCVsPVS1dfsSliaRlSFqXbs4y530ttx1nmSSubfIix02OQ
         320cAm4gkWZf48WHz67W+89Nsq81HSXHcrbvD+c7r5CE7pdGpBtLotTJA+kEy3DhB6ux
         iqU+q1+kROvindikJBILslO0qZ75mfQGqItHnrwzUHGvv4Ud+VzNG45Sjh/V6Rirh9Qn
         cPsEtEO8rjxF+ygLt33xQsWX02R4sOckYgYwfr1jKdJfqdR5tpmQ81fllB4JsV9BPv2O
         f+mPMkqdEzkf6QcNj7ECMEupST30sgx+CuVGsO1N/6FlohpsCTGrAqL6wOjjVdsj7i4n
         T9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z0L03Jv/KMgmfk0eKOEkfCryHGFGBlXyVF/TNRqkoto=;
        b=dHyR/llWuGQVA2IOB+xkmqUR83vFSE1NI8ApBfBKgjD3aFixno02rUmAUrs35f5sW9
         4j723VbvfO1OqIiJkDyNS0Evu0Q77hqxRNkCdbrTmJKB8esU8TVPsuEODx8UqAaKQy6r
         Sq/t33k/4g15gqGH7PcVMuJKA2NUTtchgV7N8SddEWgmmOUKNdmH5f4YNs+Ta1c8EZhN
         mxw4o3KuYh6eWkXzWiCCS1vMb1OnFxZWSqnBz7hZ2VFBf06KPRv6lRjRClMbJ2mcOi4h
         +qX5scMwcqCML0RqlqftIXqwitREe/dUaKN+poIYXmFPniYECrqNlf6RuGNzrfchllPm
         XPmQ==
X-Gm-Message-State: AOAM530gwPlujc2Q9V/ZuM4dmZwaMr0d+5AYMjqs4ZCWYzk5ftwFMhsh
        LCqjG4y0H8T0KybityiEESLDY4hTwYI=
X-Google-Smtp-Source: ABdhPJxXRZCF1U4EhAx14VG6rAx0hacpUnL5qqt0MkBD1dY1u7fGXN4w2Dlpihz1F56suSFaTTa7mw==
X-Received: by 2002:a17:902:ff13:: with SMTP id f19mr5574188plj.339.1593479190751;
        Mon, 29 Jun 2020 18:06:30 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id mr8sm594728pjb.5.2020.06.29.18.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 18:06:30 -0700 (PDT)
Date:   Tue, 30 Jun 2020 08:06:27 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #06; Mon, 29)
Message-ID: <20200630010627.GE20303@danh.dev>
References: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa70lfjvo.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-29 18:00:11-0700, Junio C Hamano <gitster@pobox.com> wrote:
> * js/default-branch-name (2020-06-24) 9 commits
>   (merged to 'next' on 2020-06-25 at 8f962f9219)
>  + testsvn: respect `init.defaultBranch`
>  + remote: use the configured default branch name when appropriate
>  + clone: use configured default branch name when appropriate
>  + init: allow setting the default for the initial branch name via the config
>  + init: allow specifying the initial branch name for the new repository
>  + docs: add missing diamond brackets
>  + submodule: fall back to remote's HEAD for missing remote.<name>.branch
>  + send-pack/transport-helper: avoid mentioning a particular branch
>  + fmt-merge-msg: stop treating `master` specially
>  (this branch is used by hn/reftable.)
> 
>  The name of the primary branch in existing repositories, and the
>  default name used for the first branch in newly created
>  repositories, is made configurable, so that we can eventually wean
>  ourselves off of the hardcoded 'master'.
> 
>  Will merge to 'master'.

Hi Junio,

I've posted a following up patch to change git-subtree in contrib
because of the change in fmt-merge-msg at <20200629162003.GD20303@danh.dev>

Don't know if it should be reviewed and merged separately, or it
should go with this topic?


-- 
Danh
