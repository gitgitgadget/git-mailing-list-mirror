Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40E81F453
	for <e@80x24.org>; Sun,  3 Feb 2019 03:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfBCDfP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 2 Feb 2019 22:35:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39019 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfBCDfP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 22:35:15 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so12152256qtj.6
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 19:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HX2e06nS4Uped8fT11SeEMbYEBsY59iHtkI2TNzc9tI=;
        b=sD1wh7u16W8VSaIYNhGxu/8sP3h5WtDDZecngGgQo4NW0SUgwvUA653vNK+famGrj7
         DowyRZ3nh5r/g40mo6h9ptqtItJqIF9ilwnvM6st+XEiYbKs4VaaPEAX3+dpxQIG4kWe
         5qGyU1CV7j5q2hrGPW9WAzmEaqkSo+McfSd2oDK7JwAd+BLNmnH8xZfhxyVj+jwXpopr
         dpe3ITM2kXQ2IBDf/QrqIJ6I5qYF/eYZDWnjFaG2Jz7kqVhUUrVa3ZUwnjwVkR6kxoKu
         wqkXAs6u8G8MbUfOPe2wTs5teBGLrIG6KNhgGr7d56IK5hLbms3xSL87s9wSCEcUH3p7
         pThw==
X-Gm-Message-State: AJcUuke/QZaxisifiCdaNWeo6ixt/CnZwbkJJj9syS1GhbfTXSmLvurr
        g22yaINOx4XXZanfpchS6YXb5KpRqVtrX5ZWzU8=
X-Google-Smtp-Source: ALg8bN6KDLVOtxUMJNWA/5yMRmyjL/NvHrOQkRe2EtFMTswFBhJYedcf6dYKUEpeh8TGBM7umbDQwDK6iYivuAugfP4=
X-Received: by 2002:a0c:981b:: with SMTP id c27mr44553702qvd.184.1549164914273;
 Sat, 02 Feb 2019 19:35:14 -0800 (PST)
MIME-Version: 1.0
References: <20190201135512.68220-1-koraktor@gmail.com> <CAPig+cQgEVJ6OGn9BRUJoALxE7aDCHK308sq7V0EQVRRn6Vn8g@mail.gmail.com>
 <CA+xP2Sa2zLeLg-6pFn9UEufurd=EOOf8UFx3Qh7o0dwzJgN-ag@mail.gmail.com>
In-Reply-To: <CA+xP2Sa2zLeLg-6pFn9UEufurd=EOOf8UFx3Qh7o0dwzJgN-ag@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 2 Feb 2019 22:35:03 -0500
Message-ID: <CAPig+cRg55g_x7XvfHuP4J17ODnmWp+o7x=Wqpq6v2TCWcgcuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] describe: setup working tree for --dirty
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 2, 2019 at 5:05 AM Sebastian Staudt <koraktor@gmail.com> wrote:
> Am Fr., 1. Feb. 2019 um 21:12 Uhr schrieb Eric Sunshine
> <sunshine@sunshineco.com>:
> > On Fri, Feb 1, 2019 at 8:55 AM Sebastian Staudt <koraktor@gmail.com> wrote:
> > > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > > @@ -145,14 +145,38 @@ check_describe A-* HEAD
> > > +test_expect_success 'describe --dirty with --work-tree' '
> > > +       [...]
> > > +'
> > > +test_expect_success 'describe --dirty with --work-tree' '
> > > +       [...]
> > > +'
> >
> > Can you give these two new tests different titles to make it easier to
> > narrow down a problem to one or the other if one of them does fail?
> > Perhaps the second test could be titled:
> >
> >     test_expect_success 'describe --dirty with dirty --work-tree' '
> >
> > or something.
>
> Thanks, didn‘t notice this.
> I‘d use a suffix (dirty) for my test titles. But this won‘t work for tests
> using check_describe(). Any objections?

I have no objections to using suffix "(dirty)".

It's true that there are a few duplicate test titles due to
check_describe() invocations, however, this patch isn't introducing
any new callers, so it's not strictly a concern of this series. If you
did want to address that issue, one possibility would be to add a
'title' argument to check_describe() and adjust callers to use a
unique title, however, such a change would not be part of this
particular patch, and I'm not convinced that it's even worth the
effort and churn at this point.
