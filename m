Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D953C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2B6120897
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="QGtXWefh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgIOAzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgIOAzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 20:55:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83630C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:55:23 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i22so2559215eja.5
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A2QVIJm/wdXsrfXg0LDbReKS29x6a/vDcECIpTGNub0=;
        b=QGtXWefhn+syTgwNWvRQg+D0bPHRpQTY0kQvUSVqf80kYswHSoBacvMnFanyKeXK69
         iqinE2zUJJnZ9JrwmUYsLiRfQ8MjOLK50nlPjuz/qSjAwvB3THYlU9mkF/eKarvCqtP9
         yAsxfbCJAFPhSms5+mZhYeMKV5hbZVRz/5xOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A2QVIJm/wdXsrfXg0LDbReKS29x6a/vDcECIpTGNub0=;
        b=AF+YpisnDXsil9TseDihj2mK3j27lGSA+6BAw3gr+7f1UO17XrYidpMPJXNGMglGlF
         7EqzFQY3Rknx1VMGRVPoBTMymU+XqGx+ysQLUSlPAvL7lVrRjHuM8kGR8YUfQm+daXW/
         9yVEBCa92PO+9D0llQ/Ua8UFHMdlIiTJ1JpT6sECbs2gX/B5U+zRrP2SVG+yU0WtuaQN
         VbK754jSZIV6/Z3nnC6yvgIP2CSCvNlgIfewqt2NDPmKOrFmzQL37rjjNVJo0rGuuXSy
         3NnakCEgexxG2vdcslr4wzvWDGVh6geJ+uOeG1DvhCxYJfN2/5ol79QWBmVcCju0vP62
         POQg==
X-Gm-Message-State: AOAM531rRRv23yI5HjwBO3oOR7gxnjDQ4EyzfU4PdrqzB/DC0IUkzaq9
        Bn3VfPaF8c5WnvYHS5JpvuDTef8Z280Z2fLMvyoRhT0MO61LzDfVHFnqsj8ivLBwQhHYt2/d/Vp
        NtRxULibyyGUjlscidIoOR9bYYdmwkg9ztRVJSbnS4+eUyrpNSMtXhQzu+pxU8Ui8MP8YTWJFbW
        RnH3o8iVtq
X-Google-Smtp-Source: ABdhPJyT5Yug7SreVu4fApGaikL6IreRmep92vVCC6k0pUyJCS6LLAEWEvrNdjW1o/lUuwD8OUHeoGspg6zvKZwZXTs=
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr17270573eja.23.1600131322162;
 Mon, 14 Sep 2020 17:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
 <pull.781.v18.git.git.1599895268433.gitgitgadget@gmail.com> <xmqqr1r4jf54.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1r4jf54.fsf@gitster.c.googlers.com>
From:   Lin Sun <lin.sun@zoom.us>
Date:   Tue, 15 Sep 2020 08:55:09 +0800
Message-ID: <CAKu6+JH6vJsJ8Gj75qnKefqOh8Dk3XcPt+vjpTbYahY4jzSAeQ@mail.gmail.com>
Subject: Re: [PATCH v18] Support auto-merge for meld to follow the vim-diff behavior
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sunlin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunlin <sunlin7@yahoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> conflict =E2=80=A6
It=E2=80=99s my typo. Thank you for fixing it.

Best Regards
Lin Sun
