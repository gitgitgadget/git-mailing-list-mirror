Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59714C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380342065F
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/HzKGz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgE2Rht (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgE2Rhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 13:37:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC9C008632
        for <git@vger.kernel.org>; Fri, 29 May 2020 10:29:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so77739pfd.6
        for <git@vger.kernel.org>; Fri, 29 May 2020 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JigBQwxYNqLCKLnGRMuvOOY+ycAxj9pg4zw6QaPkq/4=;
        b=E/HzKGz5b0TGtygMdRHX+mBQBURvza+w3UaCQeH5hrDRH52780an6LN3kdyzJITmA4
         OYuoQWMXgfCy7q+cnU8M9AqDl8EmIF5rikz0U7Hf9fd4kjbsMSHQmUopLzZgdyveMnDl
         lxTB+uvBrU3yVhLdQvzygc6xI4VdH+qV8hudNnPLXTCBQc+B/obcXPWqei+322Fri8ps
         /XBKrtSqqZ9fRxhFRU9gEXaypWarq/6opquFeX6U6WUtazVx9YZtKHB9dEwGDonVMlWu
         vaKLQrfzE54+S4TmbSQ6yAlgFbBbf1/bUg/oi7lD652h7XMA42gstgixXgaZw9htHqVo
         9Q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JigBQwxYNqLCKLnGRMuvOOY+ycAxj9pg4zw6QaPkq/4=;
        b=iTpE2fb4TBQ76YiPbQD4GHIeoeeEVUU5mYzBl+FJM6ER6lqLEdjfZ1MGR6hf4Sj+1O
         7r7d185RCgstLEOmP70+CjKbqe3Wf9yrQKgY+sFMOTRiU+wRvhcsm2rGOthjaAiLqyNQ
         HoRSzKrmLB0o3o/IOjXzFt6VuQIp+q128GbwRyUVViNlcT6wQcB6viYXHeNkA0J/uPky
         TXrKSWckl5fGz0H7FeaHPwAVk0Se8xTcXaZ/W5kcguD+BrCdoXgR66bb+lZAGKNFKw7I
         RXTFNzCWmHzOQQHGBjgFPv3DvKPp3qf9G+ST0rTyNbj+PTB5wwSVKeZXXjJMATRLSP5N
         yF0A==
X-Gm-Message-State: AOAM530HpSSlfw/v7CUnz6HYdCw6/VlF97fnE4nhhkzdMprDUrY7QGC5
        uJbjIiIC/lxjNi021kzeuTE=
X-Google-Smtp-Source: ABdhPJx8pAhR0BkFWYgqGPY8W5xhrFHF8f0hzjNy9ZBcKxSW/8gemeFbJXRJUR8M+4vJ0ary0WUbow==
X-Received: by 2002:a63:7453:: with SMTP id e19mr9138781pgn.139.1590773398144;
        Fri, 29 May 2020 10:29:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p8sm7375425pgs.29.2020.05.29.10.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:29:57 -0700 (PDT)
Date:   Fri, 29 May 2020 10:29:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Git fetches whole repository and not just latest
Message-ID: <20200529172955.GA123244@google.com>
References: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ves8x9_1=fVo_+dB92GpAGLcbGVqeo2gjRbBnzTzM0uzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andy,

Andy Shevchenko wrote:

> So, I have a local repository which has many remotes added (~20 or
> so). Most of them are from the same Git server, but few are from
> different servers.
[...]
> origin, for example, almost everyday now gets in full (1.21 GiB!),
> while others have no pattern.
>
> I would like to know if it's problem of proxy, or that specific Git
> server or is it (new) bug in Git?

What Git version are you using?  Can you test 2.27.0-rc2?

I believe this is fixed by

	commit 2f0a093dd640e0dad0b261dae2427f2541b5426c
	Author: Jonathan Tan <jonathantanmy@google.com>
	Date:   Mon Apr 27 17:01:10 2020 -0700

	    fetch-pack: in protocol v2, reset in_vain upon ACK

which is part of 2.27.0-rc0.

Thanks and hope that helps,
Jonathan
