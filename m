Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D951F954
	for <e@80x24.org>; Mon, 20 Aug 2018 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHTVs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 17:48:29 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33558 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeHTVs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 17:48:29 -0400
Received: by mail-wr1-f50.google.com with SMTP id v90-v6so10605799wrc.0
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qg/aFvf74e2rCDlHwDNB/uL3kAJBKZlMXpAi6TUHVh4=;
        b=qONoTnMlO5XpSBuL8iuT2HpCdHXzGVsidqxzPk2ewjPkq8aD4OkBkLCvW0WCZJJME1
         9AUOKoiBMMPqb9rVJ1C4lDVcyrzzKIldjMDeWSlZDrlOiYtu11PfTScPLBMAtHxm/WNd
         JpoEw/3AF/QQvVRLaL90QUDjr75UpV+KJlsm7A2j3BcTmcTy1cW8LJy+O16twrTBalZw
         5czwqgTqe5ZVwszu8rTCftuFRkXaeViaYggnTV6n1ukQ7+JevIeiSvTef5f5bs6fM3ZA
         EBCZTB2T/85QG0BDifJyZ9dlPfYxFGKKEQ+Nlt6l2gR+RL78WBKQd9GxmeZ1fPn/OI+J
         Kq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Qg/aFvf74e2rCDlHwDNB/uL3kAJBKZlMXpAi6TUHVh4=;
        b=bv2fman/swaL+YIinhKnnzvg8dVxcsIayCxEN/iiOZvYMlXzx2FEV+Yx33efONVwmG
         /REuSIiA0GCw04Ff5Y/vBYwvbs4oYOC3WFqDzRl9gq0T1Ssn2I0+7+w2US9Wg7r8eERy
         iU5WjUc5WOs7A6Hc8Tf3xe9BTh+vgnpgr+CYNTPUz9NUVPwMr8u2ZFYkr5mXGxahpA19
         8qLG/n/LG9QZRG8vmPU4oWPCwDSUdqBdsn4QRlqYDepZ+BOq+VhFerjnSDxgicyWZIh9
         G7BidB0lChhwa42Eo45I/yIEg3WTxvSM0b9geOwfmcxh/DDMaJWCBDSfE/KuDRZu2dzh
         rS7w==
X-Gm-Message-State: APzg51BivvD7xWmX65J1+OChzGQ4ATRgKAK/aVgUf5Air5m9M7Iz7gjS
        QnIQVtK/VrTkSrIZqOAXd6M=
X-Google-Smtp-Source: ANB0Vdb+wBsQEr0MBlQ/tVz9scgFyOrxJqV71UYhdF3sWfBRM/ajg02owt//7al7rALBFDtZJ2NTPw==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr5461482wrd.218.1534789904034;
        Mon, 20 Aug 2018 11:31:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a37-v6sm25483619wrc.21.2018.08.20.11.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:31:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= 
        <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] checkout: optimize "git checkout -b <new_branch>"
References: <20180724180122.29212-1-benpeart@microsoft.com>
        <20180816182653.15580-1-benpeart@microsoft.com>
        <CACsJy8B84T9HSJKAErNAyoMwbBpu6Gwgyz3RsvmqD0+o=bg3Ng@mail.gmail.com>
        <448bd740-73fb-aa3a-ded0-e4012cf6ec21@gmail.com>
        <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
Date:   Mon, 20 Aug 2018 11:31:42 -0700
In-Reply-To: <CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com>
        (Elijah Newren's message of "Sat, 18 Aug 2018 18:44:54 -0700")
Message-ID: <xmqqh8joc2k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> == The patch ==
> - Ben's patch only affects the "checkout -b $NEWBRANCH" case.  He
> checks for it by looking for any other flag that would be a different
> case, and using the old codepath if he finds any.
> - This means there is a "giant list of checks" for this optimization,
> and an ongoing maintenance burden because if anyone ever adds any
> extra options, this optimization might suddenly break things if that
> giant list of checks isn't updated.

Correct.  

Having said that, I do not mind leaving it in 'pu' for the rest of
the cycle, possibly merging it to 'next' after that and keeping it
there, to see how horrible a maintenance burden it would become in
real life, though.

