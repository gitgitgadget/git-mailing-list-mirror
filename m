Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A6CC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbiCKNxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbiCKNw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 08:52:59 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ABC1C4B05
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:51:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y8so5915311edl.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eysZKgyNkZJtL/HxRFu48ybZMmhMiOes0qcgghO3P+8=;
        b=L/huO6J/LHYXPfHWT4W+9aEXMPjHbQcxEnI07lntv2xIQZrbyqcO1c0f67zP5jjhDt
         m593btXFQU4AyV4KfLi0iOokjAkmN6FFIxe4hPODd/pXF86hG/KF/z1FWE821YoSX+nv
         gt446t8cF/wQypMHXGFnnbrAGojC/ZAy0ak7Gm8EqrLGPH8GjOGFilgtTlxBm2DX5Vo4
         7CU9e7gQzrfDvK2oq9/Gk6I/o+r5q4X2K2n57IW4ChrvE+7r0upi/dePFgke9oOdREMl
         l0aGtgIu9ogZ7UzjaVr9kSAa2L7wUCN8qa4n9AC5e58E/X1Sie0m7e1Rts6ypNx5coaJ
         ijkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eysZKgyNkZJtL/HxRFu48ybZMmhMiOes0qcgghO3P+8=;
        b=Znx22vNciXLIPfZfgwcaxRkExcZo7hNA+UtNkjrlvNacjkIGx1RhJORWR/YnJpY/zV
         oldRxdM8saHh+LRxG4mWJur7Srkf8y2C+guIOcJv168isguVqdR3fyNUbtDxhtl4CfXX
         3y3mQkwsaYCS2SraN4/ypN6X+u2aqxawMYlKVclmaHMO8hs0l6nZ9Zep7YRWjo2FhK5L
         GnMKvfseX6GbtvdqgHh7fzq4R9YFmgBnG+msAWOxrVREeNY7wRVl4HCLSyafYsEscKLM
         Vd5iKRWiVMMyxmIqcGBOnWhHoaMige3LeAFFJepNCXKmHCo27OUFlL+XyTcu5psSlZ4o
         w/qQ==
X-Gm-Message-State: AOAM530hSP6T5Tm07MEP8MTOZz3yi2XN+ViJZPPwL8qGuvhnaJfXDXx6
        lhapvCsvVrxsBThB01vGDhtwqeKc/bOcRA==
X-Google-Smtp-Source: ABdhPJz/X3IITK04PccsYgZJLYeDquJEKYRxdCZ4tdIJtfaPqeIy0X7RVb7ZyEB3gkfNiritt0HoLA==
X-Received: by 2002:aa7:c401:0:b0:415:ce8a:9397 with SMTP id j1-20020aa7c401000000b00415ce8a9397mr8924056edq.389.1647006713575;
        Fri, 11 Mar 2022 05:51:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7cf8a000000b004160af67840sm3227130edx.66.2022.03.11.05.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 05:51:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSfgO-00138U-FY;
        Fri, 11 Mar 2022 14:51:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        aevar@gmail.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 02/25] bundle: alphabetize subcommands better
Date:   Fri, 11 Mar 2022 14:47:18 +0100
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <a9bcb6065523e2d2307fdc5b7bc92b04aba012e8.1645641063.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <a9bcb6065523e2d2307fdc5b7bc92b04aba012e8.1645641063.git.gitgitgadget@gmail.com>
Message-ID: <220311.86czisha13.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The usage strings for the 'git bundle' subcommands are not alphabetical.
> This also applies to their inspection within cmd_bundle(). Fix this
> ordering before we insert a new subcommand.
>
> This change does not reorder the cmd_bundle_*() methods to avoid moving
> lines that are more likely wanted in a future 'git blame' call. It is
> fine that those longer methods are not ordered alphabetically.

If we're moving these around it makes sense to make them use the pattern
of macros we use in commit-graph.c. I could have sworn I changed that
here already, but obviously not...

Anyway, I think as general UX I thought having these in alphabetical
order was a non-goal. Doesn't it make more for these commands in general
to list themost frequently used commands first.

In this case though there's pretty much a mapping between that and what
happens to be alphabetical order.

But I'd think if e.g. we implemented an "add-ref" or whatever to
in-place munge a bundle file to add more data to it such an obscure
thing would be better off last, before create/unbundle/list-heads/verify
etc.

Jut my 0.02, but for this change I really don't mind it, other than the
macro suggestion...
