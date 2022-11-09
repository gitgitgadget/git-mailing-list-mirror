Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC234C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKIWrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIWrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:47:47 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B9ABF5
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:47:46 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r81so20970iod.2
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0fC/onEFOvZ3CA2WJNYqkgCju7cpsOFbA4FtFstRC0=;
        b=I9zZiZj0bqEHQqp/jDJ9xRvwYLoTcamRmO4dXLiArAvaXArIzom4p23aOUvNvHs5BO
         U0AiOnMRlL0ovJfC3bn3AKphWSK/g7EwDA9vDKHL6J6Tz9X0fIoJjI07fhbbWNi/kKxU
         8Ko/99ueWfzO4oVPihgOOV8NGmxbBslCIiynFouPfuy6vlT1zzwjHZz40jic9AqDGS39
         2EPmwNLFuZqGDElgnY8cgJqko3A67WDz7RLVtpwbfkAhxA9iwrJQ1jYd6F0DI//cpf45
         bvh3edidO9Dd3g+ENob8gaGOnzYAxPBUXq74U6I1/giBG/Y2jdNBrF/7YNIXF0n/3jim
         s5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0fC/onEFOvZ3CA2WJNYqkgCju7cpsOFbA4FtFstRC0=;
        b=jHma+yxGMhvs+XqFdfoD8N+I2ZNJLTv+fUKyldbpK86zKp78eDzRA3j8rCDiUwzUpz
         3LnfRKF20abc8zvfpcN3qViQmR6GS0s3YzpxIgfLcZgG7mtBBOFK2JGwdB+RLTbvnnP4
         jYY5/EI/WqhOyKJwMPdQyk1U8swYdZflkay2nBSjDheuek9pnk2xDOQWgSbUSVLvhEUo
         cgpqXd1H+0CwiScQXtEMrkshnDJanyt8RNCG0wlk55V/xQ/lLq8RikdBikxfK0DYJCMR
         xlkymLyZkbEkGVb3qANCh/D+SYjLPS8n6yaAfh4E7GRh+/rLHnSIIeHa/lLZTIND941n
         PyPQ==
X-Gm-Message-State: ACrzQf3R2yNr7ZXq4p11YWbRFWVtiTJVJsj90BKcQdePP8MVhWf9gk9K
        efBGnHfAaGEoch7OOXL9yGMEIZfa7yqWhA==
X-Google-Smtp-Source: AMsMyM5mUJ+F7kkBqFHZPmhYsT1ovLaPPEpFDtlZ/grvpFLVZSLCTBv+zU16AquNTIf4ccSw0nREng==
X-Received: by 2002:a05:6638:15c3:b0:375:5b8d:e565 with SMTP id i3-20020a05663815c300b003755b8de565mr2356494jat.121.1668034065672;
        Wed, 09 Nov 2022 14:47:45 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i9-20020a92c949000000b002fc681a6ad8sm5286573ilq.78.2022.11.09.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:47:45 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:47:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] t7610: fix flaky timeout issue, don't clone from
 example.com
Message-ID: <Y2wuEDGMRg99Ifef@nand.local>
References: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-83eca7b5a7c-20221105T115420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 05, 2022 at 12:54:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> The behavior of "-N" here might be surprising to some, since it's
> explained as "[if you use -N we] don’t fetch new objects from the
> remote site". But (perhaps counter-intuitively) it's only talking
> about if it needs to do so via "git fetch". In this case we'll end up
> spawning a "git clone", as we have no submodule set up.

Makes sense, though I'm not sure I agree this is worth patching as I
currently understand it.

If I run t7610 today with '--run=2-' (IOW, skipping the setup test), I
am definitely going to get failures. And I don't think we should have
every subsequent test depend on having run anything containing "setup"
before it. That is, it is not surprising that we will see some test
failures when carving up and running portions of the test instead of the
whole file.

I don't think this is substantively any different than that. Whether we
don't complete the "setup" test because we had some leak (and ran the
test suite with the appropriate LSan options), or because we neglected
to run it at all, I don't think there is a significant difference.

Either way, the end-state of the test repository isn't guaranteed to
match the intent of the "setup" test.

If this is the only such problem in-tree, sure, I think it's fine to
patch. But I would wager that there are *many* more than just this one
lurking, and patching all of them would be less straightforward than
this one.

So... I don't know. I'm certainly leaning negative on this patch, but if
you have some compelling reason that I'm missing, I'm all-ears.

Thanks,
Taylor
