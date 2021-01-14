Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA4C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6064C23B45
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 17:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbhANRmD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 12:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhANRmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 12:42:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE320C061574
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:41:22 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id j26so4086851qtq.8
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 09:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wHMbqxW6bYEiXD85XCC2N8BqfZMMSILi41/BqpKJ+KY=;
        b=r9oRHGurJxRhPsRxuDv/3aco9yJ8u3bFsf2hP+fxid6nsR1bQubD90KQBonUD7aFpA
         y5Psh6fsFe6OvOLt50rHW/99MOJ/WiGmfquSCN0hv9dYCM2NKJYSFHuHKneq2BD39hdI
         X6D3VC/Q0ojhVlrb3T1gbr99P+OcYjIC4T3AIR9Vkg12jAg4286UcLU7nB6uTf3y8Adw
         EiYvzQbyUUOxw2irAi4QgebZdRvKt/pepgBn5iBJeL/S4xpiOOVYR8kt96muwgviMQMQ
         z4ki1rLWjOBG2AG9s8pRC8H4XVcscbUgp5X6wnr7T+Lnm9hGLWz4wCAuvJ+mvC2/Hp93
         bK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wHMbqxW6bYEiXD85XCC2N8BqfZMMSILi41/BqpKJ+KY=;
        b=ihsaCixbE+z3co5EkkkBFe3nOsOrfeaBuA4kOIZ1/88LsXaPtJ4gRtXjisqlvdWaZF
         oZ5ZyYc/X7lRLyGaP111aAlxm4QuDCtRkXSW7y2dduHRcS4DhG1+NX+sM0/sHrPnNY6d
         8cAZjKxZXe3uoQzwY6Ewc3V4MXqTzejtFx4oB+HYFg6USHB6livd8IZkEBCt4Hgt42GE
         h8qgOfWlFxJX6br0tRNwDs2XvaVJp+36+DCmlloL6ut323pavpMcb2fLBJVZgfiIJg5w
         0T/jC8y6o/cjWeRLtJEespWGT/lw2g/mXELZj2/aFcfC2dNR9IbOJ4lS0mOLgwVBU64o
         rzOg==
X-Gm-Message-State: AOAM532TL8wkw7EA5Y2IIZJut8ZZZbSAq41GkbwY95sYM0994BTBFmY1
        ipNn6PPQgfsmZOzuCNf5QjQ=
X-Google-Smtp-Source: ABdhPJy3nc75RqO7eCbgSuUzZcI1+95sIWbgg0kpksgPkbXLo5tXts/426NlypDvtlzrUXY5EbV32A==
X-Received: by 2002:ac8:6b0a:: with SMTP id w10mr8245879qts.224.1610646082078;
        Thu, 14 Jan 2021 09:41:22 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i17sm3283506qtg.77.2021.01.14.09.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 09:41:21 -0800 (PST)
Subject: Re: [PATCH 01/22] mailmap doc: create a new "gitmailmap(5)" man page
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20210105130359.21139-1-avarab@gmail.com>
 <20210112201806.13284-2-avarab@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <a71860ee-6810-8766-b9c7-4c03ea7e6e01@gmail.com>
Date:   Thu, 14 Jan 2021 12:41:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112201806.13284-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2021-01-12 à 15:17, Ævar Arnfjörð Bjarmason a écrit :
> Create a gitmailmap(5) page similar to how .gitmodules and .gitignore
> have their own pages at gitmodules(5) and gitignore(5). Now instead of
> "check-mailmap", "blame" and "shortlog" documentation including the
> description of the format we link to one canonical place.
> 
> This makes things easier for readers, since in our manpage or
> web-based[1] output it's not clear that the "MAPPING AUTHORS" sections
> aren't subtly different, as opposed to just included.
> 
> 1. https://git-scm.com/docs/git-check-mailmap

I think that's a good idea.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   Documentation/Makefile                        |  1 +
>   Documentation/git-blame.txt                   |  2 +-
>   Documentation/git-check-mailmap.txt           |  2 +-
>   Documentation/git-shortlog.txt                |  6 +---
>   Documentation/{mailmap.txt => gitmailmap.txt} | 33 +++++++++++++++++++
>   command-list.txt                              |  1 +

Nice to see that the comment I added in Documentation/Makefile
about command-list.txt served its purpose :)

>   6 files changed, 38 insertions(+), 7 deletions(-)
>   rename Documentation/{mailmap.txt => gitmailmap.txt} (88%)
> 

-- 8< --

> diff --git a/Documentation/mailmap.txt b/Documentation/gitmailmap.txt
> similarity index 88%
> rename from Documentation/mailmap.txt
> rename to Documentation/gitmailmap.txt
> index 4a8c276529..8b07f9c5d7 100644
> --- a/Documentation/mailmap.txt
> +++ b/Documentation/gitmailmap.txt
> @@ -1,9 +1,28 @@
> +gitmailmap(5)
> +=============
> +
> +NAME
> +----
> +gitmailmap - Map author/committer names and/or E-Mail addresses
> +
> +SYNOPSIS
> +--------
> +$GIT_WORK_DIR/.mailmap

This should be GIT_WORK_TREE, gitmodules(5) is wrong as GIT_WORK_DIR
does not exists (my series at [1] fixes this).

Also, if you feel like this new guide should be featured in the "Guides" column
at git-scm.com/docs, I encourage you to submit a PR to the website. Though
I think for this specific guide, simply having it listed in git(1), linked from the
"All guides..." link at the bottom of that column, is sufficient.

Cheers,

Philippe.

[1] https://lore.kernel.org/git/pull.942.v2.git.git.1609695736001.gitgitgadget@gmail.com/
