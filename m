Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DBDC77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 20:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDNUgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDNUgI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 16:36:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1F6581
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:36:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id z11-20020a17090abd8b00b0024721c47ceaso5997257pjr.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681504567; x=1684096567;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veSZ6derWW49UI7VqDTcnEJPLAahKjTlkWffZUDDEn4=;
        b=M9z0RKJRjl6uBGlLBtIKC+HpyqfQmfLxd8NdZ+lbmaaLEVt5Er069coVHT3eEiWMhB
         T/NGIxGoGING3EbTiqno8Go/I1qdELi8r9QSiOOwOjTtmivCb3C3s+XtKAdDo9OvEheW
         wW984eEX5wXqZ2Koj3Mm72jmxDhzhrFUL129YEAG9/c8zU1uT+Qule0ODG6nOjQZv/tK
         Ua2p9scryNIeOEzN8KrCf7mVF5Z6YnkqHa6x9raNNsGRnumox9oESCwJ4bSu1fDEi9Cf
         PRbAyv0Q2DDCn6NbMFUCDT17kEMZuM1zsOvPkj6HzAaCAnUn6R80uHtT0h6BMiePPFbv
         ZX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681504567; x=1684096567;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=veSZ6derWW49UI7VqDTcnEJPLAahKjTlkWffZUDDEn4=;
        b=gz+FMonnz6CqCji1q1gNzcH/Js9mIEEmHQFxZqtAVDWcBSaBstoeviK8etH+E6ENod
         UAZ19s5zE7i/hsy8E4NzwQW0rihVldtLgJa//YNY/j4Q/xm/J9AkEskrG0rb3lijay+M
         gwzQnzTMk7XxUMFWmm7m1njvK5FrEf7qcy/gmYykwdUnbjFaeS7zrdDuGHiObjxxXS+R
         xc5MURix0uCa1O2ECeyVZr/Qb+vjAS8otKI5TskzO4eyLrDMPRDSwEqTEnNPZlwcwB4H
         dudFHOligEx55wc01I709diMkQ6Gtb2bVx7vN1Pq/7RiCfW6QzYuo2cEzu7IoS4vf5s8
         sBtQ==
X-Gm-Message-State: AAQBX9e2VXjittPAqWqaAaKbYJxXug0ukw9Zm4NO44VUdZyavgjZ6Z6l
        oefJOOnd5Fg6Vserk4cyelM=
X-Google-Smtp-Source: AKy350aOpv1zJtkDPdYA4MpNyxEEuQY1CqFEYAUyjFDAEBTaBWmT6K9ENOxOg53exCAWqpfW7bcsWQ==
X-Received: by 2002:a17:90b:3649:b0:247:4adc:ef4b with SMTP id nh9-20020a17090b364900b002474adcef4bmr2060252pjb.47.1681504567300;
        Fri, 14 Apr 2023 13:36:07 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b002470ce35621sm3179125pjs.20.2023.04.14.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 13:36:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/5] git-merge.txt: modernize word choice in "True
 merge" section
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
        <62b68829c5aeaa28a79192b55058e87a0ef72816.1681495119.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Apr 2023 13:36:06 -0700
In-Reply-To: <62b68829c5aeaa28a79192b55058e87a0ef72816.1681495119.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Fri, 14 Apr 2023
        17:58:36 +0000")
Message-ID: <xmqqr0smp5ft.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The "True merge" section of the 'git merge' documentation mentions that
> in case of conflicts, the conflicted working tree files contain "the
> result of the "merge" program". This probably refers to RCS' 'merge'
> program, which is mentioned further down under "How conflicts are
> presented".
>
> Since it is not clear at that point of the document which program is
> referred to, and since most modern readers probably do not relate to RCS
> anyway, let's just write "the merge operation" instead.

Good.

I suspect that the original refers literally to the RCS's merge
program.  Until caba139d (Use git-merge-file in git-merge-one-file,
too, 2006-12-22) switched to use our poor-man's substitute for
"merge", we used to invoke "merge" for three-way merge.

We no longer do, and a more generic "merge operation" is certainly a
lot more appropriate in today's world.

>     can inspect the stages with `git ls-files -u`).  The working
> -   tree files contain the result of the "merge" program; i.e. 3-way
> +   tree files contain the result of the merge operation; i.e. 3-way
>     merge results with familiar conflict markers `<<<` `===` `>>>`.

