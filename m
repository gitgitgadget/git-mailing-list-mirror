Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A031F453
	for <e@80x24.org>; Sun, 23 Sep 2018 07:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeIWNsH convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 23 Sep 2018 09:48:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36406 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeIWNsG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 09:48:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id n186-v6so10145744qke.3
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8TrAwQjzQ2L3AOZtBiFHrdlNjmWgAJ1DHKzPDHloFX8=;
        b=eWZA9832DqfTMYwuzOmbQ97D7syXw/I/8AbtdlB/21gIEl7Yfaa8WFstBsPhUIYzQB
         HWpDrBTunc2eVu/K5qnVzc4rrYIVEDAL1wZeQKuNRcygWNUKcIHcdMeRoYGwAoFWsANK
         OnT8n9Oi5Q6Nu7/vZJdBnON+CIVLrYYOy2VsH+PDyUiM6uW4wTtUR2SIJO3nP2/lcw/G
         CsY29iyb9HHLzFoqr5oPSQbzN/9C/WSLPR43pLdzGL0oebMbYqe8Dw5IW+vuO6sG/11Q
         0mQS6D1upQaKLbZZYYv9YEwuRUmVQJnlAnXhcK9+xGpZt1W51hAf3lFDWsoScGlqhjDG
         5Img==
X-Gm-Message-State: ABuFfojXTQz36JvGP2wxgfC3VAYL5ISlkyllMHZS77WL/HjAkIW+tcPr
        N9ySt1XBiieL7EN9UMux9OX1ICy7Nz3aWlH9jRc=
X-Google-Smtp-Source: ACcGV63a0UvjzwZT92A4qRxEpafYebvTLVKh2Zkzy/Ylx3jAX4b0HivqWVJ9hlLyTfof37h5Nnh8FamUhHd+T9wLK+Y=
X-Received: by 2002:a37:9306:: with SMTP id v6-v6mr3077924qkd.36.1537689092924;
 Sun, 23 Sep 2018 00:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180922180500.4689-1-pclouds@gmail.com> <20180922180500.4689-3-pclouds@gmail.com>
In-Reply-To: <20180922180500.4689-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Sep 2018 03:51:22 -0400
Message-ID: <CAPig+cS-S8cnDnZfXLyz=W3fVM=Bp9ntNVab6uZqeHA9_CSUCw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Add a place for (not) sharing stuff between worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 22, 2018 at 2:05 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> When multiple worktrees are used, we need rules to determine if
> something belongs to one worktree or all of them. Instead of keeping
> adding rules when new stuff comes, have a generic rule:
> [...]
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/t1415-worktree-refs.sh b/t/t1415-worktree-refs.sh
> @@ -0,0 +1,36 @@
> +test_expect_success 'setup' '
> +       test_commit initial &&
> +       test_commit wt1 &&
> +       test_commit wt2 &&
> +       git worktree add wt1 wt1 &&
> +       git worktree add wt2 wt2 &&
> +       git checkout initial
> +'
> +
> +test_expect_success 'add refs/local' '
> +       git update-ref refs/local/foo HEAD &&
> +       git -C wt1 update-ref refs/local/foo HEAD &&
> +       git -C wt2 update-ref refs/local/foo HEAD
> +'

Not at all worth a re-roll, but the "add refs/local" test seems like
just more setup, thus could be rolled into the "setup" test (unless it
will be growing in some non-setup way in later patches).
