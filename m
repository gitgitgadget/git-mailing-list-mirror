Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4EC4332F
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 18:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiJESFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJESFR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 14:05:17 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC70B1E3EE
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 11:05:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so15886832pgb.4
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIqsN5Y36o9uKB3kQl6IPDAEUpBerFIdsKTeks0pAdU=;
        b=H2bF2EK8yg7WeUE2VhFxyvdENtn6ogUpwnExVHkBKbgW+Vv62uOoOGr65e1BqssB1r
         kRRAHA0VFmJIU0K4pBsu5al80IpdNZylULmHFpPMxqI0F8mnGmtAFHwZBH1m8jyex/HE
         +7mTPVf7KKbGrfIreHgHOVlOkVQNj1OUqVPabHGekgvpdelZjrV5uuW0tqXLS922DJXI
         CWV46bycVVdmUUaX+ViwoFv+qiA8294hfXsd+KYZxl5l0DfOX4NSP7ufxIj4DaVt+8D4
         +lXUsUtmDuQb6RfNOPxjNpSfbONdUkwRftiHxzVHhZkiyB8C7PwnmC4Qwtc5rba2pmBu
         tzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIqsN5Y36o9uKB3kQl6IPDAEUpBerFIdsKTeks0pAdU=;
        b=KF1Bvy9R3O+rh6L82xk/nX7kKtlwAsFpS0leYzyD7YK9goFgrpzqaQxKucPPNl2dC4
         1gFyNR2RmKYoBPeKdXyhBItAAdmwCL6RYruBLKv3IXxC7tgWlCqIcwWunNJ22DBibM+Z
         gknRubsz9WbOdCkUps8KsVrSpxeVWzxn3Ql6R2lLPs4lcvXZdtrMip8yWCMbSQ/qF/qh
         u2t1fSONgeGt8oEUis1N0CCvCRhETevJPfPl450wnIdA+53MqQvmNzA6/8SdrAqMuEKk
         Q1t6WYYcOyKKqCG0bKIv1Yf3oFL2dY9EY8eaG12PO+XJT4VVxz5eocfjCPYwdMuk9onD
         bhpw==
X-Gm-Message-State: ACrzQf2SQk02fsAwwhb+czkq+EvNQe1mtM/ISPBOyljGLLM350rdGyiS
        72sepvIxj1BVNj5hnRKcq4ybUHAeMvU=
X-Google-Smtp-Source: AMsMyM74zdr61EBj/05p4lEQqgJAxv/BBhlhw29qOuCEBiFsdvLKYHZWs8NIcD+OPtoUi5I4mw8/Mg==
X-Received: by 2002:a05:6a00:99f:b0:543:198b:f995 with SMTP id u31-20020a056a00099f00b00543198bf995mr885740pfg.45.1664993110019;
        Wed, 05 Oct 2022 11:05:10 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id pc14-20020a17090b3b8e00b0020a28156e11sm946pjb.26.2022.10.05.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:05:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v15 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
        <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
Date:   Wed, 05 Oct 2022 11:05:09 -0700
In-Reply-To: <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Tue, 04 Oct 2022 17:32:25
        +0000")
Message-ID: <xmqq35c2qh7u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> An additional issue is that for mount points in the root directory, FSEvents
> does not report a path that matches the worktree directory due to the
> introduction of 'synthetic firmlinks'. fsmonitor must map the FSEvents paths
> to the worktree directory by interrogating the root filesystem for synthetic
> firmlinks and using that information to translate the path.
>
> v15 differs from v14:
>
>  * fix memory leak

Thanks.  I thought "what, another iteration?  didn't we see this
enough times already?" and a note like this does help reminding
reviewers why we need one.

Very much appreciated.

