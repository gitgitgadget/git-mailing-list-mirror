Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E6C433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F4761164
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 15:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhIQPYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 11:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbhIQPYF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 11:24:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B45AC0617B1
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 08:20:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v19so7189096pjh.2
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdQ1A2zlhNuUw71fHtPrnv9tRcVxxoH74PnM7x5htos=;
        b=hujCUCmn04DkWRwyWtSbiNjDF49ga2V+TXgKGZ5mYQZ4e1BgHTQPlOBVOQs14TYuDQ
         cAp5AxfDpe1n93/rtOpjB4rxkfjYiK3J3/CUdJjoXckbEbOabbuq6rvCR43lVSIeD3i9
         tglXWmxIgL3d+lEP4BgzbkQ2CLLCfht5oKA2Kt4fHie3T+GJGywwPB/P7qlVOaETOe0C
         x3EffGzYoknhtSlOex40Af2DiJZrdIvffbUK+pVZX1OezV+gw0CDKLDUX2optMhkWYba
         5fmHGKqP2N8ZR2gl0kZ9XmKS8FOuQi1oJ0mNhS7OkodPnm6UqlgjUzGA0jjK94Qa78Ew
         7Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdQ1A2zlhNuUw71fHtPrnv9tRcVxxoH74PnM7x5htos=;
        b=P4P4gNI9JIngOEOyoeV5YIorDdHprZ4WfXyf6IKX/CBFyEz3sFag5219g7ocpn9oxD
         na0tClZFldcd9iusvY7WKkK/Af0afeWG1uz+zio208Qel0s8pQETFLmjgzcNNc0oFa0y
         9wd9DJlTZ6aqmjNA2BOfvPIToMtG69IbHuKC/TtjM9U+h13+tA730/rOQah3fARJKQXg
         TvcpxnC5jqPSbV8IF2NZILN0eWa6s631S/h1MUZgMa3gJ9L/MqhMu7TyVrq1eLagTaFH
         KNvWi/WBQGeH9sa2HVo9Gay1BnLJMBu1Ir/KKtVPnbHd0ZislEJ/3NLI8aC0aLgjEYH/
         ROdQ==
X-Gm-Message-State: AOAM532OBy8Ia44zLf17gBQ0gOtB0RSuZ/1l+fXMTJkcOyvYYoAhJVjn
        gheHvFpGiDU8ucafp/ucwnw=
X-Google-Smtp-Source: ABdhPJzNS8y9aXUEqnWAYifk+v8jmbTh1pEvuMErt4FaGhrGTbKh/q3nhd9jUPuK8AdKADz7EAWDqw==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr13161242pjj.117.1631892045858;
        Fri, 17 Sep 2021 08:20:45 -0700 (PDT)
Received: from localhost ([2402:800:63b8:a175:897f:beb8:2ff7:699a])
        by smtp.gmail.com with ESMTPSA id y2sm6090748pjl.6.2021.09.17.08.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:20:45 -0700 (PDT)
Date:   Fri, 17 Sep 2021 22:20:43 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [QUESTION] How to add new configuration variable
Message-ID: <YUSyNqd51euzvt8N@danh.dev>
References: <9f3cc3f0-36db-f7e5-de1d-2c8c9f246884@gmail.com>
 <20210917134318.scdqa6k4swzgo5k2@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917134318.scdqa6k4swzgo5k2@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-09-17 09:43:18-0400, Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:
> On Fri, Sep 17, 2021 at 05:44:42PM +0700, Bagas Sanjaya wrote:
> > Supposed that I'm writing git-foobar script ("git-foobar.sh"), which takes
> > configuration variable "foobar.something" (string type).
> > 
> > How can I add that configuration variable so that it can be used by the
> > script?
> 
> You can just add it. :) Git doesn't complain when it finds configuration
> parameters it doesn't know anything about, it just ignores them.
> 
> E.g. in your .gitconfig or individual repository .git/config:
> 
>     [foobar]
>         something = yourvalue

Or just:

	git config [--global] foobar.something yourvalue

-- 
Danh
