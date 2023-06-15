Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87843EB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjFOWuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFOWuX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 18:50:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1518626A9
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 15:50:23 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6667defb5a3so222515b3a.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 15:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686869422; x=1689461422;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDmjeY9SfuuvU26U+2ykfZdL1y+3bJ9poIA6bRkVO00=;
        b=oaAzT7jik/591kR+OFD7ZKODq/s8fd4DeZ9Ic0i1NTdQY3Tqt4scggNr9++gx/Q3px
         gnpxBiC1WzXn3LWvUzxOWY5O4Ci75s04lu7BGQXPg2KtjR/Vi5Jfo1Gz2AruNNRW5+m2
         p9NZPfAhUPQCugTYC/vdsATuzjaiIsvus8aOcwek/+f7As4PFHA4j6DbM3+1caNRjCMG
         xhHgidlrWRML/SsgAKcXw0GXKkh6uZVhPSgA5tlptjhTrQkakwcWfl4QB3qBJn4W1kim
         RQJClaGPUg7uHBbBGVjmrzSzNE7kp1f7FCnTxFaxagE4WIf3210UqXAK94yk6Pr8dKKa
         a/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686869422; x=1689461422;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDmjeY9SfuuvU26U+2ykfZdL1y+3bJ9poIA6bRkVO00=;
        b=SYNRkNps6olfbDE/AkfblcllyDSd9DFFSvxUZL90j2E+GV7JLFk7nCo5zclesN8FcV
         gT48oOovRK4kIBsnbWUvEIJveDtv9KF10DVrNwvAL/hn0PdKcETihMKVaCoYARLsCKIh
         IPXZIeamRwMMPfGaHQ8UQWtRRsq/UySS1+FTa2rpPCtAcsbZsDrRa5saYwN4lJRmTBxL
         OVPtzY97vzpaXxxUd3waeCIZ3OOo/MGOKma/aK3k1r0Bh2uobcC5PukPJCloobifoxiM
         QZQbodagCZyLVf0t+mqybyR4t4mTfPSnO2lWGXvZ6w8LASvGB2ZYtPEMREeA39O0pOgm
         hMRA==
X-Gm-Message-State: AC+VfDyTGeZqjt8bXZtpqNeboClioRw6faRZXmqzpXiDOzTniOvef6uf
        0/Dqm+T6yYoC4JrXCUZDcy4=
X-Google-Smtp-Source: ACHHUZ6eccVF5aZuiWf5OwRWkJbqpeak7Dr8G1bK7KQxk00uEKwHTgmr2gvop6kbY0wY1SYaTQx26A==
X-Received: by 2002:a05:6a20:3ca0:b0:10f:708b:bb28 with SMTP id b32-20020a056a203ca000b0010f708bbb28mr1000144pzj.7.1686869422386;
        Thu, 15 Jun 2023 15:50:22 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id i25-20020aa787d9000000b0064f51ee5b90sm2212054pfo.62.2023.06.15.15.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 15:50:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/9] pack-objects: add `--print-filtered` to print
 omitted objects
References: <20230614192541.1599256-1-christian.couder@gmail.com>
        <20230614192541.1599256-3-christian.couder@gmail.com>
Date:   Thu, 15 Jun 2023 15:50:17 -0700
In-Reply-To: <20230614192541.1599256-3-christian.couder@gmail.com> (Christian
        Couder's message of "Wed, 14 Jun 2023 21:25:34 +0200")
Message-ID: <xmqq7cs4uyqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> When using the `--filter=<filter-spec>` option, `git pack-objects` will
> omit some objects from the resulting packfile(s) it produces. It could
> be useful to know about these omitted objects though.
>
> For example, we might want to write these objects into a separate
> packfile by piping them into another `git pack-object` process.
> Or we might want to check if these objects are available from a
> promisor remote.
>
> Anyway, this patch implements a simple way to let us know about these
> objects by simply printing their oid, one per line, on stdout when the
> new `--print-filtered` flag is passed.

Makes sense.  It is a bit sad that we have to accumulate everything
until the end at which time we have to dump the accumulated in bulk,
but that is a current limitation of list-objects-filter API and not
within the scope of this change.  We may in the longer term want to
see if we can make the collection of filtered-out objects streamable
by replacing the .omits object array with a callback function, or do
something along that line.
