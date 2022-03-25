Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5118FC433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiCYRnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiCYRnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:43:09 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CE213F8F4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:41:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 125so9697147iov.10
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rHc1/z3z8kE3HgLlChUzizuLqxvmEydhGb7J/bNn1TA=;
        b=RzoIK0rRshPR7+X3a5iMtt/j6D6PNfzQCME4Oh5RPtEojtK2g7oO+HxWyUohtAqPRO
         qgcUSNxtdrO1E70RNMnVP2Pko8FLl4Gb7teIO/03jYO81sYscr3efir3Jqij2/bdJGrE
         lj1W4XjtxsRuzIGJqblwDt//ZqKvPGtKvJV+hWboQLWlnHzVji3lnRTRB+qFjKr2wqv/
         m7Mz7dtrvM6u16Y18OxaiT8XlkjaIDD8E1o67N9mLbpH0eJnnHI+ENxFfsiFEsUiaLpu
         yxGhSk0f2rNO6HlbA86TsyS9i+ZbvqUc0Q6/xwkxrDWn99kY6Gote/6PltsC7d8puQaw
         BSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rHc1/z3z8kE3HgLlChUzizuLqxvmEydhGb7J/bNn1TA=;
        b=EBW1gUhJSJSGtXam+wDPyUN90ZDuCooHnGyYGNVfnvhCMzo7kX3fnPlnSjULRps8jq
         qKaMUbKg+sowPdIXrE6a76je4v+RGKeg8xHUGMffAVXn1EMYOQpCUq6TC9Hab2wGiYza
         SbNrVE7mP+Evvzil2U5bavLCGwie+Y+u+tIgPuLoBuYk2jbgB1rO0zeVmvomaWwF95Y1
         e5NoypL1FghbUyy/aaMSDx/ZKfljhfkx2/A+kNFeqNbdrBdvbEs4lVI/gfk5C2SgvtsS
         14DALU5L4+9t9aO/Td3bcKcHKU/HpfTCcR1QHvziwWNoOizOkR3zt/I5LcrFmp01b3QD
         e9Eg==
X-Gm-Message-State: AOAM532K17qhb2kj6LIQ4q5v5AFJVZKNBDZ5G+wik0E2yBurt1kydLZO
        ErNrMg1zh8e5M38FDdLa5W3pqg==
X-Google-Smtp-Source: ABdhPJzUpdI/dn4RBSwuWhQBl4YchdPiJZyDiAdpm4qQfZXAC1PFOsNLeLZBY5cMSEemhaSJPZVz3Q==
X-Received: by 2002:a02:cadb:0:b0:317:b785:8ab2 with SMTP id f27-20020a02cadb000000b00317b7858ab2mr6747423jap.108.1648229781507;
        Fri, 25 Mar 2022 10:36:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m8-20020a92d708000000b002c6381d9144sm3179842iln.59.2022.03.25.10.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:36:21 -0700 (PDT)
Date:   Fri, 25 Mar 2022 13:36:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH v2 1/2] t7700: check post-condition in kept-pack test
Message-ID: <Yj39lEzd/9AwQJaP@nand.local>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
 <f2f8d12929bcbd630b2de3ce770a6763989ffcff.1648146897.git.gitgitgadget@gmail.com>
 <xmqqmthearlz.fsf@gitster.g>
 <3fab1246-1451-597c-4359-c01f9675e3f1@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fab1246-1451-597c-4359-c01f9675e3f1@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 25, 2022 at 01:23:27PM -0400, Derrick Stolee wrote:
> > Since we've made sure "before" is a one-liner earlier, we could just
> > say
>
> > 		test_cmp before kept &&
> >
> > instead, no?
>
> 'before' contains a .idx name and 'kept' contains a .keep name,
> so this direct comparison does not work. We could do that
> additional check like this:
>
> 	kept_name=$(cat kept) &&
> 	echo ${kept_name%.keep}.idx >kept-idx &&
> 	test_cmp before kept-idx &&

I think keeping this kind of post-condition check pretty minimal is
favorable, since this is functionality of `git repack` (i.e., that `-a`
leaves you with one kept) that is already tested thoroughly elsewhere.

So I'd probably avoid checking the output altogether, but if we did want
to test it, I think something as quick and cheap as:

    test_line_count = 1 before

would do the trick.

Thanks,
Taylor
