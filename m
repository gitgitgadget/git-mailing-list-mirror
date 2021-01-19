Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01FC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879AA20A8B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbhASXzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbhASXyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:54:52 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF70C061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:54:12 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l7so10092442qvt.4
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CmQk4BPx3E9dm1NmxAuPft6oljDVTlfImOhpc4+6VjE=;
        b=E7Yztar8mJG3YbZ3iPi87NcmWx7oZ1jeyDZRxsYt+LeWE8Ei/qnZCdRAgYDBinCsoN
         txvaHf+wZEDAHN9L0j3KlZaQW8UJGErb8fF5bzhU9h8bgjFkgy2x22M88dSwZh5bgQ2h
         gEu35VjEz4yVlcGlwB6KXPqEPRp61Vpyw5ISXSpr08eq4BSpmR1fowABZsAbhG1cL0fr
         axZa/sSj93nmazFS4ozJ6ZaWYLx2AjDxM7aeQgASZ2J777iwHzx95KwlEuGFh6tjmst5
         S2MceCFLNrt4LALXJN9sikKeoazBYE3i4z5vaJlKDbry/PmOCsXhVL912YV9IS91ZsJA
         f4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CmQk4BPx3E9dm1NmxAuPft6oljDVTlfImOhpc4+6VjE=;
        b=eUl0PyyzDtY1RgBGJrbgqE2UDiJgvLcpHN2YcIujQOULMTqi3kb+KUvmwTN07KJxQR
         cQm2w7VASYW8nA7de9M5+Ntl5Nhe4IhDymM0YiYjGXe+sXrRSTUPqhIdKg7DjfKsBIqQ
         QEb+KJ6uLgvczFYYQgQE5+PqGIupllSXp7DTY8OL9TDfRDjiq7lOvmzySw+uFmVNS1sK
         fxQUeDv3OadysrgMwADAJfMgUakF3nPtV8cCIkYVK7XTpGnf+/bWnEzwrildsVnhO9do
         LM++MNNJDqqNhmC3pHyJwcSaVL/Wq1VXc5M+QfEXvBh1tjIqkC8VJIXaONCGbxDjOhbk
         HNBA==
X-Gm-Message-State: AOAM532gNbbs8CZhE1KH40aty/ngXbSud2rsPM34AiHLucq/p3Toii+c
        0aq7a1aPW4bahH9EOrdZ/bo8ng==
X-Google-Smtp-Source: ABdhPJySFfwzxF7eWSAgjNfDWOZthevF0Pke3tpfzSN7+VO2QhOZOlVKtA6MQUA85miuYgzsMJty/g==
X-Received: by 2002:a0c:f2cd:: with SMTP id c13mr7129898qvm.11.1611100451948;
        Tue, 19 Jan 2021 15:54:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id v17sm26579qkg.111.2021.01.19.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:54:11 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:54:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Jacob Vosmaer <jacob@gitlab.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAdxIfjkK+ShZ3Ux@nand.local>
References: <20210119143348.27535-1-jacob@gitlab.com>
 <20210119143348.27535-2-jacob@gitlab.com>
 <YAdmb3EfNVHYavNk@nand.local>
 <YAdsTjDXImYlfTn8@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAdsTjDXImYlfTn8@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 19, 2021 at 06:33:34PM -0500, Jeff King wrote:
> On Tue, Jan 19, 2021 at 06:08:31PM -0500, Taylor Blau wrote:
> > That said, you could shorten this to use 'for_each_tag_ref()' instead
> > (which compiles to the exact same thing).
>
> You'd end up with "v1.2.3" in the refname field of the callback then,
> rather than "refs/tags/v1.2.3". So we'd definitely need to drop the
> prefix check in add_ref_tag() then (though I think it is a good idea
> anyway). But I'm also not sure if it would interfere with peel_ref(),
> and its magic for using packed-refs peeled information.

Ack, thanks for correcting me. Looking at ref_peel_ref(), I am almost
positive that calling peel_ref() on "v1.2.3" (referring to
"refs/tags/v1.2.3") wouldn't work. So I think the current implementation
is good.

Thanks,
Taylor
