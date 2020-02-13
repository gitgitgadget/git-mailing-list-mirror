Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2902CC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 12:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA98222C2
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 12:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clkXdrjI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgBMMbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:31:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37893 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMMbe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 07:31:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id a9so6510076wmj.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QO4dFawU2QuyfH7/5+Y7RQEiNVjhNuwhmoLrd+62fJ0=;
        b=clkXdrjIlY2Vpio5t2iUK82u1VxwytSkMDE7uH7WBiEp8ZwSy9bPg+F5zRTg0j7tD0
         qr7lgPXnpVDFgjbrGYVGFuCSWQr0EVsWSO0GlMxFuRJJDy1/cOA2DRXJPybInURLjTsh
         P3MIgRdwLpWWhXyh9KcKkpT/UiEEQVewXl/QEupqD+1U1xLcKfjG9pIjJW/2rPMbRwUn
         1V8tj3tETk0ptja0p9ARsPCpssh0XVFRnxbzTsbvlb7iyB80w8ufnOw/ypCaEQLrxrOq
         JLwnuoBvibZpFgp+Vdp2Q5A93PSCW8QJyPUKfo2uIfSvSQApKoXx9ZbeQFR0eXoQC7EU
         cuyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QO4dFawU2QuyfH7/5+Y7RQEiNVjhNuwhmoLrd+62fJ0=;
        b=lH0kapgE14hylO6xUaDFXeRgRMbMKg3X16sv2N0DsT8nGgbj7CzUqojMELbB9JjU22
         7f2YZ8kdOO4k6j76eFOJd/MQ2JIMUQjThoY2mqLodyBqxQGmvctfbHhDBAfyDbIIWQ/B
         42osb+isCTR2M+TBi9Cp7GuRXnhfqTmnfYQXvscqbqTDMh1Ctjr6ergZ68q4pWhE7LLf
         jL5MDZTriNYy1w9QBe8lUJLNrBMAt1Xuo1c4TtdaAepie68ZKrXHpN34kl11FsI46OBk
         i+z/y4ErVF7pybnxwMTkz0Ks1EwhErGPSa+TgPkJuGoyzuuq7h0gsbYRvrrXHNDN+js3
         CNDA==
X-Gm-Message-State: APjAAAW/qNJK05ZAGmye2DxDS2vHRync7inabR7/+GSRGDGNd9adj6RO
        0FSLEPIhThjdWRWGA6RF+2s=
X-Google-Smtp-Source: APXvYqznOeYfXapzOIk8PfAlbaJDqriWt+qpwjg0JnZ8vfdjRHZ1uDFcJL7cTzimeAKMt1oXxdzRXw==
X-Received: by 2002:a1c:3b87:: with SMTP id i129mr5524210wma.142.1581597093239;
        Thu, 13 Feb 2020 04:31:33 -0800 (PST)
Received: from szeder.dev (x4dbd7231.dyn.telefonica.de. [77.189.114.49])
        by smtp.gmail.com with ESMTPSA id t13sm2672859wrw.19.2020.02.13.04.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 04:31:32 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:31:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 3/3] builtin/commit-graph.c: support '--input=none'
Message-ID: <20200213123129.GQ10482@szeder.dev>
References: <cover.1580430057.git.me@ttaylorr.com>
 <cover.1581486293.git.me@ttaylorr.com>
 <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 09:47:57PM -0800, Taylor Blau wrote:
> In the previous commit, we introduced '--split=<no-merge|merge-all>',
> and alluded to the fact that '--split=merge-all' would be useful for
> callers who wish to always trigger a merge of an incremental chain.
> 
> There is a problem with the above approach, which is that there is no
> way to specify to the commit-graph builtin that a caller only wants to
> include commits already in the graph.

I'd like clarification on a detail here.  Is it only about not adding
any new commits, or about keeping all existing commits as well?  IOW,
do you want to:

  - include only commits already existing in the commit-graph, without
    adding any new commits, but remove any commits that do not exist
    in the object database anymore.

or:

  - include _all_ commits already existing in the commit-graph, even
    those that don't exist anymore in the object database, without
    adding any new commits.

