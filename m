Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05617C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0D961405
	for <git@archiver.kernel.org>; Mon, 24 May 2021 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhEXUun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 16:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbhEXUum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 16:50:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFFC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:49:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v13-20020a17090abb8db029015f9f7d7290so602234pjr.0
        for <git@vger.kernel.org>; Mon, 24 May 2021 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jxdl7FAZ7BuY2kbqHL/tMywqo9dl95rXmKGgabj8rdc=;
        b=vkfkJUKuyNzNiBObHMbb9CiUsg1rvvN4qbU451cexGZcky4nRTyXW7EC16rCjC98ec
         lf34QqjQ07zPrgEiRTZeCUbZ5Y40rQ4QStCA1JQrWDKm3RTPJH50JqKJ94eEP58C+hg4
         BJmIbuwhml2BjY+QvvcpW1gypq9SGgWYBS7hh1AXVDgYSgDq8wAdC2ZNHU5dCKIL+4/i
         3lAolaQW/GUjdIgUc64kmvMGMoU1pD7bs06ck08wnxsZ3HiRWtv6RZLdyoBk+5OmQXaP
         9gPJcYk0DmxrQFVZarJjcyL2uW/OijTK62zDzkvy+qlqh4XLrMTPtjSX9NCBKKvuzN8O
         h+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jxdl7FAZ7BuY2kbqHL/tMywqo9dl95rXmKGgabj8rdc=;
        b=stOMLLeS5KfBKIXj84oT/a9/CRVIIAPHbRVGDqZXz7G+u6EMmYKXlFbGZ0us04DQNz
         g01XVb5BsprSfaaH5jy1VbBOQZqvQFYm7VEReGBgI6IpQot1UnWTFSrkLia48ahPT0rU
         lwiTWEBkPjz/cihTTdc+A23B3n+IRS/pfBj3QpdaPh6kaaSvDgv7peB1/MJqzdvXUnRr
         6o+VUaLDYdD9Zw21rZcHFmNRbOT5qaymcMRK7uOyeWZ1gsafh3wZtIqnPY9kyyFZofcd
         weoITQkH7JJkNBG+s0er0Xqx9EM9cxZGBGnYZiSnALj8zPMTJyFkMAXFX6ybFUU9goJi
         jPWg==
X-Gm-Message-State: AOAM532ZaUfmI0ofc3VAhUUDUkl3HvXdm8N1ME0E27kCxJhUJGTuu7Bh
        w8CUEQV5RPE2rbFK32p8SD5YMc3QLXm+pA==
X-Google-Smtp-Source: ABdhPJydKNsiKFKdatENEMyLOdPsbLczlTua8DE082pfYNONfYQ9oi9koWNChjSWoGbAYN0FCdqKbQ==
X-Received: by 2002:a17:902:6b81:b029:ea:dcc5:b841 with SMTP id p1-20020a1709026b81b02900eadcc5b841mr27379768plk.29.1621889351872;
        Mon, 24 May 2021 13:49:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:cd8d:2ee1:d1a9:b26c])
        by smtp.gmail.com with ESMTPSA id f3sm3167199pfd.21.2021.05.24.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 13:49:11 -0700 (PDT)
Date:   Mon, 24 May 2021 13:49:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3] tr2: log parent process name
Message-ID: <YKwRQbPwbds1wcyW@google.com>
References: <20210520210546.4129620-1-emilyshaffer@google.com>
 <20210524201007.115124-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524201007.115124-1-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 24, 2021 at 01:10:07PM -0700, Emily Shaffer wrote:
> 
> Git for Windows also gathers information about more than one parent. In
Oh, bah, I guess I missed changing this to "more than one generation of
parent". It doesn't seem worth a reroll, but I'll make the change
locally now so I don't miss it with any v3->v4 nits that may come in.

 - Emily
