Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75623C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbiEIQ2p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238952AbiEIQ2o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:28:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865D1A809
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:24:50 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f5so9641308ilj.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schrodinger.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2b06CUdYXjWiEn3nP1UkmanFdhCZqI0dkeFbHfZJj/g=;
        b=nkO51lEz9mgol8qBKDbo/8FL4QlEIU2F2JIMZZukCvzOfqYsqBWSehCBeyCV0DriWk
         y9oj4mkvfw420VaZl3iAbfc+HSG4kxcxUobvTxSdav3S8D5ZRVLdWVnwmc69c9/A+V2W
         mo6P1xh6LSuvhWAIkAc2p5VM8Ck49WQ06uLTnpfMptOn8wn+VMm5NMEtcrzy11NzFdUp
         o7b/D5f1nbNqFZMpULNToA0YCSFAIFcv5drPUXoZzAu86O4BsVeyaFw738bHe1SPrK+d
         t5TQfzdWRPUt/4CArzmN2+SFkFu9cREfGpSCM1kJK6bRTWXrmxkKv/GVqoBFmY3aQaU1
         nAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2b06CUdYXjWiEn3nP1UkmanFdhCZqI0dkeFbHfZJj/g=;
        b=zuiZxrMS9YS81roly6+SCj/lxV8bQ0fs4BmODv/FhlZNPhYT6PclqOMhgvS9oSovm+
         VJbWqK9f61HFVFFJbKLKdQYfEh1krWdpau5KaUhW96ScWa46k1DQzbcoUbEqSTqLVEid
         iZQTU4a3OAoTO/rTI3ERZdGIv78/kKas+Kz2Ta5xLUWRCzT+StEyhC48sbeb5gFOfqmf
         peF28By0h75lRWRPUTFWqQp31iK6C/ZQAFLeQjFqcjSJ8H11XeVRT8yU0xKYMLMq/SuH
         2K5sTtWiH2K+Pjub61bHVLHppDYLtscRWERJW5l7yTQG26J9D7u9j5BjUvZZRk/fAM/G
         jRww==
X-Gm-Message-State: AOAM533/yXuLrc7M5tT5qB9fYCvHul12a84rKobbZNkCS31GruZnMyKp
        V94xxAqrqdQVwIOu0VZe3kKdMSJnnlPfcUKWSj0GoA==
X-Google-Smtp-Source: ABdhPJwgo5SgPItE/EcoPQt4Vn3gUwCWjTWhIF9i3VKKs4DwLbQIzCqIwOO+gh2wvWhOQhySIYaOoC368MtPYTuIqF4=
X-Received: by 2002:a92:d4cf:0:b0:2cd:6e3e:9d8c with SMTP id
 o15-20020a92d4cf000000b002cd6e3e9d8cmr7045638ilm.242.1652113489733; Mon, 09
 May 2022 09:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnZ=JNE_Sa3TsKghBPj1d0cz3kc6o91Ogj-op8o6qK8t9hPgg@mail.gmail.com>
 <fc492627-c552-10ec-b30c-820299241278@gmail.com> <kl6lbkwa8h5n.fsf@chooglen-macbookpro.roam.corp.google.com>
 <b4d7600e-ed4e-b4b3-262a-a69818c25365@gmail.com>
In-Reply-To: <b4d7600e-ed4e-b4b3-262a-a69818c25365@gmail.com>
From:   Huang Zou <huang.zou@schrodinger.com>
Date:   Mon, 9 May 2022 12:24:38 -0400
Message-ID: <CAFnZ=JO15s=nXSNSDNeMvS98M49HxZ6N6EfNxP6v7-46i6dDNw@mail.gmail.com>
Subject: Re: Bug Report: fetch.recurseSubmodules doesn't affect git pull as
 otherwise stated in the git config docs
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen & Philippe,

Thanks for taking the time to look into this!

> > I think the bigger question to ask is "what is the intended effect of
> > 'submodule.recurse = true' and 'fetch.recurseSubmodules = false'?".
>
> Yes, I agree that it would be nice if Huang clarified that as I'm not sure
> either of the use case.

> > Perhaps this is just a performance optimization? i.e. after fetching in
> > the superproject, the user wants to skip the rev walk that discovers new
> > submodule commits.
> >

So the use case here is just performance optimization. My team has
over 10 submodules and I do not deal with most of them. I want to be
able to pull the latest changes quickly (fetching submodules adds ~13
seconds when there are no new commits to a pull that would otherwise
take ~1 second). I want my working tree to be clean after
pulls/checkouts. So checkouts and other commands that update my commit
HEAD should still recursively update submodules (hence
submodule.recurse is true). Although, I may be naively assuming that
fetches can be avoided if I only care about the commit referenced in
the submodule link. If that isn't the case, then the more practical
use-case would be  'submodule.recurse = true' and
'fetch.recurseSubmodules = on-demand', so at least submodules are only
fetched when there are changes.

The other use-case here, which I should have probably included in my
original report, is `git pull` currently also recurse into *inactive
submodules*. i.e. submodules that are not set in "submodule.active".
If my submodules are not active, and not initialized, then git should
not fetch commits in those submodules regardless of the settings in
fetch.recurseSubmodules

I hope this helps clear up a few things!

Thanks,
Huang
