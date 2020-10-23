Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D544C55178
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3014124182
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 09:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6yEYZgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461215AbgJWJN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461148AbgJWJN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 05:13:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A48C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 02:13:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bc23so847145edb.5
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Av1wqLsNGVi/TRziXeIrRKokSpQSW8sp/ypvZS5jxT8=;
        b=r6yEYZggCOfn+ItxiG8h+Sq408zUkfw42VDEQ6WVdkG/MJEJrKMcli7acPGuEgigBx
         mHTmt3aBzVa+w5P1FWXqwHM+1lqNtsjr/3SktgOqUTw83EICasN8n50EsUKkrDth4pMD
         /yD3iW+SDK85TWLkAL1ceFWyN32GB8LaOEO2q4wlikb0UZpTpDx0I0nABfMQxwR/KWvw
         LVjbXUS/84Gd9Ue2YjYwxIGstAIQQNCSAHUyAYqBDUu5zD2g4Idv2rYJxjDmokC3o4E3
         E81+/vI/dtov+zwGxjNW9VzvAc0yVlvv5YkFQlMJOfdxccZt3PexMDFVByIN/vOFEOvt
         YQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Av1wqLsNGVi/TRziXeIrRKokSpQSW8sp/ypvZS5jxT8=;
        b=DlQO+R+o+gypPysCJ/igFoWGx1bSP2E96m5MMUCFgqx62skhGLu6/T1lbFP75PQdWO
         QYs7TzJcBpflACBKH4NLxahc944/hYATUS+8K+AArBqe0NHPs1BhCCXRH0nziv2Q8Kpj
         ipZKRM+swGQ7Qo7dmyiX1yHnlw1PxKrU+05XQA2IpmQTauIBWdxKgZGTbs770Bj4wh7b
         8I/mjb0wzb8LKPHQtN/oobL5wt4ZogCPIybg2RBM2VjAWL+g374dy5Et7iMcHSRG4sDq
         GKIs3LVhNFIsu83SzBF0yy+qVvN6zHrACcXKAuZZ3CZRDh1DRyvSYh7ZkKz29lAugQiV
         vKCg==
X-Gm-Message-State: AOAM531zpJ5cVNX51M5UpMMhlEHdDhfTJr30xO0rjedOBq4reit3JdoA
        5RjLgn/YyQ+BZYB5ZgECa/M=
X-Google-Smtp-Source: ABdhPJwU8/vyvV01kAVSZRDkdZO0FsA1eN37D87Pel3N+fZbY1d1RnejqzA3UpdIWO7KbqqYrHi0mw==
X-Received: by 2002:a50:9519:: with SMTP id u25mr1306413eda.102.1603444434299;
        Fri, 23 Oct 2020 02:13:54 -0700 (PDT)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id se12sm462775ejb.37.2020.10.23.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:13:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201008014855.1416580-1-jonathantanmy@google.com> <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
Date:   Fri, 23 Oct 2020 11:13:51 +0200
Message-ID: <873625i9tc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 10 2020, Han-Wen Nienhuys wrote:

> On Thu, Oct 8, 2020 at 3:48 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> > From: Han-Wen Nienhuys <hanwen@google.com>
>> >
>> > This commit provides basic utility classes for the reftable library.
>> >
>> > Since the reftable library must compile standalone, there may be some overlap
>> > with git-core utility functions.
>
>> I think duplicating things like strbuf is an unnecessary burden if Git
>> is to maintain this library. Something like "reftable will only import
>> git-compat-util.h and strbuf.h, and any project that wants to use
>> reftable must make sure that these functions and data structures are
>> available" would be more plausible.
>
> Sure, but how do we ensure that the directory won't take on
> dependencies beyond these headers? I am worried that I will be
> involved in a tedious back & forth process to keep updates going into
> libgit2 and/or also have to keep maintaining
> github.com/google/reftable.
>
> FWIW, the duplication is really tiny: according to
>
>  $ wc $(grep -l REFTABLE_STANDALONE *[ch])
>
> it's just 431 lines of code.

Why import the dead code at all? If I add this to your update script:

    # Not a general solution, but works for the specific code here.
    perl -0777 -pi -e 's[(#ifndef REFTABLE_STANDALONE\n.*?\n#else\n).*?(?=\n#endif)][$1/* Removed upstream code for git.git import */]gs' reftable/system.h
    perl -0777 -pi -e 's[(?<=#ifdef REFTABLE_STANDALONE\n).*?(?=\n#endif)][/* Removed upstream code for git.git import */]gs' reftable/strbuf.c reftable/compat.h
    perl -0777 -pi -e 's[(?<=#ifdef REFTABLE_STANDALONE\n).*?(?=\n#else)][/* Removed upstream code for git.git import */]gs' reftable/compat.c reftable/strbuf.h

It's now 157 lines instead of 431.

I think doing that with a tiny bit more complexity in the update.sh
script is a much lower maintenance burden.

It's not just about the number of lines, but things coming up in grep,
and now unique code really stands out (e.g. strbuf_add_void, should
probably be just added to the main strbuf.h if it's needed...), and of
course the cost of attention of eyeballing an already big series on the
ML & the churn every time we have updates.

Overall I'm all for having this carved out in its own directory at a
cost of a bit more maintenance burden if it can be shared with libgit2 &
be a standalone library.

I am concerned that it seems this code can't be maintained in git.git by
anyone not willing to sign a contract with Google. I sent a tiny PR for
a typo fix at [1] and got directed to sign [2] before someone at Google
could look at it. I see brian raised this before in [3] but there wasn't
a reply to that point.

Is there some summary of how this part of integrating it is supposed to
work going forward?

At first glance that seems like a recipe for perma-forking this pretty
much from day one, i.e.:

 A. Upstream changes happen
 B. We get a patch to the bundled library to this ML
 ==> Google employees maintaining A can't even look at B
 ==> Patch B can't be integrated into A

1. https://github.com/google/reftable/pull/2
2. https://cla.developers.google.com/about/google-individual
3. https://lore.kernel.org/git/20200512233741.GB6605@camp.crustytoothpaste.net/
