Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B0ECAA2B
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 19:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiHYToY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHYToX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 15:44:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB875BFC4F
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 12:44:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z2so27450843edc.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=NPEZuTe7tkFlahXoIeyxO6wPhXCg7GZ4dT62wo1+/Lk=;
        b=cPJ6q3H0pzGTa+KhnwANe9wvZJ9gi0Gr1xXiNhOvtRuY29Ck2lnKUSzEy0Zini7mis
         0g7J1MN3PAEf6IGjh7PwXZt0Ptm+sKSkS+XdvR4X/mYg628xooeJvPZTmNArCCmK/CeE
         WGTHLZN4onZg4r57ge3aSwWIxeHm8Lu4z4L4BDEdM8ldgaeEfmcoHKKFAx94ihMEGRYN
         73v2dctUW2z2pcob+dSKoheo+8+7y/v9toKNvdqJ5xZ2Ejiz3fo3lhrV1CwsDRqHEyWn
         FRJFzPMz4Z0tkmxizMqdxCav0hOHyyZiETH8qcV7DMP77TQSkUL3PWFt4mp/JoM/+lZu
         ppZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=NPEZuTe7tkFlahXoIeyxO6wPhXCg7GZ4dT62wo1+/Lk=;
        b=AziFmJ60Y3iANtCl+Zy6xnGkv+4JernFFEJ8rqnBcLYc2w2tE8YQXQXw4P+6W5Nvuu
         vRQC2wrF1jd/iEGpWoAWhMAzCiHd/XQEb5ZuEAlbC1JwBJ34ieMokshaUv8UPtE6yWvI
         e4u7K7d9U0V1Ctif9k6FFqIELDcxnDggKvpzI0ypGRqFwe2wmb2/cXuovTY82sYBSRQk
         DOuRWheUQwOD/Tveity3x6J+yUOe2SpzWlDJJLaBgGH3zPFF/WHSngATuJm7RQM95YuB
         /MJRQ+dZITQqhaQoUmmyOu5fNstvyB8jvtsrgRlJEtU9Q0jIMpY+KgO644bILG28GPPf
         fkyw==
X-Gm-Message-State: ACgBeo1arn8h8V4vW6DYE0yDinTo0A9gOBnTGXNJmM3ZXQ5uFVsXEfrS
        jE9tmePNXh3J2sIw1jLvJCA=
X-Google-Smtp-Source: AA6agR60rztuPq0RzKtOnV0DeH6LMrPgisi5B43Utt19QMzgcewRwGL7+uOXb6xpXsfDqFKWtJ3Huw==
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id q13-20020a056402248d00b00437dd4ce70emr4284764eda.75.1661456660323;
        Thu, 25 Aug 2022 12:44:20 -0700 (PDT)
Received: from localhost (78-131-17-114.pool.digikabel.hu. [78.131.17.114])
        by smtp.gmail.com with ESMTPSA id d25-20020a056402079900b00447e2aeeba2sm119356edy.27.2022.08.25.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 12:44:19 -0700 (PDT)
Date:   Thu, 25 Aug 2022 21:44:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] cocci: make "coccicheck" rule incremental
Message-ID: <20220825194418.GI1735@szeder.dev>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com>
 <patch-3.5-6fa83695f1f-20220825T141212Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.5-6fa83695f1f-20220825T141212Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 04:36:15PM +0200, Ævar Arnfjörð Bjarmason wrote:
> * Since we create a single "*.cocci.patch+" we don't know where to
>   pick up where we left off. Note that (per [1]) we've had a race
>   condition since 960154b9c17 (coccicheck: optionally batch spatch
>   invocations, 2019-05-06) which might result in us producing corrupt
>   patches to to the concurrent appending to "$@+" in the pre-image.
> 
>   That bug is now fixed.

There is no bug, because there is no concurrent appending to "$@+".
The message you mention seems to be irrelevant, as it talks about
'xargs -P', but the invocation in '%.cocci.patch' targets never used
'-P'.


> Which is why we'll not depend on $(FOUND_H_SOURCES) but the *.o file
> corresponding to the *.c file, if it exists already. This means that
> we can do:
> 
>     make all
>     make coccicheck
>     make -W column.h coccicheck
> 
> By depending on the *.o we piggy-back on
> COMPUTE_HEADER_DEPENDENCIES. See c234e8a0ecf (Makefile: make the
> "sparse" target non-.PHONY, 2021-09-23) for prior art of doing that
> for the *.sp files. E.g.:
> 
>     make contrib/coccinelle/free.cocci.patch
>     make -W column.h contrib/coccinelle/free.cocci.patch
> 
> Will take around 15 seconds for the second command on my 8 core box if
> I didn't run "make" beforehand to create the *.o files. But around 2
> seconds if I did and we have those "*.o" files.
> 
> Notes about the approach of piggy-backing on *.o for dependencies:
> 
> * It *is* a trade-off since we'll pay the extra cost of running the C
>   compiler, but we're probably doing that anyway.

This assumption doesn't hold, and I very much dislike the idea of
depending on *.o files:

  - Our static-analysis CI job doesn't build Git, now it will have to.

  - I don't have Coccinelle installed, because my distro doesn't ship
    it, and though the previous release did ship it, it was outdated.
    Instead I use Coccinelle's most recent version from a container
    which doesn't contain any build tools apart from 'make' for 'make
    coccicheck'.

    With this patch series I can't use this containerized Coccinelle
    at all, because even though I've already built git on the host,
    the dependency on *.o files triggers a BUILD-OPTIONS check during
    'make coccicheck', and due to the missing 'curl-config' the build
    options do differ, triggering a rebuild, which in the absence of a
    compiler fails.

    And then the next 'make' on the host will have to rebuild
    everything again...


>  * We can take better advantage of parallelism, while making sure that
>    we don't racily append to the contrib/coccinelle/swap.cocci.patch
>    file from multiple workers.
> 
>    Before this change running "make coccicheck" would by default end
>    up pegging just one CPU at the very end for a while, usually as
>    we'd finish whichever *.cocci rule was the most expensive.
> 
>    This could be mitigated by combining "make -jN" with
>    SPATCH_BATCH_SIZE, see 960154b9c17 (coccicheck: optionally batch
>    spatch invocations, 2019-05-06). But doing so required careful
>    juggling, as e.g. setting both to 4 would yield 16 workers.

No, setting both to 4 does yield 4 workers.

SPATCH_BATCH_SIZE has nothing to do with parallelism; it is merely the
number of C source files that we pass to a single 'spatch' invocation,
but for any given semantic patch it's still a sequential loop.

