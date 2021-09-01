Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAD4C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9617B60232
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhIAE7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhIAE7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 00:59:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913AC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:58:52 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e26so930518wmk.2
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o9eZ+GrbCFEeyIDXtRKMx9F9YosGHW2FpnqZVlhaMKA=;
        b=LFm0/kYYdvW+8u40iCaOA49wcdyidzCOJSpdSxnCMJwyIFScEJk06PqlIyjcKx8ht9
         gxBcnekp8yT6hMbDAShJEn6YYix3jQ/5TRuK5mwHupsXOZBGcEjCOpOuaUfX5YYcYr9Q
         wEqI220UHG35juRelBwDBTElYM7ctMBFpB7sAFXe9fPR8BdJZyrkbRmQUmLYcrIsUX3s
         PONgPhyuI9oEFg6Ju7UyBLMGmhBBs6C3Bvh/8gmokkDpfIo5ptp3RZw2IgKqTsrassaF
         +5GGYgt+ohrbh5Xy/cMVobFwNenU9rgxenhSRpUvv6nzz9fxXchO1AuG8qrxGo+aU1kG
         bayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o9eZ+GrbCFEeyIDXtRKMx9F9YosGHW2FpnqZVlhaMKA=;
        b=TnpJH1HbUpGXHoZjYnFJkBFou95YVchtV8Y6xRzqxYv/83FSaF5DwaGdaERtDQUsNN
         2SVOOU5qn8dAX5Crdhwum9nrcq2nR/GfVr9GhbE/iYoch/Jf53OrPJ3cn5BzSbYCNT0u
         kHh9c8k14J82gjGAtjffns3hK9Rug+YQlfQ/vXX5tgxDyuU/tcpYyGZd25LoxAC8akOL
         3KWHutrPVVZR8eMLN9JphYHtnAXnV1Se5T33MOo7vCgHtWfV+GBoj6oaOQZVqHxKjnNt
         Gx/s6ncmekJg76NpUe/p0rNdIYXnXLT2508oU3rXviAvYm3MfWYhZEg//KU39KUHWZt+
         E0KQ==
X-Gm-Message-State: AOAM530IKyjy2Ta6qa8Alnk3RRJZg1mObl5sS1ituFvMpcxB05ZfTw/e
        sPdgKESR4g5BdDaFq/dNI203nksNf6Q=
X-Google-Smtp-Source: ABdhPJxSlTAlrYLpDuQhqxgcN1j1GHtBwbXp/aYwAzKl+mhlXN6nQXSm7ZHurtsS5FittCiZq9K+1Q==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr7560072wmi.141.1630472331240;
        Tue, 31 Aug 2021 21:58:51 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id a6sm12234755wrh.97.2021.08.31.21.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:58:50 -0700 (PDT)
Date:   Wed, 1 Sep 2021 06:58:45 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH v2] test-lib: set GIT_CEILING_DIRECTORIES to protect the
 surrounding repository
Message-ID: <20210901045845.GA76263@szeder.dev>
References: <20210828121329.1971762-1-szeder.dev@gmail.com>
 <20210829092536.2582899-1-szeder.dev@gmail.com>
 <87pmttwuaw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmttwuaw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 04:40:39PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Aug 29 2021, SZEDER Gábor wrote:
> 
> > Every once in a while a test somehow manages to escape from its trash
> > directory and modifies the surrounding repository, whether because of
> > a bug in git itself, a bug in a test [1], or e.g. when trying to run
> > tests with a shell that is, in general, unable to run our tests [2].
> >
> > Set GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/.." as an additional
> > safety measure to protect the surrounding repository at least from
> > modifications by git commands executed in the tests (assuming that
> > handling of ceiling directories during repository discovery is not
> > broken, and, of course, it won't save us from regular shell commands,
> > e.g. 'cd .. && rm -f ...').

> For what it's worth I'm very happy with this, and have been running this
> in my own daily build of git, I've occasionally ran into e.g. needing to
> manually clean up my own git.git's config file because some test escaped
> its trash directory.

Thanks, that's a good point.

After a test escapes from its trash directory I routinely check the
content of the work tree and look for stray refs, but it never occured
to me that I should look at the config, too.  And indeed, at the
bottom of .git/config there are two config variables that I don't
remember setting (actually don't even know what they do).

