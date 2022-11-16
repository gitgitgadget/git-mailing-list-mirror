Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3002C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 20:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiKPUOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 15:14:14 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D8317E5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:14:13 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s10so14113032ioa.5
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 12:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMeXsBMGFDmcDzg6wwYNy29FN190d2rKwtPhDtvPNf4=;
        b=k35OtmLQQ4fmEv5aUoxFiKyVvDJMolPa3dmceYHUfUhFU+9/RdP0D2VcuJLhDRqNBm
         8MFEryO8+3v5Dc9zP7rOtS+OB/BIGGodL1iZY+B+SjDvXgQ4C9daIqCrq+dqcF2/w7jb
         DxWhYlwLxyZblcK3w9SW5EJklGWJMCw98S8y8UbkjY5Fmo/rDU6bACaAPsd5xcDPkDRK
         7jAN8DSzH73KZBNBLiy7Z8TfUzTYAYDmTVfqyCg2L0HEY2k2a0Yqs31RZam4u3fhZ8qs
         7DnUltmaGGaoMudJhoWG75ZCgAxcp3IQgSbZeg+NrkzteWm4FgX35ct4PYaSUw5PeXsu
         j+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMeXsBMGFDmcDzg6wwYNy29FN190d2rKwtPhDtvPNf4=;
        b=BzOyz3VL6od1pfsB/BQwhsNhLyaKpddtycx7UE7Bz7IdKwYHEUNJtti9tXKpi3aBI2
         5gyrhsa5byxqTt2+0jEJ5QHys5UkFauF1bVcgXgHyzk948dqb2zMwr20XlM2ZFqvQa9V
         qZzcUE4ji2X/yldyxipg4cp+ChmIK8KP5B/SjIJTwYdFcnRe0LeyGxYAOph7HFQ6tUVj
         J0C0lDcGaEwnZfOOhPhF/MTW4SVHD4rzo/QdskUQ0Ro30VA93MHvpQTRs6ittppg16Y6
         qHteWDsjWHElLzFSmy1in0OYOUhqqOH5TmGlIRRbBBO4h3+NhSjJY6l15oXtRMtqSHyb
         oI3w==
X-Gm-Message-State: ANoB5pmf6pl5EMfQc6tLJFnzadorDa9iUCLOqPQ/3/CyK3/xooM0Ujur
        8ksVxDNKpjdHXZlDZipveTGFJw==
X-Google-Smtp-Source: AA0mqf7O7iywRmmjQ/irgssSlsFNpypEw6vKLvWySgnJUJ72xhPFrqG0R9+slRv4TGX9Yrkogt4dfQ==
X-Received: by 2002:a02:3f55:0:b0:34a:9a94:f106 with SMTP id c21-20020a023f55000000b0034a9a94f106mr11556996jaf.141.1668629653147;
        Wed, 16 Nov 2022 12:14:13 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v21-20020a02cbb5000000b003495b85a3b9sm6050017jap.178.2022.11.16.12.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:14:12 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:14:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
Message-ID: <Y3VEk5VbAow0bqpS@nand.local>
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
 <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com>
 <Y3Puhtj8Q8kf2wt0@nand.local>
 <2ce55cf7-5eef-8e6d-7b91-9a4bc16ed1c4@github.com>
 <221116.865yffj5ha.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221116.865yffj5ha.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 04:14:30PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> Copying from other zero-initializations of `struct config_set`:
> >>
> >>     $ git grep -oh 'struct config_set.*= {.*' | sort | uniq -c
> >>           3 struct config_set cs = { { 0 } };
> >
> > Yes, without the double braces the compiler will complain on
> > macOS, I believe.
>
> Ah, that was sorted in 54795d37d9e (config.mak.dev: disable suggest
> braces error on old clang versions, 2022-10-10).
>
> It's fine here, we can follow-up for the #leftoverbits of changing those
> some other time.

Thanks for the reference to 54795d37d9e, Ævar.

There are a small handful of these sitting around in our codebase:

    $ git grep '{ { '
    builtin/gc.c:   struct config_set cs = { { 0 } };
    builtin/worktree.c:             struct config_set cs = { { 0 } };
    oidmap.h:#define OIDMAP_INIT { { NULL } }
    oidset.h:#define OIDSET_INIT { { 0 } }
    reftable/stack_test.c:  struct reftable_ref_record refs[2] = { { NULL } };
    reftable/stack_test.c:  struct reftable_log_record logs[2] = { { NULL } };
    reftable/stack_test.c:  struct reftable_ref_record refs[2] = { { NULL } };
    reftable/stack_test.c:  struct reftable_log_record logs[2] = { { NULL } };
    reftable/stack_test.c:  struct reftable_log_record logs[20] = { { NULL } };
    reset.c:        struct tree_desc desc[2] = { { NULL }, { NULL } };
    t/helper/test-ref-store.c:static struct flag_definition empty_flags[] = { { NULL, 0 } };
    worktree.c:     struct config_set cs = { { 0 } };

But I tend to agree that I'm not all that eager to go and change these
for the sake of changing them. I think we can slowly let them age out of
the codebase when we're touching nearby areas in the future.

Thanks,
Taylor
