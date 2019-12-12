Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C6C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234F205C9
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dojQpZ4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfLLRPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:15:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36133 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfLLRPV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 12:15:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so3416322wma.1
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+/4XbyA7Sw8rHNaOeNIVjs9c07hX/90/PKdDZQwJ0rE=;
        b=dojQpZ4uJ+RuSbYTQ4k7Q3BCWH+WRFnvaXr6Ojm+pYlggHOuNdrK7ksbE5t9INhfqe
         2ZRaPPXzlWYX0GQvV4M+3c0McKG9J0ubidAidI9zhGKXOr7FgA6/B61IqO+6rUe3qkPA
         zdpDRVuLKgE1U/8tGgAMkJCCRz1GqR2WsBm7HOwGDny/1atkCE5lHtuZ0Jp2Vdlv9o/H
         /lAfQBDncGEGDQTagZugratlQ9WoHN3YKsfMX6eXc1bvI/2wANiq4vna7iJENIJwMfF/
         D9I5iju/ZvC4OtjpOjXghrvS+YPIgR9lyl/SCdegBJ+PssJjEoi1BiJpq5ZvUOUpyhET
         YawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+/4XbyA7Sw8rHNaOeNIVjs9c07hX/90/PKdDZQwJ0rE=;
        b=gxpwzgBpdxZrW4qdoWNAWBAzTRQpx23C5dWxgXZUvumHbKBnxuSakjaQGmUOIdKukr
         1a5uY8FyWobKhPFrHj8VxhHlijYx2aHU7cVwCk7zKO3D9MpyPH1/4SioPgQZa3WocJwW
         4RL8D7/142ajKt8lXPlPPptkcsepLsaMd500juOsqeXJEE39g0p0tboxBcr4GNz6anPE
         x6iGVGBjjtkWHRPLjP/OZLokE87Zm0RKXGGgdVYO1+snrjZqqQyKvS9Hoh+FPlsX1/l9
         /0QIJ2miNaBjHbKSozKb4eHBmoIa2/djSBnPg22FmJYKcQsdgdcr3yFFvzYCe8ZhNCao
         YnJA==
X-Gm-Message-State: APjAAAVXq6WoIk49++bt0+xa7xaWz7jU7o0yKI3WAeQ09OujLfyOZ66z
        DKpBO4eaUppGuRNqgrhH1IU0d+nP
X-Google-Smtp-Source: APXvYqye1tLf7h6LOQS8izaZ489KucGZPU9w57q/q5Z8Rik8j9ShkE9UlETVHzLl/booQcmC9n96Bw==
X-Received: by 2002:a1c:6a04:: with SMTP id f4mr8109215wmc.14.1576170919658;
        Thu, 12 Dec 2019 09:15:19 -0800 (PST)
Received: from szeder.dev (x4dbe262b.dyn.telefonica.de. [77.190.38.43])
        by smtp.gmail.com with ESMTPSA id s8sm6578931wrt.57.2019.12.12.09.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:15:18 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:15:16 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7
 environment
Message-ID: <20191212171516.GL6527@szeder.dev>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207003333.3228-2-yang.zhao@skyboxlabs.com>
 <20191210103014.GF6527@szeder.dev>
 <CABvFv3Lud80UzFXa6BRMGLwRV6gsJpNcs-mrgOiNHoJL0d+koA@mail.gmail.com>
 <20191212141322.GK6527@szeder.dev>
 <CABvFv3J8JjXGeAXSWDmK5zDav8qYNQ6Ce-8dPGAmuySGj8xvNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABvFv3J8JjXGeAXSWDmK5zDav8qYNQ6Ce-8dPGAmuySGj8xvNg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 09:04:24AM -0800, Yang Zhao wrote:
> On Thu, Dec 12, 2019 at 6:13 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > > The CI scripts as it is currently does not separate compiling and testing for
> > > non-Windows builds. I don't see a good way to only run a specific set of tests
> > > given a particular environment without re-architecturing the CI pipeline.
> >
> > Building git and running the test suite is encapsulated in the
> > 'ci/run-build-and-tests.sh' script, while installing dependencies is
> > encapsulated in 'ci/install-dependencies.sh', just in case Azure
> > Pipelines Linux images don't contain both Python 2 and 3 (Travis CI
> > images contain 2.7 and 3.5)  So I don't think it's necessary to touch
> > 'azure-pipelines.yml' or '.travis.yml' at all.
> 
> Yes, and this is implemented as a single step as far as the CI
> pipeline is concerned. It does not produce a build artifact that can
> then be loaded into multiple environments for running tests.

I don't understand what artifact should be loaded into what
environments...

> Unless there's a very good reason to _not_ use Azure Pipeline's
> built-in Python version selection support, I believe it's more
> desirable in the long-run to leverage the feature rather than maintain
> some custom solution.

Azure Pipelines's built-in Python version selection support only works
on Azure Pipelines, therefore it's more desirable to have a general
solution.

