Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3673B20401
	for <e@80x24.org>; Mon, 19 Jun 2017 04:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751001AbdFSESg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 00:18:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35782 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFSESf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 00:18:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id s66so14838199pfs.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 21:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cLQVFb1Dlvas6UnUBrvpF9Z0On64xA1OKLxKQDY4iQc=;
        b=STURjFpqoZDdCFbE5bmta+5nLepxIv+73osHaSBqYeEh9VyTOgxUvb1AMWaG99chgw
         durajWk7nVbZT6op0s91Hq+aByuJNyekPDVVhPwQsgfCa20Y0NdyY7BbcJPcFBU39GYg
         FlXVLiGC6IQyA8Zx7OJxVCSQ9Rql5iqhC8LXKoaialYinU1igD9eTdLaBp8EY/F6BG+r
         WUtD0Q9CGp/JofmjCUtSE02SYgeTJHGVnOL7qjYLQO4XwXQ3Xnk4R7DPhpcPVrnAcpTc
         d/L3tApGsx05yd4wozFLJt7xNjHwbH5uAYfCUIppJWXtoiqgzJzN4D1mM8SqspuOx3Pz
         7qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cLQVFb1Dlvas6UnUBrvpF9Z0On64xA1OKLxKQDY4iQc=;
        b=I4pZ/3U7OvhRO+GX7Kjz0aIsmVCvTAiRaVL+15lZFsN1hNXDTkJc/57IunYfaMGMNG
         HfwBxty7fJWypfFavYHWyvmal2m0AlkGNTwjg+TpjX8/ZrB1sJFTgAK3QilHJHEPEc34
         eGx1dEjVfiasr2zrOHblqGShen0MC+JLpLleO/jkkX08OmvJLpOzmt/q4Tkz53nX3tq6
         Dq0n2AOEhd84zklul2+AcftXM5aZkSfvPcdMUUvtjAU0kpXxLK9L7DA4Z6hevkPdcxof
         Z2D91fvyT3J8r5zs+SaWJcMYximsUIzfyl5s2tfjF6zDnrq2jlOWirIffv8uvrrx+l35
         94UA==
X-Gm-Message-State: AKS2vOwYCmk19an21Ds4lGG+zQOdNb8Ml1erLrTLIWp0xkHV685iCdQY
        XTcGuIp/bbfrTw==
X-Received: by 10.84.229.6 with SMTP id b6mr17907361plk.247.1497845914608;
        Sun, 18 Jun 2017 21:18:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec96:eb20:667b:9e2b])
        by smtp.gmail.com with ESMTPSA id 69sm18521879pft.41.2017.06.18.21.18.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 21:18:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sha1_file: consolidate storage-agnostic object fns
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
        <xmqq7f0d2l8p.fsf@gitster.mtv.corp.google.com>
        <20170617121934.a6onn7f2luhkuuym@sigill.intra.peff.net>
Date:   Sun, 18 Jun 2017 21:18:32 -0700
In-Reply-To: <20170617121934.a6onn7f2luhkuuym@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 17 Jun 2017 08:19:34 -0400")
Message-ID: <xmqqr2ygvcdj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I actually think all of that infrastructure could become part of
> Jonathan's consolidated lookup, too. We would just need:
>
>   1. A QUICK flag to avoid re-reading objects/pack when we don't find
>      anything (which it looks like he already has).
>
>   2. A FRESHEN flag to update the mtime of any item that we do find.
>
> I suspect we may also need something like ONLY_LOOSE and ONLY_NONLOCAL
> to meet all the callers (e.g., has_loose_object_nonlocal). Those should
> be easy to implement, I'd think.

Ahh, that makes a lot more sense than my reading of the related
codepath.  Thanks for straightening me out.

> ...
> I think this patch might be a bit easier to review if it were broken
> down more in a sequence of:
>
>   1. Add features to the consolidated function to support everything
>      that function X supports.
>
>   2. Preparatory cleanup around X (e.g., pointing HAS_SHA1_QUICK at
>      OBJECT_INFO_QUICK).
>
>   3. Convert X to use the consolidated function.
>
>   4. Repeat for each X we wish to consolidate.
>
> That's going to end up with probably 12 patches instead of one, but I
> think it may be a lot easier to communicate the reason for the various
> design decisions.

True, too.  Thanks.
