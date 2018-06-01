Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7351F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbeFAB1s (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:27:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34763 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeFAB1r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:27:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so34719812wrm.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MfD1yoIzAcKZUG99WXdyvRpYhUEbuLqG+VtmbvAEvvE=;
        b=N1tCmMeXQNLmIZWLXSHw/JKZkqDCzRnbyeou3x9WPEJVy2rHh+BkXfnmrlV/XdDHRo
         FEwCEMCLYane8+U8T9MFiP9WMm99wwSKTizvOrCu6oC4mEO8LvQEktQhxFNAvaRNLB6x
         tZbrnETmzgELb54BfbkHzL3D454boqJqbiSYcXBwFeGKNWOZCNQh9BKQace57J49e6hR
         yzh+1gv6PAwALfwWYKAbXggPNXbZxnLFMoxaso0QEdjOMw9bAVPf5hfPMxyVDAW088jG
         9OwOQ4RLRcqzbPcKjpF2tvYBVx4dQAC0XRwghbDTim9QWHHpJTF+dVVwVDggbueSR/60
         d5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MfD1yoIzAcKZUG99WXdyvRpYhUEbuLqG+VtmbvAEvvE=;
        b=QA184EndwcLLlbA97vbsLnE58VRFPKogRxRjmxao84T6SSggZQicgHeNRXpSg9XkMS
         SiwMj4eWNu9Yj83IZjr3rciaxnBnkhGhrS7AxTZNNczJmUh0/fN3q9zsqmZhUsSUVNf+
         GzphRkBbDdJDF5q9jLaxJwndSRvkVKEn7M1QBtjd/T28rGPtwT4igMRiReG0WTgKMbsY
         oPLIg7e4Hn7f/Amb0hTBt4izTXwxpLr/skly2Gdcey2aRr4d+6EFdvVpM7wLhzJCmzVD
         flSaFSDSxv2xUbEuSPDveEkxJmfBNAUITzOLHrDYS92Cv+mu0+W8HQJrO9XugjyCEnz8
         mEDg==
X-Gm-Message-State: ALKqPwf552sehEn98xAO8xoE3yXDTVwv88xgYnguxBUazzV0gFF4MZrV
        E/KHIvUYoD1PGPPLFiS/tsg=
X-Google-Smtp-Source: ADUXVKKCWUhRCtaZkWMxyRgtNjU/Dj6kAtrAu9VpsMtvS9XpbEiOT8cZjGKPlgytZRUljuWj2yd9qA==
X-Received: by 2002:adf:86e9:: with SMTP id 38-v6mr7748022wry.232.1527816466550;
        Thu, 31 May 2018 18:27:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 44-v6sm89385669wrv.47.2018.05.31.18.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:27:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     istephens@atlassian.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 1/2] blame: prevent error if range ends past end of file
References: <20180531050030.43364-1-istephens@atlassian.com>
Date:   Fri, 01 Jun 2018 10:27:45 +0900
In-Reply-To: <20180531050030.43364-1-istephens@atlassian.com>
        (istephens@atlassian.com's message of "Thu, 31 May 2018 15:00:29
        +1000")
Message-ID: <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

istephens@atlassian.com writes:

> From: Isabella Stephens <istephens@atlassian.com>
>
> If the -L option is used to specify a line range in git blame, and the
> end of the range is past the end of the file, git will fail with a fatal
> error. This commit prevents such behavior - instead we display the blame
> for existing lines within the specified range. Tests are amended
> accordingly.
>
> This commit also fixes two corner cases. Blaming -L n,-(n+1) now blames
> the first n lines of a file rather than from n to the end of the file.
> Blaming -L ,-n will be treated as -L 1,-n and blame the first line of
> the file, rather than blaming the whole file.
>
> Signed-off-by: Isabella Stephens <istephens@atlassian.com>
> ---
>  builtin/blame.c               |  4 ++--
>  line-range.c                  |  2 +-
>  t/t8003-blame-corner-cases.sh | 12 ++++++++----
>  3 files changed, 11 insertions(+), 7 deletions(-)

Don't t800[12]-*.sh need adjustment for this change, too?
