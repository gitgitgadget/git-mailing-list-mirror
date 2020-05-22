Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B459C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA020663
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUteTEdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgEVPy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbgEVPyz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 11:54:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46D7C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:54:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so9631164oie.11
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WX5tAdcjT0XssROWKUCmK+MKx9HByWovRhaEIEKmD0=;
        b=bUteTEdTazi8mOfoG6xtuvIIfMA62eXfNKo0/4rt+XWRln57N15/NU3LjE+ixKjMQC
         asOXbkZt7VVrm1aW9tHkwp59OrLqxOrD5qSXyETNrxAfs+UXoYNSRgzUIUeccXmOEziz
         8ljuwNLjzgX9aN8K7If9SCJ6++Y7ZREngMOjsXo/9TPp3cCBw7ikt53JAyWxGL2Bw0Iy
         O2es70pxZxJLUKVt5il3eOXUG+E6yHCNrlGogsp+KUow2lQC+V8hwlBhy0c6SeY9zULG
         zSqRXxRck080QxR9N8x72Qq8OE6kFFAg9XqlrMjQosX+1qNzIRZ2Utufu8IFJBOqBqOB
         nVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WX5tAdcjT0XssROWKUCmK+MKx9HByWovRhaEIEKmD0=;
        b=SuIYjTrb7UvzgRqe/P7B8KxtLeawrGM0W319kFfejgt9CfLwp9I4rIwUcWcAdnlaI6
         pfq6eaKZVegZT/XLJwsvIE/akOiEvXtVBG/cf0yEaiZ88JLItIu2v1qGmcg1wjjPqcY4
         DNzpeR6bUW5phD0d+4wN71muyKb66XH4JCOg/J9nfUpJN4+yoZtM5/QK7gbYaxj7lr7U
         pFuvsCJ+3v9AJwSQXNGwtMgJqbPFSyDEo90vVMEms7jyQQxq216dbY5/JlB1eORX8OxD
         SaqBUj/N4+Z4oe6yhGl2Vru7icNgtDzHm0UUFH2M+HmeYfSnXjFi97PiVaTt2ZUEM+IS
         PcGA==
X-Gm-Message-State: AOAM530J02but2RfcgONbzjnt6oPZJYxOgtMxXZCG9Gnt4TfmH6HamiP
        7fPy6j+6ISAwcSKAzMDZK6LVAxcQA9f5p62HSTk=
X-Google-Smtp-Source: ABdhPJwdO2ORCHl0ZOc/psRKu9rqwFNoGjdal5tCW2wGA2hY/yoPzXJUiqoSQGFf04gd+gbYWUBeZqlzgCK1vZfOR3g=
X-Received: by 2002:aca:220f:: with SMTP id b15mr2918562oic.31.1590162894881;
 Fri, 22 May 2020 08:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200521101455.63484-1-phillip.wood123@gmail.com>
In-Reply-To: <20200521101455.63484-1-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 22 May 2020 08:54:43 -0700
Message-ID: <CABPp-BFaexpFo-n-vPxZ2e4dF9aT45NXK8rnmJ6gi+qvLN+P+Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] cleanup ra/rebase-i-more-options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 3:15 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks for the feedback on v2, I've updated the documentation as
> suggested by Elijah and made the style fixes suggested by Alban but
> I've not changed read_author_script() for the reasons explained in
> https://lore.kernel.org/git/c6a2711a-96c1-d7ac-9678-20c581408ef5@gmail.com

All my questions were answered earlier; this round addressed my
remaining feedback and I see no new issues.

Reviewed-by: Elijah Newren <newren@gmail.com>
