Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B4C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 15:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiADPdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 10:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiADPdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 10:33:44 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46CC061761
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 07:33:42 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id bp39so34161296qtb.6
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 07:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/gDCS91pOcVy11mU2rO2nO+eBHuPeVmSex2DT0WixI=;
        b=z4N+hgE2k/ZQ8ZaOlwh1x21H8mh7wuXCO+W9HubqsxuvXiCwBCEW3DFwDZR2/TVE7D
         2CSAYpiwxFRxNZEtGEWzwRVE0z6OwQ1wWtEJ+dq4Tv7Wi8Y6JZ0xokvgOiTfgQhzSKEr
         Xj2STWhBX/vfy2bEDiZ1GY+ciIMkPX0VFur4ym+PzE0fr9WNbXSLjxMIbBugInZWz3Lf
         wh6KDwizqtMkh6x/YCr1Tm9rnw39NCLbqmh0Y316Lpgk5+eRveFRefLMFdi+my78WLFB
         60JWdazKPeCFIeCCF6nz8S9PpJXBSvzt+9Azcab70MojUeDpwXzVZzVM3NBn3pjbuMLx
         qZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/gDCS91pOcVy11mU2rO2nO+eBHuPeVmSex2DT0WixI=;
        b=Xr0PTfyj3Y7L+E9McCIM9BlRBzkDH63ybuMRrmHKyjwmoDeuASVgKYS6KOcfkhwnzW
         P1MUAjKIWkkwtQvthxVrJBXEw8h6qDxSkTu6AuG97yR5Mh8q4McEz7jogc7cb9MjsBV/
         KE67TaOnIv0f+pugQsSLdwVpQESWIFPrnFhVxbCdziYUZxO363QVPoEq/fI66JiN3ZPF
         8Hiw6W9+nzjVmQCxX5UCEhIYv8ukrW5wNnvsAuLojJGV3s8GSfz0+WoWxP+C8ErWWA+6
         N4Md/dzfV1OH3vKTZXVYj8i14QiFYJSn5PldU32dNa1mRwtdqtDkgq5g+osn9U0zL9fd
         TtDw==
X-Gm-Message-State: AOAM532ptrG/VTat0XE4qbm8wX2ksg4JaY/0qsmgwJt1bKxqW3FGqZkE
        eFYqWQepBK+KyZPrKTd3bnmcig==
X-Google-Smtp-Source: ABdhPJysIVRek82NIPcDHC5edUbJzWdQgIMZIvPAwZpSCKItHUyFsIm8/gasBeVhT+uZ9anZRcolQg==
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr44530521qta.616.1641310421359;
        Tue, 04 Jan 2022 07:33:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d9sm31911545qkn.131.2022.01.04.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 07:33:41 -0800 (PST)
Date:   Tue, 4 Jan 2022 10:33:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v2 5/8] t5326: extract `test_rev_exists`
Message-ID: <YdRo1B0Y+ZBvjspa@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <73faab9f429221b7be88ea88ce59bc47afb57348.1639446906.git.me@ttaylorr.com>
 <dbc75e29-aceb-051a-8235-e5c912172aed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dbc75e29-aceb-051a-8235-e5c912172aed@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 01:33:32PM -0500, Derrick Stolee wrote:
> On 12/13/2021 8:55 PM, Taylor Blau wrote:
> > To determine which source of data is used for the MIDX's reverse index
> > cache, introduce a helper which forces loading the reverse index, and
> > then looks for the special trace2 event introduced in a previous commit.
> >
> > For now, this helper just looks for when the legacy MIDX .rev file was
> > loaded, but in a subsequent commit will become parameterized over the
> > the reverse index's source.
> >
> > This function replaces checking for the existence of the .rev file. We
> > could write a similar helper to ensure that the .rev file is cleaned up
> > after repacking, but it will make subsequent tests more difficult to
> > write, and provides marginal value since we already check that the MIDX
> > .bitmap file is removed.
>
> ...
>
> > +test_rev_exists () {
> > +	commit="$1"
> > +
> > +	test_expect_success 'reverse index exists' '
> > +		GIT_TRACE2_EVENT_NESTING=10 \
>
> Very recently, b8de3d6 (test-lib.sh: set GIT_TRACE2_EVENT_NESTING,
> 2021-11-29) made it to master and sets this to 100 across the test
> suite, so you don't need this line.

Thanks; I had written it with this in place in case this topic was going
to reach master before the topic containing b8de3d6. But it didn't, and
you're right that setting GIT_TRACE2_EVENT_NESTING explicitly here is no
longer necessary.

> > +		GIT_TRACE2_EVENT=$(pwd)/event.trace \
> > +			git rev-list --test-bitmap "$commit" &&
>
> This use of $commit has me worried. Do the tests become too flaky
> to changes in how we choose commits for the bitmaps? Does that
> require callers to be too aware of the refstate when creating the
> bitmaps?
>
> Perhaps just `git rev-list --use-bitmap-index [--objects] HEAD`
> would suffice to generate the trace event?

It's necessary for the group of tests which exercise partial bitmap
coverage (see the "setup partial bitmaps" test and below for more). In
those tests, we don't have bitmap coverage of HEAD, only HEAD~, so we
need to be able to say things like:

    test_rev_exists HEAD~

since just asking for the tip isn't guaranteed to work always.

We could make the argument optional (i.e., `git rev-list --test-bitmap
"${1:-HEAD}"`), but I generally find that it makes the callers more
difficult to read rather than easier.

On the "--test-bitmap" vs "--objects" thing, I don't think it matters
either way. They are both doing basically the same traversal, but
"--test-bitmap" does some additional integrity checks on top.

> >  test_expect_success 'create single-pack midx with bitmaps' '
> >  	git repack -ad &&
> >  	git multi-pack-index write --bitmap &&
> >  	test_path_is_file $midx &&
> > -	test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&
> > -	test_path_is_file $midx-$(midx_checksum $objdir).rev
> > +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
> >  '
> >
> > +test_rev_exists HEAD
> > +
>
> Perhaps this helper would be more appropriate as a helper method
> within a test, rather than creating a test of its own? I think
> it looks better to include it next to the setup lines, something
> like

Eh, sure. I won't plan on picking this up, but I'm happy to if you feel
strongly about it.

Thanks,
Taylor
