Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9062C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJTRG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJTRGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:06:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725F21A1B2B
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:06:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 137so83681iou.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lZd/e+GQaixLUQ1BDCktO/vol44y5E1ppOY/xk5slu4=;
        b=J6YS/nKsrY8zRGa2eSj6SaQ0HOc2MXzjMQTPeKVwb4lGL8D/EEhuFvZQVIfZZoFWnQ
         0uqdFgy4uo5OyJfuZAFs0R0NTi56d1N5D7g3O7kcw1VUQReCi/H+cPKIS04mSwe0+7QV
         Y+4XQ6lHaTsbiN2MPLM+wJVR5x6lEaNbBP6IGXURt6S6C1TA0tidplNIPus+hPYkzh0K
         9Vuc9q7Ay8vx3nXD2I1viibsxUzEWPPPhrUDumtMo5NIR+f96CJf6aUsaZdPKw85z5yS
         taGaUCFBNYaCjMAO6n7PIF3Tfh4ODoC/3xiYgy6nSh104/FO/WVPhUCc4karwEmxAaVd
         oyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZd/e+GQaixLUQ1BDCktO/vol44y5E1ppOY/xk5slu4=;
        b=R0Pt6fFyjusH2GfVn0Bz1UHgX30PrWaXH43CsnhIkG0zP8NWvWkAwray/K37cgaZBi
         Qb5jCqS4x+z2Up5xYC+1KJ/sp6SGNGGKKNfU6VjlnqpbsBml25ic7NA5DsGbY/aNDCTl
         90WW3uKLBj+fK+dwv4nnCKmxqMGxrvm55r69Wme249MBJCZjIzQRGV9Q8b5YNSPsSVC8
         KZrxZJZOvCbPEsBYG01IoAHPE6n926Lho6ZM8V69+VojzT3FAXqeAN/zg0dYIp37achJ
         Av5Mk8jBH3s/49enrYPffb45jwVJkKbL5ZG8yufisyXfy91W6g9XRLdR+J/IjkhWx9gi
         SYhA==
X-Gm-Message-State: ACrzQf2ziJSAA/oE6gBRzOK+PvUyJzP78RENCKLBfKoiu8NC2w85Pt4J
        vGDj6+tg3AdWRSjNOzjj0yKVyQxCUSL2F75Y
X-Google-Smtp-Source: AMsMyM4WsrndLSTKOgXfGZDbOh+U3BKKWfGdOBwOYr7hI4u+sdDnX7xx824pRLbqSdGmBmbl2+a7Xg==
X-Received: by 2002:a6b:d004:0:b0:69e:2636:85df with SMTP id x4-20020a6bd004000000b0069e263685dfmr10631959ioa.19.1666285612674;
        Thu, 20 Oct 2022 10:06:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q8-20020a022448000000b00363781b551csm3425970jae.146.2022.10.20.10.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 10:06:52 -0700 (PDT)
Date:   Thu, 20 Oct 2022 13:06:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
Message-ID: <Y1GAK+y8a2lc9Kq6@nand.local>
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
 <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
 <Y1Bo18aU7YKKX9yh@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Bo18aU7YKKX9yh@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 05:15:03PM -0400, Taylor Blau wrote:
> > +- Depending on the preferences of the involved contributors and reviewers, code
> > +  review then happens either on the `git-security` mailing list or in a private
> > +  fork associated with the draft security advisory.
>
> There's a third option, too, which is using the private git/cabal
> repository. Anybody who is a member of the @git/security team on GitHub
> has access to this repository. And it is often a convenient option for
> coordinating releases that contain fixes for more than one
> vulnerability.
>
> There aren't any hard and fast rules for which approach should be used
> in a given circumstance, but I think it's worth mentioning it as another
> option.
>
> For my own $.02, I often find it useful to *start* by sending patches to
> the git-security list inline with the thread so that the original
> reporter (who is more often than not *not* a member of the @git/security
> team) can participate in review (or at least look at the patches).
>
> The private forks tied to a security advisory are often convenient
> (assuming that the reporter has a GitHub account) since they provide a
> shared workspace. But I think we usually avoid them when working on
> preparing a release for more than one vulnerability.

Here is some proposed language that I think would encompass everything
both you and I wrote here:

    Code review can take place in a variety of different locations,
    depending on context. These are: patches sent inline on the
    git-security list, a private fork on GitHub associated with the
    draft security advisory, or the git/cabal repository.

    Contributors working on a fix should consider beginning by sending
    patches on the list (inline with the original thread), since they
    are accessible to all subscribers, along with the original reporter.
    A typical review cycle often takes place here.

    Then, depending on if there are one or multiple security advisories,
    contributors should move their patches to either the private fork
    associated with the security advisory on GitHub, or the git/cabal
    repository. It is in either one of these locations that release
    branches (based on `maint`) are prepared.

    When there is a single security vulnerability, using the fork
    associated with the security advisory is convenient as it
    centralizes discussion, review, and release mechanics at a single
    location. When there are multiple such vulnerabilities, no single
    temporary fork is appropriate, so it is instead encouraged to use
    the private git/cabal repository (visibility of which is granted to
    members of the @git/security team on GitHub).

Thanks,
Taylor
