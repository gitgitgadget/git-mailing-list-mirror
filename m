Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72485C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDKVdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKVdU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:33:20 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F03510E7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:33:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id q5so12577714ybk.7
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681248799; x=1683840799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZfYgeF8XEguIK8z1fSR0n9l2est79IJiA1ImdDSBIE=;
        b=uBhBO8BcwQAPCOe85vcBG9jbjnXED4DDy047LzblV+xZH5fRe7yCKroBMgyDat8i+i
         PpIuGTAcEaxa7YLE+AYTyDshbxTgRWplo2Pu1fg3/Dl+rxA0x3iO2dI+utJz8R5WW7N7
         KscUbpYYMrzl2MoGslou5Ut1JqGBhejHjnD0PVgiN2HUVAazAr6wyE67GL9he6O49qYF
         5g0GBdENp2uxRISiaRypmldo7ckvTMhXGEgSl5hhlmrUR78GgerT3XwZhHLQKxDxwxuT
         ufrywX5CJ0lcpWDXTp1GoGFCFv/fb4RXsVGTVDOKos7C3nFfII/dd9K06tYa1LHiImBm
         p8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681248799; x=1683840799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZfYgeF8XEguIK8z1fSR0n9l2est79IJiA1ImdDSBIE=;
        b=kfZGRyGieLPySXn4+XDnpgwWbjhgN0zWyt609Cb3LLFyBlpSDsZFJ53PSFXPJtA7B5
         ddI/5PPv7Be1de6/wXXVtA8RXZDLN5zsbGLyE98GLo+T2+u/LBhjyBKrYs0eHnHYjB4Q
         h7QaNuY1KtLMvQnOJnEDmd5kffoc4Ki2/9mV7CjuiZMej1E5qO87Qfr4olng5owwwG5J
         XAepMfNlYbSsNgk34/wKBfi1RzMCcVyaCV4lVCzMS/u9Hs24Hg/A6JbESmytuVl8wgjS
         MgtM/S+ZFIOGk1e8vseHFnHzYC7d43v3HzzE9Ms9ybYHHQVYv2gYcEKIWQKZ7rf9/Ajl
         B/Mw==
X-Gm-Message-State: AAQBX9emkByEfi8FlpU5rY4+bKbcrn09hJ82plHPX1wixs9WiGAc1g/5
        WKBZ1NmLzhtltF+7JDgfF/VsXv3HRHUr2fA6WZbXKQ==
X-Google-Smtp-Source: AKy350bfBU3xxL/obSX4sRU8F6zzBsad2vp7cNBRydhWIMXoPdwMxsZJGvQ8nNf+UoYr70YMuuPb7A==
X-Received: by 2002:a25:c051:0:b0:b77:678b:ca53 with SMTP id c78-20020a25c051000000b00b77678bca53mr2506040ybf.64.1681248799242;
        Tue, 11 Apr 2023 14:33:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w124-20020a25c782000000b00b8eeb4dc37fsm1803871ybe.9.2023.04.11.14.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 14:33:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:33:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] t: invert `GIT_TEST_WRITE_REV_INDEX`
Message-ID: <ZDXSHal5IBynUTMX@nand.local>
References: <cover.1681166596.git.me@ttaylorr.com>
 <9c80379958824ac8fb7834f4f98000d11c3dc4e0.1681166596.git.me@ttaylorr.com>
 <18a54c6e-7357-42ca-779f-2ba3e6653880@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18a54c6e-7357-42ca-779f-2ba3e6653880@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 09:51:06AM -0400, Derrick Stolee wrote:
> On 4/10/2023 6:53 PM, Taylor Blau wrote:
> > Instead of getting rid of the option, invert its meaning to instead
> > disable writing ".rev" files, thereby running the test suite in a mode
> > where the reverse index is generated from scratch.
> >
> > This ensures that we are still running and exercising Git's behavior
> > when forced to generate reverse indexes from scratch.
>
> I don't think this is true because you remove the environment
> variable from the following test.

This is intentional; I wrote that last sentence ("This ensures...") with
an implied "[When set], this ensures..." at the beginning of it. IOW, if
you wanted to run the test suite with primarily in-memory reverse
indexes, you still could.

> Replacing the line with GIT_TEST_NO_WRITE_REV_INDEX=1 would keep us
> testing the from-scratch case as a side-effect in other tests.
>
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index b098e10f52..e9fbfb6345 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -27,7 +27,6 @@ linux-TEST-vars)
> >  	export GIT_TEST_MULTI_PACK_INDEX=1
> >  	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
> >  	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
> > -	export GIT_TEST_WRITE_REV_INDEX=1
> >  	export GIT_TEST_CHECKOUT_WORKERS=2
> >  	;;

I wasn't quite sure what to do here. On one hand, sticking
GIT_TEST_NO_WRITE_REV_INDEX=1 here would ensure that the linux-TEST-vars
test is still exercising the old code.

Is that desirable? I dunno. On one hand it increases our coverage, but
on the other hand I've always treated this suite as for experimental
features, not older ones.

But I think all things being equal, I'd rather have more CI coverage
than not, so I'll add it back in. Thanks for a sanity check on this one.

Thanks,
Taylor
