Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDFBF1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbeHEIO2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:14:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39520 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeHEIO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:14:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id h10-v6so9197469wre.6
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KSk3PgvOE6Rr0wF1efwY1HP8gij3YQUAWeSrKss8KBk=;
        b=j9trRpw8QVbCL9tvjc+fS2u1lqPEuIWhMpdmSVVgoSnhJBg2NX9fXbeUPVLJ0e+r8W
         t/ONRTGXryCdfLFPzQUesJHfUWQuDv2tfvBWD2kBGWoSAtCjVGu5iUS3477mQVGZmb22
         +vmSojK4RbHp+4AvdDx+/eI5gt+wXH8Q4yxc4O9R1arwZW2CEN/4nNJwRj66crjZiHVp
         i7IGHuoDyLmtN6W6+xpjFGCciyPpSAuEzPuG2pnvzWtLUnMcYS/yGOrPRWAZ4d4+Ex0p
         kDPBqAnd5ag+KJbTu2Q3wK6uGcZYRuVoMchXlF2EYAV3PxPlil8mPhkHGb/sn/Af0DH6
         G3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KSk3PgvOE6Rr0wF1efwY1HP8gij3YQUAWeSrKss8KBk=;
        b=fwypQCGod5NpcWjx7fIDXid+8PNYd3XeUwfyf2QRVjIAHkJlxxVY6bV5AOjc2N8y1b
         9sUHHc80dMHgaNwfoNoQDDMCKGxOqQ5Db2wfnYidZkGE7ic5N1hj6icTfsaIwF/JeoVB
         9j2X5I7roT+L0OTAW3chGpSwbCfUL88Td6KPAhOWebKzLAi0I1MmNC/wvM0Hj+WIgrCn
         lnIgEUO4sXWCjyGkWNKkNDCnb3wqLBDUt0LG0n1l8uc8BgM/NGoUo/eh7xo+QPcS8KFY
         ONk1zTDetuA5jhCKbCtNtBTwdUlePrNjG+7a7tGP4JmWy1ma5W4mI95AuweavBvZ5FdW
         z6Lg==
X-Gm-Message-State: AOUpUlFk2dPn6NlGYyga+LBs0JE38+nIEsR30tc5H+0JqSLxlnur7Lc8
        +wmyjwB2WiBA910cBla/Y0o=
X-Google-Smtp-Source: AAOMgpdtDsY6GRIiRjUs6tPl0FhgNKQpGc+f68QR2ZwT5cuZA6feAb48xitkoVRPZQXrFAGgsq8cKA==
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr6857751wro.214.1533449462437;
        Sat, 04 Aug 2018 23:11:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b126-v6sm4489708wmf.41.2018.08.04.23.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:11:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/4] line-log: optimize ranges by joining them when possible
References: <pull.15.git.gitgitgadget@gmail.com>
        <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
Date:   Sat, 04 Aug 2018 23:11:01 -0700
In-Reply-To: <d5d9db3c1124d29e26864596a8c36f0dc4de8a7e.1533421100.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sat, 04 Aug 2018
        15:18:26 -0700 (PDT)")
Message-ID: <xmqq7el5s5qi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Technically, it is okay to have line ranges that touch (i.e. the end of
> the first range ends just before the next range begins). However, it is
> inefficient, and when the user provides such touching ranges via
> multiple `-L` options, we already join them.
>
> When we traverse the history, though, we never join ranges, even they
> become "touchy-feely" due to added lines (which are "removed" from
> line-log's point of view because it traverses the commit history into
> the past).

I do not know if that would be an "optimization" (in the sense that
joining would help performance) but I do agree that such a change
makes perfect sense from consistency's point of view.  If two ranges
that were originally apart lose a gap in between them, it does not
make any sense to keep them separate.  Good thinking.

> diff --git a/line-log.c b/line-log.c
> index d8d09b5ee..bc7ef69d6 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -68,6 +68,10 @@ void range_set_append_unsafe(struct range_set *rs, long a, long b)
>  
>  void range_set_append(struct range_set *rs, long a, long b)
>  {
> +	if (rs->nr > 0 && rs->ranges[rs->nr-1].end + 1 == a) {
> +		rs->ranges[rs->nr-1].end = b;
> +		return;
> +	}

Nice.

>  	assert(rs->nr == 0 || rs->ranges[rs->nr-1].end <= a);

>  	range_set_append_unsafe(rs, a, b);
>  }
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 61ff37430..ebaf5ea86 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -119,7 +119,7 @@ q_to_lf () {
>  	tr Q '\012'
>  }
>  
> -test_expect_failure 'close to overlapping ranges' '
> +test_expect_success 'close to overlapping ranges' '
>  	test_seq 5 >a1.c &&
>  	git add a1.c &&
>  	git commit -m "5 lines" a1.c &&
