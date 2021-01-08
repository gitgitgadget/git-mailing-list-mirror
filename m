Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4ADC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 04:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD54E23601
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 04:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbhAHEK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 23:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbhAHEK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 23:10:27 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D188C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 20:09:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so5424232pfu.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 20:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9SedQYHOrcs2Y38BpQvuLPqhZeSM3p1hc2LNqPp7tt0=;
        b=KLYuUavACaE/KZFomlY1LkD0hskb6OclXcnkeFyviAB3wYyay8JNJhhfN52zmLBeo7
         3k3JXPDakEN1RQDn7nyMPAskNSKwzjZHvTnTGyh78/Hi5YWQHt+BgPsPcLNNdBUn7amr
         h3kb0cCO1fyuneFfKMObab4uk0KfRl+uJQQrgGrQ58DiYGmjN3j4ZKNAHtKsBN2TMR4t
         PUYljkPYZhi46+cFu9bwh5x9oI/gFTL+e7LMOkA06R+MfCnONlIxcfpA+5LZXSACRxU9
         iKWLZnq0McN4L1E0lMI8yHgR9lVx36oy3+Qhs2tEHjBVOe1B/8Tdx50hR4M/CtGESqmi
         Jbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SedQYHOrcs2Y38BpQvuLPqhZeSM3p1hc2LNqPp7tt0=;
        b=SifEz/YcA89SAabNfoC6y5oWWrI4vYGHN3bxWRA1kMqK6ReEHKLXt93uqJnz1cKcMs
         fSKGPoRQHuzHsstD6LQgWvureDLNE/g6Md9c2iqi3R57GDSfRKHd9wmev8N7MnyzBN0r
         /8g344WKl4tNXtYa6I6+74yXpjbrs+LKnvGTPy2M80g/o4rFgzB2RRgiO0SXhPx+QRjc
         onUGB7C6L3llL32paaNje/QY3gmn5IQtpQfUg+3jPuFIII4+upFwHoQx/phZwrgwLi7j
         V3DqzCSldH1cxRIbhmmaBTuFD8CqgrPChcNfRCPSKphGk74imPoXq+VAxkQmmrmJVHQg
         zfYw==
X-Gm-Message-State: AOAM533ImU+0gYkgSHda0RxAPQBhvx43w+HWMCYph8bUo19uDlWd+3Et
        x0WfWyuSpQGlUVZAtmjxvWI=
X-Google-Smtp-Source: ABdhPJyPy4o5SFjGkZCzFsx8nxkkF6ugzN1IqR16Hx0ajqmUftppFwWbXFEGBT3KsEbnKskES6poSA==
X-Received: by 2002:a05:6a00:2259:b029:19d:cfba:5614 with SMTP id i25-20020a056a002259b029019dcfba5614mr5003115pfu.35.1610078986737;
        Thu, 07 Jan 2021 20:09:46 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id b11sm6959192pfr.38.2021.01.07.20.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 20:09:45 -0800 (PST)
Date:   Thu, 7 Jan 2021 20:09:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #01; Wed, 6)
Message-ID: <X/fbB4zf4egSyuxC@generichostname>
References: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Jan 07, 2021 at 05:38:51AM -0800, Junio C Hamano wrote:
> * dl/reflog-with-single-entry (2021-01-06) 2 commits
>  - refs: allow @{n} to work with n-sized reflog
>  - refs: factor out set_read_ref_cutoffs()
> 
>  After expiring a reflog and making a single commit, the reflog for
>  the branch would record a single entry that knows both @{0} and
>  @{1}, but we failed to answer "what commit we was on?", i.e. @{1}

Quick grammo fix: s/we was/we were/

Thanks,
Denton
