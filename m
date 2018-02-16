Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33901F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162415AbeBPSFu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:05:50 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37703 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161668AbeBPSFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:05:49 -0500
Received: by mail-wr0-f193.google.com with SMTP id k32so3751053wrk.4
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=48lRtkAxpiqJNQ+Ip8ppxwKvsMg8AEm+e+w6HurT04A=;
        b=nZ/AcyqDGhKj5PvciPTbKXfM8eCYUgx5eZQ1HBezU8ceg99W7Ia+NAZB8CZpuDJj6k
         TcssdmPE1lCegEuEEB6fWIvufqnjVD5VeNYFPVC/FjXguOgWTqOsBuqq+uj6mbVf6PEs
         jBl7iifj5RYuiYfaOht4FEv32tbCIjEiXj5hx0xAD6WkdQzgAxRTF5WGhmaq8dZiFgDo
         K+kT5cNIqtEdiXCvguLlWrgz1+2JhpU7UJ8JoiR+WQ+tPKV1t/R0c8ODI6NJsFhmOJKB
         YUB90W3yoA+XhpUb4UGPc97ojsSrEapAvrBcMYCQ9B43uKwHRvgpvGE4WpFkqwlfaat2
         0OYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=48lRtkAxpiqJNQ+Ip8ppxwKvsMg8AEm+e+w6HurT04A=;
        b=VNC6/asmy8Y6Z8kOOTF9rcDF1Ah9WCNNnjJyggFYYWp9MKfrpLogH5cLd8GgqQsDLc
         FW1wOZNZ4+xf18+Joo0b4+AlCWUnpSpv2YA4akSKwldg3t9gl2jbsroz4n7pE+3EHOxc
         wy92I6pBKI5Bt8ZLFf63RM7WhI/mjMEtZqi3rf2pGSOYG9nE4x56pCis+mB9Ua7tOkAP
         ImHSEWKdqHu4VnbtM0x6yHb7msqN5ihMIVJlj5SUo2mn4HgfSvi8XRW2KizGV/UTIsT+
         2sQktHSlELRhFtm1QLheWgCQIH7oR78/FKLRgfhKOstG2Dyu4VJwaZkbTa9gKpLfmGH9
         opHw==
X-Gm-Message-State: APf1xPAp8RAVQFuRzEzV+Ptn7j/w2BuHwLLK48afFFQCDiYla0km1K3g
        R/ShKR40kSPqGZYVnn6RN30=
X-Google-Smtp-Source: AH8x227f1j2G1S8r9tUixYPvGAjjUkZDCDCdId1NSoJpWgWkIp+ebwHYdyf4CsApqFFl0yr29gQruA==
X-Received: by 10.223.153.23 with SMTP id x23mr6238731wrb.134.1518804347772;
        Fri, 16 Feb 2018 10:05:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g13sm21843077wrh.51.2018.02.16.10.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 10:05:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        matthew.k.gumbel@intel.com
Subject: Re: [PATCH v3] worktree: add: fix 'post-checkout' not knowing new worktree location
References: <20180215191841.40848-1-sunshine@sunshineco.com>
        <20180215230952.51887-1-sunshine@sunshineco.com>
Date:   Fri, 16 Feb 2018 10:05:46 -0800
In-Reply-To: <20180215230952.51887-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Thu, 15 Feb 2018 18:09:52 -0500")
Message-ID: <xmqqeflk7qth.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ...
> The hook is run manually, rather than via run_hook_le(), since it needs
> to change the working directory to that of the worktree, and
> run_hook_le() does not provide such functionality. As this is a one-off
> case, adding 'run_hook' overloads which allow the directory to be set
> does not seem warranted at this time.
>
> Reported-by: Lars Schneider <larsxschneider@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> This is a re-roll of [1] which fixes "git worktree add" to provide
> proper context to the 'post-checkout' hook so that the hook knows the
> location of the newly-created worktree.
>
> Changes since v2:
>
> * Fix crash due to missing NULL-terminator on 'env' list passed to
>   run_command().

Thanks.  This matches what I had (v2 plus manual fixup while
queueing) and looks good.

As long as the "hand-rolled" implementation uses the same
find_hook() helper used in run_hook[lv]e, I do not think a one-off
invocation of the hook is not too bad, at least for now.
