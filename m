Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBED01F453
	for <e@80x24.org>; Fri,  1 Feb 2019 20:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfBAUMP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 15:12:15 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33747 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBAUMP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 15:12:15 -0500
Received: by mail-qk1-f195.google.com with SMTP id d15so4903515qkj.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 12:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMoARGeIYAJF/Ixxp3jBgRLeBxnctzQMRYv88fNysAU=;
        b=PRFTMznbrIBe5R3yvXjWE2sFEgXesS3zMOy5aala5S0HJy7NWprVP4BJ4IMxkOk1hS
         vQyIe2HbfqjJQi30q7FqZ+5ED8mrk904N1SdWeLjXO21ltVrq+PJiamGux4HIIjIF1SE
         M/W8WpnRkLW1u3MBn3AL0AwqZW/K61/lM6Fm37KVTPXNKy160yYpVNk0ojgjum11ip09
         ANC7na8raiEHxfOm5/NBZAsGOsoI4VR9w+iBnYXmFf5er6hoN1yOz0TdRTVReGYcKVyJ
         kNBKpCjtz3lMh9YNas3BUeSVC12Ouc81d9FsWC/N0mprWvLk6U1GT6Nnz5/C+pnE1n8a
         JCmA==
X-Gm-Message-State: AHQUAubZiC4j1Wo4IvWu88hJys9WuIqExC+JpO2ssx0EZ9przGrHWkVx
        Oy1wtv2MzM+uKbz8MAk3rNfvNixxIDtvaff2FAM=
X-Google-Smtp-Source: AHgI3IYRkPypvCMP+qRBVRYXGnvPR8x4NVhiEPUOZUDA8NNmeEEI3nj8VRjZqROrIyiuek2t42qyo/K8BKW7LsVaOEw=
X-Received: by 2002:a37:404f:: with SMTP id n76mr2855233qka.26.1549051934379;
 Fri, 01 Feb 2019 12:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20190201135512.68220-1-koraktor@gmail.com>
In-Reply-To: <20190201135512.68220-1-koraktor@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 15:12:03 -0500
Message-ID: <CAPig+cQgEVJ6OGn9BRUJoALxE7aDCHK308sq7V0EQVRRn6Vn8g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] describe: setup working tree for --dirty
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 8:55 AM Sebastian Staudt <koraktor@gmail.com> wrote:
> We don't use NEED_WORK_TREE when running the git-describe builtin,
> since you should be able to describe a commit even in a bare repository.
> However, the --dirty flag does need a working tree. Since we don't call
> setup_work_tree(), it uses whatever directory we happen to be in. That's
> unlikely to match our index, meaning we'd say "dirty" even when the real
> working tree is clean.
> [...]
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> @@ -145,14 +145,38 @@ check_describe A-* HEAD
> +test_expect_success 'describe --dirty with --work-tree' '
> +       [...]
> +'
>
> +test_expect_success 'describe --dirty with --work-tree' '
> +       [...]
> +'

Can you give these two new tests different titles to make it easier to
narrow down a problem to one or the other if one of them does fail?
Perhaps the second test could be titled:

    test_expect_success 'describe --dirty with dirty --work-tree' '

or something.
