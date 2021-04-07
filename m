Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F6BC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1326128A
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhDGXiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhDGXiG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:38:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F50C061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:37:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q10so39885pgj.2
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8gRHjna5Ja57WmGGp+orC/zPZ7U7GsPbm6X2hpxKSI=;
        b=GhxwpLvjJJSDWV5xtu5uA9mVmPcL6hFPsLX1+ZQqYptfnV2pYUoWuGa22eMlyoG7xp
         6FmBHk1svVYmA5jgew5xLZKIf84Hs0JYY/OUD1vTbPQ1PD5Bt1RCKkDTWOJVl2r2LTH7
         mYx/y8vjLvZmqL+1gGvfx4KkkdTDg5nHByiqfKpTmB10tV0jAaYGxuhwgIga566gxRvY
         RCMZ6Qkum2C0/km2OWvaWLERVgNwJOvTiGSRqH9/Pu2Ibk4Jc/nJNXGVnJ3SV+XC4/Kf
         oy7sA3Ky8JuvikNzV3R8mqUR6wLOI9nawv5o2woT9EkBR5z2R6Fr93NIWu4Ib8wvvcex
         qF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8gRHjna5Ja57WmGGp+orC/zPZ7U7GsPbm6X2hpxKSI=;
        b=UXhR46v0rkrMN2NcZyzEqkBvIRymp06PjSBfp3KPK9TxIeF2KspIa4Br+ltUvYH80v
         yTjWaDQItKZVGtbpgcfDDplQk+OcbqQkkd988C7YYuaaA6/roYtSuXZoZLWNoveJWWBg
         y/hI6srlX8yO/UrODHoWj1WeI9+/BbH7+9sfwKoAIDZsB5MTx/Qks566S260X/LEKPPH
         qTOPZ5MkHg+p1qjmD58OVOR+Kc31DjzDDNBoJiyr3ZA6PVvK/IrYyGOWWV2518bdVSP6
         c1YSZX2RSy6qWZ2NI1GRX8aHJVblCQH8OKGjikbs44NJILatjb7L0g26Dl3ccJQ/IyTd
         /+GQ==
X-Gm-Message-State: AOAM531N9iJ385xNT/9Czixyj0oMyYfDcCdkPnPlOlfIrJ+kJY00E4yD
        ZXIqSSAUEZMeJAfz/I70FZr4/g==
X-Google-Smtp-Source: ABdhPJzW7sAhuYBsRVB9a/PienGsEskgUTaAw83qrQnuDJFCepAu0Gp4snV7x80Bd+DoQsQfL8prUg==
X-Received: by 2002:a63:1921:: with SMTP id z33mr5458716pgl.211.1617838674611;
        Wed, 07 Apr 2021 16:37:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:8cb6:cbee:2f8c:7584])
        by smtp.gmail.com with ESMTPSA id d13sm23170683pgb.6.2021.04.07.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:37:53 -0700 (PDT)
Date:   Wed, 7 Apr 2021 16:37:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, tom.saeger@oracle.com, gitster@pobox.com,
        sunshine@sunshineco.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 5/5] maintenance: allow custom refspecs during prefetch
Message-ID: <YG5CTFMIfSYcqZkJ@google.com>
References: <pull.924.git.1617627856.gitgitgadget@gmail.com>
 <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9592224e3d428762c6f9b38a0bcc2cee5c3dff6c.1617734871.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 06:47:50PM +0000, Derrick Stolee via GitGitGadget wrote:
> @@ -877,6 +878,7 @@ static int fetch_remote(struct remote *remote, void *cbdata)
[snip]
> +		/*
> +		 * If a refspec dst starts with "refs/" at the start,
> +		 * then we will replace "refs/" with "refs/prefetch/".
> +		 * Otherwise, we will prepend the dst string with
> +		 * "refs/prefetch/".
> +		 */
> +		if (!strncmp(replace.dst, "refs/", 5))
> +			ignore_len = 5;
Using a literal string plus the literal value of the string length,
twice, doesn't sit great with me...

> +
> +		strbuf_addstr(&new_dst, "refs/prefetch/");
> +		strbuf_addstr(&new_dst, replace.dst + ignore_len);
...plus with some ugly array pointer math. :) Why not use
git-compat-util.h:skip_prefix() instead of doing your own math? (In
fact, the doc comment on skip_prefix() talks about using it exactly for
stripping "refs/" off the beginning of a string :) )

 - Emily
