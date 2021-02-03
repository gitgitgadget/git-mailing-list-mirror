Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68EDC433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C9264F65
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhBCPys (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 10:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhBCPfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 10:35:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E62C061786
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 07:34:50 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id k193so29308qke.6
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 07:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ArkWLqU89mwdUJZMs2TD6Y8+7altj3rxKhntlKj23c=;
        b=Joq4wHm1FHtGFtS+UBLIfRxjrkN51dFYvm1i+0C8PBaamfwCl/cQcolFnw9e14zjs4
         w9IIi1msp7bAPggwvqBhs5kfACjqQwbDE60n2naAc33ZfUBUV8pr4gGLbRnfP1OLfPG2
         Kh40HIFWhJ0kI2867fSxwI3/c0f5hLJjovf8Z2dwZHgDFhNLLVZvaWcudGHlu2F/DxWe
         zWoJMPtAPZsVYvsz2y4kIdHe/MJUqWoPSwWuxBilMt3L5D+a4VKKdKtFotDtATBpjCyY
         qrUZOFjY4aTet3a+WttkDDeUW01ucL5WdSCtla5Vkf+VntgcjNGBWLM4WVuMg61x26C0
         Q+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ArkWLqU89mwdUJZMs2TD6Y8+7altj3rxKhntlKj23c=;
        b=K90kBHWhf1bY5BLtKSiNAFHbhwx7sPzDlwotmbAnI5KX0PN6hi8nLV0n96R42GR7q8
         dWrWcjWUFgllM5izZDe/do8mWvLH2HziiUpjfh0tRj/uynZLSYNyZlKKF1qK4Mp80m6w
         RV4azpO72v2yk+xwvPsMl7vRGcdM+fXqbAffSmqZOkTebNXDPyBYkEg0GRCtDhIHDiQj
         L4cWoBj3SK5RgfZwzOoQl0mg4xQ6gezkWa4OnuOqGdijbfXrNhCRAYMwQRgKvwsARxht
         QJLT5p/RU6vz15bhLv6ZpzHeDR+xb3Pl3siqqlQYsm7LFjRb7CRL2qGZcEyPYZT65jcR
         MSaw==
X-Gm-Message-State: AOAM530Q3ZaEtwasBXb6TcdqH5c6E34rlF4K7v2Gj20Gg5HaJdQGYx4F
        +2TNxf9iLgxBH7ckHzi1NeVUsw==
X-Google-Smtp-Source: ABdhPJz4er/YnoEEXUB4J9rH9d1AJF6PSdF9f1z6LlrhyJJ6VdjzR/6M+Tn4B620G7jiOam1Y0coxA==
X-Received: by 2002:a37:4e43:: with SMTP id c64mr3053705qkb.49.1612366489828;
        Wed, 03 Feb 2021 07:34:49 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id t3sm1849962qkg.91.2021.02.03.07.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:34:49 -0800 (PST)
Date:   Wed, 3 Feb 2021 10:34:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/6] commit-graph: always parse before
 commit_graph_data_at()
Message-ID: <YBrCli7AR/XrB3Pr@nand.local>
References: <pull.850.git.1612199707.gitgitgadget@gmail.com>
 <pull.850.v2.git.1612234883.gitgitgadget@gmail.com>
 <454b183b9ba502da7f40dc36aaa95cc3d12b5c2f.1612234883.git.gitgitgadget@gmail.com>
 <YBn3fxFe978Up5Ly@google.com>
 <1dab0bf0-9a7f-370a-c807-25d67ac7a0a0@gmail.com>
 <YBoBBie2t1EhcLAN@google.com>
 <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dc1520f-8130-75e1-6617-67b54cb03933@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 02, 2021 at 10:07:32PM -0500, Derrick Stolee wrote:
> > Can we package this as something more user-friendly?  E.g.
> >
> > 	git commit-graph clear
> > 	git commit-graph write --reachable
> >
> > If that makes sense to you, I'm happy to send a patch (or to review
> > one if someone else gets to it first).  I'm mostly asking to find out
> > whether this matches your idea of what the UI should be like.
>
> 'clear' is probably fine. I was thinking it might be good to have
> an option to the 'write' subcommand to clear the existing data, but
> it's probably better as separate steps.

Wouldn't 'git commit-graph write --split=replace --reachable' do the
same thing? I know that you changed some of the spots where we load an
existing commit graph, so my claim might be out-of-date, but I'm pretty
sure that this would get you out of a broken state.

Thinking aloud, I'm not totally sure that we should be exposing "git
commit-graph clear" to users. The only time that you'd want to run this
is if you were trying to remove a corrupted commit-graph, so I'd rather
see guidance on how to do that safely show up in
Documentation/git-commit-graph.txt.

On the other hand, now I'm encouraging running "rm -fr
$GIT_DIR/objects/info/commit-graph*", which feels dangerous.

Somewhere in the middle would be something like:

  git -c core.commitGraph=false commit-graph write --reachable

which would disable reading existing commit-graph files. Since
85102ac71b (commit-graph: don't write commit-graph when disabled,
2020-10-09), that causes us to exit immediately.

I think that reverting that patch and advertising setting
'core.commitGraph=false' in the documentation makes the most sense.

Thanks,
Taylor
