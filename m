Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AD4C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiI1Pmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 11:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiI1Pmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 11:42:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8356CD01
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:42:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z13so17743909edb.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=j0n58hU82Hp3RHRRu+VI21GcuKDg6Tufc+67mRgp1eo=;
        b=aip+MT4XpYuFQiOTDMm4Q4OKTGG/07ROYzrWX4/AAC2mERw8dvf+zc8DTzAAC+pqVp
         YI7c5ynp2uMGDdocEJ+VjVMSBnByoSTfX3jj+nYI+95trMxxgFWuc26z0j/CHfR2I5Ua
         u+9masn9BMtC1XjZiCDk/62eUh/sm4jdUhiOgBqCCJxk0QAbuIIpdcO9+yo913CbhGWp
         pXRgkPYx3uEZfZ7gr0499BrqR1xj2bA+7GkWfrU/E4+QQmeRh76xTZ5sdQLDJY7bVQtM
         vouf0G/7one/D898JzuATYcLIqVHmrJ/BsgZZHSb3kdi024C57qnUCqXke8rP3f+FV/k
         O2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=j0n58hU82Hp3RHRRu+VI21GcuKDg6Tufc+67mRgp1eo=;
        b=g3kEpO6Mjbz2Jn5wv31uw4eafmTjmIpqxlXCiyNZv9uUKrABp5cVR/nXa2qA4ILi1s
         +owbwrY3bBK7zO3V8djD3K8OWmeDrasjoZhm/ELnbzJtwR+8mXVa42iQGCcoqhapnLur
         YN0snjAwXwzikjZscxYwEo9lOtouVJhdZAIch5pPrTc3sGoaUICIi8Rg8mb5RPaDtKWA
         PHWQT8O+npMLRzVOZTtEqJJS0KVe7c0T0rqMEjZKLU8IT1VStvJ6Dmgd5C11WW3Ok7yE
         ypQKtG/cBmw9oJqhVaHEWp1UmMeK9AyrJTm9lP/a+ZX3ujXNh2L0MVd0mnhQSx2stBGB
         RMww==
X-Gm-Message-State: ACrzQf1m1ezfB8E7tavQgE161VUi5mEUO7OIp9Mlm7vzxF3vYwuknY6d
        zC7N25ai81MGnlW7RbXCxz+RKVWqJcwT2A==
X-Google-Smtp-Source: AMsMyM7JnwzvmcUig9EmTJZMvp85gaitqZSXcxXSSm0Nh9yx+fhKj3qwZTIkMDaCr9xi7+OTblbXfw==
X-Received: by 2002:a05:6402:909:b0:435:a8b:5232 with SMTP id g9-20020a056402090900b004350a8b5232mr34093597edz.240.1664379749741;
        Wed, 28 Sep 2022 08:42:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id vs1-20020a170907138100b0077fc446aaf6sm2507313ejb.202.2022.09.28.08.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:42:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odZCe-0011uj-0x;
        Wed, 28 Sep 2022 17:42:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3] tmp-objdir: skip clean up when handling a signal
Date:   Wed, 28 Sep 2022 17:38:21 +0200
References: <pull.1348.v2.git.git.1664306341425.gitgitgadget@gmail.com>
 <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1348.v3.git.git.1664376956780.gitgitgadget@gmail.com>
Message-ID: <220928.86leq3wlnf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 28 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>

This looks good! Just a clarifying question/comment:

> Since we can't do the cleanup in a portable and signal-safe way, skip
> the cleanup when we're handling a signal.
>
> This means that when signal handling, the temporary directory may not
> get cleaned up properly. This is mitigated by b3cecf49ea (tmp-objdir: new
> API for creating temporary writable databases, 2021-12-06) which changed
> the default name and allows gc to clean up these temporary directories.

I think this still doesn't cover the common case of the "atexit" handler
saving the day, as Jeff King pointed out in v1:

	https://lore.kernel.org/git/YzLiI1HZeBszsIJq@coredump.intra.peff.net/

I think it's fine to have this proceed as-is (although if you're doing a
v4 anyway, maybe we want to update tho commit message). I.e. is it
correct that we'll now only skip this if we get a signal, *and* it's a
fatal signal, or we otherwise die/exit/abort/whatever before we can get
to our atexit() handler?
