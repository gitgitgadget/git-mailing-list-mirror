Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCAAEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjF0XTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 19:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0XTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 19:19:07 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29B1BD3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 16:19:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-401d1d967beso126051cf.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687907945; x=1690499945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc7EY/zacrvVUubmEL91rvFQrMaLzfbUfVo4blPhIUI=;
        b=Fh5Q/xhqd+zcH5h6lJz5gAEnp5cmsFcAE74000Zeqmeh3t+fEcnExo80230UH5y3So
         FQHBYFY8lKc3t3yvA+8THeMdrG5WgS3kUn872L5cw+KUOQThvtXVjRQh0tSnihBPsZbN
         RzKPXSWmcKwcqpktRjlwq+tifaiVD/0puL/9gXZlqHnnrJKdwi+Q+EpkkVm8+bdkwSJq
         mlSJwz2Zzz5zGJkHeKTTiE49dLP1sOINSwsKK1nwjzWBPAtFUNW94XGMEQEZN4PS0dfy
         QGgejWeA2GiIQ/LJEMyQ9OtuNmDaJ20mvxduy3FQU+03+EtROeyNV0nQSCgu8Sq5p72O
         srGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687907945; x=1690499945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc7EY/zacrvVUubmEL91rvFQrMaLzfbUfVo4blPhIUI=;
        b=Rbgb0nQ0JR94LoHQcAyrH1Rl0nf/3ZkQUlFMJRVfh7FTqxJIJxEK68Zhl97haOhsGc
         If1vUX5ggd/yBCoUfUCBBjubYsZkc1CLV+sdtBvd138CrXpFzpxHiCPTdsTiZv8NPU6n
         0SVHp4ciGfQ5N1my7pl5P1C5LMRSOpsvfaxc+/4p28HIdaI/oZlijd+Oh7Oy9kAqGUE3
         8tNwb9q+X1chA9Zul7x6BshFtwM3CRtkm+B+DI436t1VEHmgr3HI/8tWAsPAwb5JP1To
         uQWMyJMqhxFnSwKsN220X1sDYxAjgdLQI8YJ+VO5jdIaX8bO7eHSlMyBDVTyTX7Zh7S3
         zN4g==
X-Gm-Message-State: AC+VfDxP+aHNGd8T+GlNxjdd7TKEk4pzMuoOMfyBs2zuiS1SYUMvFvk4
        a5IalyZzZ+Hu7H+7Mrq7NMZin1G+IxDpRoLbngukNw==
X-Google-Smtp-Source: ACHHUZ54q15jaSSia3kayb8GlInfhbmqIgZCd5g4D0G63NNr3fMmazPPtuQw9JwOiEvfuRf0j3cEtix+zPwZrPGs7II=
X-Received: by 2002:ac8:5843:0:b0:3f9:a986:f3a4 with SMTP id
 h3-20020ac85843000000b003f9a986f3a4mr22929qth.25.1687907945183; Tue, 27 Jun
 2023 16:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
 <20230627195251.1973421-7-calvinwan@google.com> <xmqq1qhwfr46.fsf@gitster.g>
In-Reply-To: <xmqq1qhwfr46.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 27 Jun 2023 16:18:54 -0700
Message-ID: <CAFySSZCpEy1ZF5b9kjbxfh7ANiYbVO7W1t=oazAJzGtOZofyew@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> With so many (read: more than 3) callsites, I am not sure if this is
> an improvement.  pager_in_use() cannot be misspelt without getting
> noticed by compilers, but git_env_bool("GIT_PAGOR_IN_USE", 0) will
> go silently unnoticed.  Is there no other way to lose the dependency
> you do not like?

I thought about only changing this call site, but that creates an
inconsistency that shouldn't exist. The other way is to move this
function into a different file, but it is also unclear to me which
file that would be. It would be awkward in parse.c and if it was in
environment.c then we would have many more inherited dependencies from
that. I agree that the value of this patch is dubious in and of
itself, which is why it's coupled together with this series rather
than in a separate standalone cleanup series.
