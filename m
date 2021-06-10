Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E64DC48BCF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 03:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0276140F
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 03:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFJDci (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 23:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFJDch (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 23:32:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3C7C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 20:30:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso26100371otu.10
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 20:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zs9omYxUs4203JZQOjk0qaRldbQBWnKSJGUzwv+eVdw=;
        b=WS5ZfNzZMaENa3+San+RO5eViYUQwk1DkCgKXQfOJJJhvmRf0uvP+MQe6grs66OWAw
         eEFSUusywz5jjZqZFmmst6ENxPDfzE2ZCHTN7R/kfcR0x65Muzi8JF1ZhZ79nXG39L+b
         LfmCPql2edD2nWwv/GZHtm2gcLxh7ctCvbus/QOG6FizHkW2sncKEMUOU3TSdiEweRrz
         1VUJPNhnf6TBP0ubCzDO5EceilYXOhPVWZR4UMVBQ+SoPkMOxIm/YeGKWBNCbVyXLRWU
         kacZCYeS1LIITP+behKd+Pq7zoMG+16GAkG8Zi7SYeV/6FYNeq98nw87Th+wQTGYv8B9
         zN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zs9omYxUs4203JZQOjk0qaRldbQBWnKSJGUzwv+eVdw=;
        b=ud4WOLX0ytt+VCPhm1ro9GTCyoaTPejp9OtUlXCHB7rXd8hHQjADRZD4C6qbYpbgwD
         xBHYwDVt8oRenT7lMI+tWs6d2e4WdP+6OYC3JsNb41mCaw4uwEa4D9VDwbHHJQe0B/x0
         6g6mRBLFsSuscptYM54VX8T1iTur11KPaahZavy1mxZiRsN42XO7PSh09Bev4wb4fK6g
         zXMAy7GIKSBkjo5jX4ohgbTrp3mybM2Hjd7lks5CHsb8A2tBcxnexUJHrvhue3ZTZEDF
         fJ3oWd2wnvymKwOUja75uSxszFfhMBi1a2+uUTD/4i1MBi9EDViSsY37+Xb4VyYkGjtN
         NmPA==
X-Gm-Message-State: AOAM530HC51DcU8CafzEnxOzI/hms5UoEP2gc3ntZn4ywzcR3xt8S6pm
        Ej6IkUE9f6YYmsw+m+W21XE=
X-Google-Smtp-Source: ABdhPJxKfL3EzkkC+yz+LBkulel59mXP4ae1s3oflRILOl9Z+BmAVkICYilpU7azxh3ehG3jqE2deA==
X-Received: by 2002:a05:6830:4023:: with SMTP id i3mr707676ots.45.1623295823061;
        Wed, 09 Jun 2021 20:30:23 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 5sm391553ots.67.2021.06.09.20.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 20:30:22 -0700 (PDT)
Date:   Wed, 09 Jun 2021 22:30:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60c1874d127af_af76d2084@natae.notmuch>
In-Reply-To: <xmqqsg1qh3wo.fsf@gitster.g>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <xmqqsg1qh3wo.fsf@gitster.g>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> =

> > + When it becomes awkward to stick to this style prefer "you" when
> > + addressing the the hypothetical user, and possibly "we" when
> > + discussing how the program might react to the user.
> =

> Because I still get a funny feeling whenever I see a singular they,
> which I was taught to be ungrammatical in my foreign language
> classes long time ago, I kind of like this approach better, if we
> can pull it off.

Once again; we non-native English speakers shouldn't forgo our
instincts. Even professional English linguists agree this isn't OK:

  We thank the anonymous reviewer for their helpful comments

https://ahdictionary.tumblr.com/post/147597257733/updated-usage-note-they=


-- =

Felipe Contreras=
