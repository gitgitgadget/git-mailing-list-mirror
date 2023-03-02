Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DCCC678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 07:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCBHRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 02:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCBHRO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 02:17:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FCE3B648
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 23:17:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x34so15980236pjj.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1677741432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQhBPOaUFNA5D0HDlis871DL5+SHdOw9iDDiW+MI18w=;
        b=Md9v2MS6bW5zxDnci9Jtp0RKoTqYIlEjmXtduBaeECLLrGeeOHZnazreYAkVApGZLq
         Mto+azBNHrePL2FyKrfZNdjw6Ti7J+2IYW5s9t+MA0HpmRHhABClrXMR50Rj4cns2AdU
         ZpPS3DdO6HMk0Oup8WFGHL7LCTh9g+3e/5zuplGF7BIBFy8JJgVcNJt0Lde+smEYVnDa
         uLv2cWjAst21k/QmML9QAjs/qIYR5LumAyoFqkFtJ9AQRv1CZPk5CiGE5XCMfiPckYa8
         DSaqW70n/95tOAj/aZcPSEefw7IugTY15JcLoA/GQecYGB96koY1hvey/Pjf1UxXvG2z
         Zuxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677741432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQhBPOaUFNA5D0HDlis871DL5+SHdOw9iDDiW+MI18w=;
        b=WPpe51Foht4OgUtvdxhFDJs9/9sgXyk8zDy/5zjQDfwFNiLyxmI5zxKq/k2J5u7Q/f
         bI8RXxlEWzuYKS35j5FWHJLNAqCDb2cS9bJ5wXfkgBDLCzrx00LJvlhZ6gwnKZTREggh
         eRqdcSASD5k25/91oNsIs3GcJYHUdPUop2p8f5IAutE1zo95PGB2gGZVbeEeo2FDRI9X
         pEt1/WowX/TWEbc6c7N/aHlbSvjA87yXrcqedDe2zWEd4qHWnVGPblTCXP23E7nCMBuy
         Lk5T2Q//fY6bNukcbGE/ypUWbvkvyLTYcPoQM+V6ctaJ45U1+88ovQKiMAAohqoHoEFa
         RLLg==
X-Gm-Message-State: AO0yUKVvhouS5fZKW8O326YLwDPrMo2eAaePsY7DNsWMweNKKJoZQY4j
        ycsVhztXvL1eda7GKW0u6VbudgMiZp2EOIZ+Z3c=
X-Google-Smtp-Source: AK7set98o8B+0NJYfZL0PDX34Wc8anlfekLI6SeauH/iDtxFkgfNwJFcC13wNGxVueMfE1BnT/UXRg==
X-Received: by 2002:a05:6a20:2d8a:b0:cd:5334:e249 with SMTP id bf10-20020a056a202d8a00b000cd5334e249mr10305760pzb.18.1677741432501;
        Wed, 01 Mar 2023 23:17:12 -0800 (PST)
Received: from F407C5W6RY.office.atlassian.com ([123.103.201.174])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b005dc70330d9bsm9013845pff.26.2023.03.01.23.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 23:17:11 -0800 (PST)
Date:   Thu, 2 Mar 2023 18:17:05 +1100
From:   Ben Humphreys <behumphreys@atlassian.com>
To:     Junio C Hamano <gitster@pobox.com>, newren@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/7] merge: ensure we can actually restore pre-merge
 state
Message-ID: <ZABNceY3cSWNb75u@F407C5W6RY.office.atlassian.com>
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
 <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
 <887967c1f3fd6f03cf1d0bb3c19ed16819541092.1658391391.git.gitgitgadget@gmail.com>
 <xmqq35eul95b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq35eul95b.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio / Elijah,

On Thu, Jul 21, 2022 at 09:31:44AM -0700, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/builtin/merge.c b/builtin/merge.c
> > index f807bf335bd..11bb4bab0a1 100644
> > --- a/builtin/merge.c
> > +++ b/builtin/merge.c
> > @@ -1686,12 +1686,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
> >  	 * tree in the index -- this means that the index must be in
> >  	 * sync with the head commit.  The strategies are responsible
> >  	 * to ensure this.
> > +	 *
> > +	 * Stash away the local changes so that we can try more than one
> > +	 * and/or recover from merge strategies bailing while leaving the
> > +	 * index and working tree polluted.
> >  	 */
> 
> Makes sense.  We may want to special-case strategies that are known
> not to have the buggy "leave contaminated tree when bailing out"
> behaviour to avoid waste.  I expect that more than 99.99% of the
> time people are feeding a single other commit to ort or recursive,
> and if these are known to be safe, a lot will be saved by not saving
> "just in case".  But that can be left for later, after the series
> solidifies.

This may stretch your memory a bit since the above was many months ago,
but I'm wondering if you know of any effort since to build the above
described optimisations?

We've seen when Git 2.38.0 (which introduced this change) is used with
Bitbucket Server it results in a severe performance regression due to an
sharp increase in disk and CPU load. Our code that tests the mergeability
of a pull request is one such affected codepath.

If there isn't any existing efforts to build the optimisations you
mention above I will have a shot at it.

> > -	if (use_strategies_nr == 1 ||
> > -	    /*
> > -	     * Stash away the local changes so that we can try more than one.
> > -	     */
> > -	    save_state(&stash))
> > +	if (save_state(&stash))
> >  		oidclr(&stash);
> >  
> >  	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {

Best Regards,
Ben Humphreys
