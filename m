Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74641C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3F61C6A
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 18:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhGFSG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 14:06:29 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:43535 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhGFSG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 14:06:29 -0400
Received: by mail-ej1-f44.google.com with SMTP id v20so35553200eji.10
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 11:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2chIeYyIbqo6Q3NU6DwTU1t6vvzl3s37+e4NQhAfCM=;
        b=YRuYjEGo7Bp8OTz5VMCIJ7ZHcm2jsOswgJH/0pKPcwT0cHTzuQG1k+Z8tKtJ5hAx1h
         Q+mTMBxFbDSpgrF9Fdp1L2Dj6UKluNaGO4+slOwL8Wt+iNps2vEUr0eC8pkI6UO074+p
         aYsQiHloRwpU2lxoyt7GCnK8YoaJzL8hBngebSIQbeXXzy6x/ibaNryQtiF7XQYGI/8V
         Ini+PnRWEi3EfYgeO7xGEiTRvUF/j3xfr2qZS83ZciX6dogxn/C4nYlwIwjdpqJoqz8Z
         z8qInhLFiYHZn/wWtVJRRH8qRFRD6tWreioogS/FMVfrjOSA2o3ZBGBQNHhrcNDEIZZD
         TDsw==
X-Gm-Message-State: AOAM531njS3h7eNJXzaz+lwcICdz71+OgtnEVBh5Oe0w0fWV/LoQKxhy
        o1XIGa8dLeCN41Jv80hrK+H3cJ+clERc3PKQJXA=
X-Google-Smtp-Source: ABdhPJxfPR8/lT9Vr2oAhiB+rmszT25yk3mfD7W3O3f/UFJHiGFD6vlHNnWgKsDREQR1O/Yf+lqpfBLIrPs/m/khR1k=
X-Received: by 2002:a17:907:7d8c:: with SMTP id oz12mr19538491ejc.202.1625594629213;
 Tue, 06 Jul 2021 11:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210706162238.575988-1-clemens@endorphin.org> <xmqq1r8bl40i.fsf@gitster.g>
In-Reply-To: <xmqq1r8bl40i.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 6 Jul 2021 14:03:38 -0400
Message-ID: <CAPig+cTRXTGe-MNTy=2gk1eX8G+0fa303nrLnEtX1uHUC2usmg@mail.gmail.com>
Subject: Re: [PATCH] fetch: Fix segfault on pull --set-upstream outside a branch.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Clemens Fruhwirth <clemens@endorphin.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 6, 2021 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
> Clemens Fruhwirth <clemens@endorphin.org> writes:
>
> > branch_get("HEAD") can return NULL, when we are outside a branch and
> > the user calls pull --set-upstream. Catch this case and warn the user
> > to avoid a segfault.
>
> Nit.  What do you mean by "outside a branch"?  If you mean "when the
> HEAD is detached", please say so, and use the same terminology in
> your warning message.

Also, adding a new test, probably to `t/t5553-set-upstream.sh`, would
be welcome. The test can likely be as simple as ensuring that the
command does not crash, and perhaps check that the outcome was as
expected.
