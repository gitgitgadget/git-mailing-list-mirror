Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1143C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11DA610A0
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhGTQFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhGTQEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:04:25 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B7C061762
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:44:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j1so2987706ljo.10
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 09:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AZ4Jr1EWETTwGPSEZ5D+LUT96M4UGbP9mYpmB3BUuoM=;
        b=rNdJ+GDS/TAlvs2XpEWtZB1c2RyHX6au4n9H5b1xeXb2zFFXUibZWka2Kvj+jlm8eM
         H5MS7ot4NjK+D0BdktpcgZgeAZKzKScQByHTbdSpnx14cPqCCx+rxnotgGjhVhe/QJ7X
         AFU4b1O1+trV9Q7lR0ltPWg+5DKwrAbCQOLqvzKQhhOjC1iZu7UADhNEwOPMrzBh3qkC
         hHGHr9wyT6l91ZgMA0KwQdBPdqNMRLeiEGpOfi9/XPcuPLhTUmzH6uPj/QVJMA3mA5Fd
         9TYp19xd1tCsh/6IA2NL9RJ9lqMWThIe6XdNbhuHPJti70LB9BavbB/0YkiVMgzbe9+N
         5dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AZ4Jr1EWETTwGPSEZ5D+LUT96M4UGbP9mYpmB3BUuoM=;
        b=KvhK9y4PaeyQZEG72nIl1KJVrC9diwWcasu6fYCDEdFfxswgScnII7kMvkY9qGzTlK
         J9e2wbCDBZ4OTjg9ZfP9n84PPH72Moz3Yj2ewRAHKnQv/E4MovslYb5pv+jf4sbC+1D1
         1CgacOgzcVVQY3UQ1lVnC3WBEkXK0ExhmvJt1kh2s8sveyqpNHByzfaMrN35G9S31NKl
         F6j4QtyTP/tjr2AcW773CPrUXdwejAnV3l7804anO2maFLHZacOmQJ+sRlzD1r4Rb9iS
         xppyYxNAkD5ZyyTJEVT3qHP4Nri7tKrCKyW7UFKWdRT+bBpghwleMOMRUtnPBtqLrbVo
         1zsQ==
X-Gm-Message-State: AOAM5302B0Be7ED9Z8OArm7VmRtFrDi1JGEFcBJbr3j+AgLdu4YGqcyq
        ejivQ+6GV4dDw6Jt6R6CsnsYfpWfYZ4=
X-Google-Smtp-Source: ABdhPJyecQcnDS/wJHIfyf5f06vGbAX5mzt2As233zhPEYmqs3pulNUCczoImZey9Lq/9i/SVAxsBg==
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr28186715ljj.279.1626799491866;
        Tue, 20 Jul 2021 09:44:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v14sm175483lfo.155.2021.07.20.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:44:51 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andy Zhang <zhgdrx@gmail.com>, git@vger.kernel.org
Subject: Re: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
        <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
        <xmqqmtqij63t.fsf@gitster.g> <87a6mhgxv4.fsf@osv.gnss.ru>
        <xmqqczrdhu9q.fsf@gitster.g>
Date:   Tue, 20 Jul 2021 19:44:50 +0300
In-Reply-To: <xmqqczrdhu9q.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        20 Jul 2021 08:36:33 -0700")
Message-ID: <87y2a19bp9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>

[...]

>
>> I don't actually like this.
>
> You do not have to ;-) because I was not suggesting to change any
> existing behaviour.  It was merely me thinking aloud, how I might
> do the feature if I were designing it from scratch now.

Yeah, I've noticed the absence of [PATCH] ;-) and was just thinking
aloud myself as well.

Thanks,
-- 
Sergey Organov
