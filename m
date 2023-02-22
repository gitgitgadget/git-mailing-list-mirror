Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CCAC61DA3
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBVBik (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBVBii (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:38:38 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA29A5EF
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:38:33 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id r14-20020a4ad4ce000000b0051ff0b173ccso620456oos.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IM0m/4xJEdsn/v8x9hWGZMLxL0eoRyLlR/D1yjVI3o=;
        b=Vtbswvnyw9c1ab15RBZs4t9I5hJl7AqKD5BoO/YszyK1lUEFP9bm9fYhN385NITQKz
         8v8kuaSZO77xVOiwAf9Zv0PORGpEy3GtiY2/eDXN9ptdSzLGNWeIoYC8zZERcozQVLOm
         MmjJxqnpSaT49IIXEIaFmiGAxRKrdPwHEGV/uzIwOaMxXG8ZnGihLbFbbYIZcQORxEdn
         cjcQ5MTP/B+tNfOv1t/yHKZNRKZNcW2S2VyPZZziBRiOA7G83XsKcfqPtu1wniHnp9/p
         3MYpvWUhYmurgoaa3OEXPUuayelGJMBw5J8dxJ8A64XMTr5WhjogUPzCS+th68rQeKye
         Mx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IM0m/4xJEdsn/v8x9hWGZMLxL0eoRyLlR/D1yjVI3o=;
        b=difQ72WBT/XHLin99mczzrs5wSa+9t8MoGJRCZ7K13HhcaKWWdcKHShGwpZl4X+Ha+
         G1Za+0uPIszX8LZyphdSxwixrpvNTyEbNs1Y2jKyOQnnqgpp3+8wcDnoQ/uI4PWZatGB
         DTqhNwW14LoLvvGGxqyxz3HTxkuLT3GGmJVfq/9uG0x8QEv/WMilqNLrEbayTa9Det6y
         YfWLdBRMelw4Weagfaicsw+ht2myo1TKlIAMEU3rOuhg8K4oLFwYdqQCkHo2xcy/HYmr
         wDFaFHIuG3MDL/7G8HYXqtnhPKyuLegj7DmbhyH+oO2o9rCNS8dT+LqfIWvJ9O9lLAtj
         2cvQ==
X-Gm-Message-State: AO0yUKV4wdaecliqjUkDLaoJyqTYvAJJxOtBpHAjrMtU6g3/utts4c+0
        v2dZwtg+S02F7P1lP53LiYuXpJ12aLEZVHdbhhg=
X-Google-Smtp-Source: AK7set9K37KrrxLyrq+Q1vT3reWKcFZ9MQ0YXQ/8Lhikl0D1ijf5+15zwP9ePsMaTefoY8vyTftoPF6jgpS5LzMj7Rw=
X-Received: by 2002:a4a:be87:0:b0:525:dae:db4b with SMTP id
 o7-20020a4abe87000000b005250daedb4bmr119164oop.1.1677029912239; Tue, 21 Feb
 2023 17:38:32 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-3-alexhenrie24@gmail.com> <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
In-Reply-To: <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Feb 2023 18:38:20 -0700
Message-ID: <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 3:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 21/02/2023 05:58, Alex Henrie wrote:
> > The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> > empty string argument) has been an undocumented synonym of
> > --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
> > confusion when a rebase.merges config option is introduced, where
> > rebase.merges="" will be equivalent to not passing --rebase-merges.
>
> I think this is sensible in the context of adding a config option. It is
> a backwards incompatible change though, lets hope no one was relying on
> it.

Since the syntax is bizarre and undocumented, I doubt anyone is
relying on it for anything serious, if anyone uses it at all.

> Is there a particular reason you decided to redo the option parsing
> rather than just calling parse_merges_value() from the existing "if
> (rebase_merges)" block? I don't think it really matters, I'm just curious.

Without a parse_opt_merges callback, how could we know whether the
user passed --no-rebase-merges as opposed to passing nothing at all?
const char *rebase_merges would be NULL in either case. It's an
important distinction to make because --no-rebase-merges overrides
rebase.merges but the absence of a command-line argument does not.

All the same, your comment made me realize that it would probably make
more sense to simply change the default value of --rebase-cousins from
"" to "no-rebase-cousins" in this patch and then add the
parse_opt_merges callback in the next patch when it is actually
needed.

-Alex
