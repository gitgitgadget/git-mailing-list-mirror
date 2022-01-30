Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94376C433F5
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 08:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354365AbiA3IQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 03:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiA3IQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 03:16:19 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F5C061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 00:16:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id k17so31252438ybk.6
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 00:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O6JzQKaxID/QKC8HzKBhX8ZqmLyUVOVlsWjBM3EWa8=;
        b=PaKYP5cbBrq/5zDr/VtIjLhRZnslUhXOMiQD8NyuaIfEboLNkniHAnQePJEo+7t1hd
         BEW7GS9zgW+1EStYu5te4l5RsMnP7gIwC5sX+LLNqjHyExrjNjTZPdGzu5IAaFX4Wmf/
         IlJ/mPwPNy4aeE+6KMNl6xMQkyiIcK3wDWr2UOEwKrF/gzq3MeCnoI4FMdZWafwppOrR
         9hs3HOE5N7HUDBThiwjF/8J0LNL4Tt9a8aRC8ybQTvkOA3IUorP0YUmxzhJL3LLfNghb
         nimrdyVMuTCk0YEr2c4JtRWxhcAXN2sL/GQw1n1ac1NsMYfH9ysx/1+EpU6CQXQ3+NcK
         pVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O6JzQKaxID/QKC8HzKBhX8ZqmLyUVOVlsWjBM3EWa8=;
        b=XyGaWKMqsA3WsEFZ5RLZ/70Ah32sHslPARIuqCEScaUDbFlbculRy9YQKZ7wGjGkz1
         boAJrU0Tx+zZjXpJXohUZ6DTBb7b9EmUbUXiJ17K1/YqoTMP9U4D2s0d9PUtprYxgn3e
         pgXrhso9bU8uXMlvkfQzuqS68AvF3uhcb95Ltec8B5U7CN/7i/2sxPYIJ7cXF2vxrliA
         zRtlHPuIZFs7AeauKPy3Z/leDDhhgLnu+FPATI/Yy0YUvnIpDMCtrQPA5Km8+ptSUndY
         iOggf+m4ZWhwD2G0Zsd52WPS4drOf1PR7FtFPmKJVRgcEF7I+KlqqRxr45Rsu5cl7xaX
         ZfXQ==
X-Gm-Message-State: AOAM533EoDiGhXLr/miggSx4Jzu9xSvd2WzTxtP3l90VuB0uKTfemoDt
        7ruG1GxaxHc7ZBgO/JFFOynAqVM1M6ppkXxOj91m9+ADxO8=
X-Google-Smtp-Source: ABdhPJyxQ5akV72/GFJWtnPt/iUBSoWspeE23X9YFw5TjW19I138p6tfZJ+XqdnBR3+u6mmobPBd0Y4/dxZofB7jP0w=
X-Received: by 2002:a05:6902:920:: with SMTP id bu32mr22733562ybb.693.1643530578756;
 Sun, 30 Jan 2022 00:16:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <a3166381572481f2ed159740eb8a1d88d4f9dc0f.1643248180.git.gitgitgadget@gmail.com>
 <a62a007f-7c61-68eb-c0e6-548dc9b6f671@gmail.com> <A4BAD509-FA1F-49C3-87AF-CF4B73C559F1@gmail.com>
In-Reply-To: <A4BAD509-FA1F-49C3-87AF-CF4B73C559F1@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Jan 2022 09:16:07 +0100
Message-ID: <CAP8UFD2z1P2-7zhyBEoSpV=KBri9qEQpho_q6RZ1+7tUNLiyHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack: add --filter=<filter-spec> option
To:     John Cai <johncai86@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 29, 2022 at 8:14 PM John Cai <johncai86@gmail.com> wrote:

> Apologies for the lack of clarity. Indeed, I can see why this is the most important
> detail of this patch to provide enough context on, as it involves deleting
> objects from a full repository as you said.
>
> To back up a little, the goal is to be able to offload large
> blobs to a separate http server. Christian Couder has a demo [1] that shows
> this in detail.

You might have forgotten to provide a link for [1], also I am not sure
if you wanted to link to the repo:

https://gitlab.com/chriscool/partial-clone-demo/

or the demo itself in the repo:

https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http-promisor/server_demo.txt

> If we had the following:
> A. an http server to use as a generalized object store
> B. a server update hook that uploads large blobs to 1.

s/1./A./

> C. a git server
> D. a regular job that runs `git repack --filter` to remove large
> blobs from C.
>
> Clients would need to configure both C) and A) as promisor remotes to

Maybe s/C)/C./ and s/A)/A./

Also note that configuring A. as a promisor remote requires a remote helper.

> be able to get everything. When they push new large blobs, they can
> still push them to C), as B) will upload them to A), and D) will
> regularly remove those large blobs from C).
>
> This way with a little bit of client and server configuration, we can have
> a native way to support offloading large files without git LFS.
> It would be more flexible as you can easily tweak which blobs are considered large
> files by tweaking B) and D).

Yeah, that's the idea of the demo.

Thanks for working on this!
